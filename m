Message-ID: <20060504113947.98923.qmail@domain.hid>
Date: Thu, 4 May 2006 11:39:47 +0000 (GMT)
From: gilles mendes <mendesgilles@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-469992444-1146742787=:98878"
Subject: [Xenomai-core] linker: undefined reference to `nktickdef'
Reply-To: gilles mendes <mendesgilles@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--0-469992444-1146742787=:98878
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

hi,

I have a kernel 2.6.14 patched whit xenomai-2.1-rc2, i do real time applica=
tions in user space, i want to compil a program whit eclipse (SDK),  i have=
 no errors on my program file but i have an error whit the linker, i have :

Building file: ../Util.c
Invoking: GCC C Compiler
gcc -D__XENO__ -D__XENO_UVM__ -DHPCi_linux -I/usr/xenomai/include -I/Hpci/w=
orkspace/cible2_linux/H -I/usr/include -O0 -g3 -Wall -c -fmessage-length=3D=
0 -oUtil.o ../Util.c
Finished building: ../Util.c
=20
Building file: ../main_hpci.c
Invoking: GCC C Compiler
gcc -D__XENO__ -D__XENO_UVM__ -DHPCi_linux -I/usr/xenomai/include -I/Hpci/w=
orkspace/cible2_linux/H -I/usr/include -O0 -g3 -Wall -c -fmessage-length=3D=
0 -omain_hpci.o ../main_hpci.c
../main_hpci.c: Dans la fonction =AB main_task =BB:
../main_hpci.c:85: attention : implicit declaration of function `kbhit'
../main_hpci.c:59: attention : unused variable `cmd_line'
Finished building: ../main_hpci.c
=20
Building file: ../rtai_util.c
Invoking: GCC C Compiler
gcc -D__XENO__ -D__XENO_UVM__ -DHPCi_linux -I/usr/xenomai/include -I/Hpci/w=
orkspace/cible2_linux/H -I/usr/include -O0 -g3 -Wall -c -fmessage-length=3D=
0 -ortai_util.o ../rtai_util.c
Finished building: ../rtai_util.c
=20
Building target: test2
Invoking: GCC C Linker
gcc -L/usr/xenomai/lib --uvm-ldflags -otest2 ./Util.o ./main_hpci.o ./rtai_=
util.o -luvm -lnucleus -lpthread -lvxworks
/usr/xenomai/lib/libvxworks.a(module.o)(.text+0xb1): dans la fonction =AB _=
_xeno_skin_init =BB:
: undefined reference to `nktickdef'
collect2: ld a retourn=E9 1 code d'=E9tat d'ex=E9cution
make: *** [test2] Erreur 1
make: La cible `all' n'a pas pu =EAtre refabriqu=E9e =E0 cause d'erreurs.
Build complete for project test2


what can i do solve it.

THANKS

Gilles


--0-469992444-1146742787=:98878
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px} --></style></hea=
d><body><div style=3D"font-family:times new roman, new york, times, serif;f=
ont-size:12pt"><div>hi,<br><br>I have a kernel 2.6.14 patched whit xenomai-=
2.1-rc2, i do real time applications in user space, i want to compil a prog=
ram whit eclipse (SDK),  i have no errors on my program file but i have an =
error whit the linker, i have :<br><br>Building file: ../Util.c<br>Invoking=
: GCC C Compiler<br>gcc -D__XENO__ -D__XENO_UVM__ -DHPCi_linux -I/usr/xenom=
ai/include -I/Hpci/workspace/cible2_linux/H -I/usr/include -O0 -g3 -Wall -c=
 -fmessage-length=3D0 -oUtil.o ../Util.c<br>Finished building: ../Util.c<br=
>&nbsp;<br>Building file: ../main_hpci.c<br>Invoking: GCC C Compiler<br>gcc=
 -D__XENO__ -D__XENO_UVM__ -DHPCi_linux -I/usr/xenomai/include -I/Hpci/work=
space/cible2_linux/H -I/usr/include -O0 -g3 -Wall -c -fmessage-length=3D0 -=
omain_hpci.o ../main_hpci.c<br>../main_hpci.c: Dans la fonction =AB main_ta=
sk
 =BB:<br>../main_hpci.c:85: attention : implicit declaration of function `k=
bhit'<br>../main_hpci.c:59: attention : unused variable `cmd_line'<br>Finis=
hed building: ../main_hpci.c<br>&nbsp;<br>Building file: ../rtai_util.c<br>=
Invoking: GCC C Compiler<br>gcc -D__XENO__ -D__XENO_UVM__ -DHPCi_linux -I/u=
sr/xenomai/include -I/Hpci/workspace/cible2_linux/H -I/usr/include -O0 -g3 =
-Wall -c -fmessage-length=3D0 -ortai_util.o ../rtai_util.c<br>Finished buil=
ding: ../rtai_util.c<br>&nbsp;<br>Building target: test2<br>Invoking: GCC C=
 Linker<br>gcc -L/usr/xenomai/lib --uvm-ldflags -otest2 ./Util.o ./main_hpc=
i.o ./rtai_util.o -luvm -lnucleus -lpthread -lvxworks<br>/usr/xenomai/lib/l=
ibvxworks.a(module.o)(.text+0xb1): dans la fonction =AB __xeno_skin_init =
=BB:<br>: undefined reference to `nktickdef'<br>collect2: ld a retourn=E9 1=
 code d'=E9tat d'ex=E9cution<br>make: *** [test2] Erreur 1<br>make: La cibl=
e `all' n'a pas pu =EAtre refabriqu=E9e =E0 cause d'erreurs.<br>Build compl=
ete for project
 test2<br><br><br>what can i do solve it.<br><br>THANKS<br><br>Gilles<br></=
div></div></body></html>
--0-469992444-1146742787=:98878--

