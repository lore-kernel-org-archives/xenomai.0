MIME-Version: 1.0
Sender: madjsw@domain.hid
Date: Wed, 23 Mar 2011 15:11:52 -0500
Message-ID: <AANLkTikC-6XF9nx58AEyiuU_ZYa29jjg37km6eRer5Kz@domain.hid>
From: Jeff Weber <jwamsc@domain.hid>
Content-Type: multipart/alternative; boundary=e0cb4e3856d4bf4f90049f2bf8a7
Subject: [Xenomai-help] unable to build xenomai-head
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

--e0cb4e3856d4bf4f90049f2bf8a7
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

I am unable to build the xenomai head. "make modules" gives

  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CC [M]  kernel/xenomai/nucleus/registry.o
kernel/xenomai/nucleus/registry.c:226:8: warning: type defaults to =91int=
=92 in
declaration of =91DECLARE_MUTEX=92
kernel/xenomai/nucleus/registry.c:226:1: warning: parameter names (without
types) in function declaration
kernel/xenomai/nucleus/registry.c: In function =91registry_proc_callback=92=
:
kernel/xenomai/nucleus/registry.c:250:8: error: =91export_mutex=92 undeclar=
ed
(first use in this function)
kernel/xenomai/nucleus/registry.c:250:8: note: each undeclared identifier i=
s
reported only once for each function it appears in
kernel/xenomai/nucleus/registry.c: At top level:
kernel/xenomai/nucleus/registry.c:226:8: warning: =91DECLARE_MUTEX=92 decla=
red
=91static=92 but never defined
make[3]: *** [kernel/xenomai/nucleus/registry.o] Error 1
make[2]: *** [kernel/xenomai/nucleus] Error 2
make[1]: *** [kernel/xenomai] Error 2
make: *** [kernel] Error 2
make: *** Waiting for unfinished jobs....

this config:
linux=3D/usr/src/linux-2.6.37.3
xenomai=3D xenomai-head
adeos=3Dadeos-ipipe-2.6.37-x86-2.9-00.patch
arch=3Dx86 32-bit on SMP

I recently successfully build the same config using the released
xenomai-2.5.6 with no problems.
I'm  not yet experienced in git, but I obtained the xenomai-head branch by:

git clone git://xenomai.org/xenomai-head.git

Did I fetch the branch wrong, or does the xenomai-head branch currently not
build?
I need the CLOCK_HOST_REALTIME feature.

TIA,
Jeff

--e0cb4e3856d4bf4f90049f2bf8a7
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

I am unable to build the xenomai head. &quot;make modules&quot; gives<div><=
br></div><div><div>=A0=A0CHK =A0 =A0 include/linux/version.h</div><div>=A0=
=A0CHK =A0 =A0 include/generated/utsrelease.h</div><div>=A0=A0CALL =A0 =A0s=
cripts/checksyscalls.sh</div>

<div>=A0=A0CC [M] =A0kernel/xenomai/nucleus/registry.o</div><div>kernel/xen=
omai/nucleus/registry.c:226:8: warning: type defaults to =91int=92 in decla=
ration of =91DECLARE_MUTEX=92</div><div>kernel/xenomai/nucleus/registry.c:2=
26:1: warning: parameter names (without types) in function declaration</div=
>

<div>kernel/xenomai/nucleus/registry.c: In function =91registry_proc_callba=
ck=92:</div><div>kernel/xenomai/nucleus/registry.c:250:8: error: =91export_=
mutex=92 undeclared (first use in this function)</div><div>kernel/xenomai/n=
ucleus/registry.c:250:8: note: each undeclared identifier is reported only =
once for each function it appears in</div>

<div>kernel/xenomai/nucleus/registry.c: At top level:</div><div>kernel/xeno=
mai/nucleus/registry.c:226:8: warning: =91DECLARE_MUTEX=92 declared =91stat=
ic=92 but never defined</div><div>make[3]: *** [kernel/xenomai/nucleus/regi=
stry.o] Error 1</div>

<div>make[2]: *** [kernel/xenomai/nucleus] Error 2</div><div>make[1]: *** [=
kernel/xenomai] Error 2</div><div>make: *** [kernel] Error 2</div><div>make=
: *** Waiting for unfinished jobs....</div></div><div><br></div><div>this c=
onfig:</div>

<div>linux=3D/usr/src/linux-2.6.37.3</div><div>xenomai=3D xenomai-head</div=
><div>adeos=3Dadeos-ipipe-2.6.37-x86-2.9-00.patch</div><div>arch=3Dx86 32-b=
it on SMP</div><div><br></div><div>I recently successfully build the same c=
onfig using the released xenomai-2.5.6 with no problems.</div>

<div>I&#39;m =A0not yet experienced in git, but I obtained the xenomai-head=
 branch by:</div><div><div><br></div><div>git clone git://<a href=3D"http:/=
/xenomai.org/xenomai-head.git" target=3D"_blank">xenomai.org/xenomai-head.g=
it</a></div>
</div>
<div><br></div><div>Did I fetch the branch wrong, or does the=A0xenomai-hea=
d branch currently not build?</div><div>I need the CLOCK_HOST_REALTIME feat=
ure.</div><div><br></div><div>TIA,</div><div>Jeff</div><div><br></div><div>

<br></div><div></div>

--e0cb4e3856d4bf4f90049f2bf8a7--

