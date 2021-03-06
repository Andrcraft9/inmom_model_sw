C SEA WATER DENSITY DEVIATION FROM 1.02 [GR/CM**3]
C AS FUNCTION OF T[�C](potential),S[PPT],P[MPa]
C By Bryden et al.:"A new approximation of the equation of state for
C                   seawater, suitable for numerical ocean models."
C In: J.Geophis.Res.,v.104,No.C1, p.1537-1540, 1999.
C VARIANT 1: -2<T<30;30<S<38;0<P<50. (MORE ACCURACY)
C PRESTOMPA - CONVERSION FACTOR FOR PRESSURE[1MPa=(0 or 1E-7)din/cm**2]
       REAL      PRESTOMPA,T,S,P,DENP
       PARAMETER(PRESTOMPA=1.0E-07)
C      DENP(T,S,P) =-2.0136471E-02
C    1 + (             5.06423E-04*P-5.52640E-07*P*P)
C    2 + ( 4.68181E-05-3.57109E-06*P+4.88584E-09*P*P)*T
C    3 + ( 8.07004E-04-8.76148E-07*P+9.96027E-10*P*P)*S
C    4 + (-7.45353E-06+5.25243E-08*P-7.25139E-11*P*P)*T*T
C    5 + (-2.94418E-06+1.57976E-08*P-3.98736E-12*P*P)*T*S
C    6 + ( 3.43570E-08-3.46686E-10*P+4.00631E-13*P*P)*T*T*T
C    7 + ( 3.48658E-08-1.68764E-10*P+8.26368E-14*P*P)*T*T*S
C VARIANT 2: -2<T<40;0<S<42;0<P<100.
      DENP(T,S,P)  =  -2.00920601E-02
     1 + (             5.07043E-04*P-5.43283E-07*P*P)
     2 + ( 5.10768E-05-3.69119E-06*P+6.54837E-09*P*P)*T
     3 + ( 8.05999E-04-9.34012E-07*P+1.38777E-09*P*P)*S
     4 + (-7.40849E-06+5.33243E-08*P-1.01563E-10*P*P)*T*T
     5 + (-3.01036E-06+1.75145E-08*P-2.34892E-11*P*P)*T*S
     6 + ( 3.32267E-08-3.25887E-10*P+4.98612E-13*P*P)*T*T*T
     7 + ( 3.21931E-08-1.65849E-10*P+2.17612E-13*P*P)*T*T*S
