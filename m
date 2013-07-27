References: <1374841118.86884.BPMail_high_noncarrier@web125405.mail.ne1.yahoo.com>
	<51F2A4E9.3000304@xenomai.org> <51F2AAF9.3050403@xenomai.org>
Message-ID: <1374894673.81161.YahooMailNeo@web125403.mail.ne1.yahoo.com>
Date: Fri, 26 Jul 2013 20:11:13 -0700 (PDT)
From: GP Orcullo <kinsamanka@ymail.com>
In-Reply-To: <51F2AAF9.3050403@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] XDDP test failure on Raspberry Pi, 3.8.13 kernel
Reply-To: GP Orcullo <kinsamanka@ymail.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

------------------------------=0AOn Fri, Jul 26, 2013 9:59 AM PDT Philippe =
Gerum wrote:=0A=0A>On 07/26/2013 06:33 PM, Philippe Gerum wrote:=0A>> On 07=
/26/2013 02:18 PM, GP Orcullo wrote:=0A>>=0A>> ----------------------------=
--=0A>> On Fri, Jul 26, 2013 5:09 AM PDT GP Orcullo wrote:=0A>>=0A>>> -----=
 Original Message -----=0A>>>=0A>>> From: Gilles Chanteperdrix <gilles.chan=
teperdrix@xenomai.org>=0A>>> To: GP Orcullo <kinsamanka@ymail.com>=0A>>> Cc=
: "xenomai@xenomai.org" <xenomai@xenomai.org>=0A>>> Sent: Friday, July 26, =
2013 4:26 AM=0A>>> Subject: Re: [Xenomai] XDDP test failure on Raspberry Pi=
, 3.8.13 kernel=0A>>>=0A>>> On 07/24/2013 02:12 PM, GP Orcullo wrote:=0A>>>=
=0A>>> Hi,=0A>>>=0A>>> Raspberry Pi on Xenomai v2.6.2.1 passes all the regr=
ession tests=0A>>> except for the xddp_test. =A0The test fails with "FAILUR=
E bind: Address=0A>>> already in use".=0A>>>=0A>>> How do I resolve this is=
sue?=0A>>>=0A>>>=0A>>> Hi,=0A>>>=0A>>> do you have the same issue with Xeno=
mai from git repository?=0A>>>=0A>>>=0A>>> --=A0=0A>>> =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=0A>>> Gilles.=0A>>>=0A>>>=0A>>> Hel=
lo Gilles,=0A>>>=0A>>> I have restarted from scratch and the issue seemed t=
o have resolved=A0=0A>>> itself. I have no clue why it initially failed.=0A=
>>>=0A>>> Thanks!=0A>>>=0A>>> GP Orcullo=0A>>=0A>> I have found the cause.=
=0A>>=0A>> If the module xeno_klat is loaded, xddp_test fails.=0A>>=0A>>=A0=
=0A>> It looks like both the kernel latency and xddp tests do not cope well=
=A0=0A>> together, with respect to the message pipe number they want to use=
. The=A0=0A>> patch below works around the issue, but xddp_test should rath=
er be fixed=A0=0A>> to use the XDDP port auto-selection, like klat already =
does.=0A>>=A0=0A>=0A>Something like this would do:=0A>=0A>commit 3a61082756=
c097ba60a87ee8f9f185ad9f8d4686=0A>Author: Philippe Gerum <rpm@xenomai.org>=
=0A>Date: =A0 Fri Jul 26 18:56:49 2013 +0200=0A>=0A> =A0 =A0testsuite/regre=
ssion: xddp_test: use port auto-selection=0A> =A0 =A0=0A> =A0 =A0Let the XD=
DP driver pick an idle port for communication, so that we=0A> =A0 =A0won't =
conflict with other message pipe users (e.g. xeno_klat).=0A>=0A>diff --git =
a/src/testsuite/regression/posix/xddp_test.c b/src/testsuite/regression/pos=
ix/xddp_test.c=0A>index 194584e..e10a09a 100644=0A>--- a/src/testsuite/regr=
ession/posix/xddp_test.c=0A>+++ b/src/testsuite/regression/posix/xddp_test.=
c=0A>@@ -22,14 +22,14 @@=0A>=A0=0A> static pthread_t rt, nrt;=0A> static se=
m_t opened;=0A>-=0A>-#define XDDP_PORT 0/* [0..CONFIG-XENO_OPT_PIPE_NRDEV -=
 1] */=0A>+static int xddp_port =3D -1;/* First pass uses auto-selection */=
=0A>=A0=0A> static void *realtime_thread(void *arg)=0A> {=0A> unsigned long=
 count =3D (unsigned long)arg;=0A> struct sockaddr_ipc saddr;=0A> struct ti=
mespec ts;=0A>+socklen_t addrlen;=0A> size_t poolsz;=0A> int ret, s;=0A>=A0=
=0A>@@ -57,7 +57,7 @@ static void *realtime_thread(void *arg)=0A>  */=0A> m=
emset(&saddr, 0, sizeof(saddr));=0A> saddr.sipc_family =3D AF_RTIPC;=0A>-sa=
ddr.sipc_port =3D XDDP_PORT;=0A>+saddr.sipc_port =3D xddp_port;=0A> ret =3D=
 bind(s, (struct sockaddr *)&saddr, sizeof(saddr));=0A> if (count =3D=3D 1)=
 {=0A> if (ret < 0 && errno =3D=3D EADDRINUSE) {=0A>@@ -69,6 +69,10 @@ stat=
ic void *realtime_thread(void *arg)=0A> exit(EXIT_FAILURE);=0A> }=0A> fprin=
tf(stderr, "FAILURE: bind returned %d\n", ret);=0A>+} else {=0A>+addrlen =
=3D sizeof(saddr);=0A>+check_unix(getsockname(s, (struct sockaddr *)&saddr,=
 &addrlen));=0A>+xddp_port =3D saddr.sipc_port;=0A> }=0A> if (ret < 0) {=0A=
> fprintf(stderr, "FAILURE bind: %m\n");=0A>@@ -91,7 +95,7 @@ static void *=
regular_thread(void *arg)=0A> char buf[128], *devname;=0A> int fd;=0A>=A0=
=0A>-check_unix(asprintf(&devname, "/dev/rtp%d", XDDP_PORT));=0A>+check_uni=
x(asprintf(&devname, "/dev/rtp%d", xddp_port));=0A>=A0=0A> fd =3D check_uni=
x(open(devname, O_RDWR));=0A> free(devname);=0A>--=A0=0A>Philippe.=0A=0AThi=
s patch works as intended.=0A=0A=0AThanks!=A0=0A

