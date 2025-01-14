/*
 * generated by Xtext
 */
package org.xtext.xrobot.dsl.formatting

import org.eclipse.xtext.formatting.impl.AbstractDeclarativeFormatter
import org.eclipse.xtext.formatting.impl.FormattingConfig
import org.xtext.xrobot.dsl.services.XRobotDSLGrammarAccess
import com.google.inject.Inject

// import com.google.inject.Inject;
// import org.xtext.xrobot.dsl.services.XRobotDSLGrammarAccess
/**
 * This class contains custom formatting description.
 * 
 * see : http://www.eclipse.org/Xtext/documentation.html#formatting
 * on how and when to use it 
 * 
 * Also see {@link org.eclipse.xtext.xtext.XtextFormattingTokenSerializer} as an example
 */
class XRobotDSLFormatter extends AbstractDeclarativeFormatter {

	@Inject extension XRobotDSLGrammarAccess

	override protected void configureFormatting(FormattingConfig it) {
		autoLinewrap = 120

		setLinewrap(1, 2, 3).around(modeRule)
		setLinewrap(1, 2, 3).around(subRule)
		setLinewrap(1, 2, 3).around(fieldRule)
		setLinewrap(0, 1, 2).before(programAccess.robotKeyword_1)
		setLinewrap(1, 2, 3).before(programAccess.authorKeyword_3)

		for (braces: findKeywordPairs('{', '}')) {
			setLinewrap.after(braces.first)
			setIndentation(braces.first, braces.second)
			setLinewrap.before(braces.second)
		}
		for (symbol: findKeywords('(', ')', '.', ';', ',')) 
			setNoSpace.before(symbol)
		for (symbol: findKeywords('(', '.')) 
			setNoSpace.after(symbol)

		setLinewrap(1).after(XBlockExpressionAccess.group_2)
		setLinewrap(1).after(XImportDeclarationRule)

		setLinewrap(0, 1, 2).before(SL_COMMENTRule)
		setLinewrap(0, 1, 2).before(ML_COMMENTRule)
		setLinewrap(0, 1, 1).after(ML_COMMENTRule)
	}
}
