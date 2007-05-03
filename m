Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 3 May 2007 13:42:37 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB01E43D41@domain.hid>
In-Reply-To: <4639D724.5010702@domain.hid>
References: <4639D724.5010702@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
Subject: Re: [Xenomai-help] Latency calculation and test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Johan Borkhuis <j.borkhuis@domain.hid>, Xenomai-help@domain.hid

Johan,

If I am not very wrong, you should have plenty experiences with VxWorks =
(Maintainer of VxWorks FAQ ?). So if you have the correct timing =
measurements for Xenomai, could you make similar tests on your board =
with VxWorks, just to have a comparision ? I understand that this =
comparision is not fair, but I think people can better see, where =
Xenomai is currently standing.


Philip:
Also for our MPC5200B based board we get bogus latency measurements. How =
can we find out the right value of /proc/xenomai/latency ? Wouldn't an =
auto calibration be more useful when starting up (similar to the Linux =
Bogo Mips value), because actually one can configure the boards to have =
different bus speed settings, so the CPU detection alone will not be =
sufficient ?

Best regards,

Daniel Schnell.





-----Original Message-----
From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid] =
On Behalf Of Johan Borkhuis
Sent: 3. ma=ED 2007 12:36
To: Xenomai-help@domain.hid
Subject: [Xenomai-help] Latency calculation and test

I am quite new to Xenomai, but not to realtime and embedded development. =

I am trying to run Xenomai on a MVME3100 board (PPC8540 processor, =
kernel version 2.6.14, Xenomai 2.3.1).

I am trying to do latency measurements on my target, and I have some =
questions.

As far as I understand it, the value in /proc/xenomai/latency is the =
time needed to start a timer, and this value is subtracted from the =
value provided to the timer. The value calculated by Xenomai on my =
platform is 9489. All latencies reported with the latency tool are =
negative when this value is used.
When I write 0 to this setting (to get the real values without offset) =
and run the latency test program I see different values for the =
different modes: user space =3D 3.6 usec, kernel space =3D 1.8 usec and =
IRQ =3D 0.9 usec. What is the relation between the value calculated by =
Xenomai and the values measured by the latency program, and what is the =
correct way to calculate the latency setting?

I also did a port of the cyclictest program to Xenomai. Instead of the =
pthreads I used the RT-tasks, like the latency program.  The cyclictest =
program uses signals to  trigger the task, but as I found out this does =
not work in userspace: the applications returns to secondary mode at the =
moment the thread waits for a signal. Is there another way to do this =
(next to moving the whole program to kernel space)?

One option of the cyclictest program is that you can have several =
threads running. I modified the output of the cyclictest tool somewhat, =
to have min, max and average like the latency program.
When running multiple threads within this program (without load) the =
values range from -5 usec to +5 usec, with an average of around 0 usec.=20
But with more RT tasks I see a very high latency once in a while (over =
400 usec).

Below is the example of such a test run with 10 threads/tasks:
 T: 0 ( 1305) P:80 I:1000 O: 0 Min:   -2.404 Avg: -0.001 Max:   1.873
 T: 1 ( 1306) P:79 I:1000 O: 0 Min:   -3.052 Avg: -0.001 Max:   1.584
 T: 2 ( 1307) P:78 I:1000 O: 0 Min:   -5.694 Avg:  0.000 Max:  18.282
 T: 3 ( 1308) P:77 I:1000 O: 0 Min:   -5.166 Avg:  0.046 Max: 479.782
 T: 4 ( 1309) P:76 I:1000 O: 0 Min:   -2.595 Avg:  0.036 Max: 368.310
 T: 5 ( 1310) P:75 I:1000 O: 0 Min:   -1.731 Avg: -0.001 Max:   1.633
 T: 6 ( 1311) P:74 I:1000 O: 0 Min: -481.273 Avg: -0.001 Max: 490.352
 T: 7 ( 1312) P:73 I:1000 O: 0 Min: -273.947 Avg: -0.001 Max: 277.717
 T: 8 ( 1313) P:72 I:1000 O: 0 Min:  -47.016 Avg: -0.001 Max:  45.789
 T: 9 ( 1314) P:71 I:1000 O: 0 Min:  -22.968 Avg: -0.001 Max:  29.572 =
(P=3DPriority, I=3Dinterval, O=3Doverruns)

When looking at the detailed information, I see that the latencies occur =
when a higher priority task is ending. Is there some specific reason for =
this, or is there some kind of configuration problem with my setup?

Kind regards,
    Johan Borkhuis


_______________________________________________
Xenomai-help mailing list
Xenomai-help@domain.hid
https://mail.gna.org/listinfo/xenomai-help

