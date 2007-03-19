From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Subject: Re: [Xenomai-help] RT-Socket-CAN bus error handling (was CAN errors
	and real-time behaviour (IRQ raise forever and may lock system))
Date: Mon, 19 Mar 2007 17:56:22 +0100
References: <bc4264770703030609w188a675cj618872986ff1071c@domain.hid>
	<E1HTD6v-0004qo-QI@mailer.emlix.com> <45FEBEC5.8010608@domain.hid>
In-Reply-To: <45FEBEC5.8010608@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200703191756.23249.Sebastian.Smolorz@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?utf-8?q?St=C3=A9phane_ANCELOT?= <sancelot@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

St=C3=A9phane ANCELOT wrote:
> > IIRC, there is no possibility to detect a "normal" bus error
> > (acknowledge) appearing during normal operation from the one occuring
> > when the cable is plugged off. The best indication is a high number of
> > consecutive BEIs.
>
> I do not agree :
> case normal :
> In normal bus error condition, if error repeats the chip will go to
> busoff state (unfortunately I don't know how to simulate this...)
>
> case unplugged (easy to simulate):
> when the cable is not plugged it will not go to busoff condition.

I know that. Unfortunately, you took my above answer out of context. I repl=
ied=20
to:

> What about something like option 3: After the first error occurred that
> may mark the beginning of a flood, disable that error interrupt until
> the next stop/start cycle or the user has read the event?

I was referring to *one* bus error. If one bus error occurs how will the=20
driver know it is the beginning of a flood due to an unplugged cable? It ca=
n=20
only tell after serveral consecutive ones.

=2D-=20
Sebastian

