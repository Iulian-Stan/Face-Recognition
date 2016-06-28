function output = normal(input)

maxim = max(max(input));
minim = min(min(input));

output = (input-minim)/(maxim-minim);