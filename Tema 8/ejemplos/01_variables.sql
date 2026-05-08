-- variables
SET @numero_2 = 2;
SELECT @numero_1 + @numero_2;

use maratoon;
SET @ciudad = 'Villamartin';
select nombre from corredores where ciudad = @ciudad;