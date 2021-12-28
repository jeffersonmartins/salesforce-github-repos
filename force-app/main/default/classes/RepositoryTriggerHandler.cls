/**
 * @description       : Classe handler para processar registros inseridos, classe é chamada pela 
 *                      trigger RepositoryTrigger.
 * @author            : Jefferson Martins
 * @group             : 
 * @last modified on  : 12-28-2021
 * @last modified by  : Jefferson Martins
**/
public class RepositoryTriggerHandler {
    public static void processRepositorySharing(List<Repository__c> repositories) {
        List<Repository__Share> repositoryShrs = new List<Repository__Share>();
        List<Group> groups = [SELECT Id FROM Group WHERE DeveloperName = 'AllInternalUsers'];
        Repository__Share repositoryShr;
        for (Repository__c repository : repositories) {
            repositoryShr = new Repository__Share();
            repositoryShr.ParentId = repository.Id;
            repositoryShr.UserOrGroupId = groups[0].Id;
            repositoryShr.AccessLevel = 'Edit';                                            
            repositoryShr.RowCause = 'Manual';
            repositoryShrs.add(repositoryShr);
        }
        
        if (repositoryShrs.size() > 0) {
            insert repositoryShrs;
        }
    }
}
