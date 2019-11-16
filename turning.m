brick.SetColorMode(1, 2);
global key;
InitKeyboard();
autoDrive = false;
lock180 = false;
while 1
    %VARIABLE UPDATING
    distance = brick.UltrasonicDist(3);    
    buttonPressed = brick.TouchPressed(2);
    color = brick.ColorCode(1);
    
    %KEYBOARD COMMANDS
    pause (.1);
    switch key
        case 'd'
            autoDrive = true;
        case 's'
            autoDrive = false;
            brick.StopMotor('ABCD');
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
    
    %IF BUTTON IS PRESSED TURN RIGHT
    if(buttonPressed == 1)
            autoDrive = false;
            
            brick.StopMotor('BD'); %STOP
            brick.MoveMotor('BD', 50); %BACKUP
            pause(.8);
            brick.StopMotor('BD'); %STOP
           
            brick.MoveMotor('D', -50);
            pause(1.18);
            brick.StopMotor('D');

            autoDrive = true;
    end
    
    %DRIVE AUTOMATICALLY
    if(autoDrive == true)
        brick.MoveMotor('BD', -50);
    end
    if (distance < 4 && autoDrive == true) %Nudge too close 
        brick.MoveMotor('D', -60); 
        lock180 = false;
    elseif (distance > 8  && distance < 30 && autoDrive == true) %Nudge too far
        brick.MoveMotor('B', -65);
        lock180 = false;
    
    elseif (distance > 30 && distance < 200 && autoDrive == true && lock180 == false)
        lock180 = true;
        autoDrive = false;
        disp("180");
       
        brick.MoveMotor('D', -35);
        brick.MoveMotor('B', -200);
        pause(1);
        brick.StopMotor('DB');
        pause(.5);
        if(color == 3 || color == 2)
            autoDrive = false;
            brick.StopMotor('BD');
            disp("mid turn stop");
        elseif( color == 5)
            brick.StopMotor('DB');
            pause(5);
            brick.MoveMotor('DB', -50); %Move forward a little
            pause(.25);
        elseif(distance < 15)
            brick.StopMotor('DB');
        else
            brick.MoveMotor('D', -35);
            brick.MoveMotor('B', -200);
            pause(1);
            brick.StopMotor('DB');
        end
        
        autoDrive = true;
   
    end
    
    if color ==  5
        disp("color is red");
        brick.StopMotor('DB');
        pause(5);
        brick.MoveMotor('DB', -50); %Move forward a little
        pause(.25);
        lock180 = false;

    elseif color==2
        disp("color is blue");
        autoDrive = false;
        brick.StopMotor('BD');

    elseif color == 3
    
        autoDrive = false;
        brick.StopMotor('BD');
        
    elseif color == 4
        disp("color is yellow")
    end
end
CloseKeyboard();
