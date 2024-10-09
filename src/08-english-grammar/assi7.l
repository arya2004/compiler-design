%{
  // Lex program
  #include "assi7.tab.h"
%}

%%
is|am|was|were {return VERBTOKEN;}
boy|girl      {return NOUNTOKEN;}
he|she|He|She    {return PRONOUNTOKEN;}
and|or     {return CONJTOKEN;}
fine      {return ADVTOKEN;}
a|an|the    {return ARTICLETOKEN;}
good|bad       {return ADJTOKEN;} 
[.]\n        {return 0;}
quit|QUIT      {exit(0);}

%%
int yywrap(void)
{
  return 1;
}