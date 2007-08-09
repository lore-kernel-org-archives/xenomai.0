Message-ID: <2ff1a98a0708090651k39f895c6ncefbd3fd3eabd18d@domain.hid>
Date: Thu, 9 Aug 2007 15:51:37 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <000a01c7da89$ada93230$c124a986@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <2ff1a98a0708090614u3b223ff4n196f0d5ed2a5db41@domain.hid>
	<000a01c7da89$ada93230$c124a986@domain.hid>
Subject: Re: [Xenomai-help] POSIX Skin: Changing scheduling parameters
	ofthreads in other processes
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Torsten_Kr=F6ger?= <t.kroeger@domain.hid>
Cc: xenomai@xenomai.org

On 8/9/07, Torsten Kr=F6ger <t.kroeger@domain.hid> wrote:
> >> Thanks for this immediate answer. I just read some parts of the posix
> >> specification, and if I'm not mistaking posix message queues do not
> >> inherit thread priorities.
> >
> >My idea was that you could encode the request in a message that you
> >would handle in the receiving process by receiving messages and
> >calling pthread_setschedparam.
>
> That was also one of my first ideas. But it won't be real-time-capable.
> When a high-priority sender thread sends a message (using posix message
> queues) to a low-priority receiver thread and blocks right after the

I do not understand why you need pthread_setschedparam to happen with
a high priority, but anyway In the process that will receive the
messages, there will be a thread whose only job will be to receive
messages from the message queue. Why not giving this particular thread
the highest priority available ?


> I guess this is a general problem of the posix specification. As fare as
> I know, there is no way to change the priority of a thread running in
> another process. You would need something like SchedSet() from the
> QNX-OS. Here you can specify a process ID and a thread ID in order to
> change the thread's scheduling parameters.

The problem I see is, how in one process, do you know the thread ID of
a threa d belonging to another process. If you solve this issue in
your application, then  the message queue solution can work.

--=20
                                               Gilles Chanteperdrix

