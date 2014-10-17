/*
* generated by Xtext
*/
package org.xtext.xrobot.dsl.ui.labeling

import com.google.inject.Inject
import org.eclipse.emf.edit.ui.provider.AdapterFactoryLabelProvider
import org.eclipse.xtext.xbase.ui.labeling.XbaseLabelProvider
import org.eclipse.jface.resource.ImageDescriptor
import org.xtext.xrobot.dsl.xRobotDSL.Mode
import org.eclipse.xtext.xbase.ui.labeling.XbaseImages2
import static org.eclipse.xtext.common.types.JvmVisibility.*
import org.xtext.xrobot.dsl.xRobotDSL.Sub
import org.xtext.xrobot.dsl.xRobotDSL.Field

/**
 * Provides labels for a EObjects.
 * 
 * see http://www.eclipse.org/Xtext/documentation.html#labelProvider
 */
class XRobotDSLLabelProvider extends XbaseLabelProvider {

	@Inject XbaseImages2 images 
	
	@Inject
	new(AdapterFactoryLabelProvider delegate) {
		super(delegate);
	}

	protected def dispatch ImageDescriptor imageDescriptor(Mode mode) {
		images.forOperation(DEFAULT, 0)
	}

	protected def dispatch ImageDescriptor imageDescriptor(Sub sub) {
		images.forOperation(PUBLIC, 0)
	}

	protected def dispatch ImageDescriptor imageDescriptor(Field sub) {
		images.forField(PRIVATE, 0)
	}

}
