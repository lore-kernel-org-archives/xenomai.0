MIME-Version: 1.0
Date: Mon, 23 Mar 2009 10:00:31 +0200
Message-ID: <b131c9f0903230100x1b2aa2fet9e2b0efe68a7a77f@domain.hid>
From: vikesh rambaran <vikesh.rambaran@domain.hid>
Content-Type: multipart/alternative; boundary=000325574d7a1700680465c4a9ab
Subject: [Xenomai-help] Xenomai LTTng support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

--000325574d7a1700680465c4a9ab
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi

I'm trying to get LTTng support for Xenomai 2.4.7 with Linux 2.6.28.7
running.
With regards the mailing list, the latest one seems to be

[ date    Tue, Feb 24, 2009 at 8:30 PM
  subject    [Xenomai-help] [ANNOUNCE] LTTng-over-I-pipe git tree
]

My understanding of the sequence is :
(please correct as necessary)

1. Get the tree which already has LTTng and ipipe patched in
2. Apply trace_mark channel event patch to xenomai 2.4.7
3. Apply xenomai patches to kernel
4. Build and install

However, I am having trouble with the following and would appreciate help

a) "git clone git://git.kiszka.org/ipipe-2.6.git lttng/2.6.28-x86"
as per the email, results in the 2.6.29-rc6. What should the command be
to access the 2.6.28 tree ?

Note : downloading ipipe-2.6.28.7-x86-2.2-06 from
http://git.kiszka.org/?p=ipipe-2.6.git;a=commit;h=7abbb32f691345126d96cb6b48c587e145b8ef20
using the web interface gives the 2.6.28.7 tree. Is this ok to use ?

b) The LTTng manual mentions that there should be a kernel option
Linux Trace Toolkit Next Generation (LTTng) under General settings. This
seems to be
unavailable for both the above trees. What must be done to enable this
feature ?

c) Applying the xenomai instrumentation patch from
[http://permalink.gmane.org/gmane.linux.real-time.xenomai.devel/6009]  to
the xenomai 2.4.7
tree using patch -p1 < "filename",  results in numerous hunks. What am i
doing wrong ?


Thanx for any help
Vicki

--000325574d7a1700680465c4a9ab
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi<br><br>I&#39;m trying to get LTTng support for Xenomai 2.4.7 with Linux =
2.6.28.7 running.<br>With regards the mailing list, the latest one seems to=
 be<br><br>[ date=A0=A0=A0 Tue, Feb 24, 2009 at 8:30 PM<br>=A0 subject=A0=
=A0=A0 [Xenomai-help] [ANNOUNCE] LTTng-over-I-pipe git tree<br>
]<br><br>My understanding of the sequence is :<br>(please correct as necess=
ary)<br><br>1. Get the tree which already has LTTng and ipipe patched in<br=
>2. Apply trace_mark channel event patch to  xenomai 2.4.7<br>3. Apply xeno=
mai patches to kernel<br>
4. Build and install<br><br>However, I am having trouble with the following=
 and would appreciate help<br><br>a) &quot;git clone git://<a href=3D"http:=
//git.kiszka.org/ipipe-2.6.git">git.kiszka.org/ipipe-2.6.git</a> lttng/2.6.=
28-x86&quot;<br>
as per the email, results in the 2.6.29-rc6. What should the command be<br>=
to access the 2.6.28 tree ?<br><br>Note : downloading ipipe-2.6.28.7-x86-2.=
2-06 from <br><a href=3D"http://git.kiszka.org/?p=3Dipipe-2.6.git;a=3Dcommi=
t;h=3D7abbb32f691345126d96cb6b48c587e145b8ef20">http://git.kiszka.org/?p=3D=
ipipe-2.6.git;a=3Dcommit;h=3D7abbb32f691345126d96cb6b48c587e145b8ef20</a><b=
r>
using the web interface gives the 2.6.28.7 tree. Is this ok to use ?<br><br=
>b) The LTTng manual mentions that there should be a kernel option <br>
Linux Trace Toolkit Next Generation (LTTng) under General settings. This se=
ems to be<br>
unavailable for both the above trees. What must be done to enable this feat=
ure ?<br>
<br>c) Applying the xenomai instrumentation patch from<br>
[<a href=3D"http://permalink.gmane.org/gmane.linux.real-time.xenomai.devel/=
6009">http://permalink.gmane.org/gmane.linux.real-time.xenomai.devel/6009</=
a>]=A0 to the xenomai 2.4.7 <br>tree using patch -p1 &lt; &quot;filename&qu=
ot;,=A0 results in numerous hunks. What am i doing wrong ?<br>
<br><br>Thanx for any help<br>Vicki<br>

--000325574d7a1700680465c4a9ab--

