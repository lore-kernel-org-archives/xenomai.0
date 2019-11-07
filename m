Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Date: Thu, 07 Nov 2019 16:37:17 +0100
Subject: Weird page fault while debugging an application using gdbserver
Message-ID: <b7f-5dc43a00-7b-344a2840@235498125>
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I'm porting an existing application to xenomai, and trying to debug it =
using GDBserver.
I try to set a break to stop at some interesting point in execution. Th=
at break is never reached, and each time I get the page fault error wit=
h the log copied at the end of the message.
After that, I get the debug feature of the network driver automatically=
 activated.

Starngely enought, the backtrace does not point to my application code,=
 rather in linux kernel/drivers.

The system is an Arm7 Zynq 7000 reference board, being debugged via eth=
ernet.
Running linux 4.4.189 vanilla + corresponding ipipe patch and xenomai 3=
.0.9

Anybody can help ?

Thanks

Fran=C3=A7ois

[ 5481.750121] Unhandled fault: page domain fault (0x01b) at 0x00033238=

[ 5481.756485] pgd =3D 41eac000
[ 5481.759171] [00033238] *pgd=3D01c9e831, *pte=3D1f9105df, *ppte=3D1f9=
10e7e
[ 5481.765435] Internal error: : 1b [#1] PREEMPT SMP ARM
[ 5481.770456] CPU: 0 PID: 745 Comm: Module de Confi Not tainted 4.4.18=
9 #10
[ 5481.777217] Hardware name: Xilinx Zynq Platform
[ 5481.781729] I-pipe domain: Linux
[ 5481.784945] task: 5d892180 ti: 41ef6000 task.ti: 41ef6000
[ 5481.790333] PC is at =5F=5Fund=5Fusr+0x68/0x80
[ 5481.794236] LR is at ipipe=5Funstall=5Froot+0x30/0xa0
[ 5481.798921] pc : [<40015888>]    lr : [<4009bdd4>]    psr: 60000013
[ 5481.798921] sp : 41ef7fb0  ip : 41ef7e28  fp : 00000000
[ 5481.810377] r10: 000dd48c  r9 : 40015a4c  r8 : 18c5387d
[ 5481.815585] r7 : 18c5387d  r6 : ffffffff  r5 : 60000010  r4 : 000332=
38
[ 5481.822095] r3 : 60000010  r2 : 0003323c  r1 : 00000000  r0 : 000000=
00
[ 5481.828606] Flags: nZCv  IRQs on  FIQs on  Mode SVC=5F32  ISA ARM  S=
egment none
[ 5481.835723] Control: 18c5387d  Table: 01eac04a  DAC: 00000051
[ 5481.841451] Process Module de Confi (pid: 745, stack limit =3D 0x41e=
f6220)
[ 5481.848138] Stack: (0x41ef7fb0 to 0x41ef8000)
[ 5481.852480] 7fa0:                                     00000000 00000=
000 364884e4 00000000
[ 5481.860643] 7fc0: 00000000 36487e28 3efdebd4 000f0042 36487e2c 00032=
ea0 000dd48c 36487df4
[ 5481.868802] 7fe0: 36f206cc 36487d18 36f0711c 0003323c 60000010 fffff=
fff 00000000 00000000
[ 5481.876965] Code: f1080080 e3130020 1a000006 e2424004 (e4b40000)
[ 5481.883043] I-pipe tracer log (100 points):
[ 5481.887191]    #func                    0 ipipe=5Ftrace=5Fpanic=5Ffr=
eeze+0x10 (oops=5Fenter+0x1c)
[ 5481.895348]    #func                   -2 oops=5Fenter+0x10 (die+0x2=
8)
[ 5481.901684]    #func                   -2 die+0x14 (arm=5Fnotify=5Fd=
ie+0x2c)
[ 5481.908368]    #func                   -4 arm=5Fnotify=5Fdie+0x10 (d=
o=5FDataAbort+0x11c)
[ 5481.915919]    #func                   -5 wake=5Fup=5Fklogd+0x10 (co=
nsole=5Funlock+0x338)
[ 5481.923558]    #func                   -6 =5Fraw=5Fspin=5Funlock=5Fi=
rqrestore+0x10 (console=5Funlock+0x310)
[ 5481.932411]    #func                   -7 =5F=5Fipipe=5Fspin=5Funloc=
k=5Fdebug+0x10 (console=5Funlock+0x300)
[ 5481.941091]    #func                   -8 =5Fraw=5Fspin=5Flock+0x10 =
(console=5Funlock+0x2e4)
[ 5481.948817]    #func                   -8 =5Fraw=5Fspin=5Funlock=5Fi=
rqrestore+0x10 (up+0x50)
[ 5481.956543]    #func                   -9 =5F=5Fipipe=5Fspin=5Funloc=
k=5Fdebug+0x10 (up+0x44)
[ 5481.964093]    #func                  -10 ipipe=5Froot=5Fonly+0x10 (=
ipipe=5Ftest=5Fand=5Fstall=5Froot+0x18)
[ 5481.972773]    #func                  -11 ipipe=5Ftest=5Fand=5Fstall=
=5Froot+0x10 (=5Fraw=5Fspin=5Flock=5Firqsave+0x1c)
[ 5481.982061]    #func                  -12 =5Fraw=5Fspin=5Flock=5Firq=
save+0x10 (up+0x1c)
[ 5481.989352]    #func                  -13 up+0x10 (console=5Funlock+=
0x2d8)
[ 5481.996036]    #func                  -13 =5Fraw=5Fspin=5Funlock+0x1=
0 (console=5Funlock+0x2d0)
[ 5482.003935]    #func                  -15 ipipe=5Froot=5Fonly+0x10 (=
ipipe=5Ftest=5Fand=5Fstall=5Froot+0x18)
[ 5482.012615]    #func                  -16 ipipe=5Ftest=5Fand=5Fstall=
=5Froot+0x10 (=5Fraw=5Fspin=5Flock=5Firqsave+0x1c)
[ 5482.021902]    #func                  -16 =5Fraw=5Fspin=5Flock=5Firq=
save+0x10 (console=5Funlock+0xd4)
[ 5482.030235]    #func                  -17 =5Fraw=5Fspin=5Funlock=5Fi=
rqrestore+0x10 (cdns=5Fuart=5Fconsole=5Fwrite+0x144)
[ 5482.039870]    #func                  -18 =5F=5Fipipe=5Fspin=5Funloc=
k=5Fdebug+0x10 (cdns=5Fuart=5Fconsole=5Fwrite+0x138)
[ 5482.049331]    #func                  -19 l2c210=5Fsync+0x10 (arm=5F=
heavy=5Fmb+0x2c)
[ 5482.056559]    #func                  -20 arm=5Fheavy=5Fmb+0x10 (cdn=
s=5Fuart=5Fconsole=5Fwrite+0x118)
[ 5482.064868]    #func                  -20 l2c210=5Fsync+0x10 (arm=5F=
heavy=5Fmb+0x2c)
[ 5482.072073]    #func                  -21 arm=5Fheavy=5Fmb+0x10 (cdn=
s=5Fuart=5Fconsole=5Fwrite+0x104)
[ 5482.080446]    #func                 -107 l2c210=5Fsync+0x10 (arm=5F=
heavy=5Fmb+0x2c)
[ 5482.087610]    #func                 -108 arm=5Fheavy=5Fmb+0x10 (cdn=
s=5Fuart=5Fconsole=5Fputchar+0x3c)
[ 5482.096029]    #func                 -144 cdns=5Fuart=5Fconsole=5Fpu=
tchar+0x10 (uart=5Fconsole=5Fwrite+0x64)
[ 5482.104970]    #func                 -144 l2c210=5Fsync+0x10 (arm=5F=
heavy=5Fmb+0x2c)
[ 5482.112174]    #func                 -145 arm=5Fheavy=5Fmb+0x10 (cdn=
s=5Fuart=5Fconsole=5Fputchar+0x3c)
[ 5482.120595]    #func                 -146 cdns=5Fuart=5Fconsole=5Fpu=
tchar+0x10 (uart=5Fconsole=5Fwrite+0x58)
[ 5482.129534]    #func                 -147 uart=5Fconsole=5Fwrite+0x1=
0 (cdns=5Fuart=5Fconsole=5Fwrite+0xcc)
[ 5482.138301]    #func                 -148 l2c210=5Fsync+0x10 (arm=5F=
heavy=5Fmb+0x2c)
[ 5482.145506]    #func                 -148 arm=5Fheavy=5Fmb+0x10 (cdn=
s=5Fuart=5Fconsole=5Fwrite+0xa4)
[ 5482.153751]    #func                 -150 l2c210=5Fsync+0x10 (arm=5F=
heavy=5Fmb+0x2c)
[ 5482.160956]    #func                 -150 arm=5Fheavy=5Fmb+0x10 (cdn=
s=5Fuart=5Fconsole=5Fwrite+0x8c)
[ 5482.169202]    #func                 -152 ipipe=5Froot=5Fonly+0x10 (=
ipipe=5Ftest=5Fand=5Fstall=5Froot+0x18)
[ 5482.177882]    #func                 -152 ipipe=5Ftest=5Fand=5Fstall=
=5Froot+0x10 (=5Fraw=5Fspin=5Flock=5Firqsave+0x1c)
[ 5482.187169]    #func                 -153 =5Fraw=5Fspin=5Flock=5Firq=
save+0x10 (cdns=5Fuart=5Fconsole=5Fwrite+0x15c)
[ 5482.196370]    #func                 -154 cdns=5Fuart=5Fconsole=5Fwr=
ite+0x14 (call=5Fconsole=5Fdrivers.constprop.13+0x110)
[ 5482.206526]    #func                 -155 call=5Fconsole=5Fdrivers.c=
onstprop.13+0x10 (console=5Funlock+0x288)
[ 5482.215901]    #func                 -156 =5Fraw=5Fspin=5Funlock+0x1=
0 (console=5Funlock+0x270)
[ 5482.223799]    #func                 -157 ipipe=5Froot=5Fonly+0x10 (=
ipipe=5Ftest=5Fand=5Fstall=5Froot+0x18)
[ 5482.232479]    #func                 -158 ipipe=5Ftest=5Fand=5Fstall=
=5Froot+0x10 (=5Fraw=5Fspin=5Flock=5Firqsave+0x1c)
[ 5482.241767]    #func                 -159 =5Fraw=5Fspin=5Flock=5Firq=
save+0x10 (console=5Funlock+0x54)
[ 5482.250101]    #func                 -159 console=5Funlock+0x14 (vpr=
intk=5Femit+0x350)
[ 5482.257652]    #func                 -160 =5Fraw=5Fspin=5Funlock=5Fi=
rqrestore+0x10 (down=5Ftrylock+0x3c)
[ 5482.266244]    #func                 -161 =5F=5Fipipe=5Fspin=5Funloc=
k=5Fdebug+0x10 (down=5Ftrylock+0x30)
[ 5482.274664]    #func                 -162 ipipe=5Froot=5Fonly+0x10 (=
ipipe=5Ftest=5Fand=5Fstall=5Froot+0x18)
[ 5482.283344]    #func                 -163 ipipe=5Ftest=5Fand=5Fstall=
=5Froot+0x10 (=5Fraw=5Fspin=5Flock=5Firqsave+0x1c)
[ 5482.292631]    #func                 -164 =5Fraw=5Fspin=5Flock=5Firq=
save+0x10 (down=5Ftrylock+0x1c)
[ 5482.300791]    #func                 -165 down=5Ftrylock+0x10 (conso=
le=5Ftrylock+0x1c)
[ 5482.308342]    #func                 -165 console=5Ftrylock+0x10 (vp=
rintk=5Femit+0x314)
[ 5482.315982]    #func                 -166 =5Fraw=5Fspin=5Funlock+0x1=
0 (vprintk=5Femit+0x2b4)
[ 5482.323706]    #func                 -168 log=5Fmake=5Ffree=5Fspace+=
0x14 (log=5Fstore+0x50)
[ 5482.331344]    #func                 -169 log=5Fstore+0x14 (cont=5Ff=
lush.part.2+0xb4)
[ 5482.338809]    #func                 -170 cont=5Fflush.part.2+0x14 (=
vprintk=5Femit+0x3f4)
[ 5482.346621]    #func                 -171 cont=5Fadd+0x14 (vprintk=5F=
emit+0x3d0)
[ 5482.353660]    #func                 -172 =5Fraw=5Fspin=5Flock+0x10 =
(vprintk=5Femit+0x184)
[ 5482.361213]    #func                 -174 ipipe=5Froot=5Fonly+0x10 (=
ipipe=5Ftest=5Fand=5Fstall=5Froot+0x18)
[ 5482.369892]    #func                 -174 ipipe=5Ftest=5Fand=5Fstall=
=5Froot+0x10 (vprintk=5Femit+0x150)
[ 5482.378399]    #func                 -175 vprintk=5Femit+0x14 (vprin=
tk=5Fdefault+0x34)
[ 5482.385950]    #func                 -176 vprintk=5Fdefault+0x14 (pr=
intk+0x1e0)
[ 5482.393068]    #func                 -177 printk+0x18 (show=5Fpte+0x=
e8)
[ 5482.399491]    #func                 -179 =5Fraw=5Fspin=5Funlock=5Fi=
rqrestore+0x10 (console=5Funlock+0x310)
[ 5482.408345]    #func                 -179 =5F=5Fipipe=5Fspin=5Funloc=
k=5Fdebug+0x10 (console=5Funlock+0x300)
[ 5482.417025]    #func                 -180 =5Fraw=5Fspin=5Flock+0x10 =
(console=5Funlock+0x2e4)
[ 5482.424750]    #func                 -181 =5Fraw=5Fspin=5Funlock=5Fi=
rqrestore+0x10 (up+0x50)
[ 5482.432475]    #func                 -182 =5F=5Fipipe=5Fspin=5Funloc=
k=5Fdebug+0x10 (up+0x44)
[ 5482.440026]    #func                 -183 ipipe=5Froot=5Fonly+0x10 (=
ipipe=5Ftest=5Fand=5Fstall=5Froot+0x18)
[ 5482.448707]    #func                 -184 ipipe=5Ftest=5Fand=5Fstall=
=5Froot+0x10 (=5Fraw=5Fspin=5Flock=5Firqsave+0x1c)
[ 5482.457995]    #func                 -185 =5Fraw=5Fspin=5Flock=5Firq=
save+0x10 (up+0x1c)
[ 5482.465285]    #func                 -185 up+0x10 (console=5Funlock+=
0x2d8)
[ 5482.471969]    #func                 -186 =5Fraw=5Fspin=5Funlock+0x1=
0 (console=5Funlock+0x2d0)
[ 5482.479867]    #func                 -188 ipipe=5Froot=5Fonly+0x10 (=
ipipe=5Ftest=5Fand=5Fstall=5Froot+0x18)
[ 5482.488548]    #func                 -189 ipipe=5Ftest=5Fand=5Fstall=
=5Froot+0x10 (=5Fraw=5Fspin=5Flock=5Firqsave+0x1c)
[ 5482.497836]    #func                 -189 =5Fraw=5Fspin=5Flock=5Firq=
save+0x10 (console=5Funlock+0xd4)
[ 5482.506168]    #func                 -191 =5Fraw=5Fspin=5Funlock=5Fi=
rqrestore+0x10 (cdns=5Fuart=5Fconsole=5Fwrite+0x144)
[ 5482.515803]    #func                 -191 =5F=5Fipipe=5Fspin=5Funloc=
k=5Fdebug+0x10 (cdns=5Fuart=5Fconsole=5Fwrite+0x138)
[ 5482.525264]    #func                 -192 l2c210=5Fsync+0x10 (arm=5F=
heavy=5Fmb+0x2c)
[ 5482.532469]    #func                 -193 arm=5Fheavy=5Fmb+0x10 (cdn=
s=5Fuart=5Fconsole=5Fwrite+0x118)
[ 5482.540801]    #func                 -194 l2c210=5Fsync+0x10 (arm=5F=
heavy=5Fmb+0x2c)
[ 5482.548006]    #func                 -194 arm=5Fheavy=5Fmb+0x10 (cdn=
s=5Fuart=5Fconsole=5Fwrite+0x104)
[ 5482.556338]    #func                 -280 l2c210=5Fsync+0x10 (arm=5F=
heavy=5Fmb+0x2c)
[ 5482.563543]    #func                 -281 arm=5Fheavy=5Fmb+0x10 (cdn=
s=5Fuart=5Fconsole=5Fputchar+0x3c)
[ 5482.571963]    #func                 -366 cdns=5Fuart=5Fconsole=5Fpu=
tchar+0x10 (uart=5Fconsole=5Fwrite+0x38)
[ 5482.580903]    #func                 -367 l2c210=5Fsync+0x10 (arm=5F=
heavy=5Fmb+0x2c)
[ 5482.588108]    #func                 -368 arm=5Fheavy=5Fmb+0x10 (cdn=
s=5Fuart=5Fconsole=5Fputchar+0x3c)
[ 5482.596528]    #func                 -453 cdns=5Fuart=5Fconsole=5Fpu=
tchar+0x10 (uart=5Fconsole=5Fwrite+0x38)
[ 5482.605467]    #func                 -454 l2c210=5Fsync+0x10 (arm=5F=
heavy=5Fmb+0x2c)
[ 5482.612672]    #func                 -454 arm=5Fheavy=5Fmb+0x10 (cdn=
s=5Fuart=5Fconsole=5Fputchar+0x3c)
[ 5482.621091]    #func                 -539 cdns=5Fuart=5Fconsole=5Fpu=
tchar+0x10 (uart=5Fconsole=5Fwrite+0x38)
[ 5482.630032]    #func                 -540 l2c210=5Fsync+0x10 (arm=5F=
heavy=5Fmb+0x2c)
[ 5482.637237]    #func                 -541 arm=5Fheavy=5Fmb+0x10 (cdn=
s=5Fuart=5Fconsole=5Fputchar+0x3c)
[ 5482.645655]    #func                 -545 cdns=5Fuart=5Fconsole=5Fpu=
tchar+0x10 (uart=5Fconsole=5Fwrite+0x38)
[ 5482.654596]    #func                 -546 l2c210=5Fsync+0x10 (arm=5F=
heavy=5Fmb+0x2c)
[ 5482.661802]    #func                 -547 arm=5Fheavy=5Fmb+0x10 (cdn=
s=5Fuart=5Fconsole=5Fputchar+0x3c)
[ 5482.670220]  | #func                 -548 =5F=5Fipipe=5Fbugon=5Firqs=
=5Fenabled+0x10 (=5F=5Fipipe=5Ffast=5Fsvc=5Firq=5Fexit+0x4)
[ 5482.679768]  | #func                 -549 ipipe=5Ftest=5Froot+0x10 (=
=5F=5Fipipe=5Fcheck=5Froot=5Finterruptible+0x5c)
[ 5482.689056]  | #func                 -550 =5F=5Fipipe=5Fcheck=5Froot=
=5Finterruptible+0x10 (=5F=5Firq=5Fsvc+0x58)
[ 5482.697824]  | #func                 -551 =5F=5Fipipe=5Fdo=5Fsync=5F=
pipeline+0x14 (dispatch=5Firq=5Fhead+0x184)
[ 5482.706694] ---[ end trace b591dcdb6dbe58ba ]---


