# README

## Pipeline
Test of pipeline illustration

<details> 
<summary></summary>
custom_activity
@startuml;
%28*%29 --> if "Start QC" then;
  -->[true] "Background subtraction";
  if "" then;
    -> "activity 3" as a3;
  else;
    if "Other test" then;
      -left-> "activity 5";
    else;
      --> "activity 6";
    endif;
  endif;
else;
  ->[false] "Cross-hybredizing probes";
endif;
a3 --> if "last test" then;
  --> "activity 7";
else;
  -> "activity 8";
endif;
@enduml
custom_activity
</details>




This is the Original Gravizo code for the illustration, in case something goes wrong.
![Alt text](https://g.gravizo.com/source/custom_activity?https%3A%2F%2Fraw.githubusercontent.com%2FTLmaK0%2Fgravizo%2Fmaster%2FREADME.md)
<details> 
<summary></summary>
custom_activity
@startuml;
%28*%29 --> if "Some Test" then;
  -->[true] "activity 1";
  if "" then;
    -> "activity 3" as a3;
  else;
    if "Other test" then;
      -left-> "activity 5";
    else;
      --> "activity 6";
    endif;
  endif;
else;
  ->[false] "activity 2";
endif;
a3 --> if "last test" then;
  --> "activity 7";
else;
  -> "activity 8";
endif;
@enduml
custom_activity
</details>

How does this looks
