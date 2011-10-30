MIME-Version: 1.0
In-Reply-To: <CAPASGLrv71uw9NYEjxwhYfrz2kHZsSUFANVAegGGU4RBPW3_Ow@domain.hid>
References: <CAAeYjMmOjq5mrGJ2E5m9oz0HeCP+6UJ8f7aziXcACPuAKM4PzQ@mail.gmail.com>
	<4EAC8885.6070107@domain.hid>
	<CAAeYjMnq-cai4m9=EnDh4bNtKXQw+kMj=JQ3JJ1nYhFb=zD-Nw@domain.hid>
	<CAPASGLrv71uw9NYEjxwhYfrz2kHZsSUFANVAegGGU4RBPW3_Ow@domain.hid>
From: =?UTF-8?Q?=C5=81ukasz_Sacha?= <dragilla@domain.hid>
Date: Sun, 30 Oct 2011 10:41:41 +0100
Message-ID: <CAAeYjM=PCjeZ3UhXnGW87+EhPVezi+DrNdwmOUY_hZNmTuC55w@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Eric Noulard <eric.noulard@domain.hid>
Cc: xenomai@xenomai.org

> A skin is an API on top of the "thin kernel (ADEOS + Xenomai Nucleus) "
> which is offered to Real-Time tasks.
> There is FAQ for that question
> http://www.xenomai.org/index.php/FAQs#What_is_a_Xenomai_skin.3F
> which part of this answer does you not understand?

For a beginner there are too many terms that mix in my head, adeos,
rtos... I'm starting to see the big picture now.

>> My guess is it's the way "real time tasks" part looks like/acts like.
>> Am I right?
>> However there is another diagram shown in the Chameleon RTOS pdf -
>> this does not include the user space.
>> What is the user space?
> Which diagram ? on which page of the document?

Page 5. But now when I know that xenomai is more like a nano kernel
approach than thin kernel approach it all makes sense.

>> Can xenomai have multiple skins at the same time?
> Yes Xenomai may have mulitple skins
> (see slide 5 of =A0http://www.xenomai.org/images/c/c6/Xenomai-OSMB-2007-0=
1.pdf)
> but I don't know if a single application may use different skins at
> the same time.
> I never tried myself so I let other answer that one.
> Why would you want to have/use multiple skin?

I don't. I just wanted to understand how it all works.

I guess for now it is enough questions. I mean I still have plenty but
I guess now I can start finding answers by myself. Thank you.

regards,
--=20
Luke

