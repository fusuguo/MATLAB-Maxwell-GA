function MaxNewProject(fid)
% Preamble.
fprintf(fid, 'Dim oAnsoftApp\n');
fprintf(fid, 'Dim oDesktop\n');
fprintf(fid, 'Dim oProject\n');
fprintf(fid, 'Dim oDesign\n');
fprintf(fid, 'Dim oEditor\n');
fprintf(fid, 'Dim oModule\n');
fprintf(fid, '\n');

% Create a New Project.
fprintf(fid, 'Set oAnsoftApp = CreateObject("AnsoftMaxwell.MaxwellScriptInterface")\n');
% 45行要改hfss-->Maxwell
fprintf(fid, 'Set oDesktop = oAnsoftApp.GetAppDesktop()\n');
fprintf(fid, 'oDesktop.RestoreWindow\n');
fprintf(fid, 'Set oProject = oDesktop.NewProject \n'); 

% The new project created is the active project.
end
