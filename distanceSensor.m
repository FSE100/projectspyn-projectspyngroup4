clearvars -except brick;
%brick.StopMotor('BD');
distanjceSensorPort = 3;
lockClose = true;
lockFar = true;

drive = false;

global key;
InitKeyboard();
while 1
    pause (.1);
    switch key
        case 'd'
            drive = true;
        case 's'
            drive = false;
        case 'uparrow'
            brick.MoveMotor('DB', -50);
        case 'downarrow'
            brick.MoveMotor('DB', 50);
        case 'leftarrow'
            brick.MoveMotorAngleRel('D',50,-360,'Brake');
        case 'rightarrow'
            brick.MoveMotorAngleRel('B',50,-360,'Brake');
        case 'p'
            brick.MoveMotor('A', -15);
        case 'o'
            brick.MoveMotor('A', 15);
        case 'q'
           brick.StopMotor('BD');
           break;
        case 0
            
    end
    
    distance = brick.UltrasonicDist(3);
    buttonPressed = brick.TouchPressed(2);
    
    brick.SetColorMode(1, 2);
    color = brick.ColorCode(1);
    
    if(drive == true)
        
        %FRONT BUTTON PRESSED: STOP -> BACK UP -> TURN 90 -> GO
        if(buttonPressed == 1)
            disp("button pressed");
            brick.StopMotor('BD'); %STOP
            brick.MoveMotor('BD', 50); %BACKUP
            pause(.75);
            brick.StopMotor('BD'); %STOP
            pause(.75);
           
            brick.MoveMotor('D', -50);
            pause(1.5);
            brick.StopMotor('D');
            %pause(3); %IDK BUT IT BREAKS WITHOUT IT
            disp("end button pressed");
            
        %DRIVE AUTONOMOUSLY    
        elseif (buttonPressed == 0)
            if (distance < 5) %%Nudge left if too close
                disp("START TOO CLOSE");
                brick.MoveMotor('B', 50);
                pause(.03);
                brick.StopMotor('B');
                brick.MoveMotor('DB', 100);
                pause(.25);
               % brick.StopMotor('DB');
                %lockClose = false;
                %lockFar = true;
                disp("END TOO CLOSE");
                
            elseif (distance > 20  && distance < 30) %%Nudge left if too far
                disp("START TOO FAR");
                brick.MoveMotor('D', 50);
                pause(.03);
                brick.StopMotor('D');
                brick.MoveMotor('DB', 100);
                pause(.25);
               %q brick.StopMotor('DB');
                %lockFar = false;
                %lockClose = true;
                disp("END TOO FAR");
            else
                brick.MoveMotor('DB', 100);
                pause(.25);
                brick.StopMotor('DB');
            %{
            elseif distance > 40 && distance < 100 %%180 turn
                lockFar = false;
                lockClose = false;
                disp("180 degree starting");

                brick.MoveMotor('DB', -100); %Move forward a little
                pause(.45);
                brick.StopMotor('BD');
                
                brick.MoveMotor('D', 100); %Turn 90
                pause(.65);
                brick.StopMotor('D');
                if(color == 5)
                    brick.StopMotor('BD');
                    pause(5);
                end

                brick.MoveMotor('DB', -100); %Move forward a little
                pause(1);
                brick.StopMotor('BD');

                brick.MoveMotor('D', 100); %Turn 90
                pause(.3);
                brick.StopMotor('D');

                brick.MoveMotor('DB', -100); %Move forward a little
                pause(.75/2);
                brick.StopMotor('BD');

                lockFar = true;
                lockClose = true;
                %brick.MoveMotorAngleRel('B',50,-360,'Brake');
                
           %}
            end
        end
    end

    %COLOR SENSING BEHVAIOR: SET DRIVE = FALSE FOR EACH BEHAVIOR AND IT
    %WILL STOP DRIVING
    
    %disp(color);
    
    if color ==  5
        disp("color is red");
        brick.StopMotor('DB');
        pause(5);
        brick.MoveMotor('DB', -50); %Move forward a little
        pause(.25);
  
    elseif color==2
        disp("color is blue");
        brick.StopMotor('BD');
        drive = false;
        pause(5);
    elseif color == 3
        disp("color is green");
        brick.StopMotor('BD');
        drive = false;
        pause(5);  
    elseif color == 4
        disp("color is yellow")
    end
   
    
end
CloseKeyboard();


