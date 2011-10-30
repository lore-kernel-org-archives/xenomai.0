MIME-Version: 1.0
In-Reply-To: <CAAeYjMnq-cai4m9=EnDh4bNtKXQw+kMj=JQ3JJ1nYhFb=zD-Nw@domain.hid>
References: <CAAeYjMmOjq5mrGJ2E5m9oz0HeCP+6UJ8f7aziXcACPuAKM4PzQ@mail.gmail.com>
	<4EAC8885.6070107@domain.hid>
	<CAAeYjMnq-cai4m9=EnDh4bNtKXQw+kMj=JQ3JJ1nYhFb=zD-Nw@domain.hid>
Date: Sun, 30 Oct 2011 10:21:27 +0100
Message-ID: <CAPASGLrv71uw9NYEjxwhYfrz2kHZsSUFANVAegGGU4RBPW3_Ow@domain.hid>
From: Eric Noulard <eric.noulard@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] xenomai on em2440
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?Q?=C5=81ukasz_Sacha?= <dragilla@domain.hid>
Cc: xenomai@xenomai.org

2011/10/30 =C5=81ukasz Sacha <dragilla@domain.hid>:
> Thank you for your answer.
> I'm starting to read. I just to to understand one more thing first
> because it not clear to me from the wikifaq/howtos.
> I've fount an overview of real time linux solutions here:
> http://www.ibm.com/developerworks/linux/library/l-real-time-linux/
> Xenomai is said to be a thin kernel approach. Is this right?

More or less.
In the next drawing "Nano-kernel" approach you see a reference
to ADEOS, ADEOS/I-pipe is the hardware abstraction layer used by Xenomai
see: http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Life-with-Ade=
os-rev-B.pdf

So from the cited article point of view Xenomai is more like a
nano-kernel approach than think kernel.

> If so, would you explain to me what is a skin on this picture?

A skin is an API on top of the "thin kernel (ADEOS + Xenomai Nucleus) "
which is offered to Real-Time tasks.
There is FAQ for that question
http://www.xenomai.org/index.php/FAQs#What_is_a_Xenomai_skin.3F

which part of this answer does you not understand?

> My guess is it's the way "real time tasks" part looks like/acts like.
> Am I right?
> However there is another diagram shown in the Chameleon RTOS pdf -
> this does not include the user space.
> What is the user space?

Which diagram ? on which page of the document?

User space vs Kernel Space is the usual privilege separation of
operating systems:
http://en.wikipedia.org/wiki/User_space

> Is it or can it be a "regular linux", like emdebian for example?

As far as I know Emdebian is more about stripping down a classical linux
than making it real-time. Xenomai as a sub-kernel approach which runs
one linux system instance (for which there may not be hard realtime guarant=
ee).
So Linux is not a Xenomai skin it's kind of low-priority task running along=
 with
Xenomai.

That said may be it's possible to apply xenomai patch set to
Emdebian, but I really don't know.

> Can xenomai have multiple skins at the same time?

Yes Xenomai may have mulitple skins
(see slide 5 of  http://www.xenomai.org/images/c/c6/Xenomai-OSMB-2007-01.pd=
f)
but I don't know if a single application may use different skins at
the same time.
I never tried myself so I let other answer that one.

Why would you want to have/use multiple skin?

--=20
Erk
Membre de l'April - =C2=AB promouvoir et d=C3=A9fendre le logiciel libre =
=C2=BB -
http://www.april.org

