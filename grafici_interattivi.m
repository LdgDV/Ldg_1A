% Script grafici interattivi
%
%

for i = 1:length(X)
    plot(U(1:i),W(1:i))
    xlabel('U [~]')
    ylabel('W [~]')
    axis([min(U) max(U) min(W) max(W)])
    title(['Odografa per t = ',num2str(out.tout(i))])
    hold on
    
    plot(U(i),W(i),'o','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','r')
    
    pause(0.0001)
    frame = getframe(1);
    img = frame2im(frame);
    [imgind,cm]=rgb2ind(img,256);
    
    if i==1
        imwrite(imgind,cm,'Odo+40_simple.gif','gif','DelayTime',0,'loopcount',inf);
    else
        imwrite(imgind,cm,'Odo+40_simple.gif','gif','DelayTime',0,'writemode','append');
    end
    
    hold off
end
pause
