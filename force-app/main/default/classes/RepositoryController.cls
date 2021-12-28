/**
 * @description       : Classe controller para o Repository__c
 * @author            : Jefferson Martins
 * @group             : 
 * @last modified on  : 12-28-2021
 * @last modified by  : Jefferson Martins
**/
public class RepositoryController {


    @testVisible private static Boolean forceException = false;

    @AuraEnabled(cacheable=true)
    public static List<Repository__c> getRepositories(){
        try {

            if (forceException){
                throw new HandledException('Force exception by class test');
            }

            return [SELECT Id, Name, 
                        Stargazers_Count__c, 
                        Forks_Count__c,
                        GitHub_Id__c,
                        Language__c,
                        Url__c,
                        Owner_Login__c
                    FROM Repository__c
                    ORDER BY Stargazers_Count__c DESC];

        } catch (Exception e) {            
            throw new HandledException(e.getMessage());
        }
    }


}


