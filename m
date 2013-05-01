Message-ID: <5181302A.70900@gmail.com>
Date: Wed, 01 May 2013 11:09:30 -0400
From: Sebastian Pavez <sebastian.pavez.t@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Help with the feasibility of some actions with Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi everyone,

I'm using Xenomai to develop a real time control system with educational=20
purposes. The idea is to show how a control system is affected by other=20
tasks and how a real time approach will help to sustain his execution=20
over other threads. To do this, I have a program with a control thread=20
(used to control the position and velocity of a DC motor) and other one=20
that consist in a for loop wich allow to change the execution time of=20
this thread and see the effect on the control. I'm executing this on a=20
i7 processor and I would like to know a couple of things, and hopefully=20
you could help me with some advice.

- Is there a way to get the information about the times related with the=20
tasks? I mean I would like to draw a classic execution time line to=20
explain the effect on the control thread with real data. This means=20
having the release time, when a task is suspended and reactivated, etc.=20
because sometimes I can see the degradation in the control performance=20
but other times don't, even with the same conditions and to explain the=20
fenomena this would be very helpful. I know that maybe this issue isn't=20
so related with the purpose of this mail list but If you have some idea=20
on how to do this, if is feasible to do it, or if Xenomai have some logs=20
or something to get this data will be preciated.

- I also would like to know if there is a way to assign the execution of=20
a thread to a specific CPU and, for instance, force the execution of=20
both threads in the same CPU. Or a least to know if there is a way to=20
confirm that the threads are allocated in the same CPU.

Sorry if this is not the place to find some answers to this questions=20
and thank you for your time and any reply you could gave me.
Sebasti=E1n Pavez.

