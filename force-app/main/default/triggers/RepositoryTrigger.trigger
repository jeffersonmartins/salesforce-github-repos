/**
 * @description       : Trigger para objeto Repository__c
 * @author            : Jefferson Martins
 * @group             : 
 * @last modified on  : 12-28-2021
 * @last modified by  : Jefferson Martins
**/
trigger RepositoryTrigger on Repository__c (after insert) {
    if (trigger.isInsert) {
       RepositoryTriggerHandler.processRepositorySharing(trigger.new);
    }
}