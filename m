MIME-Version: 1.0
Sender: madjsw@domain.hid
In-Reply-To: <AANLkTikF63jMSnD-XDq_KvApr1EZoGPLP6rFG7HcwpPC@mail.gmail.com>
References: <AANLkTikF63jMSnD-XDq_KvApr1EZoGPLP6rFG7HcwpPC@mail.gmail.com>
Date: Tue, 21 Sep 2010 08:52:56 -0500
Message-ID: <AANLkTinhmyo1AFvPzHXZ12ochSOpMHLj9qwEfQ8GCc5L@mail.gmail.com>
From: Jeff Weber <jwamsc@domain.hid>
Content-Type: multipart/alternative; boundary=001636833d4aa450920490c5580f
Subject: [Xenomai-help] Fwd: isolate realtime and Linux by CPU on SMP system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--001636833d4aa450920490c5580f
Content-Type: text/plain; charset=ISO-8859-1

What is the best method for segregating Xenomai and Linux by CPU?  I was
unable to do this cleanly using /proc/xenomai/affinity for Xenomai, together
with the Linux isolcpus boot option.  Details below.

TIA,
Jeff

---------- Forwarded message ----------
From: Jeff Weber <jwamsc@domain.hid>
Date: Wed, Sep 15, 2010 at 4:40 PM
Subject: isolate realtime and Linux by CPU on SMP system
To: xenomai@xenomai.org


I have a SMP system with 2 CPUs, and wish to assign all Linux functionality
(processes, threads, interrupts, etc)  to one CPU, and all Xenomai, RTnet
functionality to the other CPU.  Global solutions for isolating each domain
would be preferrable to walking lists of processes, threads, etc.

Initially, writing to /proc/xenomai/affinity appears to isolate all Xenomai
threads to the desired CPU.  (I haven't had an opportunity to test Xenomai
interrupts yet.)

Then I encountered difficulties when starting to isolate Linux processes,
threads.  Using the kernel boot option isolcpus=0 resulted in 49 out of 126
Linux processes running on CPU0.

Switching instead to boot option isolcpus=1 placed 11 out of 126 Linux
processes on CPU1, the remainder on CPU0  The processes running on CPU1 were
migration/1, ksoftirqd/1, watchdog/1, etc, so this may be the bare minimum
possible on CPU1.  I considered this "good enough".

Then I attempted to set Xenomai global affinity to CPU1:
echo 00000002 > /proc/xenomai/affinity
But running my Xenomai Posix skin application failed:
Xenomai Posix skin init: pthread_setschedparam: Invalid argument

Interestingly, switching Xenomai global affinity to CPU0 then succeeded:
echo 00000001 > /proc/xenomai/affinity
But my Xenomai threads then ran on CPU0 alongside the bulk of the Linux
processes.

I was able to assign all Linux interrupts to either CPU, without any
difficulties, by manipulating the IRQBALANCE_BANNED_CPUS environment for the
irqbalance daemon.

What is the best way to assign Linux to use one CPU, and Xenomai, RTnet to
use the other CPU?

my config:
x86 32-bit arch
linux-2.6.34.5
Xenomai-2.5.4
adeos-ipipe-2.6.34.5-x86-2.7-03.patch

TIA,
Jeff

--001636833d4aa450920490c5580f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

What is the best method for segregating Xenomai and Linux by CPU?=A0 I was =
unable to do this cleanly using /proc/xenomai/affinity for Xenomai, togethe=
r with the Linux isolcpus boot option.=A0 Details below.<br><br>TIA,<br>Jef=
f<br>
<br><div class=3D"gmail_quote">---------- Forwarded message ----------<br>F=
rom: <b class=3D"gmail_sendername">Jeff Weber</b> <span dir=3D"ltr">&lt;<a =
href=3D"mailto:jwamsc@domain.hid">jwamsc@domain.hid</a>&gt;</span><br>Date: W=
ed, Sep 15, 2010 at 4:40 PM<br>
Subject: isolate realtime and Linux by CPU on SMP system<br>To: <a href=3D"=
mailto:xenomai@xenomai.org">xenomai@xenomai.org</a><br><br><br>I have a S=
MP system with 2 CPUs, and wish to assign all Linux functionality (processe=
s, threads, interrupts, etc)=A0 to one CPU, and all Xenomai, RTnet=A0 funct=
ionality to the other CPU.=A0 Global solutions for isolating each domain wo=
uld be preferrable to walking lists of processes, threads, etc.<br>

<br>Initially, writing to /proc/xenomai/affinity appears to isolate all Xen=
omai threads to the desired CPU.=A0 (I haven&#39;t had an opportunity to te=
st Xenomai interrupts yet.)<br><br>Then I encountered difficulties when sta=
rting to isolate Linux processes, threads.=A0 Using the kernel boot option =
isolcpus=3D0 resulted in 49 out of 126 Linux processes running on CPU0.<br>

<br>Switching instead to boot option isolcpus=3D1 placed 11 out of 126 Linu=
x processes on CPU1, the remainder on CPU0=A0 The processes running on CPU1=
 were migration/1, ksoftirqd/1, watchdog/1, etc, so this may be the bare mi=
nimum possible on CPU1.=A0 I considered this &quot;good enough&quot;.<br>

<br>Then I attempted to set Xenomai global affinity to CPU1:<br>echo 000000=
02 &gt; /proc/xenomai/affinity<br>But running my Xenomai Posix skin applica=
tion failed:<br>Xenomai Posix skin init: pthread_setschedparam: Invalid arg=
ument<br>

<br>Interestingly, switching Xenomai global affinity to CPU0 then succeeded=
:<br>echo 00000001 &gt; /proc/xenomai/affinity<br>But my Xenomai threads th=
en ran on CPU0 alongside the bulk of the Linux processes.<br><br>I was able=
 to assign all Linux interrupts to either CPU, without any difficulties, by=
 manipulating the IRQBALANCE_BANNED_CPUS environment for the irqbalance dae=
mon.<br>

<br>What is the best way to assign Linux to use one CPU, and Xenomai, RTnet=
 to use the other CPU?<br><br>my config:<br>x86 32-bit arch<br>linux-2.6.34=
.5<br>Xenomai-2.5.4<br>adeos-ipipe-2.6.34.5-x86-2.7-03.patch<br><br>TIA,<br=
>
<font color=3D"#888888">
Jeff<br>
</font></div><br>

--001636833d4aa450920490c5580f--

