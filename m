MIME-Version: 1.0
Date: Thu, 6 Jan 2011 20:57:32 +0900
Message-ID: <AANLkTimQ5KK_qqdCmfmeA2+spnGcCy1frEwrUhDa_RwV@mail.gmail.com>
From: Donggu Kang <cdslashboot@domain.hid>
Content-Type: multipart/alternative; boundary=001636833064f6537504992c34ae
Subject: [Xenomai-help] Xenomai/switchtest pthread_create: Resource
 temporarily unavailable on i7 860 CPU
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--001636833064f6537504992c34ae
Content-Type: text/plain; charset=UTF-8

hi,

It looks like something problem in pthread_create with FPU option on my
system.
Could you talk to me your any tips/suggestions/experiences.

./switchtest -T10
== Testing FPU check routines...
r0: 1 !=2
r1: 1 !=2
r2: 1 !=2
r3: 1 !=2
r4: 1 !=2
r5: 1 !=2
r6: 1 !=2
r7: 1 !=2
== FPU check routines : OK
pthread_create: Resource temporarily unavailable
== Threads :

System
Dell Precision T1500 ( i7 860 )
linux-kernel 2.6.35.7
xenomai 2.5.5.2
adeos-ipipe-2.6.35.7-x86-2.8-01.patch

please help me

--001636833064f6537504992c34ae
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div>hi,</div><div><br></div><div><div><span class=3D"Apple-style-span" sty=
le=3D"font-family: monospace; font-size: medium; white-space: pre; ">It loo=
ks like something problem in pthread_create with FPU option </span><span cl=
ass=3D"Apple-style-span" style=3D"font-family: monospace; font-size: medium=
; white-space: pre; ">on my system.</span></div>
<div><span class=3D"Apple-style-span" style=3D"font-family: monospace; font=
-size: medium; white-space: pre; ">Could you talk to me your any </span><sp=
an class=3D"Apple-style-span" style=3D"font-family: monospace; font-size: m=
edium; white-space: pre; ">tips/suggestions/experiences.</span></div>
</div><div><font class=3D"Apple-style-span" face=3D"monospace" size=3D"3"><=
span class=3D"Apple-style-span" style=3D"white-space: pre;"><br></span></fo=
nt></div><div>./switchtest -T10</div>=3D=3D Testing FPU check routines...<d=
iv>r0: 1 !=3D2</div>
<div>r1: 1 !=3D2<span class=3D"Apple-style-span" style=3D"font-family: aria=
l, sans-serif; font-size: 13px; border-collapse: collapse; ">=C2=A0</span><=
/div><div><span class=3D"Apple-style-span" style=3D"font-family: arial, san=
s-serif; font-size: 13px; border-collapse: collapse; "><span class=3D"Apple=
-style-span" style=3D"border-collapse: separate; font-family: arial; font-s=
ize: small; ">r2: 1 !=3D2<span class=3D"Apple-style-span" style=3D"font-fam=
ily: arial, sans-serif; font-size: 13px; border-collapse: collapse; ">=C2=
=A0</span></span></span></div>
<div><span class=3D"Apple-style-span" style=3D"font-family: arial, sans-ser=
if; font-size: 13px; border-collapse: collapse; "><span class=3D"Apple-styl=
e-span" style=3D"border-collapse: separate; font-family: arial; font-size: =
small; "><span class=3D"Apple-style-span" style=3D"font-family: arial, sans=
-serif; font-size: 13px; border-collapse: collapse; "><span class=3D"Apple-=
style-span" style=3D"border-collapse: separate; font-family: arial; font-si=
ze: small; ">r3: 1 !=3D2<span class=3D"Apple-style-span" style=3D"font-fami=
ly: arial, sans-serif; font-size: 13px; border-collapse: collapse; ">=C2=A0=
</span></span></span></span></span></div>
<div><span class=3D"Apple-style-span" style=3D"font-family: arial, sans-ser=
if; font-size: 13px; border-collapse: collapse; "><span class=3D"Apple-styl=
e-span" style=3D"border-collapse: separate; font-family: arial; font-size: =
small; "><span class=3D"Apple-style-span" style=3D"font-family: arial, sans=
-serif; font-size: 13px; border-collapse: collapse; "><span class=3D"Apple-=
style-span" style=3D"border-collapse: separate; font-family: arial; font-si=
ze: small; "><span class=3D"Apple-style-span" style=3D"font-family: arial, =
sans-serif; font-size: 13px; border-collapse: collapse; "><span class=3D"Ap=
ple-style-span" style=3D"border-collapse: separate; font-family: arial; fon=
t-size: small; ">r4: 1 !=3D2<span class=3D"Apple-style-span" style=3D"font-=
family: arial, sans-serif; font-size: 13px; border-collapse: collapse; ">=
=C2=A0</span></span></span></span></span></span></span></div>
<div><span class=3D"Apple-style-span" style=3D"font-family: arial, sans-ser=
if; font-size: 13px; border-collapse: collapse; "><span class=3D"Apple-styl=
e-span" style=3D"border-collapse: separate; font-family: arial; font-size: =
small; "><span class=3D"Apple-style-span" style=3D"font-family: arial, sans=
-serif; font-size: 13px; border-collapse: collapse; "><span class=3D"Apple-=
style-span" style=3D"border-collapse: separate; font-family: arial; font-si=
ze: small; "><span class=3D"Apple-style-span" style=3D"font-family: arial, =
sans-serif; font-size: 13px; border-collapse: collapse; "><span class=3D"Ap=
ple-style-span" style=3D"border-collapse: separate; font-family: arial; fon=
t-size: small; "><span class=3D"Apple-style-span" style=3D"font-family: ari=
al, sans-serif; font-size: 13px; border-collapse: collapse; "><span class=
=3D"Apple-style-span" style=3D"border-collapse: separate; font-family: aria=
l; font-size: small; ">r5: 1 !=3D2<span class=3D"Apple-style-span" style=3D=
"font-family: arial, sans-serif; font-size: 13px; border-collapse: collapse=
; ">=C2=A0</span></span></span></span></span></span></span></span></span></=
div>
<div><span class=3D"Apple-style-span" style=3D"font-family: arial, sans-ser=
if; font-size: 13px; border-collapse: collapse; "><span class=3D"Apple-styl=
e-span" style=3D"border-collapse: separate; font-family: arial; font-size: =
small; "><span class=3D"Apple-style-span" style=3D"font-family: arial, sans=
-serif; font-size: 13px; border-collapse: collapse; "><span class=3D"Apple-=
style-span" style=3D"border-collapse: separate; font-family: arial; font-si=
ze: small; "><span class=3D"Apple-style-span" style=3D"font-family: arial, =
sans-serif; font-size: 13px; border-collapse: collapse; "><span class=3D"Ap=
ple-style-span" style=3D"border-collapse: separate; font-family: arial; fon=
t-size: small; "><span class=3D"Apple-style-span" style=3D"font-family: ari=
al, sans-serif; font-size: 13px; border-collapse: collapse; "><span class=
=3D"Apple-style-span" style=3D"border-collapse: separate; font-family: aria=
l; font-size: small; "><span class=3D"Apple-style-span" style=3D"font-famil=
y: arial, sans-serif; font-size: 13px; border-collapse: collapse; "><span c=
lass=3D"Apple-style-span" style=3D"border-collapse: separate; font-family: =
arial; font-size: small; ">r6: 1 !=3D2<span class=3D"Apple-style-span" styl=
e=3D"font-family: arial, sans-serif; font-size: 13px; border-collapse: coll=
apse; ">=C2=A0</span></span></span></span></span></span></span></span></spa=
n></span></span></div>
<div><span class=3D"Apple-style-span" style=3D"font-family: arial, sans-ser=
if; font-size: 13px; border-collapse: collapse; "><span class=3D"Apple-styl=
e-span" style=3D"border-collapse: separate; font-family: arial; font-size: =
small; "><span class=3D"Apple-style-span" style=3D"font-family: arial, sans=
-serif; font-size: 13px; border-collapse: collapse; "><span class=3D"Apple-=
style-span" style=3D"border-collapse: separate; font-family: arial; font-si=
ze: small; "><span class=3D"Apple-style-span" style=3D"font-family: arial, =
sans-serif; font-size: 13px; border-collapse: collapse; "><span class=3D"Ap=
ple-style-span" style=3D"border-collapse: separate; font-family: arial; fon=
t-size: small; "><span class=3D"Apple-style-span" style=3D"font-family: ari=
al, sans-serif; font-size: 13px; border-collapse: collapse; "><span class=
=3D"Apple-style-span" style=3D"border-collapse: separate; font-family: aria=
l; font-size: small; "><span class=3D"Apple-style-span" style=3D"font-famil=
y: arial, sans-serif; font-size: 13px; border-collapse: collapse; "><span c=
lass=3D"Apple-style-span" style=3D"border-collapse: separate; font-family: =
arial; font-size: small; "><span class=3D"Apple-style-span" style=3D"font-f=
amily: arial, sans-serif; font-size: 13px; border-collapse: collapse; "><sp=
an class=3D"Apple-style-span" style=3D"border-collapse: separate; font-fami=
ly: arial; font-size: small; ">r7: 1 !=3D2<span class=3D"Apple-style-span" =
style=3D"font-family: arial, sans-serif; font-size: 13px; border-collapse: =
collapse; ">=C2=A0</span></span></span></span></span></span></span></span><=
/span></span></span></span></span></div>
<div><span class=3D"Apple-style-span" style=3D"font-family: arial, sans-ser=
if; font-size: 13px; border-collapse: collapse; "><span class=3D"Apple-styl=
e-span" style=3D"border-collapse: separate; font-family: arial; font-size: =
small; "><span class=3D"Apple-style-span" style=3D"font-family: arial, sans=
-serif; font-size: 13px; border-collapse: collapse; "><span class=3D"Apple-=
style-span" style=3D"border-collapse: separate; font-family: arial; font-si=
ze: small; "><span class=3D"Apple-style-span" style=3D"font-family: arial, =
sans-serif; font-size: 13px; border-collapse: collapse; "><span class=3D"Ap=
ple-style-span" style=3D"border-collapse: separate; font-family: arial; fon=
t-size: small; "><span class=3D"Apple-style-span" style=3D"font-family: ari=
al, sans-serif; font-size: 13px; border-collapse: collapse; "><span class=
=3D"Apple-style-span" style=3D"border-collapse: separate; font-family: aria=
l; font-size: small; "><span class=3D"Apple-style-span" style=3D"font-famil=
y: arial, sans-serif; font-size: 13px; border-collapse: collapse; "><span c=
lass=3D"Apple-style-span" style=3D"border-collapse: separate; font-family: =
arial; font-size: small; "><span class=3D"Apple-style-span" style=3D"font-f=
amily: arial, sans-serif; font-size: 13px; border-collapse: collapse; "><sp=
an class=3D"Apple-style-span" style=3D"border-collapse: separate; font-fami=
ly: arial; font-size: small; "><span class=3D"Apple-style-span" style=3D"fo=
nt-family: arial, sans-serif; font-size: 13px; border-collapse: collapse; "=
>=3D=3D FPU check routines : OK</span></span></span></span></span></span></=
span></span></span></span></span></span></span></div>
<div><font class=3D"Apple-style-span" face=3D"arial, sans-serif"><span clas=
s=3D"Apple-style-span" style=3D"border-collapse: collapse;">pthread_create:=
 Resource temporarily unavailable</span></font></div><div><font class=3D"Ap=
ple-style-span" face=3D"arial, sans-serif"><span class=3D"Apple-style-span"=
 style=3D"border-collapse: collapse;">=3D=3D Threads :=C2=A0</span></font><=
/div>
<div><font class=3D"Apple-style-span" face=3D"monospace" size=3D"3"><span c=
lass=3D"Apple-style-span" style=3D"white-space: pre;"><br></span></font></d=
iv><div><span class=3D"Apple-style-span" style=3D"font-family: arial, sans-=
serif; border-collapse: collapse; ">System=C2=A0</span></div>
<div><span class=3D"Apple-style-span" style=3D"font-family: monospace; font=
-size: medium; white-space: pre; ">Dell Precision T1500 ( i7 860 )</span></=
div><div><span class=3D"Apple-style-span" style=3D"font-family: monospace; =
font-size: medium; white-space: pre; ">linux-kernel 2.6.35.7</span></div>
<div><span class=3D"Apple-style-span" style=3D"font-family: monospace; font=
-size: medium; white-space: pre; ">xenomai 2.5.5.2</span></div><div><span c=
lass=3D"Apple-style-span" style=3D"font-family: monospace; font-size: mediu=
m; white-space: pre; ">adeos-ipipe-2.6.35.7-x86-2.8-01.patch</span></div>
<div><span class=3D"Apple-style-span" style=3D"font-family: monospace; font=
-size: medium; white-space: pre; "><br></span></div><div><font class=3D"App=
le-style-span" face=3D"monospace" size=3D"3"><span class=3D"Apple-style-spa=
n" style=3D"white-space: pre;">please help me</span></font></div>
<div><span class=3D"Apple-style-span" style=3D"font-family: monospace; font=
-size: medium; white-space: pre; "><br></span></div><div><font class=3D"App=
le-style-span" face=3D"monospace" size=3D"3"><span class=3D"Apple-style-spa=
n" style=3D"white-space: pre;"><br>
</span></font></div><div><font class=3D"Apple-style-span" face=3D"monospace=
" size=3D"3"><span class=3D"Apple-style-span" style=3D"white-space: pre;"><=
br></span></font></div><div><font class=3D"Apple-style-span" face=3D"monosp=
ace" size=3D"3"><span class=3D"Apple-style-span" style=3D"white-space: pre;=
"><br>
</span></font></div>

--001636833064f6537504992c34ae--

