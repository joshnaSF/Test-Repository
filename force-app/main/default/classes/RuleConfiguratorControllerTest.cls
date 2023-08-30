@isTest
public with sharing class RuleConfiguratorControllerTest {
    @isTest
    static void configController() {
        Rule_Definition__c rule = new Rule_Definition__c(Rule_Name__c='StageName Rule', Sequence__c = 1, Subject_Field__c = 'StageName',
                                                            Target_Object__c='Integration_Checklist__c',Rule_Condition__c='Equals',Value_Field__c='Value');
        Database.SaveResult rDef = Database.insert(rule);
        
        Rule_Driver__c ruleDriver = new Rule_Driver__c(Configuring_For__c='Integration Checklist', Logical_Expression__c='1 AND 2',
                                                        Match_Criteria__c='All Match', Object_Name__c='Opportunity', Target_Value__c='Get Hunter Details');
        Database.SaveResult rDriver = Database.insert(ruleDriver);
        Rule_Definition_Driver_Mapping__c rDD = new Rule_Definition_Driver_Mapping__c( Rule_Id__c=rDef.getId(), 
                                                            Rule_Driver_ID__c = rDriver.getId());
        Database.SaveResult rDefDriver = Database.insert(rDD);

        ApexPages.StandardController sc = new Apexpages.StandardController(ruleDriver);
        RuleConfiguratorController ruleConfigCtrl = new RuleConfiguratorController(sc);
        PageReference pageRef = Page.RuleConfigurator;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('Id', String.valueOf(rDriver.getId()));
        ruleConfigCtrl.saveData();
        ruleConfigCtrl.validateRules();
        ruleConfigCtrl.addRows();
        ruleConfigCtrl.deleteRow();
        ruleConfigCtrl.initializeDefaultRows(2);
	//Testing commit
    }
}