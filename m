Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Adeos-main] RE: ppc64 port questions
Date: Fri, 18 Mar 2005 08:53:41 -0600
Message-ID: <0D21CBD1298D2C4790E2F2B86D96EC1938029A@amr-ex5.ds.amrdec.army.mil>
From: "Reynolds, Terry \(Contractor-SIMTECH\)" <terry.reynolds2@domain.hid>
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: adeos <adeos-main@gna.org>

Hello,
=20
I'll see if I can figure out a way to get a complete listing off my G5.  =
It isn't connected to the network,=20
and I've never actually produced a readable cd from it.
=20
Mine is failing while loading the rtai_native module.  It seems Ok right =
up through the end of the=20
fusion_skin_init (I.E. the end of module_init).  After that the kernel =
enters a loop apparently either trying
to start a task, or responding to some periodic task that was started by =
the module.  If I run the latency=20
test, this loop terminates after several seconds, and all the rtai =
modules get un-loaded.  If I load the modules
via insmod, the loop goes on forever.
=20
I haven't tried the klatency test.  Cruncher crashed my G5 and corrupted =
the hard drive.  Luckily, a manual=20
fsck repaired it.  I haven't tried it again.
=20
Does anyone have this stuff actually working on a PPC?  If so, could you =
share any helpful ideas as to=20
what is suppose to be happening after the rtai_native module is loaded?  =
I'm still trying to figure what
is causing the kernel to be receive these events.
=20
Thanks,
=20
=20
Terry.

________________________________

From: Heikki Lindholm [mailto:holindho@domain.hid]
Sent: Thu 3/17/2005 11:34 PM
To: Reynolds, Terry (Contractor-SIMTECH)
Subject: Re: [Adeos-main] RE: ppc64 port questions



Hi,
I'm trying to analyze a (probable) stack overflow problem with the ppc32
version of adeos+fusion - it too dies at the latency test. Could you
send me your heap of printk output (syslog, dmesg), so that I can get
the general idea of the call chain - maybe these are related. Btw. How
far do you get with klatency on the ppc64?

Regards,
  Heikki Lindholm

Reynolds, Terry (Contractor-SIMTECH) kirjoitti:
> Hi All,
>
>
> I have more info, but still no idea as to where things are broken.
>=20
> In trying to run the RTAI latency test, the program ends up in a loop =
processing schedule_tail
> & schedule_head events until the test gives up.  Both events are =
"caught" in the
> rtai/nucleus/shadow.c set of event handlers.  The _head event is =
caught from the handler
> called in the _adeos_handle_events routine.  The _tail event is caught =
from the
> _adeos_suspend_domain functions' event handler block.  The first is =
dispatched from
> the root domain, whereas the second is from the RTAI domain.
>=20
> The schedule_tail event happens first.
>=20
> After several seconds of this loop, the latency test fails with a =
"failed to create display task, code -38".=20
> The rt_task_create function wasn't reached (the printk statement which =
is the first line doesn't get printed),
> so this must be comming from one of the module_init functions.
>=20
> The shadow.c routines both report handling the events as the root =
domain.
>=20
> At the moment I'm stuck trying to figure out which routine is trying =
to spawn a task, and why it's failing.
>=20
> ANY help would be greatly appreciated!
>=20
> TIA.
>=20
> Terry
>
> ________________________________
>
> From: adeos-main-admin@domain.hid on behalf of Reynolds, Terry =
(Contractor-SIMTECH)
> Sent: Tue 3/15/2005 10:24 AM
> To: adeos
> Subject: [Adeos-main] ppc64 port questions
>
>
>
> Hi All,
>
> I apologize for the long posting, but wanted to give sufficient detail =
for folks to see what's going on.
>
> I have made a good bit of progress on the ppc64 port.  I'm trying to =
get the RTAI example test latency to work.
> Things fail in a way that looks like I've missed a function somewhere. =
  I've added quite a few printk statements
> in trying to track down the problem.
>
> What I'm seeing is:
>
> Root domain registered.
> Pipeline started.
>
> Start latency test:
>
> RTAI[hal] domain registered:
>    switch from root to RTAI[hal].
>    calls suspend.
>    switches back to root.
>
> Domain IShield registered.
>    root switches to IShield
>   IShield suspends & switches back to root.
>
> RTAI[nucleus] RTAI/fusion v0.6.9 started
>   all initialization routines seem to run OK.
>  __fusion_skin_init processes all the way through and exits without =
error.
>
> THEN
>
> In Root:
>    sched.c's need_resched: calls -
>    adeos_schedule_tail, which calls __adeos_handle_event with  =
ADEOS_SCHEDULE_TAIL
>
>    __adeos_handle_event does a switch_to RTAI[hal] domain.
>    it resumes in suspend_domain, from which it returns to =
rthal_domain_entry.
>    At that point it is in a loop constantly calling suspend_domain.
>    So, RTAI[hal] instantly suspends again, switching back to root.
>    Root ends up back in need_resced, and this process repeats several =
hundred times,
>    until the latency test gives up and exits with a "failed to create =
display task, code -38"
>
> IShield is unregistered.
> RTAI/fusion stops.
> RTAI is unregistered.
> RTAI[hal] is unloaded.
>
> At least things seem to exit gracefully!
>
> So, my questions are:
>
>   Did any of that description look totally wrong?
>
>    What is suppose to cause RTAI[hal] to break out of the =
suspend_domain loop,
>   and process the event being passed in from root via the =
schedule_tail?
>   Should it be suspended at a different place?
>
> I'm not sure if this is an Adeos or an RTAI problem at this point.
>
>
> TIA!
>
> Terry.
>
>
>
>
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
>
>
>
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main



