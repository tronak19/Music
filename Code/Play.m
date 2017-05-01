%  Fs=8000;
%  Ts=1/Fs;
%  t=[0:Ts:0.3];
%  F_A = 440; %Frequency of note A is 440 Hz
%  F_B = 493.88;
%  F_Csharp = 554.37; 
%  F_D = 587.33;
%  F_E = 659.26;
%  F_Fsharp = 739.9;
%  notes = [F_A ; F_B; F_Csharp; F_D; F_E; F_Fsharp];
%  x = cos(2*pi*notes*t); 
%  sig = reshape(x',6*length(t),1);
%  soundsc(sig,1/Ts)
 
% notecreate = @(frq,dur) sin(2*pi* [1:dur]/8192 * (440*2.^((frq-1)/12)));
% notename = {'A' 'A#' 'B' 'C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' 'G#'};
% song = {'A' 'A' 'E' 'E' 'F#' 'F#' 'E' 'E' 'D' 'D' 'C#' 'C#' 'B' 'B' 'A' 'A'};
% for k1 = 1:length(song)
%     idx = strcmp(song(k1), notename);
%     songidx(k1) = find(idx);
%     fprintf('\nsongidx(k1) = %d',songidx(k1));
% end
% disp(length(songidx));
% dur = 0.3*8192;
% songnote = [];
% for k1 = 1:length(songidx)
%     songnote = [songnote; [notecreate(songidx(k1),dur)  zeros(1,75)]'];
% end
% soundsc(songnote, 8192)


notecreate = @(frq,dur) sin(2*pi* [1:dur]/8192 * (440*2.^((frq-1)/12)));
notename = {'A' 'A#' 'B' 'C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' 'G#' 'a' 'b' 'c' 'd' 'e' 'g'};
%song = {'A' 'A' 'E' 'E' 'F#' 'F#' 'E' 'E' 'D' 'D' 'C#' 'C#' 'B' 'B' 'A' 'A'};
song = {'E' 'E' 'E' 'E' 'E' 'E' 'E' 'G' 'C' 'D' 'E' 'F' 'F' 'F' 'F' 'F' 'E' 'E' 'E' 'E' 'E' 'D' 'D' 'E' 'D' 'G' 'E' 'E' 'E' 'E' 'E' 'E' 'E' };
for k1 = 1:length(song)
    idx = strcmp(song(k1), notename);
    songidx(k1) = find(idx);
end    
dur = 0.3*8192;
songnote = [];
for k1 = 1:length(songidx)
%     if(songidx(k1)<13)
% %     if(songidx(k1)=='A' ||songidx(k1)=='C' ||songidx(k1)=='D' ||songidx(k1)=='F' ||songidx(k1)=='G' ||songidx(k1)=='B') 
%     dur = 0.3*8192;
%     
%     end
%     
%     if(songidx(k1)>12)
% %     if(songidx(k1)=='a' ||songidx(k1)=='c' ||songidx(k1)=='d' ||songidx(k1)=='f' ||songidx(k1)=='g' ||songidx(k1)=='b') 
%         fprintf('current=%d\n',songidx(k1));
%         dur = 0.3*8192;
%     end
    
    songnote = [songnote; [notecreate(songidx(k1),dur)  zeros(1,75)]'];
end
soundsc(songnote, 8192)

