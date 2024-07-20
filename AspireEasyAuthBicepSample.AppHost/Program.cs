using Aspire.Hosting;

var builder = DistributedApplication.CreateBuilder(args);

var apiService = builder.AddProject<Projects.AspireEasyAuthBicepSample_ApiService>("apiservice");


//var githubClientId = builder.AddParameter("githubClientId", secret: false);
//var githubClientSecret = builder.AddParameter("githubClientSecret", secret: true);

builder.AddProject<Projects.AspireEasyAuthBicepSample_Web>("webfrontend")
	.WithExternalHttpEndpoints()
	.WithReference(apiService);

builder.AddBicepTemplate(name: "acaauth", bicepFile: "./infra/aca-auth-config.bicep")
	.WithParameter("name", "aca-github-auth")
	.WithParameter("clientId", string.Empty)
	.WithParameter("clientSecretName", string.Empty);

builder.Build().Run();
