C======================================================================
	SUBROUTINE LQPCOORDINATES(PATH2OCEANDATA)    !PATH TO OCEAN DATA
C (C) DIANSKY N.A. dinar@inm.ras.ru, 2008

	IMPLICIT NONE
      INCLUDE '1LREC.INC'
	INCLUDE '1BASINPAR.INC'
	INCLUDE '1LQBC.INC'
	CHARACTER*(*) PATH2OCEANDATA !PATH TO OCEAN DATA	
		
C-----INPUT VARIABLES FROM COMMON BLOCK 1LQBC.INC------------------------------	 
C THESE VARIABLES COME FROM COMMON BLOCKS

C	INTEGER NUMB_OF_LB,        !NUMBER OF LIQUID BOUNDARIES (CALCULATED)   
C     &        NUMB_OF_LQP,       !NUMBER OF LIQUID POINTS ON T-GRID(CALCULATED)
C     &        LQPX(NUMB_OF_LQP), !X-GRID COORDINATES OF LIQUID POINTES
C     &        LQPY(NUMB_OF_LQP), !Y-GRID COORDINATES OF LIQUID POINTES
C     &                NX,        !X-DIMENSION OF FILD
C     &                NY         !L-DIMENSION OF FILD
      


	CHARACTER(1024) NAME_OF_LQPMASK   !NAME OF FILE WITH LQPMASK CODED AS 
	                                  !ENGLISH LETTERS

C------WORKING VARIABLES--------------------------------------------------------	
	INTEGER M,N,L,NUMB_OF_LQP_REAL,IERR

	CHARACTER FRMT*16,COMMENT*1024

	CHARACTER*1 ALPHABET(26)
	DATA ALPHABET/'A','B','C','D','E','F','G','H','I','J','K','L','M',
     &              'N','O','P','Q','R','S','T','U','V','W','X','Y','Z'/

	CHARACTER, ALLOCATABLE:: LQBMASK(:,:)

	ALLOCATE (LQBMASK(NX,NY))

      WRITE(FRMT,1000) NX
1000  FORMAT('(',I9,'A1)')

C FULL FILE NAME WITH LIQUID BOUNDARY TEMPERATURE
      CALL FULFNAME(NAME_OF_LQPMASK,PATH2OCEANDATA,'lqbmask.txt',IERR)
	WRITE(*,*) ' FILE WITH MASK WITH LIQUID BOUNDARY POINTES MARKED' 
      WRITE(*,'(5X,A)') NAME_OF_LQPMASK(1:LEN_TRIM (NAME_OF_LQPMASK))


C READING DIOGIN MASK FROM:
      OPEN (11,FILE=NAME_OF_LQPMASK,STATUS='OLD',RECL=NX*LRECL)
      READ (11,  '(A)') COMMENT(1:MIN(1024,NX))
      WRITE(*,'(1X,A)') COMMENT(1:80)

      DO N=NY,1,-1
         READ(11,FRMT,END=99) (LQBMASK(M,N),M=1,NX)
      ENDDO

	NUMB_OF_LQP_REAL=0

	DO L=1,26

		DO N=1,NY
		DO M=1,NX
		
		IF(LQBMASK(M,N).EQ.ALPHABET(L)) THEN

		NUMB_OF_LB=L
		NUMB_OF_LQP_REAL=NUMB_OF_LQP_REAL+1

              IF(NUMB_OF_LQP_REAL.GT.NUMB_OF_LQP_MAX) THEN
      WRITE(*,*)' ERROR IN SUBROUTINE LQPCOORDINATES()!!!'
      WRITE(*,*)' NUMBER OF LIQUID GRID POINTS GREATER THEN DEFINED'
	WRITE(*,*)' CORRECT NUMBER OF LIQUID POINTES (NUMB_OF_LQP_MAX)'
      STOP 1
              END IF

		LQPX(NUMB_OF_LQP_REAL)=M		
		LQPY(NUMB_OF_LQP_REAL)=N
				
		END IF

		END DO	
		END DO

	END DO
	
	NUMB_OF_LQP=NUMB_OF_LQP_REAL	
	
	WRITE(*,'(A,I4)') ' NUMBER OF LIQUID BOUNDARIES =',NUMB_OF_LB
	WRITE(*,'(A,I4)') ' NUMBER OF LIQUID POINTES    =',NUMB_OF_LQP
	WRITE(*,*) 
     &       ' YOU MAY SET NUMBER OF LIQUID POINTES (NUMB_OF_LQP_MAX) IN
     & 1LQBC.INC'

	DEALLOCATE (LQBMASK)
	RETURN
99    WRITE(*,*)'  ERROR IN READING FILE ',
     &             NAME_OF_LQPMASK(1:LEN_TRIM (NAME_OF_LQPMASK))
	STOP 1
	END SUBROUTINE 
C======================================================================
