
--------------------------------------------------------------------------------------------------------------------


// 1) 
SELECT b.club,m1.data, d.club, m2.data, a.club;
FROM data1!matches m1, data1!matches m2, data1!club a, data1!club b, data1!club d;
WHERE a.idc=m1.away AND a.idc=m2.away AND b.idc=m1.home AND d.idc=m2.home AND d.idc>b.idc AND a.idc=1 

// 2)
SELECT p.surname, p.idp;
FROM data1!players p;
WHERE  p.idc=1 AND p.idp NOT IN(SELECT mp.idp FROM data1!matches_players mp;
WHERE mp.idm=7)

// 3) 
SELECT p.surname, SUM(mp.goals) as M;
FROM data1!players p,data1!matches m, data1!matches_players mp INTO CURSOR tmp;
WHERE p.idp=mp.idp AND mp.idm=m.idm AND m.data>=CTOD("02.01.2018") AND m.data<=CTOD("05.20.2018"); 
GROUP BY p.idp, p.surname

SELECT tmp.surname, M FROM tmp;
WHERE M in (SELECT MAX(M) FROM tmp)


// 4) 
SELECT c.club, SUM(mp.goals) as S;
FROM data1!matches m, data1!matches_players mp, data1!players p, data1!club c INTO CURSOR tmp;
WHERE m.idm = mp.idm AND p.idp=mp.idp AND p.idc!=c.idc AND (c.idc=m.home OR c.idc=m.away);
GROUP BY c.club

SELECT tmp.club, S FROM tmp;
WHERE S in (SELECT MAX(S) FROM tmp)



// 5) 
SELECT c.club, SUM(mp1.goals) as S1, SUM(mp2.goals) as S2;
FROM data1!matches m, data1!matches_players mp1, data1!matches_players mp2, data1!players p1,data1!players p2, data1!club c INTO CURSOR tmp;
WHERE m.idm = mp1.idm AND p1.idp=mp1.idp AND p1.idc=c.idc AND c.idc=m.home AND m.idm = mp2.idm AND p2.idp=mp2.idp  AND p2.idc!=c.idc;
GROUP BY c.club

SELECT tmp.club, S1-S2 as WORST_HOME FROM tmp;
WHERE S1-S2 in (SELECT MIN(S1-S2) FROM tmp)


// 6)
SELECT p.surname, SUM(mp.assists) as A;
FROM data1!players p,data1!matches m, data1!matches_players mp INTO CURSOR tmp;
WHERE p.idp=mp.idp AND mp.idm=m.idm; 
GROUP BY p.idp, p.surname

SELECT tmp.surname, A FROM tmp;
WHERE A in (SELECT MAX(A) FROM tmp)


-----------------------------------------------------------------------------------------------------------------