MIME-Version: 1.0
Sender: madjsw@domain.hid
Date: Wed, 15 Sep 2010 16:40:22 -0500
Message-ID: <AANLkTikF63jMSnD-XDq_KvApr1EZoGPLP6rFG7HcwpPC@mail.gmail.com>
From: Jeff Weber <jwamsc@domain.hid>
Content-Type: multipart/alternative; boundary=0016364ef6fa3b93560490532d82
Subject: [Xenomai-help] isolate realtime and Linux by CPU on SMP system
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

--0016364ef6fa3b93560490532d82
Content-Type: text/plain; charset=ISO-8859-1

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

--0016364ef6fa3b93560490532d82
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I have a SMP system with 2 CPUs, and wish to assign all Linux functionality=
 (processes, threads, interrupts, etc)=A0 to one CPU, and all Xenomai, RTne=
t=A0 functionality to the other CPU.=A0 Global solutions for isolating each=
 domain would be preferrable to walking lists of processes, threads, etc.<b=
r>
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
Jeff<br>

--0016364ef6fa3b93560490532d82--

