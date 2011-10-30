MIME-Version: 1.0
In-Reply-To: <4EAC8885.6070107@domain.hid>
References: <CAAeYjMmOjq5mrGJ2E5m9oz0HeCP+6UJ8f7aziXcACPuAKM4PzQ@mail.gmail.com>
	<4EAC8885.6070107@domain.hid>
From: =?UTF-8?Q?=C5=81ukasz_Sacha?= <dragilla@domain.hid>
Date: Sun, 30 Oct 2011 09:17:45 +0100
Message-ID: <CAAeYjMnq-cai4m9=EnDh4bNtKXQw+kMj=JQ3JJ1nYhFb=zD-Nw@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Thank you for your answer.
I'm starting to read. I just to to understand one more thing first
because it not clear to me from the wikifaq/howtos.
I've fount an overview of real time linux solutions here:
http://www.ibm.com/developerworks/linux/library/l-real-time-linux/
Xenomai is said to be a thin kernel approach. Is this right?
If so, would you explain to me what is a skin on this picture?
My guess is it's the way "real time tasks" part looks like/acts like.
Am I right?

However there is another diagram shown in the Chameleon RTOS pdf -
this does not include the user space.
What is the user space? Is it or can it be a "regular linux", like
emdebian for example?

Can xenomai have multiple skins at the same time?

Please help me understand.

regards,
--
=C5=81ukasz Dragilla Sacha



On Sun, Oct 30, 2011 at 01:13, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 10/29/2011 10:38 PM, =C5=81ukasz Sacha wrote:
>> Hello!
>>
>> I'm just starting to play with xenomai. My first goal is to install it
>> on my em2440 (similar to mini2440) board.
>> I could use some solid guidelines on where to start as there are many
>> tutorials out there - on mini2440, on xenomai, on arm, on i-pipe and I
>> don't even know which should I follow.
>>
>> So please be patient with me and please help me get started.
>
> I would recommend downloading xenomai 2.6.0-rc5 (soon to be release
> 2.6.0), and follow the installation guidelines called README.INSTALL in
> the tarball. The instructions are for ARM in general, but there is not
> much specific to a board or SOC, except the kernel configuration.
>
> If you have some issue once xenomai is installed, you can try the
> TROUBLESHOOTING file contained in the tarball, or the FAQ, if that does
> not help you ask questions on the mailing list (you can also try to
> browse the mailing list archives for similar issues).
>
> Then, you will have to choose which skin you want to use, if it is
> posix, you may read the following document:
> http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai
> If you choose the native skin, you may read the following document:
> http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Native-API-Tour-=
rev-C.pdf
>
> Finally, for detailed api documentation, try the doxygen API
> documentation available here:
> http://www.xenomai.org/documentation/xenomai-head/html/api/index.html
>
> We keep links to all these documents when you click "Start here", on
> xenomai main page.
>
> Regards.
>
> --
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Gilles.
>
>

