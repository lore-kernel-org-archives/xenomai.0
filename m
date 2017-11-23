From: =?UTF-8?Q?C=C3=A9dric_Perles?= <cperles@sepro-group.com>
References: <023601d363ac$6ce04c40$46a0e4c0$@sepro-group.com>
 <d2a2bcaf-7cfb-78f9-55cb-b1cca9b4a0be@xenomai.org>
In-Reply-To: <d2a2bcaf-7cfb-78f9-55cb-b1cca9b4a0be@xenomai.org>
Date: Thu, 23 Nov 2017 15:35:38 +0100 (CET)
Message-ID: <02ca01d36468$537ffef0$fa7ffcd0$@sepro-group.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Strange scheduling behaviour
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

>> Hi,
>>
>> I=E2=80=99m working on an iMX6 based board with NXP kernel 4.1.15.

>> Vendor kernels for i.MX6 are creepy (another vowel comes to mind). A=20
>> recent mainline kernel is just fine if the SoC supports it. If not,=20
>> porting the SoC (and/or missing driver) to mainline is often much >=20
>> better and faster than enduring a truckload of bugs.

>> I would like to understand why latency max returned by cyclictest
>> increases from 20=C2=B5s to 100=C2=B5s when dohell accesses to USB.
>>
>> Since i-pipe tracer refuses to work,

> Which means?

I sent a message on this subject=20
(https://xenomai.org/pipermail/xenomai/2017-November/037919.html).
I don't know why but my kernel don't boot when ipipe tracer is activated.

>> I used ftrace to record cobalt,
>> scheduling and irq events. Here is what I see on kernelshark:
>>
>> As expected, cyclictest has 1 xenomai thread per core (I can see them
>> on
>> /proc/xenomai/sched/threads) that wakes up periodically after a 200=C2=
=B5s
>> nanosleep.
>>
>> Sometimes, the wake up seems to be delayed (400=C2=B5s instead of 200=C2=
=B5s)
>> because of an USB irq treatment followed by a call to usb-storage.
>> Other times, the wake up seems to be delayed (400=C2=B5s instead of 20=
0=C2=B5s)
>> by a Linux call to ktimersoft, rcu and cat (see
>> https://drive.google.com/file/d/18-B3WO2QH7PvBzJrt9tK5-TXvAkDxTPn/view
>> ?usp
>> =3Dsharing)
>>

> The textual trace shows no issue. 40us are spent suspending a Cobalt=20
> thread, which seems reasonable on i.MX6Q with ftrace enabled and the sl=
ow=20
> PL310 L2 outer cache you have there. I likely missed your point then.

>> Is it normal to delay a xenomai task wake up because of a Linux
>> interrupt (I expected ipipe to act as a shield) ?
>> How a simple Linux "cat" can delay a xenomai wake up ?
>>

> For instance, if the Xenomai task in question dropped to secondary mode=
=20
> earlier because the app is wrong somehow, then some work queue kernel=20
> thread starts running funky driver code issuing usleep() to sync with t=
he=20
> hw. The rt thread running in non-rt mode will have to wait until the=20
> driver stops busy-waiting for a bit to toggle, causing the next rt=20
> operation for that task to appear as badly delayed. > The point is, tha=
t=20
> Xenomai is not in charge when the delay appears.

> This case has been observed several times with MMC host and PCI host=20
> drivers on fsl kernels; I would not be surprised if that happened with=20
> other vendor-specific driver(s) too.

I agree, if the application dropped to secondary mode, it would explain t=
he=20
trace. However, I don't think we drop to secondary.
The application is the cyclictest included with xenomai tools to bench re=
al=20
time performances through posix skin. I don't expect such application to=20
switch to secondary. Moreover, /proc/xenomai/sched/stat indicates no mode=
=20
switch (MSW is stuck to 1 for this thread).

I made another test and set cyclictest period to 400=C2=B5s. In this case=
, the=20
wake up is sometime 800=C2=B5s instead of 400=C2=B5s. It's just like if=20
clock_nanosleep used by cyclictest missed some events.

--
Philippe.

