Message-ID: <2ff1a98a0708090614u3b223ff4n196f0d5ed2a5db41@domain.hid>
Date: Thu, 9 Aug 2007 15:14:54 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <000901c7da86$2171afc0$c124a986@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <18106.60807.692746.230882@domain.hid>
	<000901c7da86$2171afc0$c124a986@domain.hid>
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
> >> this is my first email to this list, and I would like to start with a
> >> question. I use the posix skin of Xenomai 2.3.1, and I have several
> >> processes running, each consisting of several threads. Is there a
> >> possibility for a thread A1 running in process A to change the
> >> scheduling parameters, in particular the priority, of a thread B1
> >> running in process B?
> >>
> >> Regarding the posix specification I cannot find this functionality
> there
> >> and so I guess there is no way doing it with
> "pthread_setschedparam()".
> >> But is there another possibility?
> >
> >No, the only way you could do that is by using an IPC to pass the
> >request from a process to another. You could use message queues for
> >that.
> >
>
> Thanks for this immediate answer. I just read some parts of the posix
> specification, and if I'm not mistaking posix message queues do not
> inherit thread priorities.

My idea was that you could encode the request in a message that you
would handle in the receiving process by receiving messages and
calling pthread_setschedparam.
But then another problem arises: a pthread_t identifier is only valid
in one process, so how could you designate in one process the threads
of another process ?

--=20
                                               Gilles Chanteperdrix

