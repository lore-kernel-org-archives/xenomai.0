MIME-Version: 1.0
In-Reply-To: <1266226607.2375.67.camel@domain.hid>
References: <20100204105700.GB20669@domain.hid>
	<4B7019AA.8020102@domain.hid>
	<b88603c31002080633v1b9ee7b4s2a6ee82eeaab644d@domain.hid>
	<4B71339F.6050300@domain.hid> <4B713462.6000300@domain.hid>
	<b88603c31002090214j2d21f572sba26ed3883bc0612@domain.hid>
	<b88603c31002120757m386b5662nd8844a8fbccb22f0@domain.hid>
	<4B758DC6.4040508@domain.hid>
	<b88603c31002150107s115bec57x1ea9f635e54eab50@domain.hid>
	<1266226607.2375.67.camel@domain.hid>
Date: Mon, 15 Feb 2010 11:33:39 +0100
Message-ID: <b88603c31002150233g7265655eqebdb0e4ea31ee3d1@domain.hid>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Force switch back to primary domain
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

I am not sure why our application used the clone() system call
directly. And because we didn't find a reason why not to use the
pthread_create(), we already decided to convert our application to use
pthread_create() instead.

However, we didn't run into any problems when using the clone() calls
while still on the Xenomai 2.4.x branch. I couldn't find a clear
statement in the rt_task_shadow documentation about assuming threads
created by libpthread and I assumed that a thread created with clone()
would also be "a regular Linux task".

So don't get me wrong, I have no problem with Xenomai assuming threads
to be created with libpthread! It is just that we would have removed
the clone() call much earlier when the documentation at rt_task_shadow
would have been more clear on this.

We have learned this now, but enhancing the documentation might
prevent these misunderstandings.

Thanks,
Henri.

On Mon, Feb 15, 2010 at 10:36 AM, Philippe Gerum <rpm@xenomai.org> wrote:
> On Mon, 2010-02-15 at 10:07 +0100, Henri Roosen wrote:
>> Hi Gilles,
>>
>> Thanks for your support on this! We changed our application so it uses
>> the pthread library to create threads. Just to be on the safe side.
>> And I can confirm this works now on Xenomai 2.5.1.
>>
>> Might be a good idea to change the documentation of rt_task_shadow
>> what the requirements are for a task to be shadowed. Because "the
>> calling regular Linux task" does not apply anymore for Xenomai 2.5.x.
>>
>
> It actually never applied to any Xenomai release. Having the thread
> created by the standard POSIX call has always been assumed by the
> libraries (and by myself in the first place).
>
>
>> Thanks,
>> Henri.
>>
>> On Fri, Feb 12, 2010 at 6:20 PM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>> > Henri Roosen wrote:
>> >> Ok, found some time to investigate the mutex problem we see on 2.5.1.
>> >>
>> >> I managed to reproduce with a basic app that uses the same way of
>> >> thread creation as we have in our app.
>> >> Please find attached the basic app. Note, it runs fine on Xenomai
>> >> 2.4.10. Fails on 2.5.1.
>> >>
>> >> Also, the problem does not show when creating the threads with rt_tas=
k_create.
>> >>
>> >> So the main question is, should it be possible to create threads with
>> >> the clone() system call and then shadowing the threads into the
>> >> Xenomai domain with rt_task_shadow()? And are we just lucky it runs
>> >> this way in 2.4.10?
>> >
>> > To get __thread working, I think you should pass CLONE_SETTLS to clone=
,
>> > with something as the tls argument. But what to pass probably depends =
on
>> > the internals of the glibc. I would also pass CLONE_THREAD, since you
>> > want to create a thread in the same thread groups as other threads.
>> >
>> >
>> > --
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0Gilles.
>> >
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>
>
> --
> Philippe.
>
>
>

