MIME-Version: 1.0
Sender: madjsw@domain.hid
Date: Tue, 1 Mar 2011 08:56:07 -0600
Message-ID: <AANLkTimQBPGtBysVt7UHeBgaNiU045nWCBDSaHuEDJk6@domain.hid>
From: Jeff Weber <jwamsc@domain.hid>
Content-Type: multipart/alternative; boundary=e0cb4e3853a40b84b4049d6cfffc
Subject: [Xenomai-help] SMP load balancing
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

--e0cb4e3853a40b84b4049d6cfffc
Content-Type: text/plain; charset=ISO-8859-1

I am looking for guidance on how much I can rely upon the Linux kernel and
Xenomai schedulers to perform automatic load balancing, vs. how much I must
load balance manually.  My config:

x86 SMP system with 2 CPUs
Linux 2.6.35.10 + xenomai-2.5.5.2
ISA hardware device with 1 IRQ
Xenomai kernel module driver using old-style native API (may be ported to
RTDM in the future)
user space application with multiple Linux and Xenomai threads
no effort [yet] to explicitly set CPU affinities for either Xenomai, nor
Linux
cat /proc/xenomai/affinity output = 000000ff

question:  From /proc/xenomai/stat , I see all Xenomai kernel driver and
userspace threads running on only CPU0, though my IRQ handler is being
balanced on both CPUs.  Will Xenomai ever "balance" or "migrate" threads to
other CPUs if the affinity mask allows this?

question: Does the Linux scheduler assume it owns 100% of the cycles on CPU0
(where all the Xenomai threads happen to be running), and thus make
incorrect scheduling decisions for Linux threads on CPU0?

thanks,
Jeff

--e0cb4e3853a40b84b4049d6cfffc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I am looking for guidance on how much I can rely upon the Linux kernel and =
Xenomai schedulers to perform automatic load balancing, vs. how much I must=
 load balance manually.=A0 My config:<br><br>x86 SMP system with 2 CPUs<br>
Linux 2.6.35.10 + xenomai-2.5.5.2<br>ISA hardware device with 1 IRQ<br>Xeno=
mai kernel module driver using old-style native API (may be ported to RTDM =
in the future)<br>user space application with multiple Linux and Xenomai th=
reads<br>
no effort [yet] to explicitly set CPU affinities for either Xenomai, nor Li=
nux<br>cat /proc/xenomai/affinity output =3D 000000ff<br><br>question:=A0 F=
rom /proc/xenomai/stat , I see all Xenomai kernel driver and userspace thre=
ads running on only CPU0, though my IRQ handler is being balanced on both C=
PUs.=A0 Will Xenomai ever &quot;balance&quot; or &quot;migrate&quot; thread=
s to other CPUs if the affinity mask allows this?<br>
<br>question: Does the Linux scheduler assume it owns 100% of the cycles on=
 CPU0 (where all the Xenomai threads happen to be running), and thus make i=
ncorrect scheduling decisions for Linux threads on CPU0?<br><br>thanks,<br>
Jeff<br><br>

--e0cb4e3853a40b84b4049d6cfffc--

