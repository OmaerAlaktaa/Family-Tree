/* Facts */
male(kam).
male(rob).
male(dom).
male(jeb).
male(tio).
male(dag).
male(zev).
male(gio).

female(ana).
female(sue).
female(kat).
female(syd).
female(may).
female(fey).
female(pam).
female(liz).

parent(kam,rob).
parent(ana,rob).
parent(kam,syd).
parent(ana,syd).
parent(rob,dom).
parent(sue,dom).
parent(rob,kat).
parent(sue,kat).
parent(syd,dag).
parent(tio,dag).
parent(syd,fey).
parent(tio,fey).
parent(jeb,tio).
parent(may,tio).
parent(jeb,pam).
parent(may,pam).
parent(pam,liz).
parent(zev,liz).
parent(pam,gio).
parent(zev,gio).
spouse(kam,ana).
spouse(jeb,may).
spouse(rob,sue).
spouse(tio,syd).
spouse(zev,pam).

/* Rules */
% X is a male parent of Y
father(X,Y):-parent(X,Y),male(X).
% X is a female parent of Y
mother(X,Y):-parent(X,Y),female(X).

child(Y,X):-parent(X,Y).
% X is a male child of Y
son(Y,X):-child(Y,X), male(Y).
% X is a female child of Y
daughter(Y,X):-child(Y,X),female(Y).
% X is the daughter of the same mother or father of Y
sister(X,Y):-daughter(X,Z),parent(Z,Y),X \= Y.
% X is the son of the same mother or father of Y
brother(X,Y) :-son(X,Z),parent(Z,Y), X \= Y.
% X and Y have the same mother or father of Y
sibling(X,Y):-parent(Z,X),parent(Z,Y),X \= Y.

spouse(X,Y):-parent(X,Z),parent(Y,Z),X \= Y.
% X is the husband of Y
husband(X,Y):-spouse(X,Y),male(X).
% X is the wife of Y
wife(X,Y):-spouse(X,Y),female(X).

grandparent(X,Y):-parent(X,Z),parent(Z,Y).
% X is the father of Y’s father or mother
grandfather(X,Y):-grandparent(X,Y),male(X).
% X is the mother of Y’s father or mother
grandmother(X,Y):-grandparent(X,Y),female(X).
% X is the son of Y’s son or daughter
grandson(X,Y) :-male(X),(grandfather(Y,X);grandmother(Y,X)).
% X is the daughter of Y’s son or daughter
granddaughter(X,Y) :-female(X),(grandfather(Y,X);grandmother(Y,X)).

% X is the brother of Y’s father or mother
uncle(X,Y):-parent(Z,Y), brother(X,Z).
% X is the sister of Y’s father or mother
aunt(X,Y):- parent(Z,Y),sister(X,Z).
% X is the son of Y’s brother or sister
nephew(X,Y):-male(X),(uncle(Y,X); aunt(Y,X)).
% X is the daughter of Y’s brother or sister
niece(X,Y):-female(X),(uncle(Y,X);aunt(Y,X)).
% X is the son or daughter of Y’s uncle or aunt
cousin(X,Y):-(son(X,Z);daughter(X,Z)),(uncle(Z,Y); aunt(Z,Y)),X \=Y.

relative(X,Y):-parent(X,Y),X \= Y.
relative(X,Y):-parent(Y,X),X \= Y.
relative(X,Y):-sibling(X,Y) ,X \= Y.
relative(X,Y):-spouse(X,Y),X \=Y.
relative(X,Y):-grandparent(X,Y),X \= Y.
relative(X,Y):-grandparent(Y,X),X \= Y.
relative(X,Y):-uncle(X,Y),X \= Y.
relative(X,Y):-aunt(X,Y),X \= Y.
relative(X,Y):-nephew(X,Y),X \= Y.
relative(X,Y):-niece(X,Y),X \= Y.
relative(X,Y):-cousin(X,Y),X \= Y.









