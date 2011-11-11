Message-ID: <1320995056.19430.YahooMailNeo@domain.hid>
Date: Thu, 10 Nov 2011 23:04:16 -0800 (PST)
From: Guvenc Gulce <gulceg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] IDDP send-receive example emits SIGXCPU signal
Reply-To: Guvenc Gulce <gulceg@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi=0AMy environment looks like the following:=0AXenomai 2.5.6=A0=0AUsed ski=
n: Posix=0A=0AKernel 2.6.35.3=0ATarget Environment: ARM=0A=0A=0AI have comp=
iled the example iddp-sendrecv which can be found under /examples/rtdm/prof=
iles/ipc=A0=0A(http://www.xenomai.org/documentation/xenomai-head/html/api/i=
ddp-sendrecv_8c-example.html )=0A=0Awith the existing makefile under the sa=
me directory. The binary seems to be linking ok with the =0A=0Axenomai libr=
aries as you can also see here:=0A=0A=0Aarm-linux-readelf -d iddp-sendrecv=
=0A=0ADynamic section at offset 0x1ed8 contains 32 entries:=0A=A0 Tag=A0=A0=
=A0=A0=A0=A0=A0 Type=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 Name/Value=0A=A00x00000001 (NEEDED)=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Shared library: [libpthread_rt.so.1=
]=0A=A00x00000001 (NEEDED)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 Shared library: [libxenomai.so.0]=0A=A00x00000001 (NEEDED)=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Shared library: [=
libpthread.so.0]=0A=A00x00000001 (NEEDED)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Shared library: [librt.so.1]=0A=A00x00000001 (N=
EEDED)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Shared l=
ibrary: [librtdm.so.1]=0A=A00x00000001 (NEEDED)=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Shared library: [librtdk.so.0]=0A=A00x000=
00001 (NEEDED)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
Shared library: [libc.so.6]=0A=0A=0A=0AIn order to test the real-timeliness=
 of this piece of binary, I have added =0A=0Aone line of code to the beginn=
ing of the each thread (client and server)=0A=0A=A0=A0=A0=A0=A0=A0=A0 pthre=
ad_set_mode_np(0, PTHREAD_WARNSW);=0A=0A=0Aso that any switch from Primary =
to Secondary will be reported with a =0A=0ASIGXCPU. My expectation was that=
 I wouldnt see any switch to secondary =0A=0Amode as IDDP is supposed to wo=
rk between real time threads without hurting =0A=0Atheir real-timeliness.=
=0A=0ABut I do get the SIGXCPU after adding the PTHREAD_WARNSW and the =0A=
=0Agdb output says=0A=0AProgram received signal SIGXCPU, CPU time limit exc=
eeded.=0A[Switching to Thread 0x2bc83470 (LWP 3401)]=0A0x2aad9894 in __wrap=
_socket () from /usr/xenomai/lib/libpthread_rt.so.1=0A=0A=0Aso it looks lik=
e the __wrap_socket call in the posix skin hurts the realtimeliness =0A=0Ao=
f the threads when using IDDP. Do you have any idea why this may be =0A=0Ah=
appening ?=0A=0AIf we look deeper in the posix skin where __wrap_socket is =
implemented=0A=0A=A0=A0=A0=A0=A0=A0=A0 ret =3D XENOMAI_SKINCALL3(__rtdm_mux=
id,=0A=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 __rtdm_socket,=0A=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 protocol_famil=
y, socket_type, protocol);=0A=A0=A0=A0=A0=A0=A0=A0 if (ret >=3D 0)=0A=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret +=3D __rtdm_fd_start;=0A=A0=A0=
=A0=A0=A0=A0=A0 else if (ret =3D=3D -EAFNOSUPPORT || ret =3D=3D -ENOSYS) {=
=0A=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D __real_socket(prot=
ocol_family, socket_type, protocol);=0A=0A=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 if (ret >=3D __rtdm_fd_start) {=0A=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 __real_close(ret);=0A=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 errno =3D -EMF=
ILE;=0A=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 ret =3D -1;=0A=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=0A=0Al=
ooks like XENOMAI_SKINCALL3 macro is failing for some reason but I can't =
=0A=0Aexplain this behavior as I am using the example code linked with the =
correct =0A=0Axenomai libraries. Any help would be highly appreciated.=0A=
=0AThanks in advance=0A=0AGuvenc

