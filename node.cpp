#include "node.h"
#include "symboltable.h"
#include "scanner.h"
#include <sstream>

using namespace std;

PSymbolTypeInt NodeInteger::type_sym_ptr = nullptr;
PSymbolTypeFloat NodeFloat::type_sym_ptr = nullptr;
PSymbolTypeChar NodeString::char_type_sym_ptr = nullptr;
PSymbolTypeString NodeString::str_type_sym_ptr = nullptr;

uint NodeString::strcounter = 0;
string NodeString::str_prefix = ".str";
string fmt_newline = "._fmt_newline_";

std::stack<std::pair<AsmLabel, AsmLabel>> cycle_continue_break;
std::stack<PSymbolProcedure> proc_func_exit;

std::map<Token::Operator, std::string> operator_lst =
{
{Token::OP_EQUAL, "="},
{Token::OP_GREATER, ">"},
{Token::OP_LESS, "<"},
{Token::OP_PLUS, "+"},
{Token::OP_MINUS, "-"},
{Token::OP_DIV_SLASH, "/"},
{Token::OP_MULT, "*"},
{Token::OP_LEFT_BRACE, "{"},
{Token::OP_LEFT_PAREN, "("},
{Token::OP_ASSIGN, ":="},
{Token::OP_PLUS_ASSIGN, "+="},
{Token::OP_MINUS_ASSIGN, "-="},
{Token::OP_DIV_SLASH_ASSIGN, "/="},
{Token::OP_MULT_ASSIGN, "*="},
{Token::OP_LEQ, "<="},
{Token::OP_GEQ, ">="},
{Token::OP_NEQ, "<>"},
{Token::OP_DOT, "."},
{Token::OP_AT, "@"},
{Token::OP_DOTDOT, ".."},
{Token::OP_RIGHT_PAREN, ")"},
{Token::OP_LEFT_BRACKET, "[]"},
{Token::OP_RIGHT_BRACKET, "]"},
{Token::OP_RIGHT_BRACE, ")"},
{Token::OP_DEREFERENCE, "^"},
{Token::OP_SHL, "SHL"},
{Token::OP_SHR, "SHR"},
{Token::OP_AND, "AND"},
{Token::OP_OR, "OR"},
{Token::OP_NOT, "NOT"},
{Token::OP_XOR, "XOR"},
{Token::OP_IN, "IN"},
{Token::OP_DIV, "DIV"},
{Token::OP_MOD, "MOD"},
};

std::map<Token::Separator, std::string> separator_lst =
{
{Token::S_COLON, ":"},
{Token::S_SEMICOLON, ";"},
{Token::S_COMMA, ","},
};

bool is_lvalue(PNodeExpression expr) {
	PNodeUnaryOperator l = dynamic_pointer_cast<NodeUnaryOperator>(expr);
	return (l && l->operation == Token::OP_DEREFERENCE) ||
	       dynamic_pointer_cast<NodeVariable>(expr)     ||
	       dynamic_pointer_cast<NodeArrayAccess>(expr)  ||
	       dynamic_pointer_cast<NodeRecordAccess>(expr);
}

bool is_integer_type(PSymbolType symt) {
	return symt == NodeInteger::type_sym_ptr || dynamic_pointer_cast<SymbolTypePointer>(symt);
}

NodeEof::NodeEof(const Token&) {
}

NodeExpression::NodeExpression(PSymbolType type) :
    m_exprtype(type) {
}

NodeInteger::NodeInteger(const Token& token) {
	value = Token::int_values[token.value_id];
	m_exprtype = NodeInteger::type_sym_ptr;
}

NodeFloat::NodeFloat(const Token& token) {
	value = Token::float_values[token.value_id];
	m_exprtype = NodeFloat::type_sym_ptr;
}

NodeString::NodeString(const Token& token) :
    strlabel_id(NodeString::strcounter++)
{
	value = Token::string_values[token.value_id];
}

NodeIdentifier::NodeIdentifier(const Token& token) {
	name.resize(token.raw_value.size());
	std::transform(token.raw_value.begin(), token.raw_value.end(), name.begin(), (int (*)(int))toupper);
	m_exprtype = nullptr;
}

NodeArrayAccess::NodeArrayAccess(PNodeExpression array, PNodeActualParameters index) :
	array(array), index(index) {
	m_exprtype = this->exprtype();
}

NodeBinaryOperator::NodeBinaryOperator(Token::Operator operation, PNodeExpression left, PNodeExpression right) :
	operation(operation), left(left), right(right) {
	m_exprtype = this->exprtype();
}

NodeVariable::NodeVariable(PNodeIdentifier identifier, PSymbolVariable s_var) :
    NodeExpression(s_var->type), identifier(identifier), symbol(s_var) {
	m_exprtype = this->exprtype();
}

NodeActualParameters::NodeActualParameters(PNodeExpression expr) {
	arglist.push_back(expr);
}

//NodeExprStmtFunctionCall::NodeExprStmtFunctionCall(PNodeIdentifier func_id, PNodeActualParameters args) :
//	function_identifier(func_id), args(args) {
//	//!
//}

NodeExprStmtFunctionCall::NodeExprStmtFunctionCall(PSymbolProcedure sym, PNodeActualParameters args) :
    proc(sym), args(args) {
	if (sym->name == "WRITE") {
		m_predefined = Predefined::WRITE;
	}
	if (sym->name == "WRITELN") {
		m_predefined = Predefined::WRITELN;
	}
	if (sym->name == "ORD") {
		m_predefined = Predefined::ORD;
	}
	if (sym->name == "CHR") {
		m_predefined = Predefined::CHR;
	}
	if (sym->name == "EXIT") {
		m_predefined = Predefined::EXIT;
	}
	m_exprtype = this->exprtype();
}

NodeUnaryOperator::NodeUnaryOperator(Token::Operator operation, PNodeExpression node) :
	operation(operation), node(node) {
	m_exprtype = this->exprtype();
}

NodeRecordAccess::NodeRecordAccess(PNodeExpression expr, PSymbolVariable var) :
    record(expr), field(var) {
	m_exprtype = this->exprtype();
	st = dynamic_pointer_cast<SymbolTypeRecord>(this->record->exprtype())->symtable;
}

NodeStmtAssign::NodeStmtAssign(PNodeExpression left, PNodeExpression right) :
	NodeBinaryOperator(Token::OP_ASSIGN, left, right) {
	m_exprtype = this->exprtype();
}

NodeConstant::NodeConstant(PSymbolConst sym) :
    symbol(sym) {
}

NodeConstantInt::NodeConstantInt(PSymbolConstInt sym) :
    NodeConstant(sym) {
}

NodeConstantFloat::NodeConstantFloat(PSymbolConstFloat sym) :
    NodeConstant(sym) {
}

NodeStmtBreak::NodeStmtBreak(PNodeStmt a_cycle) :
    cycle(a_cycle) {
}

NodeStmtContinue::NodeStmtContinue(PNodeStmt a_cycle) :
    cycle(a_cycle) {
}

string Node::str()                       const { return ""; }
string NodeEof::str()                    const { return "END OF FILE"; }
string NodeInteger::str()                const { return to_string(value); }
string NodeFloat::str()                  const { return to_string(value); }
string NodeVarDeclarationUnit::str()     const { return nodetype->symtype->str(); }
string NodeTypeDeclarationUnit::str()    const { return "ALIAS " + alias->name; }
string NodeString::str()                 const { return "\"" + value + "\""; }
string NodeIdentifier::str()             const { return name; }
string NodeBinaryOperator::str()         const { return operator_lst[operation]; }
string NodeArrayAccess::str()            const { return "[]"; }
string NodeActualParameters::str()       const { return ","; }
string NodeRecordAccess::str()           const { return "."; }
string NodeExprStmtFunctionCall::str()   const { return "FUNCTION CALL"; }
string NodeUnaryOperator::str()          const { return operator_lst[operation]; }
string NodeVariable::str()               const { return identifier->name; }
string NodeStmtIf::str()                 const { return "IF"; }
string NodeStmtWhile::str()              const { return "WHILE"; }
string NodeStmtAssign::str()             const { return "ASSIGN"; }
string NodeStmtConst::str()              const { return "CONST"; }
string NodeStmtRepeat::str()             const { return "REPEAT"; }
string NodeStmtBreak::str()              const { return "BREAK"; }
string NodeStmtContinue::str()           const { return "CONTINUE"; }
string NodeStmtVar::str()                const { return "VAR"; }
string NodeStmtFor::str()                const { return "FOR"; }
string NodeStmtProcedure::str()          const { return "PROCEDURE " + name->str(); }
string NodeFormalParameterSection::str() const { return (is_var ? "VAR " : "") + type->str() + " FORMAL PARAMETERS:"; }
string NodeStmtFunction::str()           const { return "FUNCTION " + name->str(); }
string NodeTypeRecord::str()             const { return "RECORD"; }
string NodeTypeArray::str()              const { return "ARRAY"; }
string NodeType::str()                   const { return symtype->str(); }
string NodeStmtType::str()               const { return "TYPE"; }
string NodeStmtBlock::str()              const { return "BLOCK"; }

bool Node::empty() const {
	return false;
}

bool NodeIdentifier::empty() const {
	return name.empty();
}

PSymbolType NodeExpression::exprtype() {
	return m_exprtype;
}

PSymbolType NodeInteger::exprtype() {
	return NodeInteger::type_sym_ptr;
}

PSymbolType NodeFloat::exprtype() {
	return NodeFloat::type_sym_ptr;
}

PSymbolType NodeString::exprtype() {
	return value.size() == 1 ?
	            dynamic_pointer_cast<SymbolType>(NodeString::char_type_sym_ptr) :
	            dynamic_pointer_cast<SymbolType>(NodeString::str_type_sym_ptr);
}

PSymbolType NodeBinaryOperator::exprtype() {
	PSymbolType ltype = left->exprtype(), rtype = right->exprtype();
	PSymbolType int_type = NodeInteger::type_sym_ptr, float_type = NodeFloat::type_sym_ptr;
	if (m_exprtype) {
		return m_exprtype;
	}
	switch (operation) {
	case Token::OP_PLUS:
	case Token::OP_MINUS:
	case Token::OP_MULT:{
		if (SymbolType::is_arithmetic({ltype, rtype})) {
			if (m_exprtype = SymbolType::max(ltype, rtype)) {
				break;
			} else {
				throw ParseError(Scanner::current_position(),
				                 "operations with pointers and floats forbidden : got \"" + rtype->name +
				                 "\" and \"" + ltype->name + "\"");
			}
		}
		throw ParseError(Scanner::current_position(),
		                 "both operands of \""+operator_lst[operation]+"\" must be arithmetic: got \"" +
		                 left->exprtype()->name + "\" and \"" + right->exprtype()->name + "\"");
	}
	case Token::OP_DIV_SLASH: {
		if (SymbolType::is_arithmetic({ltype, rtype})) {
			m_exprtype = float_type;
			break;
		}
		throw ParseError(Scanner::current_position(),
		                 "both operands of \"\\\" must be arithmetic: got \"" +
		                 left->exprtype()->name + "\" and \"" + right->exprtype()->name + "\"");
	}
	case Token::OP_EQUAL:
	case Token::OP_GREATER:
	case Token::OP_LESS:
	case Token::OP_LEQ:
	case Token::OP_GEQ:
	case Token::OP_NEQ: {
		if (SymbolType::is_arithmetic({ltype, rtype})) {
			m_exprtype = int_type;
			break;
		}
		throw ParseError(Scanner::current_position(),
		                 "both operands of \"" + operator_lst[operation] + "\" must be arithmetic: got \"" +
		                 left->exprtype()->name + "\" and \"" + right->exprtype()->name + "\"");
	}
	case Token::OP_AND:
	case Token::OP_OR:
	case Token::OP_XOR:
	case Token::OP_SHL:
	case Token::OP_SHR:
	case Token::OP_DIV:
	case Token::OP_MOD: {
		if (ltype == int_type && rtype == int_type) {
			m_exprtype = int_type;
			break;
		}
		throw ParseError(Scanner::current_position(),
		                 "both operands of \"" + operator_lst[operation] + "\" must be integer: got \"" +
		                 left->exprtype()->name + "\" and \"" + right->exprtype()->name + "\"");
	}
	case Token::OP_ASSIGN:
	case Token::OP_PLUS_ASSIGN:
	case Token::OP_MINUS_ASSIGN:
	case Token::OP_DIV_SLASH_ASSIGN:
	case Token::OP_MULT_ASSIGN: {
		m_exprtype = SymbolType::notype();
		if (is_lvalue(left))
		{
			if (SymbolType::is_arithmetic({ltype, rtype}) ||
			    ltype == rtype ||
			    (dynamic_pointer_cast<SymbolTypeProc>(ltype) && dynamic_pointer_cast<SymbolTypePointer>(rtype) && dynamic_pointer_cast<SymbolTypePointer>(rtype)->type == ltype) ||
			    (dynamic_pointer_cast<SymbolTypeFunc>(ltype) && dynamic_pointer_cast<SymbolTypePointer>(rtype) && dynamic_pointer_cast<SymbolTypePointer>(rtype)->type == ltype)
			    )
			{} else {
				throw ParseError(Scanner::current_position(),
				                 "incompatible types : got \"" + rtype->name +
				                 "\", expected \"" + ltype->name + "\"");
			}
		} else {
			throw ParseError(Scanner::current_position(), "variable identifier expected");
		}
		break;
	}
	default: throw runtime_error("Internal error: unknown binary operator");
	}
	return m_exprtype;
}

PSymbolType NodeUnaryOperator::exprtype() {
	if (m_exprtype) {
		return m_exprtype;
	}
	switch (this->operation) {
	case Token::OP_MINUS: {
		m_exprtype = this->node->exprtype();
		if (!SymbolType::is_arithmetic({m_exprtype})) {
			throw ParseError(Scanner::current_position(),
			                 "incompatible type for unary operator \"-\": got \"" +
			                 m_exprtype->name + "\", expected float or integer");
		}
		break;
	}
	case Token::OP_DEREFERENCE: {
		m_exprtype = this->node->exprtype();
		if (!dynamic_pointer_cast<SymbolTypePointer>(m_exprtype)) {
			throw ParseError(Scanner::current_position(),
			                 "incompatible type for dereference operator: got \"" +
			                 m_exprtype->name + "\", expected pointer");
		}
		m_exprtype = dynamic_pointer_cast<SymbolTypePointer>(m_exprtype)->type;
		break;
	}
	case Token::OP_AT: {
		if ((dynamic_pointer_cast<NodeArrayAccess>(node) ||
		    dynamic_pointer_cast<NodeVariable>(node) ||
		    (dynamic_pointer_cast<NodeUnaryOperator>(node) && dynamic_pointer_cast<NodeUnaryOperator>(node)->operation == Token::OP_DEREFERENCE)
		    ))
		{
			m_exprtype = make_shared<SymbolTypePointer>(node->exprtype());
		} else if (dynamic_pointer_cast<NodeExprStmtFunctionCall>(node)) {
			m_exprtype = make_shared<SymbolTypePointer>(dynamic_pointer_cast<NodeExprStmtFunctionCall>(node)->proctype());
		} else {
			throw ParseError(Scanner::current_position(),
			                 "invalid operand for unary operator \"@\": must be lvalue");
		}
		break;
	}
	case Token::OP_NOT: {
		m_exprtype = this->node->exprtype();
		if (m_exprtype != NodeInteger::type_sym_ptr) {
			throw ParseError(Scanner::current_position(),
			                 "incompatible type for operator \"NOT\": got \"" +
			                 m_exprtype->name + "\", expected integer");
		}
		break;
	}
	default: throw runtime_error("Internal error: unknown unary operator");
	}
	return m_exprtype;
}

PSymbolType NodeArrayAccess::exprtype() {
	if (m_exprtype) return m_exprtype;
	PSymbolTypeArray s = dynamic_pointer_cast<SymbolTypeArray>(this->array->exprtype());
	if (s) {
		m_exprtype = s->type;
	} else {
		throw ParseError(Scanner::current_position(),
		                 "left operand of [] must be an array");
	}
	if (this->index->arglist.size() != s->bounds.size()) {
		throw ParseError(Scanner::current_position(),
		                 "arg list size and n. of dimensions do not match: got "
		                 + to_string(this->index->arglist.size()) + ", expected " + to_string(s->bounds.size()));
	}
	for (int i = 0; i < this->index->arglist.size(); i++) {
		PNodeExpression expr = this->index->arglist[i];
		if (expr->exprtype() != NodeInteger::type_sym_ptr) {
			throw ParseError(Scanner::current_position(),
			                 "incompatible type for arg no. " + to_string(i+1) +
			                 ": got \"" + expr->exprtype()->name + "\", expected \"INTEGER\"");
		}
	}
	return m_exprtype;
}

PSymbolType NodeRecordAccess::exprtype() {
	return m_exprtype = this->field->type;
}

PSymbolType NodeExprStmtFunctionCall::exprtype() {
	if (m_exprtype) return m_exprtype;
	PSymbolFunction f = dynamic_pointer_cast<SymbolFunction>(this->proc);
	m_exprtype = f ? f->type : SymbolType::notype();
	return m_exprtype;
}

PSymbolType NodeExprStmtFunctionCall::proctype() {
	if (m_proctype) return m_proctype;
	PSymbolFunction f = dynamic_pointer_cast<SymbolFunction>(this->proc);
	PSymbolProcedure p = dynamic_pointer_cast<SymbolProcedure>(this->proc);
	if (f) {
		m_proctype = make_shared<SymbolTypeFunc>(f);
	} else if (p) {
		m_proctype = make_shared<SymbolTypeProc>(p);
	} else {
		throw runtime_error("Internal error: unrecognized procedure symbol");
	}
	return m_proctype;
}

PSymbolType NodeVariable::exprtype() {
	return m_exprtype = symbol->type;
}

bool NodeExprStmtFunctionCall::check_parameters(Pos pos) {
	if (proc->params->size() == 0 && !args) {
		return true;
	}
	if (m_predefined) {
		if (m_predefined == EXIT) {
			PSymbolFunction f = dynamic_pointer_cast<SymbolFunction>(proc);
			if (f && args && args->arglist.size() == 1 && f->type == args->arglist.at(0)->exprtype()) {
				return true;
			}
			if (!f && (!args || args->arglist.size() == 0)) {
				return true;
			}
			return false;
		}
		if ((m_predefined == WRITE || m_predefined == WRITELN) && args) {
			for (PNodeExpression arg: args->arglist) {
				if (!(arg->exprtype() == NodeString::char_type_sym_ptr ||
				     arg->exprtype() == NodeString::str_type_sym_ptr  ||
				     SymbolType::is_arithmetic({arg->exprtype()})))
				{
					throw ParseError(pos,
					                 "can't write variables of type \"" + arg->exprtype()->name + "\"");
				}
			}
		}
		return true;
	}
	if (proc->params->size() != args->size()) {
		throw ParseError(pos,
		                 "wrong number of parameters specified for call to \"" + proc->name +
		                 "\": got " + to_string(args->size()) + ", expected " + to_string(proc->params->size()));
		return false;
	}
	SymTable& st = *proc->params;
	for (size_t i = 0; i < args->size(); i++) {
		PSymbolType formal, actual = args->at(i)->exprtype();
		PSymbolVariable formal_var;
		st[i] >> formal_var;
		formal = formal_var->type;
		if (proc->is_nth_var.at(i) && !is_lvalue(args->at(i))) {
			throw ParseError(Scanner::current_position(), "invalid arg no. " + to_string(i+1) + ": variable identifier expected ");
		}
		if (formal != actual && !SymbolType::is_arithmetic({formal, actual})) {
			throw ParseError(pos,
			                 "incompatible type for arg no. " + to_string(i+1) +
			                 ": got \"" + actual->name + "\", expected \"" + formal->name + "\"");
			return false;
		}
	}
	return true;
}

void Node::generate(AsmCode& ac) {
}

void NodeInteger::generate(AsmCode& ac) {
	ac << AsmCmd1{PUSHQ, value};
}

void NodeFloat::generate(AsmCode& ac) {
	ac << AsmCmd2{MOVQ, value, RAX}
	   << AsmCmd1{PUSHQ, RAX};
}

void NodeString::generate(AsmCode& ac) {
	if (!m_label) {
		m_label = ac.add_data(make_shared<AsmVarString>(str_prefix + to_string(strlabel_id), value));
	}
}

void NodeVariable::generate(AsmCode& ac) {
	ac << AsmCmd1{PUSHQ, AsmVar{this->identifier->name}};
}

void NodeVariable::generate_lvalue(AsmCode& ac) {
	ac << AsmCmd2{LEAQ, AsmVar{this->identifier->name}, RAX}
	   << AsmCmd1{PUSHQ, RAX};
}

void NodeExprStmtFunctionCall::generate_lvalue(AsmCode& ac) {

}

void NodeRecordAccess::generate_lvalue(AsmCode& ac) {
	int64_t offs = this->st->offsetb(this->field->name);
	m_gen_start_address(ac);
	ac << AsmCmd1{POPQ, RAX}
	   << AsmCmd2{MOVQ, offs, RCX}
	   << AsmCmd2{LEAQ, AsmOffs{RAX, RCX, 1}, RAX}
	   << AsmCmd1{PUSHQ, RAX};
}

void NodeArrayAccess::generate_lvalue(AsmCode& ac) {
	int64_t sz = dynamic_pointer_cast<SymbolTypeArray>(this->array->exprtype())->type->size();
	m_gen_start_address(ac);
	m_gen_index(ac);
	ac << AsmCmd1{POPQ, RCX}
	   << AsmCmd2{IMULQ, sz, RCX}
	   << AsmCmd1{POPQ, RAX}
	   << AsmCmd2{LEAQ, AsmOffs{RAX, RCX, 1}, RAX}
	   << AsmCmd1{PUSHQ, RAX};
//	ac << AsmComment{"end generate_lvalue"};
}

void NodeUnaryOperator::generate_lvalue(AsmCode& ac) {
	/// operation == dereference
	/// node == pointer
	this->node->generate(ac);
}

void NodeArrayAccess::m_gen_start_address(AsmCode& ac) {
//	ac << AsmComment{"generate array start address"};
	array->generate_lvalue(ac);
}

void NodeRecordAccess::m_gen_start_address(AsmCode& ac) {
//	ac << AsmComment{"generate record start address"};
	record->generate_lvalue(ac);
}

void NodeArrayAccess::m_gen_index(AsmCode& ac) {
	static vector<int64_t> dims;
	static vector<int64_t> qr;
	vector<PNodeExpression>& args = this->index->arglist;
	vector<pair<int, int>>& bounds = dynamic_pointer_cast<SymbolTypeArray>(this->array->exprtype())->bounds;
	dims.clear();
	for (const pair<int, int>& p: bounds) {
		dims.push_back(p.second - p.first + 1);
	}
	qr.resize(dims.size());
	for (int i = 0; i < qr.size(); i++) {
		qr[i] = 0;
		for (int j = i + 1; j < qr.size(); j++) {
			qr[i] += dims.at(j);
		}
	}
	qr.back() = 1;
	ac << AsmCmd1{PUSHQ, (int64_t)0};
	for (int i = 0; i < qr.size(); i++) {
		int64_t k = qr.at(i);
		int64_t s = bounds.at(i).first;
		args.at(i)->generate(ac);
		/// args[i] - s
		ac << AsmCmd2{MOVQ, s, R9}
		   << AsmCmd1{POPQ, RAX}
		   << AsmCmd2{SUBQ, R9, RAX}
		/// (args[i] - s)*k
		   << AsmCmd2{MOVQ, k, R9}
		   << AsmCmd2{IMULQ, R9, RAX}
		/// (args[i] - s)*k + prev
		   << AsmCmd1{POPQ, R9}
		   << AsmCmd2{ADDQ, R9, RAX}
		   << AsmCmd1{PUSHQ, RAX};
	}
}

void NodeVariable::declare(AsmCode& ac) {
	this->exprtype()->gen_declare(ac, this->identifier->name);
}

void NodeBinaryOperator::m_gen_arithm(AsmCode& ac) {
	left->generate(ac);
	left->exprtype()->gen_typecast(ac, this->exprtype());
	right->generate(ac);
	right->exprtype()->gen_typecast(ac, this->exprtype());
	ac << AsmCmd1{POPQ, R10}
	   << AsmCmd1{POPQ, RAX};
	if (is_integer_type(this->exprtype())) {
	/// RAX <op> RBX
		switch (this->operation) {
		case Token::OP_PLUS:
			ac << AsmCmd2{ADDQ, R10, RAX}; break;
		case Token::OP_MINUS:
			ac << AsmCmd2{SUBQ, R10, RAX}; break;
		case Token::OP_MULT:
			ac << AsmCmd2{IMULQ, R10, RAX}; break;
		case Token::OP_DIV:
			ac << AsmCmd0{CQO}
			   << AsmCmd1{IDIVQ, R10}; break;
		default:;
		}
	} else if (this->exprtype() == NodeFloat::type_sym_ptr) {
		ac << AsmCmd2{MOVQ, RAX, XMM0}
		   << AsmCmd2{MOVQ, R10, XMM1};
		switch (this->operation){
		case Token::OP_PLUS:
			ac << AsmCmd2{ADDSD, XMM1, XMM0}; break;
		case Token::OP_MINUS:
			ac << AsmCmd2{SUBSD, XMM1, XMM0}; break;
		case Token::OP_MULT:
			ac << AsmCmd2{MULSD, XMM1, XMM0}; break;
		case Token::OP_DIV_SLASH:
			ac << AsmCmd2{DIVSD, XMM1, XMM0}; break;
		default:;
		}
		ac << AsmCmd2{MOVQ, XMM0, RAX};
	}
	ac << AsmCmd1{PUSHQ, RAX};
}

void NodeBinaryOperator::m_gen_cmp(AsmCode& ac) {
	/// RAX <op> R11
	bool is_float = left->exprtype() == NodeFloat::type_sym_ptr || right->exprtype() == NodeFloat::type_sym_ptr;
	if (is_float) {
		left->generate(ac);
		left->exprtype()->gen_typecast(ac, NodeFloat::type_sym_ptr);
		right->generate(ac);
		right->exprtype()->gen_typecast(ac, NodeFloat::type_sym_ptr);
		ac << AsmCmd1{POPQ, R11}
		   << AsmCmd1{POPQ, RAX}
		   << AsmCmd2{MOVQ, RAX, XMM0}
		   << AsmCmd2{MOVQ, R11, XMM1}
		   << AsmCmd2{XORQ, RAX, RAX}
		   << AsmCmd2{COMISD, XMM1, XMM0};
		switch (this->operation) {
		case Token::OP_EQUAL:
			ac << AsmCmd1{SETE, AL}; break;
		case Token::OP_GREATER:
			ac << AsmCmd1{SETA, AL}; break;
		case Token::OP_LESS:
			ac << AsmCmd1{SETB, AL}; break;
		case Token::OP_LEQ:
			ac << AsmCmd1{SETBE, AL}; break;
		case Token::OP_GEQ:
			ac << AsmCmd1{SETAE, AL}; break;
		case Token::OP_NEQ:
			ac << AsmCmd1{SETNE, AL}; break;
		default:;
		}
	} else {
		left->generate(ac);
		right->generate(ac);
		ac << AsmCmd1{POPQ, R11}
		   << AsmCmd1{POPQ, RDX}
		   << AsmCmd2{XORQ, RAX, RAX}
		   << AsmCmd2{CMPQ, R11, RDX};
		switch (this->operation) {
		case Token::OP_EQUAL:
			ac << AsmCmd1{SETE, AL}; break;
		case Token::OP_GREATER:
			ac << AsmCmd1{SETG, AL}; break;
		case Token::OP_LESS:
			ac << AsmCmd1{SETL, AL}; break;
		case Token::OP_LEQ:
			ac << AsmCmd1{SETLE, AL}; break;
		case Token::OP_GEQ:
			ac << AsmCmd1{SETGE, AL}; break;
		case Token::OP_NEQ:
			ac << AsmCmd1{SETNE, AL}; break;
		default:;
		}
	}
	ac << AsmCmd1{PUSHQ, RAX};
}

void NodeBinaryOperator::m_gen_bin(AsmCode& ac) {
	left->generate(ac);
	ac << AsmCmd1{POPQ, RAX};
	AsmLabel _true, _false;
	switch (this->operation) {
	case Token::OP_AND:
		ac << AsmCmd2{TESTQ, RAX, RAX}
		   << AsmCmd1{JZ, _false};
		right->generate(ac);
		ac << AsmCmd1{POPQ, RAX}
		   << AsmCmd2{TESTQ, RAX, RAX}
		   << AsmCmd1{JZ, _false}
		   << AsmCmd1{PUSHQ, (int64_t)1}
		   << AsmCmd1{JMP, _true}
		   << _false
		   << AsmCmd1{PUSHQ, (int64_t)0}
		   << _true;
		return;
	case Token::OP_OR:
		ac << AsmCmd2{TESTQ, RAX, RAX}
		   << AsmCmd1{JNZ, _true};
		right->generate(ac);
		ac << AsmCmd1{POPQ, RAX}
		   << AsmCmd2{TESTQ, RAX, RAX}
		   << AsmCmd1{JNZ, _true}
		   << AsmCmd1{PUSHQ, (int64_t)0}
		   << AsmCmd1{JMP, _false}
		   << _true
		   << AsmCmd1{PUSHQ, (int64_t)1}
		   << _false;
		return;
	case Token::OP_XOR:
		right->generate(ac);
		ac << AsmCmd1{POPQ, RBX}
		   << AsmCmd2{XORQ, RBX, RAX};
		break;
	case Token::OP_SHL:
		right->generate(ac);
		ac << AsmCmd1{POPQ, RCX}
		   << AsmCmd2{SHLQ, CL, RAX};
		break;
	case Token::OP_SHR:
		right->generate(ac);
		ac << AsmCmd1{POPQ, RCX}
		   << AsmCmd2{SHRQ, CL, RAX};
		break;
	case Token::OP_MOD:
		right->generate(ac);
		ac << AsmCmd1{POPQ, RBX}
		   << AsmCmd2{XORQ, RDX, RDX}
		   << AsmCmd0{CQO}
		   << AsmCmd1{IDIVQ, RBX}
		   << AsmCmd2{MOVQ, RDX, RAX};
		;
	default:;
	}
	ac << AsmCmd1{PUSHQ, RAX};
}

void NodeBinaryOperator::generate(AsmCode& ac) {
	switch (this->operation) {
	case Token::OP_PLUS:
	case Token::OP_MINUS:
	case Token::OP_MULT:
	case Token::OP_DIV:
	case Token::OP_DIV_SLASH:
		m_gen_arithm(ac);
		return;
	case Token::OP_EQUAL:
	case Token::OP_GREATER:
	case Token::OP_LESS:
	case Token::OP_LEQ:
	case Token::OP_GEQ:
	case Token::OP_NEQ:
		m_gen_cmp(ac);
		return;
	case Token::OP_AND:
	case Token::OP_OR:
	case Token::OP_XOR:
	case Token::OP_SHL:
	case Token::OP_SHR:
	case Token::OP_MOD:
		m_gen_bin(ac);
		return;
	default:;
	}
}

void NodeUnaryOperator::generate(AsmCode& ac) {
	switch (this->operation) {
	case Token::OP_MINUS:
		this->node->generate(ac);
		ac << AsmCmd1{POPQ, RAX};
		if (this->exprtype() == NodeInteger::type_sym_ptr) {
			ac << AsmCmd1{NEGQ, RAX};
		} else {
			ac << AsmCmd2{MOVQ, RAX, XMM1}
			   << AsmCmd2{XORPD, XMM0, XMM0}
			   << AsmCmd2{SUBSD, XMM1, XMM0}
			   << AsmCmd2{MOVQ, XMM0, RAX};
		}
		ac << AsmCmd1{PUSHQ, RAX};
		break;
	case Token::OP_DEREFERENCE:
		this->node->generate(ac);
		ac << AsmCmd1{POPQ, RAX}
		   << AsmCmd1{PUSHQ, AsmOffs{RAX}};
		break;
	case Token::OP_AT:
		this->node->generate_lvalue(ac);
		break;
	case Token::OP_NOT:
		this->node->generate(ac);
		ac << AsmCmd1{POPQ, RAX}
		   << AsmCmd2{XORQ, (int64_t)1, RAX}
		   << AsmCmd1{PUSHQ, RAX};
		break;
	default:;
	}
}

void NodeArrayAccess::generate(AsmCode& ac) {
	int64_t sz = dynamic_pointer_cast<SymbolTypeArray>(this->array->exprtype())->type->size();
	m_gen_start_address(ac);
	m_gen_index(ac);
	ac << AsmCmd1{POPQ, R12}
	   << AsmCmd2{IMULQ, sz, R12}
	   << AsmCmd1{POPQ, R10}
	   << AsmCmd2{MOVQ, AsmOffs{R10, R12, 1}, R10}
	   << AsmCmd1{PUSHQ, R10};
}

void NodeRecordAccess::generate(AsmCode& ac) {
	int64_t offs = this->st->offsetb(this->field->name);
	m_gen_start_address(ac);
	ac << AsmCmd1{POPQ, R11}
	   << AsmCmd2{MOVQ, offs, R13}
	   << AsmCmd2{MOVQ, AsmOffs{R11, R13, 1}, R11}
	   << AsmCmd1{PUSHQ, R11};
}

void NodeStmtAssign::generate(AsmCode& ac) {
	right->generate(ac);
	right->exprtype()->gen_typecast(ac, left->exprtype());
	left->generate_lvalue(ac);
	left->generate_assign(ac);
}

void NodeStmtVar::generate(AsmCode& ac) {
	for (PNodeVarDeclarationUnit unit: this->units) {
		for (PNodeVariable var: unit->vars) {
			var->declare(ac);
			if (unit->initializer) {
				unit->initializer->expr->generate(ac.buf());
				unit->initializer->expr->exprtype()->gen_typecast(ac.buf(), var->exprtype());
				var->generate_lvalue(ac.buf());
				ac.buf() << AsmCmd1{POPQ, RAX}
				         << AsmCmd1{POPQ, AsmOffs(RAX)};
			}
		}
	}
}

void NodeExprStmtFunctionCall::generate(AsmCode& ac) {
	if (m_predefined == Predefined::WRITE || m_predefined == Predefined::WRITELN) {
		if (this->args) {
			for (PNodeExpression expr: this->args->arglist) {
				m_write(ac, expr);
			}
		}
		if (m_predefined == Predefined::WRITELN) {
			ac << AsmCmd2{LEAQ, AsmVar{fmt_newline}, RDI}
			   << AsmCmd1{CALL, PRINTF};
		}
		return;
	}
	if (m_predefined == EXIT) {
		PSymbolFunction f = dynamic_pointer_cast<SymbolFunction>(proc_func_exit.top());
		if (f) {
			int64_t rsz = f->type->size();
			int64_t psz = f->params ? f->params->size() : 0;
			this->args->arglist.at(0)->generate(ac);
/// TODO
//			ac << AsmCmd2{MOVQ, }
//			   << AsmCmd2{ADDQ, rsz + psz, RSP}
//			   << AsmCmd2{SUBQ, (int64_t), RSP};
		}
		ac << AsmCmd1{POPQ, RBP}
		   << AsmCmd0{RET};
		return;
	}
	if (this->args && this->args->arglist.size() > 0) {
		vector<PNodeExpression>& args = this->args->arglist;
		for (auto parg = args.rbegin(); parg != args.rend(); parg++) {
			(*parg)->generate(ac);
		}
	}
	PSymbolFunction f = dynamic_pointer_cast<SymbolFunction>(this->proc);
	if (f) {
		ac << AsmCmd2{SUBQ, (int64_t)f->type->size(), RSP};
	}
	ac << AsmCmd1{CALL, AsmVar{this->proc->name}};
}

void NodeStmtIf::generate(AsmCode& ac) {
	AsmLabel _else, _endif;
	this->cond->generate(ac);
	ac << AsmCmd1{POPQ, RAX}
	   << AsmCmd2{TESTQ, RAX, RAX}
	   << AsmCmd1{JZ, _else};
	this->then_stmt->generate(ac);
	ac << AsmCmd1{JMP, _endif}
	   << _else;
	if (this->else_stmt) {
		this->else_stmt->generate(ac);
	}
	ac << _endif;
}

void NodeStmtWhile::generate(AsmCode& ac) {
	AsmLabel _body, _end;
	cycle_continue_break.push({_body, _end});
	ac << _body;
	this->cond->generate(ac);
	ac << AsmCmd1{POPQ, RAX}
	   << AsmCmd2{TESTQ, RAX, RAX}
	   << AsmCmd1{JZ, _end};
	this->stmt->generate(ac);
	ac << AsmCmd1{JMP, _body}
	   << _end;
	cycle_continue_break.pop();
}

void NodeStmtRepeat::generate(AsmCode& ac) {
	AsmLabel _body, _end;
	cycle_continue_break.push({_body, _end});
	ac << _body;
	this->stmt->generate(ac);
	this->cond->generate(ac);
	ac << AsmCmd1{POPQ, RAX}
	   << AsmCmd2{TESTQ, RAX, RAX}
	   << AsmCmd1{JZ, _body}
	   << _end;
	cycle_continue_break.pop();
}

void NodeStmtFor::generate(AsmCode& ac) {
	AsmLabel _body, _end, _continue;
	cycle_continue_break.push({_continue, _end});
	/// init
	this->low->generate(ac);
	this->iter_var->generate_lvalue(ac);
	this->high->generate(ac);
	ac << AsmCmd1{POPQ, R13}
	   << AsmCmd1{POPQ, R14}
	   << AsmCmd1{POPQ, AsmOffs{R14}};
	/// pre-check
	ac << AsmCmd2{MOVQ, AsmOffs{R14}, R14}
	   << AsmCmd2{CMPQ, R14, R13}
	   << AsmCmd1{(is_inc ? JL : JG), _end};
	/// statement
	ac << _body;
	this->stmt->generate(ac);
	/// check condition
	ac << _continue;
	this->high->generate(ac);
	this->iter_var->generate(ac);
	ac << AsmCmd1{POPQ, R13}
	   << AsmCmd1{POPQ, R14}
	   << AsmCmd2{CMPQ, R13, R14}
	   << AsmCmd1{(is_inc ? JLE : JGE), _end};
	/// inc or dec
	this->iter_var->generate_lvalue(ac);
	ac << AsmCmd1{POPQ, R12}
	   << AsmCmd2{(is_inc ? ADDQ : SUBQ), (int64_t)1, AsmOffs{R12}}
	   << AsmCmd1{JMP, _body}
	   << _end;
	cycle_continue_break.pop();
}

void NodeStmtBreak::generate(AsmCode& ac) {
	ac << AsmCmd1{JMP, cycle_continue_break.top().second};
}

void NodeStmtContinue::generate(AsmCode& ac) {
	ac << AsmCmd1{JMP, cycle_continue_break.top().first};
}

void NodeStmtProcedure::generate(AsmCode& ac) {
	if (this->parts.size() == 0) {
		/// If forward
		return;
	}
	proc_func_exit.push(this->symbol);
	AsmCode& pd = ac.proc_defs();
	pd << AsmLabel{var_prefix + this->name->name};
	/// args were pushed before in reversed order
	pd << AsmCmd1{PUSHQ, RBP}      /// prolog
	   << AsmCmd2{MOVQ, RSP, RBP}  ///
	   << AsmCmd2{SUBQ, (int64_t)(symbol->locals->size() - symbol->params->size()), RSP}; /// local variables (locals = locals + params)

	for (PNodeStmt stmt: this->parts) {
		if (dynamic_pointer_cast<NodeStmtBlock>(stmt)) {
			stmt->generate(pd);
		}
	}

	pd << AsmCmd1{POPQ, RBP} /// epilog
	   << AsmCmd0{RET};       ///
	proc_func_exit.pop();
}

void NodeStmtFunction::generate(AsmCode& ac) {
	if (this->parts.size() == 0) {
		/// If forward
		return;
	}
	proc_func_exit.push(this->symbol);
	AsmCode& pd = ac.proc_defs();
	pd << AsmLabel{var_prefix + this->name->name};
	/// args were pushed before in reversed order
	pd << AsmCmd1{PUSHQ, RBP}      /// prolog
	   << AsmCmd2{MOVQ, RSP, RBP}  ///
	   << AsmCmd2{SUBQ, (int64_t)(symbol->locals->size() - symbol->params->size()), RSP}; /// local variables (locals = locals + params)

	for (PNodeStmt stmt: this->parts) {
		if (dynamic_pointer_cast<NodeStmtBlock>(stmt)) {
			stmt->generate(pd);
		}
	}

	pd << AsmCmd1{POPQ, RBP} /// epilog
	   << AsmCmd0{RET};       ///
	proc_func_exit.pop();
}

void NodeExprStmtFunctionCall::m_write(AsmCode& ac, PNodeExpression expr) {
	expr->generate(ac);
	expr->write(ac);
}

void NodeStmtBlock::generate(AsmCode& ac) {
//	ac << AsmComment{"start block"};
	for (PNode stmt: this->stmts) {
		stmt->generate(ac);
	}
//	ac << AsmComment{"end block"};
}

void NodeProgram::generate(AsmCode& ac) {
	ac.add_data(make_shared<AsmVarString>(SymbolTypeInt::fml_label, "%Ld"));
	ac.add_data(make_shared<AsmVarString>(SymbolTypeFloat::fml_label, "%lf"));
	ac.add_data(make_shared<AsmVarString>(fmt_newline, "\n"));
	ac << *ac.add_data(make_shared<AsmGlobl>("main"));
	ac << AsmCmd1{PUSHQ, RBP}
	   << AsmCmd2{MOVQ, RSP, RBP};
	ac.push_buf();
	for (PNode part: this->parts) {
		if (dynamic_pointer_cast<NodeStmtBlock>(part)) {
			ac.pop_buf();
		}
		part->generate(ac);
	}
	ac << AsmCmd1{POPQ, RBP}
	   << AsmCmd2{XORQ, RAX, RAX}
	   << AsmCmd0{RET};
	ac.append(ac.proc_defs());
}

void NodeExpression::write(AsmCode& ac) {
	this->exprtype()->gen_write(ac);
}

void NodeExpression::generate_lvalue(AsmCode& ac) {
	ac << AsmComment("TODO: define assign for this kind of expr; or compiler must throw here");
}

void NodeExpression::generate_assign(AsmCode& ac) {
	ac << AsmCmd1{POPQ, RAX}
	   << AsmCmd1{POPQ, AsmOffs(RAX)};
}

void NodeInteger::write(AsmCode& ac) {
	NodeInteger::type_sym_ptr->gen_write(ac);
}

void NodeFloat::write(AsmCode& ac) {
	NodeFloat::type_sym_ptr->gen_write(ac);
}

void NodeString::write(AsmCode& ac) {
	ac << AsmCmd2{LEAQ, dynamic_pointer_cast<AsmVar>(m_label), RDI}
	   << AsmCmd1{CALL, PRINTF};
}






















