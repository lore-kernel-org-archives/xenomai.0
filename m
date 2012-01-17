MIME-Version: 1.0
Date: Mon, 16 Jan 2012 20:14:28 -0500
Message-ID: <CAMak2D-C8E3GVhymyOUEF6hztdgnXnczNzEMNoO9sHqemxL9Zg@domain.hid>
From: Eric Eric <ericrebates@domain.hid>
Content-Type: multipart/alternative; boundary=f46d0447f2a676adb704b6af0d01
Subject: [Xenomai-help] gatekeeper using 90% CPU...
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

--f46d0447f2a676adb704b6af0d01
Content-Type: text/plain; charset=ISO-8859-1

Hi, I've added several benchmarks to the benchmark suite and seem to have a
problem with some of them causing the gatekeeper process to show high cpu
load.  A few things -don't- cause this problem.  The first is the standard
benchmarks shipped with Xenomai.  Another example of something that doesn't
peg gatekeeper is a synthetic workload I added that spawns a Xenomai kernel
thread that spins for a certain period then sleeps for a certain period,
cycling until terminated (an example of these periods may be spin fpr 800mS
sleep for 200mS).  What -does- seem to be causing this problem is another
benchmark I added that spawns a producer and consumer thread, with the
consumer waiting on a semaphore and the producer incrementing the
semaphore.  I suspect a cause for the excessive gatekeeper usage may be the
way I've structured the benchmark.  The user-mode program starts a
real-time user-mode thread that runs in a loop and does a real-time
initialization ioctl to create two POSIX threads (I originally had this as
a nrt ioctl but made it rt to avoid a mode switch).  Both threads wait on a
semaphore, then the user-mode thread does another real-time ioctl to cause
the module to broadcast on the semaphore and wake both kernel threads.  The
ioctl then blocks on a pthread_join while the producer and consumer threads
do 100,000 iterations (takes about a second or two on my hardware).  The
user mode program then prints the results to date, loops back around and
restarts the process.  My suspicion is that this act of starting and
stopping of the kernel threads may be causing the CPU utilization with
gatekeeper.  What do you think?  Also, I have registered a handler for
SIGXCPU and seem to see no mode switches at all, which seems strange
considering /proc/xenomai/stat indicates MSW is occuring.

/proc/xenomai/stat shows about double the number of mode switches for my
benchmark versus in-kernel periodic task.  While this may not be optimal,
it doesn't seem like it should bring gatekeeper from 1% CPU to 90% CPU
usage.  My system is a beagleboard XM running Xenomai 2.6.0 with the TI
2.6.37 kernel with beagle board patches applied.

As always, thanks for any assistance.

- Eric

--f46d0447f2a676adb704b6af0d01
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi, I&#39;ve added several benchmarks to the benchmark suite and seem to ha=
ve a problem with some of them causing the gatekeeper process to show high =
cpu load.=A0 A few things -don&#39;t- cause this problem.=A0 The first is t=
he standard benchmarks shipped with Xenomai.=A0 Another example of somethin=
g that doesn&#39;t peg gatekeeper is a synthetic workload I added that spaw=
ns a Xenomai kernel thread that spins for a certain period then sleeps for =
a certain period, cycling until terminated (an example of these periods may=
 be spin fpr 800mS sleep for 200mS).=A0 What -does- seem to be causing this=
 problem is another benchmark I added that spawns a producer and consumer t=
hread, with the consumer waiting on a semaphore and the producer incrementi=
ng the semaphore.=A0 I suspect a cause for the excessive gatekeeper usage m=
ay be the way I&#39;ve structured the benchmark.=A0 The user-mode program s=
tarts a real-time user-mode thread that runs in a loop and does a real-time=
 initialization ioctl to create two POSIX threads (I originally had this as=
 a nrt ioctl but made it rt to avoid a mode switch).=A0 Both threads wait o=
n a semaphore, then the user-mode thread does another real-time ioctl to ca=
use the module to broadcast on the semaphore and wake both kernel threads.=
=A0 The ioctl then blocks on a pthread_join while the producer and consumer=
 threads do 100,000 iterations (takes about a second or two on my hardware)=
.=A0 The user mode program then prints the results to date, loops back arou=
nd and restarts the process.=A0 My suspicion is that this act of starting a=
nd stopping of the kernel threads may be causing the CPU utilization with g=
atekeeper.=A0 What do you think?=A0 Also, I have registered a handler for S=
IGXCPU and seem to see no mode switches at all, which seems strange conside=
ring /proc/xenomai/stat indicates MSW is occuring.<br>
<br>/proc/xenomai/stat shows about double the number of mode switches for m=
y benchmark versus in-kernel periodic task.=A0 While this may not be optima=
l, it doesn&#39;t seem like it should bring gatekeeper from 1% CPU to 90% C=
PU usage.=A0 My system is a beagleboard XM running Xenomai 2.6.0 with the T=
I 2.6.37 kernel with beagle board patches applied.<br>
<br>As always, thanks for any assistance.<br><br>- Eric<br>

--f46d0447f2a676adb704b6af0d01--

