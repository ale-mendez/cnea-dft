      program vasp_compton

      call gcoeff_inp()
      call compute_rho()

      stop
      end
!***********************************************************************
      subroutine gcoeff_inp()

      implicit real*8 (a-h, o-z)

      parameter(nbdim=20,npdim=1500,nwdim=5000,nsdim=1)

      complex*16 cener(nbdim,nwdim,nsdim)
      dimension vtmp(3),sumkg(3),occ(nbdim,nwdim,nsdim)

      complex*8 coeff
      common/gcoeffbck/a1(3),a2(3),a3(3),b1(3),b2(3),b3(3),
     +                 wk(3,nwdim,nsdim),nplane(nwdim,nsdim),
     +                 igall(3,npdim,nwdim,nsdim),
     +                 coeff(npdim,nbdim,nwdim,nsdim),
     +                 nspin,nwk,nband,Vcell

      open(unit=10,file='GCOEFF.txt',status='unknown')
      write(6,*) 'reading file GCOEFF.txt'
      read(10,*) nspin
      write(6,*) 'nspin=',nspin
      read(10,*) nwk
      write(6,*) 'nwk=',nwk
      read(10,*) nband
      write(6,*) 'nband=',nband
 
      read(10,*) (a1(j),j=1,3)
      read(10,*) (a2(j),j=1,3)
      read(10,*) (a3(j),j=1,3)
      write(6,*) ' '
      write(6,*) 'real space lattice vectors:'
      write(6,*) 'a1 =',(sngl(a1(j)),j=1,3)
      write(6,*) 'a2 =',(sngl(a2(j)),j=1,3)
      write(6,*) 'a3 =',(sngl(a3(j)),j=1,3)
      write(6,*) ' '
      call vcross(vtmp,a2,a3)
      Vcell=a1(1)*vtmp(1)+a1(2)*vtmp(2)+a1(3)*vtmp(3)
      write(6,*) 'volume unit cell =',sngl(Vcell)
      write(6,*) ' '
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
!               write(6,*) 'nplane=',nplane(iwk,ispin)
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

      parameter(nbdim=20,npdim=1500,nwdim=5000,nsdim=1)

      real*8 sumkg(3)

      complex*8 coeff
      common/gcoeffbck/a1(3),a2(3),a3(3),b1(3),b2(3),b3(3),
     +                 wk(3,nwdim,nsdim),nplane(nwdim,nsdim),
     +                 igall(3,npdim,nwdim,nsdim),
     +                 coeff(npdim,nbdim,nwdim,nsdim),
     +                 nspin,nwk,nband,Vcell

      write(6,*) ' '
      write(6,*) 'compute rho(p):'
      write(6,*) ' '

      ispin=1
      csum=0
      x=0.
      y=0.
      nz=256
      zmax=a1(3)+a2(3)+a3(3)
      delz=zmax/float(nz)

      do 550 iz=1,nz+1
        z=(iz-1)*delz
        write(6,*) 'z=',z
        do 600 iwk=1,nwk   ! k : índice sobre vector de onda
          do 590 iband=1,nband   ! j : índice sobre bandas
            do 580 iplane=1,nplane(iwk,ispin) ! G: puntos de la red
              ig1=igall(1,iplane,iwk,ispin)
              ig2=igall(2,iplane,iwk,ispin)
              ig3=igall(3,iplane,iwk,ispin)
              do 470 j=1,3
                sumkg(j)=(wk(1,iwk,ispin)+ig1)*b1(j)+
     &                   (wk(2,iwk,ispin)+ig2)*b2(j)+
     &                   (wk(3,iwk,ispin)+ig3)*b3(j)
470           continue
!              csum=csum+abs(coeff(iplane,iband,iwk,ispin))
              wfn=coeff(iplane,iband,iwk,ispin)*cdexp(cmplx(0.,1.)*
     &            (sumkg(1)*x+sumkg(2)*y+sumkg(3)*z))
              csum=csum+abs(wfn)
580         continue
590       continue
600     continue
        csum=csum/Vcell
!        write(12,*) sumkg(1),sumkg(2),sumkg(3),csum
        write(12,*) sngl(z),csum
550   continue

      return
      end
!
!   routine for computing vector cross-product
!
      subroutine vcross(a,b,c)
      implicit real*8(a-h,o-z)
      dimension a(3),b(3),c(3)
      
      a(1)=b(2)*c(3)-b(3)*c(2)
      a(2)=-(b(1)*c(3)-b(3)*c(1))
      a(3)=b(1)*c(2)-b(2)*c(1)
      return
      end
