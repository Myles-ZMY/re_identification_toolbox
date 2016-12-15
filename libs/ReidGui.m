function ReidGui
% REIDGUI Graphic User Interface for Re-Identification Toolbox.

    f = figure('Visible','off','Position',[360,500,450,285]);
    
    % Construct the components.
    h_txt_select_dset = uicontrol('Style', 'text', ...
        'String', 'Select Dataset',...
        'Position', [325, 90, 60, 15]);
    h_popup_select_dset = uicontrol('Style', 'popupmenu', ...
        'String', {'ViPER'}, ...
        'Position', [300, 50, 100, 25]);
    
    f.Visible = 'on';

end