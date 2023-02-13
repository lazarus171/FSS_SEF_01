function fig = staticPlotN(Canali_eliminare, ave, timePlot, pretrigger, smpfq, pathLoc, fix)
% Funzione che produce il topoplot
% fix=0: Autoscaling
% fix=1: fix tra il min e il max

    if nargin < 7
        fix = 0;
    end
    n_timePlot = length(timePlot);
    if n_timePlot > 6
        disp('ERROR!!!!: max time plot 6 ...');
        return;
    end
    eloc = load(pathLoc).chanlocs;
    eloc = removeChannelLocs(eloc, Canali_eliminare);
    if fix == 1
        maxmin(1) = round(min(min(ave(:,:))))+1;
        maxmin(2) = round(max(max(ave(:,:))))+1;
    end
    [nch, ntp] = size(ave);
    t = ([-(pretrigger/(1000/smpfq))+1 : ntp-(pretrigger/(1000/smpfq))]*(1000/smpfq));
    fig = figure();
    j = 1;
    timePlotTemp = timePlot + pretrigger;
    for i=round(timePlotTemp*(smpfq/1000))
        hold on;
        subplot(2,n_timePlot, j);
        if fix == 1
            topoplot(ave(:,i)', eloc, 'electrodes', 'labels','maplimits', [maxmin(1) maxmin(2)]);
        else
            topoplot(ave(:,i)', eloc, 'electrodes','off');
        end
        time = sprintf('%2.1f ms', timePlot(j));
        title(time);
        j = j+1;
    end
    subplot(2, 1, 2);
    plot(t, ave(:,1:ntp)');
    hold on;
    for i=round(timePlotTemp*(smpfq/1000))
        plot(t(i), ave(:,i)','*');
    end
% time = sprintf ('%d ms <--> %d pnt ',t(i),i);% -( pretrigger/(1000/ smpfq )));
    xlabel('ms');
    xlim([t(1) t(end)]);
    hold off;
end
