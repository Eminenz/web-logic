formula = ws inner:biimplication ws { return inner; }
biimplication = f:implication ws "<=>" ws s:biimplication { return new logic.Formula(logic.FormulaType.BIIMPLICATION, f, s); }
              / bottom:implication { return bottom; }
implication = f:disjunction ws "=>" ws s:implication { return new logic.Formula(logic.FormulaType.IMPLICATION, f, s); }
            / bottom:disjunction { return bottom; }
disjunction = f:conjunction ws "|" ws s:disjunction { return new logic.Formula(logic.FormulaType.DISJUNCTION, f, s); }
            / bottom:conjunction { return bottom; }
conjunction = f:negation ws "&" ws s:conjunction { return new logic.Formula(logic.FormulaType.CONJUNCTION, f, s); }
            / bottom:negation { return bottom; }
negation = "~" ws inner:negation { return new logic.Formula(logic.FormulaType.NEGATION, inner); }
            / bottom:atom { return bottom; }

variable = ws name:[a-zA-Z]+ ws { return new logic.Formula(logic.FormulaType.ATOM, name.join("")); }
variableList = ws f:variable ws "," ws r:variableList{ return [f].concat(r); }
             / ws l:variable ws { return [l] };

ws = [" "]*

atom = alone:predicate { return alone; }
     / alone:quantification { return alone; }
     / "(" ws alone:formula ws ")" { return alone; }

predicate = name:[a-zA-Z]+ "(" ws variableList:variableList ws ")" { return new logic.Formula(logic.FormulaType.ATOM, name.join(""), variableList); }
          / f:variable ws "=" ws s:variable { return new logic.Formula(logic.FormulaType.ATOM, "=", [f, s]); }
quantification = "!" ws quantifiedVariable:variable ws "." ws inner:negation { return new logic.Formula(logic.FormulaType.UNIVERSAL, quantifiedVariable, inner); }
               / "?" ws quantifiedVariable:variable ws "." ws inner:negation { return new logic.Formula(logic.FormulaType.EXISTENTIAL, quantifiedVariable, inner); }
