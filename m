MIME-Version: 1.0
In-Reply-To: <4C3463FD.4040804@domain.hid>
References: <AANLkTilmN6HTqYAcEv5qTqYhpjgBiMYQAPvPwCnynAHu@domain.hid>
	<4C345529.8010309@domain.hid>
	<AANLkTimmMGLKCyhiLBdDafSvkGlldwI17Xb2Y-XCx1bV@mail.gmail.com>
	<4C3463FD.4040804@domain.hid>
Date: Wed, 7 Jul 2010 20:44:43 +0800
Message-ID: <AANLkTikjCCD9WlqVMl-of4fx4ldZ8bmk-DGzLkqr5FXO@mail.gmail.com>
From: Everett Wang <everteq@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] task management, multi-thread, multi-core
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

On Wed, Jul 7, 2010 at 7:24 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Everett Wang wrote:
>> If the second task is running already, when the
>> higher priority
>> task is waiting for an outside event, then the event comes, the high
>> priority task
>> has to wait until the lower priority one to finish?
>
> No. Xenomai scheduler is preemptive:
> http://en.wikipedia.org/wiki/Preemptive_multitasking

That is why I thought to cut the lower priority but more CPU comsuming
task into smaller pieces and only let it run for one piece at a time
then wait so
higher priority task don't have to wait. Once the higher priority task has
done its thing, then send a trigger to the let the lower priority task to r=
un
one more chunk. Is this the right thing to do or I am totally off the track=
?

Everett

>> Do you mean that if I need memory isolation, I use process, if I am sure=
 my code
>> has no memory problem, I should choose thread for better performance? Or=
 it
>> is more complex than this?
>
> You can never be sure that code has no memory problem. It is more
> complex than that, for instance, whether the threads are inter-dependent
> should be taken into account.
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>

