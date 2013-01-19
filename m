Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1283)
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <50FA9FA0.7020400@xenomai.org>
Date: Sat, 19 Jan 2013 15:09:15 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <F995AEC4-6B7E-4DB9-9C64-A5ED3F01DCFA@mah.priv.at>
References: <4D4F8D1B-022E-47F8-A579-EBF2A3427C5D@mah.priv.at>	<50F6D940.3040406@xs4all.nl>	<F1ACE4FC-3E71-4498-B683-81F5C40CB6E3@mah.priv.at>
	<50F7AF53.2090800@xs4all.nl> <50F7BC13.50009@xenomai.org>
	<50F7FCD8.7020105@xs4all.nl> <50FA9FA0.7020400@xenomai.org>
Subject: Re: [Xenomai] [Emc-developers] "new RTOS" status: Scheduler
	(?)	lockup on ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Am 19.01.2013 um 14:29 schrieb Gilles Chanteperdrix:

> On 01/17/2013 02:30 PM, Bas Laarhoven wrote:
>=20
>> On 17-1-2013 9:53, Gilles Chanteperdrix wrote:
>>> On 01/17/2013 08:59 AM, Bas Laarhoven wrote:
>>>=20
>>>> On 16-1-2013 20:36, Michael Haberler wrote:
>>>>> Am 16.01.2013 um 17:45 schrieb Bas Laarhoven:
>>>>>=20
>>>>>> On 16-1-2013 15:15, Michael Haberler wrote:
>>>>>>> ARM work:
>>>>>>>=20
>>>>>>> Several people have been able to get the Beaglebone =
ubuntu/xenomai setup working as outlined here: =
http://wiki.linuxcnc.org/cgi-bin/wiki.pl?BeagleboneDevsetup
>>>>>>> I have updated the kernel and rootfs image a few days ago so the =
kernel includes ext2/3/4 support compiled in, which should take care of =
two failure reports I got.
>>>>>>>=20
>>>>>>> Again that xenomai kernel is based on 3.2.21; it works very =
stable for me but there have been several reports of 'sudden stops'. The =
BB is a bit sensitive to power fluctuations but it might be more than =
that. As for that kernel, it works, but it is based on a branch which =
will see no further development. It supports most of the stuff needed to =
development; there might be some patches coming from more active BB =
users than me.
>>>>>> Hi Michael,
>>>>>>=20
>>>>>> Are you saying you don't have seen these 'sudden stops' yourself?
>>>>> No, never, after swapping to stronger power supplies; I have two =
of these boards running over NFS all the time. I dont have Linuxcnc =
running on them though, I'll do that and see if that changes the =
picture. Maybe keeping the torture test running helps trigger it.
>>>> Beginners error! :-P The power supply is indeed critical, but the
>>>> stepdown converter on my BeBoPr is dimensioned for at least 2A and
>>>> hasn't failed me yet.
>>>>=20
>>>> I think that running linuxcnc is mandatory for the lockup. After a =
dozen
>>>> runs, it looks like I can reproduce the lockup with 100% certainty
>>>> within one hour.
>>>> Using the JTAG interface to attach a debugger to the Bone, I've =
found
>>>> that once stalled the kernel is still running. It looks like it =
won't
>>>> schedule properly and almost all time is spent in the cpu_idle =
thread.
>>>=20
>>> This is typical of a tsc emulation or timer issue. On a system =
without
>>> anything running, please let the "tsc -w" command run. It will take =
some
>>> time to run (the wrap time of the hardware timer used for tsc
>>> emulation), if it runs correctly, then you need to check whether the
>>> timer is still running when the bug happens (cat /proc/xenomai/irq
>>> should continue increasing when for instance the latency test is
>>> running). If the timer is stopped, it may have been programmed for a =
too
>>> short delay, to avoid that, you can try:
>>> - increasing the ipipe_timer min_delay_ticks member (by default, it =
uses
>>> a value corresponding to the min_delta_ns member in the clockevent
>>> structure);
>>> - checking after programming the timer (in the set_next_event =
method) if
>>> the timer counter is already 0, in which case you can return a =
negative
>>> value, usually -ETIME.
>>>=20
>>=20
>> Hi Gilles,
>>=20
>> Thanks for the swift reply.
>>=20
>> As far as I can see, tsc -w runs without an error:
>>=20
>> ARM: counter wrap time: 179 seconds
>> Checking tsc for 6 minute(s)
>> min: 5, max: 12, avg: 5.04168
>> ...
>> min: 5, max: 6, avg: 5.03771
>> min: 5, max: 28, avg: 5.03989 -> 0.209995 us
>>=20
>> real    6m0.284s
>>=20
>> I've also done the other regression tests and all were successful.
>>=20
>> Problem is that once the bug happens I won't be able to issue the cat=20=

>> command.
>> I've fixed my debug setup so I don't have to use the System.map to=20
>> manually translate the debugger addresses : /
>> Now I'm waiting for another lockup to see what's happening.
>=20
>=20
> You may want to have a look at the xeno-regression-test script to put
> your system under pressure (and likely generate the lockup faster).

running tsc -w and xeno-regression-test in parallel I get errors like so =
(not on every run; no lockup so far):

++ /usr/xenomai/bin/mutex-torture-native
simple_wait
recursive_wait
timed_mutex
mode_switch
pi_wait
lock_stealing
NOTE: lock_stealing mutex_trylock: not supported
deny_stealing
simple_condwait
recursive_condwait
auto_switchback
FAILURE: current prio (0) !=3D expected prio (2)

dmesg=20
[501963.390598] Xenomai: native: cleaning up mutex "" (ret=3D0).
[502170.164984] usb 1-1: reset high-speed USB device number 2 using =
musb-hdrc

on another run, I got a segfault while running sigdebug:
++ /usr/xenomai/bin/regression/native/sigdebug
mayday page starting at 0x400eb000 [/dev/rtheap]
mayday code: 0c 00 9f e5 0c 70 9f e5 00 00 00 ef 00 00 a0 e3 00 00 80 e5 =
2b 02 00 0a 42 00 0f 00 db d7 ee b8
mlockall
syscall
signal
relaxed mutex owner
page fault
watchdog
./xeno-regression-test: line 53:  4210 Segmentation fault      =
/usr/xenomai/bin/regression/native/sigdebug

root@bb1:/usr/xenomai/bin# dmesg=20
[502442.312996] Xenomai: watchdog triggered -- signaling runaway thread =
'rt_task'
[502443.054186] Xenomai: native: cleaning up mutex "prio_invert" =
(ret=3D0).
[502443.055730] Xenomai: native: cleaning up sem "send_signal" (ret=3D0).
[502518.134977] usb 1-1: reset high-speed USB device number 2 using =
musb-hdrc


unsure what to make of it - any suggestions? the usb reset looks =
suspicious

- Michael


