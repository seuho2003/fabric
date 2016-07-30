###Introduction to Travis CI

Continuous Integration is a development practice that requires developers to integrate code into a shared repository. Each time developer checks in code into the repository, it is then verified by an automated build process. This process gives flexibility for the developer to detect any build issues early in the build life cycle.

**hyperledger** build process is fully automated using **Travis CI** Continuous Integration tool, which helps in building a real time solution for all the code check-ins, perform Unit and Functional Tests. Once the build execution completes, developer will get build result notifications on slack, GitHub and email (Depending on configuration settings provided in .travis.yml file)

###What is continous Integration with Travis CI for hyperledger/fabric?

Travis CI is opensource ruby based cross-platform, continous integration, and continous delivery application that increase project productivity by providing continous results back to developer and making it easier for test team to obtain stable build for testing. I my self with few of my collegues started Continuous integration for hyperledger/fabric git repository in feb this year and we abosrbed and implemented Travis CI features.

Travis CI instantiate builds in a 64 bit VM's. I have got an oppurtunity to implement continous integration with fabric, which is an IBM contibution to the LINUX Foundation's Hyperledger. Fabric did not have a continous integration process where code could be pulled from github and automatically run through unit and functional tests. I my self and team comeup with Travis Travis CI in my recent project and the way Travis CI works is awesome.

Travsi

So finally after everything was up and running, I learned a few things:
