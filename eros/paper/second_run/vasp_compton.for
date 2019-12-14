      program vasp_compton

      call gcoeff_inp()
      call compute_rho()

      stop
      end
!***********************************************************************
      subroutine gcoeff_inp()

      implicit real*8 (a-h, o-z)

      parameter(nbdim=120,npdim=15000,nwdim=51,nsdim=1)

      complex*16 cener(nbdim,nwdim,nsdim)
      dimension a1(3),a2(3),a3(3),vtmp(3),sumkg(3),
     & occ(nbdim,nwdim,nsdim)

      complex*8 coeff
      common/gcoeffbck/b1(3),b2(3),b3(3),
     +                 wk(3,nwdim,nsdim),nplane(nwdim,nsdim),
     +                 igall(3,npdim,nwdim,nsdim),
     +                 coeff(npdim,nbdim,nwdim,nsdim),
     +                 nspin,nwk,nband

      open(unit=10,file='GCOEFF.txt',status='unknown')
      write(6,*) 'reading file GCOEFF.txt'
      read(10,*) nspin
      read(10,*) nwk
      read(10,*) nband
 
      read(10,*) (a1(j),j=1,3)
      read(10,*) (a2(j),j=1,3)
      read(10,*) (a3(j),j=1,3)
      read(10,*) (b1(j),j=1,3)
      read(10,*) (b2(j),j=1,3)
      read(10,*) (b3(j),j=1,3)
      do 700 ispin=1,nspin
         do 600 iwk=1,nwk
            read(10,*) (wk(j,iwk,ispin),j=1,3)
            write(6,*) 'k point #',iwk
            do 590 iband=1,nband
               read(10,*) idum,nplane(iwk,ispin)
               read(10,*) cener(iband,iwk,ispin),occ(iband,iwk,ispin)
               do 580 iplane=1,nplane(iwk,ispin)
                  read(10,*) (igall(j,iplane,iwk,ispin),j=1,3),
     &                        coeff(iplane,iband,iwk,ispin)
580            continue
590         continue
600      continue
700   continue

      return
      end

!***********************************************************************
      subroutine compute_rho()

      implicit real*8 (a-h, o-z)

      parameter(nbdim=120,npdim=15000,nwdim=51,nsdim=1)

      complex*8 coeff
      common/gcoeffbck/b1(3),b2(3),b3(3),
     +                 wk(3,nwdim,nsdim),nplane(nwdim,nsdim),
     +                 igall(3,npdim,nwdim,nsdim),
     +                 coeff(npdim,nbdim,nwdim,nsdim),
     +                 nspin,nwk,nband

      do 700 ispin=1,nspin
         do 600 iwk=1,nwk   ! k : índice sobre vector de onda (?)
            do 590 iband=1,nband   ! j : índice sobre bandas
               do 580 iplane=1,nplane(iwk,ispin) ! G: puntos de la red
                  ! elementos del vector k:
                  xwk=wk(1,iwk,ispin)
                  ywk=wk(2,iwk,ispin)
                  zwk=wk(3,iwk,ispin)
                  ! elementos del vector G:
                  xigall=igall(1,iplane,iwk,ispin)*b1(1)+
     |                   igall(2,iplane,iwk,ispin)*b2(1)+
     |                   igall(3,iplane,iwk,ispin)*b3(1)
                  yigall=igall(1,iplane,iwk,ispin)*b1(2)+
     |                   igall(2,iplane,iwk,ispin)*b2(2)+
     |                   igall(3,iplane,iwk,ispin)*b3(2)
                  zigall=igall(1,iplane,iwk,ispin)*b1(3)+
     |                   igall(2,iplane,iwk,ispin)*b2(3)+
     |                   igall(3,iplane,iwk,ispin)*b3(3)
                  dum=abs(coeff(iplane,iband,iwk,ispin))
580            continue
590         continue
600      continue
700   continue

      return
      end
