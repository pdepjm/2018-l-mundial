% Todo: escribir enunciado en un drive?

% TODO: completar esto

pais(rusia,a).
pais(uruguay,a).
pais(egipto,a).
pais(arabiaSaudita,a).
pais(espania,b).
pais(portugal,b).
pais(iran,b).
pais(marruecos,b).
pais(francia,c).
pais(dinamarca,c).
pais(australia,c).
pais(peru,c).
pais(argentina,d).
pais(croacia,d).
pais(islandia,d).
pais(nigeria,d).
pais(argentina,d).
pais(croacia,d).
pais(islandia,d).
pais(nigeria,d).
pais(argentina,d).
pais(croacia,d).
pais(islandia,d).
pais(nigeria,d).
pais(argentina,d).
pais(croacia,d).
pais(islandia,d).
pais(nigeria,d).
pais(serbia,e).
pais(brasil,e).
pais(suiza,e).
pais(costaRica,e).
pais(suecia,f).
pais(mexico,f).
pais(alemania,f).
pais(coreaDelSur,f).
pais(belgica,g).
pais(inglaterra,g).
pais(tunez,g).
pais(panama,g).
pais(japon,h).
pais(senagal,h).
pais(colombia,h).
pais(polonia,h).

campeon(italia, 1982).
campeon(argentina, 1986).
campeon(alemania, 1990).
campeon(brasil, 1994).
campeon(francia, 1998).
campeon(brasil, 2002).
campeon(italia, 2006).
campeon(espania, 2010).
campeon(alemania, 2014).

anioActual(2018).

% TODO:
resultado(argentina,islandia,1,1).
resultado(mexico,alemania,1,0).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Si en el grupo hay dos ó mas campeones.

grupoDeLaMuerte(Grupo):-
    pais(Campeon1,Grupo),
    pais(Campeon2,Grupo),
    campeon(Campeon1,_),
    campeon(Campeon2,_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% si alguna vez metió 3 o mas goles.

esUnaFiesta(Pais):-
    resultado(Pais,_,CantGoles,_),
    CantGoles >= 3.
esUnaFiesta(Pais):-
    resultado(_,Pais,_,CantGoles),
    CantGoles >= 3.

% Mejora (evitar la repetición):

esUnaFiesta(Pais):-
    hizoAlgunaVez(Pais,CantGoles),
    CantGoles >= 3.

hizoAlgunaVez(Pais,CantGoles):-
    resultado(_,Pais,_,CantGoles).
hizoAlgunaVez(Pais,CantGoles):-
    resultado(Pais,_,CantGoles,_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% si el local ó el visitante fueron campeones.
partidoComplicado(Local,Visitante):-
    campeon(Local,_).
partidoComplicado(Local,Visitante):-
    campeon(Visitante,_).

% problemas de inversibilidad, generación.

% Al modificarse queda:
partidoComplicado(Local,Visitante):-
    pais(Visitante,_),
    campeon(Local,_).
partidoComplicado(Local,Visitante):-
    pais(Local,_),
    campeon(Visitante,_).

% ojo con la charla de repetición

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% mundialEnUnaPalabra/1: la descripción más acertada del mundial

% - estrellas si participan todos los campeones
mundialEnUnaPalabra(estrellas) :-
    forall(campeon(P,_),pais(P,_)).

% - increible si solo participan campeones
mundialEnUnaPalabra(increible) :-
    forall(pais(P,_),campeon(P,_).

% - legendario si todos los delanteros que metieron mas de 10 goles juegan para un campeon
mundialEnUnaPalabra(legendario) :-
    forall((jugador(_,P,delantero(CantidadGoles)),CantidadGoles > 10), campeon(P,_)).

% - juegoBonito si todos los delanteros metieron mas de 10 goles y juegan para un campeon
mundialEnUnaPalabra(legendario) :-
    forall(jugador(_,P,delantero(CantidadGoles)),(CantidadGoles > 10, campeon(P,_))).
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Intro a forall

% relacionar a un pais con la ultima vez que fue campeon

ultimaCopa(Pais,Anio):-
    campeon(Pais,Anio),
    forall(campeon(Pais,Anio2), Anio >= Anio2).

% con not:
ultimaCopa(Pais,Anio):-
    campeon(Pais,Anio),
    not((campeon(Pais,Anio2), Anio2 > Anio)).

% siamo fuori si alguna vez fue campion y ahora no participa XD



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Si hace bocha que no gana (cuando ganó al menos una vez, y pasaron 20 años desde la última vez que ganó )
haceBocha(Pais):-
    ultimaCopa(Pais,Anio),
    anioActual(AnioActual),
    Tristeza is AnioActual - Anio,
    Tristeza >= 20.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Proomete si siempre que jugaron metieron goles, o si ambos están en el grupo de la muerte.

promete(Pais1,Pais2):-
    pais(Pais1,Grupo),
    pais(Pais2,Grupo),
    grupoDeLaMuerte(Grupo).

promete(Pais1,Pais2):-
    siempreQueJugoMetio(Pais1),
    siempreQueJugoMetio(Pais2).

siempreQueJugoMetio(Pais):-
    pais(Pais,_),
    forall(hizoAlgunaVez(Pais,Cant), Cant \= 0).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Agregamos los jugadores

% Modelado:
% Queremos llevar estadísticas de nuestros jugadores para poder tomar mejores decisiones. 
% De los jugadores nos interesa en qué país juegan, su nombre, y su posición.
% Las posiciones que a nosotros nos interesan son los arqueros, los defensores y delanteros.
% De los arqueros se conocen los 

% arquero(goles que metio, goles que atajo, goles que le metieron)
% delantero(goles que metio).
% defensor(robos de pelota, goles que metio).

jugador(argentina,caballero,arquero(5,30,60)).
jugador(argentina,messi,delantero(150)).
jugador(argentina,meza,delantero(50)).
jugador(argentina,masche,defensor(4)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Saber si es buen defensor

buenDefensor(Jugador):-
    jugador(_,Jugador,defensor(_,_)).
buenDefensor(Jugador):-
    jugador(_,Jugador,arquero(GA,GC)),
    GA > GC.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
metePenal(Pateador,Arquero):-
    jugador(_,Pateador, Posicion),
    golesConvertidos(Posicion,CantConvertidos),
    jugador(_, Arquero, arquero(_,CantAtajados,_)),
    CantConvertidos >= CantAtajados.

golesConvertidos(arquero(Cant,_,_),Cant).
golesConvertidos(delantero(Cant),Cant).
golesConvertidos(defensor(_,Cant),Cant).

%%%%%%%%%%%%%%%%%%%%%%%%%%%

% mejorDelGrupo/2 Relaciona un grupo con el mejor jugador de todos los que juegan en los países del grupo.
% Para que un jugador sea mejor que otro, todos los stats sumados de uno deben ser mayores al del otro (ojo que los goles que le metieron restan).
% Debe ser inversible por el segundo argumento.

% Obtener el mejor jugador del mundial.
mejorJugador(Jugador):- mejorDelGrupo(_,Jugador).
