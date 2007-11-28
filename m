Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Tue, 27 Nov 2007 23:59:17 -0500
Message-ID: <BF58A8AFB316514587D61EADBFBF4C410165FD61@domain.hid>
In-Reply-To: <18252.31008.17258.994903@domain.hid>
From: "Kyle Howell" <khowell@domain.hid>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Interrupts lost during sleep / unblock cycles
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

>  > >  > I have been debugging a stall problem for a couple of=20
>  > > days, and I think  > I've put together enough info to check=20
>  > > with the pros. Everything below  > was experienced on a P4=20
>  > > (Celeron) running 2.6.20 / Xenomai 2.3.4. I've  > also=20
>  > > reproduced it on 2.6.19.7 / 2.3.1. A quick test *did not*=20
>  > > reproduce  > this problem on a Core2 running x86_64 2.6.22.9=20
>  > > / 2.4RC3.=20
>  > >  >
>  > >  > I've reduced the problem to a fairly simple example below:
>  > >  >
>  > >  > The Overview:
>  > >  > - Running a single real-time process with one standard=20
>  > > thread and one RT  > task  > - The RT task loops on a 1sec=20
>  > > rt_task_sleep  > - The standard thread loops on=20
>  > > nanosleep(10msec) and rt_task_unblock of  > the RT task.
>  > >  > - When an unrelated interrupt arrives at the wrong time,=20
>  > > the entire  > system will hang until the 1sec task_sleep expires.
>  > >  > - After resuming, everything runs normally until another=20
>  > > interrupt lands  > at the wrong moment.
>  > >=20
>  > > Do you observe the same behaviour without the interrupt shield ?
>  >=20
>  > It doesn't appear so. I'll have to let it run longer to be=20
> 100% sure,
>  > but the usual stressing isn't causing the problem. That's=20
> not expected
>  > behavior with the interrupt shield, is it?
>=20
> No, it is not an expected behavior.
>=20

After considerable staring and code surfing, I think I have an idea of
what's happening. There are still enough parts of the code I don't fully
undertand that I'm not positive, though. Check this theory out for me:

Flow of events when it works:
1=2E Process running in root domain.
2=2E Interrupt fires, IShield pending bit set.
3=2E ipipe_walk_pipeline calls IShield handler.
4=2E IShield propagates interrupt to root domain.
5=2E Root domain finishes restoring the APIC.
6=2E Everything continues as expected.
 - or -
1=2E Process running in Xenomai domain.
2=2E Interrupt fires, IShield pending bit set.
3=2E ipipe_walk_pipeline resumes high-priority Xenomai domain.
4=2E Xenomai domain finishes and suspends.
3=2E ipipe_walk_pipeline calls IShield handler.
4=2E IShield propagates interrupt to root domain.
5=2E Root domain finishes restoring the APIC.
6=2E Everything continues as expected.

Flow of events when it fails:
1=2E Process running in root domain, makes syscall *requiring Xenomai
domain*.
2=2E Thread is temporarily promoted to Xenomai domain to execute syscall.
3=2E (Optional) Syscall results in another Xenomai task gaining control.
3=2E Interrupt fires, IShield pending bit set.
4=2E ipipe_walk_pipeline resumes high-priority Xenomai domain.
5=2E (Optional) Other Xenomai task completes, promoted syscall resumes.
6=2E Syscall returns to root domain, never calling ipipe_sync_pipeline on
IShield domain.
7=2E Root domain sleeps without ever restoring the APIC.
8=2E System hangs until event-timer fires for Xenomai task.
9=2E Xenomai task finishes and suspends.
10. ipipe_walk_pipeline calls Ishield handler.
11. IShield propagates interrupt to root domain.
12. Root domain finishes restoring the APIC.
13. Everything continues as expected.

To put it in a sentence, it looks like there's a loop-hole where a
promoted syscall can get back to the root domain without the
intermediate domains being checked for pending interrupts. The propagate
logic in ipipe_dispatch_event *seems* like it would take care of this,
but I'm guessing I'm making bad assumptions about variables.

To force quick reproduction of this problem, run the previously posted
taskTest, and then create some heavy interrupt activity. The
rt_task_unblock call (from root) ends up being the ideal instigator for
this hole because it runs in the primary domain and doesn't return until
the unblocked task is done, but I'd imagine any primary-domain syscall
could occasionally reproduce it.

I may eventually be able to produce a patch for this, but I imagine
someone else out there is already familiar enough with the code to close
this up a lot faster. I certainly wouldn't be offended.

--
Kyle Howell

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
This email and any files transmitted with it are
confidential and intended solely for the use of the
named recipient or recipients.  If you have received
this email in error please notify the sender
immediately. =20

