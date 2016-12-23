C======================================================================
      SUBROUTINE READPAR(FILENAME,COMMENTS,NOFCOM)
	IMPLICIT NONE
C FILENAME - NAME OF FILE WITH PARAMETERS OF TASK
C NOFCOM   - NUMBER OF USED LINES IN FILENAME
C            CALCULATES IN THIS SUBROUTINE

      INTEGER   MAXNUMPAR
      PARAMETER(MAXNUMPAR=1024)
      CHARACTER*(*) FILENAME
      CHARACTER*(*) COMMENTS(1)
      INTEGER       N, NOFCOM

C DESCRIPTION OF INPUT VARIABLE SEE IN FILE (FILENAME)

      OPEN (90,FILE=FILENAME,STATUS='OLD',ERR=190)
      DO N=1,MAXNUMPAR
      COMMENTS(N)=' '
      READ (90,'(A)',END=19,ERR=191) COMMENTS(N)
      END DO
      WRITE(*,*)' WARNING!'
      WRITE(*,*)' TOO MANY LINES IN: ',FILENAME
      WRITE(*,*)' THEIR NUMBER IS GREATER ',MAXNUMPAR
19    CONTINUE
      CLOSE(90)
      NOFCOM=N-1
      WRITE(*,'(A,A)')' INPUT OCEAN TASK PARAMETERS FROM ',
     &                  FILENAME(1:LEN_TRIM (FILENAME))
      DO N=1,NOFCOM
      WRITE(*,'(1X,A)') COMMENTS(N)(1:LEN_TRIM (COMMENTS(N)))
      END DO
      WRITE(*,*)
      RETURN
190   WRITE(*,*) ' ERROR IN OPEN FILE: ', 
     &             FILENAME(1:LEN_TRIM (FILENAME))
      STOP 1
191   WRITE(*,*) ' ERROR IN READING FILE: ', 
     &             FILENAME(1:LEN_TRIM (FILENAME))
      STOP 2
      END
C======================================================================
      SUBROUTINE WRITEPAR(FILENAME,COMMENTS,NOFCOM)
	IMPLICIT NONE
C FILENAME - NAME OF FILE WITH PARAMETERS OF TASK
C NOFCOM   - NUMBER OF USED LINES IN FILENAME (EXTERNAL)
      INTEGER       NOFCOM
      CHARACTER*(*) FILENAME
      CHARACTER*(*) COMMENTS(NOFCOM)
      INTEGER       N, L, LONC
C DESCRIPTION OF INPUT VARIABLE SEE IN FILE (FILENAME)

      OPEN (90,FILE=FILENAME,ERR=190)
      LONC=LEN(COMMENTS(1))
      DO N=1,NOFCOM
         L=LONC
         DO WHILE(COMMENTS(N)(L:L).EQ.' '.AND.L.GT.1)
            L=L-1
         END DO
      WRITE (90,'(A)',ERR=191) COMMENTS(N)(1:L)
      END DO
      CLOSE(90)
      WRITE(*,*)' OUTPUT OF TASK PARAMETERS IN ',
     &            FILENAME(1:LEN_TRIM (FILENAME))
      DO N=1,NOFCOM
      WRITE(*,'(1X,A)') COMMENTS(N)(1:78)
      END DO
      RETURN
190   WRITE(*,*) ' ERROR IN OPEN FILE: ', 
     &             FILENAME(1:LEN_TRIM (FILENAME))
      STOP 1
191   WRITE(*,*) ' ERROR IN READING FILE: ', 
     &             FILENAME(1:LEN_TRIM (FILENAME))
      STOP 2
      END
C======================================================================
