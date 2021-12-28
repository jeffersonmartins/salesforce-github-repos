/**
 * @description       : Classe teste pra RepositoryService_Callout
 * @author            : Jefferson Martins
 * @group             : 
 * @last modified on  : 12-28-2021
 * @last modified by  : Jefferson Martins
**/
@IsTest
public class RepositoryService_CalloutTest {

    private class CalloutMock implements HttpCalloutMock {
        public HttpResponse respond(System.HttpRequest req) {
            if (req.getEndpoint().endsWith('page=1')) {
                HttpResponse res = new HttpResponse();
                res.setBody(
                    '{'+
                    '    "total_count": 10763827,'+
                    '    "incomplete_results": true,'+
                    '    "items": ['+
                    '      {'+
                    '        "id": 121395510,'+
                    '        "node_id": "MDEwOlJlcG9zaXRvcnkxMjEzOTU1MTA=",'+
                    '        "name": "CS-Notes",'+
                    '        "full_name": "CyC2018/CS-Notes",'+
                    '        "private": false,'+
                    '        "owner": {'+
                    '          "login": "CyC2018"'+
                    '    },'+
                    '    "html_url": "https://github.com/CyC2018/CS-Notes",'+
                    '    "stargazers_count": 115925,'+
                    '    "language": "Java",'+
                    '    "forks_count": 49260 '+      
                    '  },'+
                    '  {'+
                    '    "id": 132464395,'+
                    '        "node_id": "MDEwOlJlcG9zaXRvcnkxMzI0NjQzOTU=",'+
                    '        "name": "JavaGuide",'+
                    '        "full_name": "Snailclimb/JavaGuide",'+
                    '        "private": false,'+
                    '        "owner": {'+
                    '          "login": "Snailclimb"'+
                    '        },'+
                    '        "html_url": "https://github.com/Snailclimb/JavaGuide",'+
                    '        "stargazers_count": 114945,'+
                    '        "language": "Java",'+
                    '        "forks_count": 39260'+
                    '      }'+
                    '    ]'+
                    '  }'
                );
                res.setStatusCode(200);
                return res;
            } else {
                HttpResponse res = new HttpResponse();
                res.setBody('{}');
                res.setStatusCode(422);
                return res;                
            }
        }
    }

    @IsTest
    public static void getRepositoriesTest() {
        Test.setMock(HttpCalloutMock.class, new CalloutMock());
        
        Test.startTest();
        RepositoryService_Callout.getRepositories();
        Test.stopTest();

        List<Repository__c> repositories = [SELECT Id, Name, Stargazers_Count__c, Forks_Count__c
                                            FROM Repository__c];
        System.assertEquals(2, repositories.size(), 'Expected 2 repositories, but found ' + repositories.size());
        
    }
}

