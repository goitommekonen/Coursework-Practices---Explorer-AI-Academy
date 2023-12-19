/*Day 3 of the #30DaysDuckDBChallenge : Data Cleaning
Today, I did some data-cleaning tasks using SQL, DuckDB, and MotherDuck.

Below are the tasks and how each of them is being executed;

TASK 1: For the 'Height' column, make sure to extract the numerical value (e.g., 6'0" becomes 6). For the 'Weight' column, remove the "lbs" and convert it to a numerical format.

To transform the Height column to the numeric format, I used SQL Query to extract the first character (e.g. '6') and cast it as an integer, creating a clean and structured 'Height' column.
The Weight Column, here's how I did it;
> I've converted the weight into a decimal format first.
> I rounded it to the nearest whole number, then.
>Finally, I removed "lbs" and cast the result as an integer.

TASK 2: The 'Value' column has values like '€100M' (which means 100 million) and '€10K' (which means 10,000). Strip the symbols ('€', 'M', 'K') and convert the values to actual numbers accordingly. The same applies ‘Wage’ and ‘Release clause’ columns.

In doing this, I used a smart approach with a CASE statement to handle the 'Value,' 'Wage,' and 'Release Clause' columns.
Here's how I did it:
> I first checked the last character of each value to determine if it's in millions ('M') thousands ('K') or neither.
> If it was in millions ('M'), I removed the '€' and 'M,' converted the result to a numeric format, and multiplied it by 1,000,000 to get the actual number.
>If it was in thousands ('K'), I followed the same process, replacing '€' and 'K,' converting to a numeric format, and multiplying by 1,000.
>If it had no 'M' or 'K,' I simply removed the '€' and cast it as numeric.

TASK 3: Remove the 'star' character from columns where it appears and make sure the columns are in numerical format.

I focused on columns such as 'W', 'F', 'SM', and 'IR' in this case.
Here's how I accomplished it:
> I removed the "star" feature from these columns with a simple approach.
>The update involved finding instances of ' * ' and replacing them with two spaces (' ').
> In addition, I made sure that the cleaned data was in a numerical format.
>I applied this transformation to the 'W/F,' 'SM,' and 'IR' columns where necessary.

****Extra tasks by me****

·      I've also converted the 'Hits' column to a numerical format, making it useful for analysis.
·      In table fifa21_player, the 'Team & Contract' column had some show/hide signs. I removed them and then separated the 'Team' from ‘Contract’, I went further by renaming the 'Team' column as the ‘Club’ column for clarity. The purpose of doing this was to make sure that both tables I am using have the same column names.

Now I understand that data cleaning is the foundation of powerful data analysis. It paves the way for meaningful insights and well-informed decisions. Every step matters, and I'm excited to keep learning, growing, and sharing lessons.

#30DaysDuckDBChallenge #KeepQuacking #DuckDB*/

