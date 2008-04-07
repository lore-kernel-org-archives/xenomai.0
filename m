MIME-Version: 1.0
From: Thomas Wiedemann <Thomas.Wiedemann@domain.hid>
Message-ID: <OF4C98FBB1.81F59369-ONC1257421.00355333-C1257424.003F5EB0@domain.hid>
Date: Mon, 7 Apr 2008 13:32:10 +0200
Content-Type: multipart/mixed; boundary="=_mixed 003F5E8EC1257424_="
Subject: [Xenomai-core] posix-skin: unexpected scheduler behaviour
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

--=_mixed 003F5E8EC1257424_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi folks,

i think there is a problem with the xenomai scheduler or the sched=5Fyield(=
)=20
call, when using the POSIX skin (Xenomai 2.4.3, Linux 2.6.24.4, SMP,=20
.config is attached).

I've attached a small program (blub.c, Makefile) to demonstrate this:

It starts 3 threads, which are synchronized at a pthread=5Fbarrier=5Ft befo=
re=20
they execute a finite loop. Each of them puts a number of specific=20
characters into an array, to see in which order they are scheduled. Thread =

#3 calls sched=5Fyield() after wake-up, which means it should never be the =

first of the 3 threads to run its loop. In my understanding of the barrier =

functions, it should run as the last thread, as all three should become=20
ready at the same time. The output of the Linux version (no xenomai=20
involved) is here:

-- Linux version --
1 ist hier [.].
Thread 1: prio =3D 30 policy=3DFIFO
2 ist hier [-].
Thread 2: prio =3D 30 policy=3DFIFO
3 ist hier [*].
Thread 3: prio =3D 30 policy=3DFIFO
[3] PTHREAD=5FBARRIER=5FSERIAL=5FTHREAD ...
[3] Yiiiield!
[1] Loooos!
[3] Loooos!
[2] Loooos!
megabuf:=20
...........................................................................=
.........................**************************************************=
***************************************************************************=
***************************************************************************=
***************************************************************************=
*******************************************************--------------------=
------------------------------

("Loooos!" is printed after returning from *barrier=5Fwait(), just before=20
the loop)
Most of the time, linux does it right, and executes thread #3 after the=20
other two threads, but sometimes the behavious is like above. This is not=20
correct, or am i missing something?



Now the Xenomai version:

-- Xenomai version --
1 ist hier [.].
Thread 1: prio =3D 30 policy=3DFIFO
2 ist hier [-].
Thread 2: prio =3D 30 policy=3DFIFO
3 ist hier [*].
Thread 3: prio =3D 30 policy=3DFIFO
[3] PTHREAD=5FBARRIER=5FSERIAL=5FTHREAD ...
[3] Yiiiield!
[3] Loooos!
[2] Loooos!
[1] Loooos!
megabuf:=20
***************************************************************************=
***************************************************************************=
***************************************************************************=
***************************************************************************=
******************************---------------------------------------------=
-----......................................................................=
..............................

Thread #3 is scheduled first, even though it called sched=5Fyield(). This i=
s=20
even more incorrect, since it seems to be always the case, even if i call=20
sched=5Fyield() multiple times (in this case, the plain linux version=20
behaves correctly)

Any ideas what's wrong with this? Maybe it's even glibc's fault (i'm using =

version 2.4), as the posix-skin seems to use wrapper's to the=20
glibc-functions? Is this a possibility?

Note: compile the program with "make" to get the xenomai-version, or "make =

XENO=3D0" to get the plain linux version.








Thomas Wiedemann

Entwicklungsingenieur / Funktionsentwicklung (EF-F33), Fahrzeug Elektronik

IAV GmbH=20
Ingenieurgesellschaft Auto und Verkehr
Kauffahrtei 45
09120 Chemnitz
Germany

Telefon:   +49  (371) 2373-4045
Fax:          +49  (371) 2373-4112

Email: <mailto:thomas.wiedemann@domain.hid>
Internet: http://www.iav.de


IAV GmbH
Sitz/Registered Office: Berlin
Registergericht/Registration Court: Amtsgericht Charlottenburg
Registernummer/Company Registration Number: HRB 21 280
Gesch=E4ftsf=FChrer/Managing Directors: Kurt Blumenr=F6der, Michael Schubert
=20
--=_mixed 003F5E8EC1257424_=
Content-Type: application/octet-stream; name="config.gz"
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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

--=_mixed 003F5E8EC1257424_=
Content-Type: application/octet-stream; name="blub.c"
Content-Disposition: attachment; filename="blub.c"
Content-Transfer-Encoding: base64

LyoKICAgIHhlbm9tYWkgcG9zaXggdGVzdAoqLwojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUg
PHN0ZGxpYi5oPgojaW5jbHVkZSA8c3RkaW50Lmg+CiNpbmNsdWRlIDxzeXMvbW1hbi5oPgojaW5j
bHVkZSA8c2lnbmFsLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPGN0eXBlLmg+CiNp
bmNsdWRlIDxwdGhyZWFkLmg+CiNpbmNsdWRlIDxtYXRoLmg+CgoKLyogZWFjaCB0aHJlYWQgcHV0
cyBzdHVmZiBpbnRvIHRoaXMgYXJyYXkgOikgKi8Kc3RhdGljIGNoYXIgbWVnYXB1ZlsxMDAwMDBd
ID0gezB9OwpzdGF0aWMgdm9sYXRpbGUgY2hhciAqbWVnYXB1Zl9wdHIgPSBtZWdhcHVmOwoKLyog
c3luY2hyb25pc2UgdGhyZWFkcyBvbiB0aGlzIGJhcnJpZXIgKi8Kc3RhdGljIHB0aHJlYWRfYmFy
cmllcl90IGJhcnJpZXI7CgoKc3RhdGljIHZvbGF0aWxlIGludCBsb29wPTE7CgpzdGF0aWMgdm9p
ZCBzaWdpbnQoaW50IHNpZ25hbCkgewoJbG9vcD0wOwp9CgoKc3RhdGljIHZvaWQgbWtzaWdoYW5k
bGVyKHZvaWQpIHsKCXN0cnVjdCBzaWdhY3Rpb24gYWN0OwoJYWN0LnNhX2hhbmRsZXI9c2lnaW50
OwoJYWN0LnNhX2ZsYWdzPTA7CglzaWdhY3Rpb24oU0lHSU5ULCAmYWN0LCBOVUxMKTsKfQoKCgov
KiBzbGVlcCBhIGJpdC4uLiAqLwpzdGF0aWMgdm9pZCBwc2xlZXAodW5zaWduZWQgaW50IHRpbWVf
bnMpIHsKCXN0cnVjdCB0aW1lc3BlYyBpbnR2OwoKCWludHYudHZfc2VjICA9IHRpbWVfbnMgLyAx
MDAwMDAwMDAwVUw7CglpbnR2LnR2X25zZWMgPSB0aW1lX25zICUgMTAwMDAwMDAwMFVMOwoKCWNs
b2NrX25hbm9zbGVlcChDTE9DS19SRUFMVElNRSwgMCwgJmludHYsIE5VTEwpOwp9CgoKc3RhdGlj
IHZvaWQgc2V0X2FmZmluaXR5KGludCBjcHUpIHsKCWNwdV9zZXRfdCBjcHVfc2V0OwoJQ1BVX1pF
Uk8oJmNwdV9zZXQpOwoJQ1BVX1NFVChjcHUsJmNwdV9zZXQpOwoJc2NoZWRfc2V0YWZmaW5pdHko
MCwgc2l6ZW9mKGNwdV9zZXQpLCAmY3B1X3NldCk7Cn0KCgovKiBwcmludCBzY2hlZHVsZXIgaW5m
b3JtYXRpb24gKi8Kc3RhdGljIHZvaWQgcHJpbnRfc2NoZWRfaW5mbyhpbnQgaSkgewoJc3RydWN0
IHNjaGVkX3BhcmFtIHA7CglpbnQgcG9saWN5OwoJCglwdGhyZWFkX2dldHNjaGVkcGFyYW0ocHRo
cmVhZF9zZWxmKCksICZwb2xpY3ksICZwKTsKCglmcHJpbnRmKHN0ZGVyciwiVGhyZWFkICVpOiBw
cmlvID0gJWkgcG9saWN5PSVzXG4iLGkscC5zY2hlZF9wcmlvcml0eSwKCQkJCQkocG9saWN5PT1T
Q0hFRF9SUj8iUlIiOgoJCQkJCSAJCShwb2xpY3k9PVNDSEVEX0ZJRk8/IkZJRk8iOiJvdGhlciIp
KSk7CglpZihwb2xpY3k9PVNDSEVEX1JSKSB7CgkJcHJpbnRfcnJfaW5mbygpOwoJfQp9CnN0YXRp
YyB2b2lkIHByaW50X3JyX2luZm8oKSB7CglzdHJ1Y3QgdGltZXNwZWMgdDsKCXNjaGVkX3JyX2dl
dF9pbnRlcnZhbCgwLCAmdCk7CglmcHJpbnRmKHN0ZGVyciwiUlIgdGltZXNsaWNlOiAlOC4zZiBt
c1xuIiwoKGRvdWJsZSl0LnR2X3NlYyoxMDAwLjApICsgKChkb3VibGUpdC50dl9uc2VjIC8gMTAw
MDAwMC4wKSk7Cn0KCgovKiB0aGUgdGhyZWFkIGVudHJ5IGZ1bmN0aW9uICovCnN0YXRpYyB2b2lk
ICp0ZnVuYyh2b2lkICphcmcpIHsKCWludCBteV9udW09KGludClhcmc7Cgl1aW50NjRfdCBubG9v
cHM7Cgl1aW50NjRfdCBjdHI9MDsKCXN0YXRpYyBjaGFyIHRzaWduc1tdID0geyc9JywnLicsJy0n
LCcqJywnIyd9OwoKCXNldF9hZmZpbml0eSgxKTsKCWZwcmludGYoc3RkZXJyLCIlaSBpc3QgaGll
ciBbJWNdLiBcbiIsbXlfbnVtLCB0c2lnbnNbbXlfbnVtXSk7CglwcmludF9zY2hlZF9pbmZvKG15
X251bSk7CgkKCXB0aHJlYWRfYmFycmllcl93YWl0KCZiYXJyaWVyKTsKCWlmKG15X251bT09Mykg
ewoJCS8qCgkJICAgCgkJCVRocmVhZCAzIGNhbGxzIHNjaGVkX3lpZWxkKCksIGFuZCBzaG91bGQg
dGhlbiBiZWNvbWUgdGhlIGxhc3Qgb25lIGluIHRoZSBGSUZPCgkJCXF1ZXVlLiBIb3dldmVyLCB3
aGVuIGNvbXBpbGVkIGFuZCBleGVjdXRlZCB3aXRoaW4gYSB4ZW5vbWFpIGVudmlyb25tZW50LCBp
dAoJCQlpcyBzdGlsbCBleGVjdXRlZCBiZWZvcmUgdGhlIG90aGVyIHRocmVhZHMuCgkJCQoJCQlU
aGUgdXN1YWwgcHRocmVhZHMtaW1wbGVtZW50YXRpaW9uIHdvcmtzIGNvcnJlY3RseSwgaG93ZXZl
ci4KCQkJCgkJICAqLyAKCQlmcHJpbnRmKHN0ZGVyciwiWyVpXSBZaWlpaWVsZCFcbiIsbXlfbnVt
KTsKCQlzY2hlZF95aWVsZCgpOwoJfQoJZnByaW50ZihzdGRlcnIsIlslaV0gTG9vb29zIVxuIixt
eV9udW0pOwoJCgoJc3dpdGNoKG15X251bSkgewoJCWNhc2UgMTogbmxvb3BzPTEwMDAwMDAwVUxM
OyBicmVhazsKCQljYXNlIDI6IG5sb29wcz01MDAwMDAwVUxMOyBicmVhazsKCQljYXNlIDM6IG5s
b29wcz0zMzAwMDAwMFVMTDsgYnJlYWs7CgkJZGVmYXVsdDogbmxvb3BzPTA7IGJyZWFrOwoJfQoJ
Cgl3aGlsZShjdHI8bmxvb3BzKSB7CgkJaWYoY3RyJTEwMDAwMCA9PSAwKSB7CgkJCSptZWdhcHVm
X3B0cisrPXRzaWduc1tteV9udW1dOwoJCX0KCQljdHIrKzsKCX0KCXJldHVybiBOVUxMOwp9CgoK
Ci8qIHN0YXJ0IGEgdGhyZWFkICAqLwpzdGF0aWMgdm9pZCBzdGFydF90aHJlYWQoaW50IG51bSwg
cHRocmVhZF90ICppZCkgewoJcHRocmVhZF9hdHRyX3QgYXR0cjsKCXN0cnVjdCBzY2hlZF9wYXJh
bSBzcGFybTsKCWNoYXIgdG5hbWVbMzJdOwoKCXNldF9hZmZpbml0eSgxKTsKCQoJcHRocmVhZF9h
dHRyX2luaXQoJmF0dHIpOwoJcHRocmVhZF9hdHRyX3NldGluaGVyaXRzY2hlZCgmYXR0ciwgUFRI
UkVBRF9FWFBMSUNJVF9TQ0hFRCk7CglwdGhyZWFkX2F0dHJfc2V0c2NoZWRwb2xpY3koJmF0dHIs
IFNDSEVEX0ZJRk8pOwoJCglzd2l0Y2gobnVtKSB7CgkJY2FzZSAxOiBzcGFybS5zY2hlZF9wcmlv
cml0eT0zMDsgYnJlYWs7CgkJY2FzZSAyOiBzcGFybS5zY2hlZF9wcmlvcml0eT0zMDsgYnJlYWs7
CgkJY2FzZSAzOiBzcGFybS5zY2hlZF9wcmlvcml0eT0zMDsgYnJlYWs7CgkJZGVmYXVsdDogc3Bh
cm0uc2NoZWRfcHJpb3JpdHk9ODA7IGJyZWFrOwoJfQoJcHRocmVhZF9hdHRyX3NldHNjaGVkcGFy
YW0oJmF0dHIsICZzcGFybSk7CglpZihwdGhyZWFkX2NyZWF0ZShpZCwmYXR0cix0ZnVuYywodm9p
ZCopbnVtKTwwKSB7CgkJcGVycm9yKCJwdGhyZWFkX2NyZWF0ZSIpOwoJfQoKI2lmZGVmIF9fWEVO
T19fCglzcHJpbnRmKCZ0bmFtZVswXSwiYmx1Yi0laSIsbnVtKTsKCXB0aHJlYWRfc2V0X25hbWVf
bnAoKmlkLCZ0bmFtZVswXSk7CiNlbmRpZgp9CgoKCi8qIHN0YXJ0IDMgdGhyZWFkcyBhbmQgd2Fp
dCBmb3IgdGhlaXIgY29tcGxldGlvbiAqLwp2b2lkIHN0YXJ0X3RocmVhZHMoKSB7CglwdGhyZWFk
X3QgdGlkMSwgdGlkMiwgdGlkMzsKCglzZXRfYWZmaW5pdHkoMCk7CgkKCXB0aHJlYWRfYmFycmll
cl9pbml0KCZiYXJyaWVyLCBOVUxMLCAzKTsKCQoJc3RhcnRfdGhyZWFkKDEsJnRpZDEpOwoJc3Rh
cnRfdGhyZWFkKDIsJnRpZDIpOwoJc3RhcnRfdGhyZWFkKDMsJnRpZDMpOwoJCgkvL3NldF9hZmZp
bml0eSgwKTsKCgkvL3doaWxlKGxvb3ApIHsgcnRfdGFza19zbGVlcCgzMDApOyB9CgkKCXB0aHJl
YWRfam9pbih0aWQxLCBOVUxMKTsKCXB0aHJlYWRfam9pbih0aWQyLCBOVUxMKTsKCXB0aHJlYWRf
am9pbih0aWQzLCBOVUxMKTsKCgkKCSptZWdhcHVmX3B0cisrPSdcbic7CglwcmludGYoIm1lZ2Fi
dWY6ICVzIiwgbWVnYXB1Zik7Cn0KCgoKCmludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10p
IHsKI2lmZGVmIF9fWEVOT19fCglwcmludGYoIi0tIFhlbm9tYWkgdmVyc2lvbiAtLVxuIik7CiNl
bHNlCglwcmludGYoIi0tIExpbnV4IHZlcnNpb24gLS1cbiIpOwojZW5kaWYKCQoJbWxvY2thbGwo
TUNMX0NVUlJFTlR8TUNMX0ZVVFVSRSk7CiAJbWtzaWdoYW5kbGVyKCk7CglzdGFydF90aHJlYWRz
KCk7CglyZXR1cm4gMDsKfQoKCg==

--=_mixed 003F5E8EC1257424_=
Content-Type: application/octet-stream; name="Makefile"
Content-Disposition: attachment; filename="Makefile"
Content-Transfer-Encoding: base64

Q0M9Z2NjCkNGTEFHUz0tV2FsbCAtZwoKaWZuZXEgKCQoWEVOTyksMCkKCUNGTEFHUys9YC91c3Iv
eGVub21haS9iaW4veGVuby1jb25maWcgLS1wb3NpeC1jZmxhZ3NgCglMREZMQUdTKz0tbG0gYC91
c3IveGVub21haS9iaW4veGVuby1jb25maWcgLS1wb3NpeC1sZGZsYWdzYAogIGVsc2UKCUNGTEFH
Uys9LURfR05VX1NPVVJDRSAtRF9SRUVOVFJBTlQKCUxERkxBR1MrPS1scHRocmVhZCAtbHJ0IC1s
bQplbmRpZgoKCmJsdWI6IGJsdWIuYwoKCmNsZWFuOgoJCXJtIC1mIGJsdWIK

--=_mixed 003F5E8EC1257424_=
Content-Type: text/plain; name="log.txt"
Content-Disposition: attachment; filename="log.txt"
Content-Transfer-Encoding: quoted-printable

thinky:~/posix-pthread-scheduler-test# make clean ; make ; ./blub=0Arm -f b=
lub=0Agcc -Wall -g `/usr/xenomai/bin/xeno-config --posix-cflags`  -lm `/usr=
/xenomai/bin/xeno-config --posix-ldflags`  blub.c   -o blub=0Ablub.c:44: wa=
rning: =E2=80=98psleep=E2=80=99 defined but not used=0A-- Xenomai version -=
-=0A1 ist hier [.].=0AThread 1: prio =3D 30 policy=3DFIFO=0A2 ist hier [-].=
=0AThread 2: prio =3D 30 policy=3DFIFO=0A3 ist hier [*].=0AThread 3: prio =
=3D 30 policy=3DFIFO=0A[3] PTHREAD=5FBARRIER=5FSERIAL=5FTHREAD ...=0A[3] Yi=
iiield!=0A[3] Loooos!=0A[2] Loooos!=0A[1] Loooos!=0Amegabuf: **************=
***************************************************************************=
***************************************************************************=
***************************************************************************=
***************************************************************************=
****************--------------------------------------------------.........=
...........................................................................=
................=0Athinky:~/posix-pthread-scheduler-test# make clean ; make=
 XENO=3D0; ./blub=0Arm -f blub=0Agcc -Wall -g -D=5FGNU=5FSOURCE -D=5FREENTR=
ANT  -lpthread -lrt -lm  blub.c   -o blub=0Ablub.c: In function =E2=80=98st=
art=5Fthread=E2=80=99:=0Ablub.c:150: warning: unused variable =E2=80=98tnam=
e=E2=80=99=0Ablub.c: At top level:=0Ablub.c:44: warning: =E2=80=98psleep=E2=
=80=99 defined but not used=0A-- Linux version --=0A1 ist hier [.].=0AThrea=
d 1: prio =3D 30 policy=3DFIFO=0A2 ist hier [-].=0AThread 2: prio =3D 30 po=
licy=3DFIFO=0A3 ist hier [*].=0AThread 3: prio =3D 30 policy=3DFIFO=0A[3] P=
THREAD=5FBARRIER=5FSERIAL=5FTHREAD ...=0A[3] Yiiiield!=0A[1] Loooos!=0A[3] =
Loooos!=0A[2] Loooos!=0Amegabuf: ..........................................=
..........................................................*****************=
***************************************************************************=
***************************************************************************=
***************************************************************************=
***************************************************************************=
*************--------------------------------------------------=0A=0A=
--=_mixed 003F5E8EC1257424_=--

