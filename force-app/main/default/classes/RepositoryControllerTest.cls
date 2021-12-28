/**
 * @description       : Classe de teste para RepositoryController
 * @author            : Jefferson Martins
 * @group             : 
 * @last modified on  : 12-28-2021
 * @last modified by  : Jefferson Martins
**/
@IsTest
public class RepositoryControllerTest {

    @IsTest
    public static void getRepositoriesTest() {
        addRepositories(10);

        Test.startTest();
        List<Repository__c> repositoriesList = RepositoryController.getRepositories();
        Test.stopTest();

        System.assertEquals(10, repositoriesList.size(), 'Expected 10, but found ' + repositoriesList.size());
    }

    @IsTest
    public static void getRepositoriesErrorTest() {
        RepositoryController.forceException = true;
        Test.startTest();
        try {
            List<Repository__c> repositoriesList = RepositoryController.getRepositories();
        } catch (HandledException e) {
            String message = e.getMessage();
            System.assertEquals('Force exception by class test', message, 'Was expected Exception message: "Force exception by class test", but found: "' + message + '"');  
        }

        Test.stopTest();

    }

    private static void addRepositories(Integer numberOfRepositories) {
        List<Repository__c> repositoriesList = new List<Repository__c>();
        for (Integer i = 0; i < numberOfRepositories; i++) {
            Repository__c repository = new Repository__c();
            repository.Name = 'Repo' + i;
            repository.Forks_Count__c = i;
            repository.GitHub_Id__c = i;
            repository.Language__c = 'Java';
            repository.Owner_Login__c = 'owner' + i;
            repository.Stargazers_Count__c = i;
            repository.Url__c = 'https://test.com';

            repositoriesList.add(repository);
        }

        insert repositoriesList;
    }
}
