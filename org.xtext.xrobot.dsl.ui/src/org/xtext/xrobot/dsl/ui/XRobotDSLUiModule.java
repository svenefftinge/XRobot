/*
 * generated by Xtext
 */
package org.xtext.xrobot.dsl.ui;

import org.eclipse.ui.plugin.AbstractUIPlugin;
import org.eclipse.xtext.ui.editor.contentassist.IContentProposalPriorities;
import org.eclipse.xtext.ui.editor.contentassist.ITemplateProposalProvider;
import org.eclipse.xtext.ui.editor.hover.html.IEObjectHoverDocumentationProvider;
import org.eclipse.xtext.ui.editor.syntaxcoloring.IHighlightingConfiguration;
import org.eclipse.xtext.ui.editor.syntaxcoloring.ISemanticHighlightingCalculator;
import org.eclipse.xtext.xbase.ui.hover.XbaseDeclarativeHoverSignatureProvider;
import org.xtext.xrobot.dsl.ui.contentassist.XRobotContentProposalPriorities;
import org.xtext.xrobot.dsl.ui.contentassist.XRobotTemplateProposalProvider;
import org.xtext.xrobot.dsl.ui.highlighting.XRobotDSLHighlightingConfiguration;
import org.xtext.xrobot.dsl.ui.highlighting.XRobotDSLSemanticHighlightingCalculator;
import org.xtext.xrobot.dsl.ui.hover.XRobotHoverDocumentationProvider;
import org.xtext.xrobot.dsl.ui.hover.XRobotHoverSignatureProvider;

/**
 * Use this class to register components to be used within the IDE.
 */
public class XRobotDSLUiModule extends org.xtext.xrobot.dsl.ui.AbstractXRobotDSLUiModule {
	public XRobotDSLUiModule(AbstractUIPlugin plugin) {
		super(plugin);
	}
	
	public Class<? extends IContentProposalPriorities> bindIContentProposalPriorities() {
		return XRobotContentProposalPriorities.class;
	}
	
	public Class<? extends ITemplateProposalProvider> bindITemplateProposalProvider() {
		return XRobotTemplateProposalProvider.class;
	}
	
	@Override
	public Class<? extends ISemanticHighlightingCalculator> bindISemanticHighlightingCalculator() {
		return XRobotDSLSemanticHighlightingCalculator.class;
	}
	
	@Override
	public Class<? extends IHighlightingConfiguration> bindIHighlightingConfiguration() {
		return XRobotDSLHighlightingConfiguration.class;
	}
	
	public Class<? extends IEObjectHoverDocumentationProvider> bindIEObjectHoverDocumentationProvider() {
		return XRobotHoverDocumentationProvider.class;
	}
	
	public Class<? extends XbaseDeclarativeHoverSignatureProvider> bindXbaseDeclarativeHoverSignatureProvider() {
		return XRobotHoverSignatureProvider.class;
	}
}
