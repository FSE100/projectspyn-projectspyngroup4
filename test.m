
global key;

InitKeyboard();
while 1
    pause (0.1);
    switch key
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
            break;
        case 0
            brick.StopMotor('ABCD');
    end 
    
    distance = brick.UltrasonicDist(3);
    
    if (distance < 25)
        brick.beep;
    end
    
    brick.SetColorMode(1,2);
    color = brick.ColorCode(1);
    if(color == 1)
        brick.beep;
    end
    display(color);
    if(brick.TouchPressed(2) == 1)
        brick.beep;
    end
    
    
    
    
end
CloseKeyboard();