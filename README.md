# Building SAS Macros and Tracking Their Use

Many of the routine tasks we do in SAS can be converted into parameterized macros. Whether you are pulling standard data sets for ad hoc reports or some other low-level functionality, macros can help make repetitious tasks more palatable. Developing a common macro script structure and committing to it are just the first steps toward having a more concise code base.

One immediate benefit of using macros is the ease of implementing code changes. Typically, estimating the impact of impending source changes is a distributed task—end-users are asked to identify potential breaks in their code base. If these users tend to work with different versions of code for different projects or requests, the number of SAS files to scour through quickly multiplies. With macros, there will be a small fraction of SAS files to evaluate. Further, when it comes time to implement the changes, working with a smaller number of macros will always be easier than working with a larger number of files.

Macros have a tendency to proliferate in their own right, though this is hopefuly the result of identifying new opportunities for macros to replace longer pieces of code. With many macros being used throughout an organization, being able to track their use also becomes important.

Tracking what macros are called when and by whom provides those responsible for maintaining the macros with vital informaiton which can be leveraged to gather targeted feedback regarding upgrades or help identify macros to be discontinued.

This paper outlines framework for developing component macros that report back macro usage. While the framework was developed in a SAS 9.1/9.2 client-server environment (running under Windows XP, 32-bit), it should work under any client-server environment and could be modified to run under disparate clients sharing a common networked drive.