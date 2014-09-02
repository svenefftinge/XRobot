/**
 */
package org.xtext.xrobot.dsl.xRobotDSL.impl;

import java.util.Collection;

import org.eclipse.emf.common.notify.NotificationChain;

import org.eclipse.emf.common.util.EList;

import org.eclipse.emf.ecore.EClass;
import org.eclipse.emf.ecore.InternalEObject;

import org.eclipse.emf.ecore.impl.MinimalEObjectImpl;

import org.eclipse.emf.ecore.util.EObjectContainmentEList;
import org.eclipse.emf.ecore.util.InternalEList;

import org.xtext.xrobot.dsl.xRobotDSL.Field;
import org.xtext.xrobot.dsl.xRobotDSL.Mode;
import org.xtext.xrobot.dsl.xRobotDSL.Program;
import org.xtext.xrobot.dsl.xRobotDSL.Sub;
import org.xtext.xrobot.dsl.xRobotDSL.XRobotDSLPackage;

/**
 * <!-- begin-user-doc -->
 * An implementation of the model object '<em><b>Program</b></em>'.
 * <!-- end-user-doc -->
 * <p>
 * The following features are implemented:
 * <ul>
 *   <li>{@link org.xtext.xrobot.dsl.xRobotDSL.impl.ProgramImpl#getSubs <em>Subs</em>}</li>
 *   <li>{@link org.xtext.xrobot.dsl.xRobotDSL.impl.ProgramImpl#getFields <em>Fields</em>}</li>
 *   <li>{@link org.xtext.xrobot.dsl.xRobotDSL.impl.ProgramImpl#getModes <em>Modes</em>}</li>
 * </ul>
 * </p>
 *
 * @generated
 */
public class ProgramImpl extends MinimalEObjectImpl.Container implements Program
{
  /**
   * The cached value of the '{@link #getSubs() <em>Subs</em>}' containment reference list.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see #getSubs()
   * @generated
   * @ordered
   */
  protected EList<Sub> subs;

  /**
   * The cached value of the '{@link #getFields() <em>Fields</em>}' containment reference list.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see #getFields()
   * @generated
   * @ordered
   */
  protected EList<Field> fields;

  /**
   * The cached value of the '{@link #getModes() <em>Modes</em>}' containment reference list.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see #getModes()
   * @generated
   * @ordered
   */
  protected EList<Mode> modes;

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  protected ProgramImpl()
  {
    super();
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  protected EClass eStaticClass()
  {
    return XRobotDSLPackage.Literals.PROGRAM;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EList<Sub> getSubs()
  {
    if (subs == null)
    {
      subs = new EObjectContainmentEList<Sub>(Sub.class, this, XRobotDSLPackage.PROGRAM__SUBS);
    }
    return subs;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EList<Field> getFields()
  {
    if (fields == null)
    {
      fields = new EObjectContainmentEList<Field>(Field.class, this, XRobotDSLPackage.PROGRAM__FIELDS);
    }
    return fields;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EList<Mode> getModes()
  {
    if (modes == null)
    {
      modes = new EObjectContainmentEList<Mode>(Mode.class, this, XRobotDSLPackage.PROGRAM__MODES);
    }
    return modes;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public NotificationChain eInverseRemove(InternalEObject otherEnd, int featureID, NotificationChain msgs)
  {
    switch (featureID)
    {
      case XRobotDSLPackage.PROGRAM__SUBS:
        return ((InternalEList<?>)getSubs()).basicRemove(otherEnd, msgs);
      case XRobotDSLPackage.PROGRAM__FIELDS:
        return ((InternalEList<?>)getFields()).basicRemove(otherEnd, msgs);
      case XRobotDSLPackage.PROGRAM__MODES:
        return ((InternalEList<?>)getModes()).basicRemove(otherEnd, msgs);
    }
    return super.eInverseRemove(otherEnd, featureID, msgs);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public Object eGet(int featureID, boolean resolve, boolean coreType)
  {
    switch (featureID)
    {
      case XRobotDSLPackage.PROGRAM__SUBS:
        return getSubs();
      case XRobotDSLPackage.PROGRAM__FIELDS:
        return getFields();
      case XRobotDSLPackage.PROGRAM__MODES:
        return getModes();
    }
    return super.eGet(featureID, resolve, coreType);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @SuppressWarnings("unchecked")
  @Override
  public void eSet(int featureID, Object newValue)
  {
    switch (featureID)
    {
      case XRobotDSLPackage.PROGRAM__SUBS:
        getSubs().clear();
        getSubs().addAll((Collection<? extends Sub>)newValue);
        return;
      case XRobotDSLPackage.PROGRAM__FIELDS:
        getFields().clear();
        getFields().addAll((Collection<? extends Field>)newValue);
        return;
      case XRobotDSLPackage.PROGRAM__MODES:
        getModes().clear();
        getModes().addAll((Collection<? extends Mode>)newValue);
        return;
    }
    super.eSet(featureID, newValue);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public void eUnset(int featureID)
  {
    switch (featureID)
    {
      case XRobotDSLPackage.PROGRAM__SUBS:
        getSubs().clear();
        return;
      case XRobotDSLPackage.PROGRAM__FIELDS:
        getFields().clear();
        return;
      case XRobotDSLPackage.PROGRAM__MODES:
        getModes().clear();
        return;
    }
    super.eUnset(featureID);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public boolean eIsSet(int featureID)
  {
    switch (featureID)
    {
      case XRobotDSLPackage.PROGRAM__SUBS:
        return subs != null && !subs.isEmpty();
      case XRobotDSLPackage.PROGRAM__FIELDS:
        return fields != null && !fields.isEmpty();
      case XRobotDSLPackage.PROGRAM__MODES:
        return modes != null && !modes.isEmpty();
    }
    return super.eIsSet(featureID);
  }

} //ProgramImpl
