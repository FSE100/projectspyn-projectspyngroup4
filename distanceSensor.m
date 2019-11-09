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
            pause(1.2);
            brick.StopMotor('D');
            %pause(3); %IDK BUT IT BREAKS WITHOUT IT
            disp("end button pressed");
            
        %DRIVE AUTONOMOUSLY    
        elseif (buttonPressed == 0)
            brick.MoveMotor('DB', -75);
            if distance > 29 %%180 turn
                lockFar = false;
                lockClose = false;
                disp("180 degree starting");

                brick.StopMotor('BD');
                pause(1.5);



                brick.MoveMotor('DB', -50); %Move forward a little
                pause(.9);
                brick.StopMotor('BD');


                brick.MoveMotor('D', 50); %Turn 90
                pause(1.3);
                brick.StopMotor('D');

                brick.MoveMotor('DB', -50); %Move forward a little
                pause(2.25);
                brick.StopMotor('BD');

                brick.MoveMotor('D', 50); %Turn 90
                pause(1.2);
                brick.StopMotor('D');

                brick.MoveMotor('DB', -50); %Move forward a little
                pause(.75);
                brick.StopMotor('BD');

                lockFar = true;
                lockClose = true;
                %brick.MoveMotorAngleRel('B',50,-360,'Brake');
                
             elseif (distance < 6 && lockClose == true) %%Nudge left if too close
                brick.MoveMotorAngleRel('B',1,-.01,'Brake');
                lockClose = false;
                lockFar = true;
                disp("Too close: correcting");
                
            elseif (distance > 9  && distance < 29  && lockFar == true) %%Nudge left if too far
                brick.MoveMotorAngleRel('D',1,-.01,'Brake');
                lockFar = false;
                lockClose = true;
                disp("Too far: correcting");
           
           
           
            end
        end
    end

    %COLOR SENSING BEHVAIOR: SET DRIVE = FALSE FOR EACH BEHAVIOR AND IT
    %WILL STOP DRIVING
    brick.SetColorMode(1, 2);
    color = brick.ColorCode(1);
    %disp(color);

        %if color ==  5
         %   brick.MoveMotor('DB', 'Brake');
         %   brick.MoveMotorAngleRel('B',50,-30,'Brake');
        %else
         %   brick.MoveMotor('DB', -100);
       % end

      %  if color == 4

      %  end

       % if color==2
       % break;
       % end

    if color == 3
        disp("color is green");
        drive = false;
    end

    
end
CloseKeyboard();


