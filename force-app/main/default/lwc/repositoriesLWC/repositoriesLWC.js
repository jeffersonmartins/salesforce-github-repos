import { LightningElement, wire } from 'lwc';
import getRepositories from '@salesforce/apex/RepositoryController.getRepositories';

const columns = [
    {label: 'Name', fieldName: 'Name', initialWidth: 150},
    {label: 'Stars', fieldName: 'Stargazers_Count__c', initialWidth: 100,
        cellAttributes: { iconName: 'utility:favorite' }
    },
    {label: 'Forks', fieldName: 'Forks_Count__c' , initialWidth: 100},
    {label: 'Language', fieldName: 'Language__c', initialWidth: 100},
    {label: 'URL Repo', fieldName: 'Url__c', type: 'url', typeAttributes: {label: { fieldName: 'Url__c'}, target: '_self'}},   
];

export default class RepositoriesLWC extends LightningElement {
    columns = columns;

    repositories = [];
    @wire (getRepositories, {}) 
        repositories(result) {
            if (result.error) {
                console.log(result.error);

            } else if (result.data) {
                console.log('success');
                this.repositories = result.data;
            }
        };
    

}