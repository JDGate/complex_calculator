disp("Welcome to the Complex Calculator!")
# This line is here solely for the purpose of not having the function declaration first
# in the program. Octave interprets files with a function declaration at the top differently
# from a program that has something else at the top. As function declarations in Octave need
# to be before they are called (MATLAB behaves differently), this display line allows the
# function declaration to be at the top of the program while also keeping the file as a script file
# rather than as a function file (both have file ending of .m though).

clear -a # This clears the variable workspace, including global variables
global prev_answer = 0;
program_status = 1;

# If running in Octave, this function definition should be at the beginning of the program.
# If running on MatLab, this function definition should be at the end of the program.
function complex_input = get_complex_input
  #disp("getting complex input")
  global prev_answer;
  valid_response = false;
  while (valid_response == false)
    complex_type = input("Rectangular or Polar? Type 'r' or 'p' to choose.\nYou may also type 'a' to use the previous answer.\n", "s");
    if (complex_type == 'r')
      valid_response = true;
      complex_input = input("Type the number like so: a+bi\n");
    elseif (complex_type == 'p')
      valid_response = true;
      complex_mag = input("Type the magnitude:\n");
      complex_angle = input("Type the angle:\n");
      # The 'd' appended to the sine and cosine functions mean they work with degrees rather than radians.
      complex_input = (complex_mag*cosd(complex_angle)) + (complex_mag*sind(complex_angle))*i;
    elseif (complex_type == 'a')
      valid_response = true;
      complex_input = prev_answer;
      disp(complex_input);
    else
      disp("Please input a valid response.");
    endif
  endwhile
endfunction

while (program_status == 1)
  clc # This clears the command window
  disp("Enter 'p' for parallel impedances.")
  disp("Enter 'l' for adding impedances.")
  disp("Enter '/' to quit the program.")
  disp("NOTE: All angles are in degrees.\n")
  command = input("Which operation do you desire?\n", "s");
  printf("\n")
  switch (command)
    case 'p' # Calculating parallel impedances
      global prev_answer;
      clc
      disp("Enter Value #1.")
      x = get_complex_input;
      clc
      disp("Enter Value #2.")
      y = get_complex_input;
      answer = (x*y)/(x+y);
      clc
      printf("Inputs:\nValue #1 = %f + %fi\nValue #2 = %f + %fi\n\n", real(x), imag(x), real(y), imag(y));
      printf("Equivalent Parallel Impedance:\nRectangular: %f + %fi\nPolar: %f < %f\n\n", real(answer), imag(answer), abs(answer), angle(answer)*(180/pi))
      prev_answer = answer;
      printf("\a"); # Rings the terminal bell on your computer :)
      disp("Press any key to continue.")
      pause
    case 'l' # Adding impedances
      global prev_answer;
      clc
      disp("Enter Value #1.")
      x = get_complex_input;
      clc
      disp("Enter Value #2.")
      y = get_complex_input;
      answer = x+y;
      clc
      printf("Inputs:\nValue #1 = %f + %fi\nValue #2 = %f + %fi\n\n", real(x), imag(x), real(y), imag(y));
      printf("Sum of Impedances:\nRectangular: %f + %fi\nPolar: %f < %f\n\n", real(answer), imag(answer), abs(answer), angle(answer)*(180/pi))
      prev_answer = answer;
      printf("\a"); # Rings the terminal bell on your computer :)
      disp("Press any key to continue.")
      pause
    case '/' # Quitting the program
      program_status = 0;
      clc
  endswitch
endwhile

