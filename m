Message-ID: <435E5044.8090600@domain.hid>
Date: Tue, 25 Oct 2005 17:33:24 +0200
From: =?ISO-8859-15?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] How to implement a GUI for RT apps?
References: <435D7D8C.1010004@domain.hid> <435E079F.4030108@domain.hid>
	<435E0921.20001@domain.hid>
In-Reply-To: <435E0921.20001@domain.hid>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:

>Ignacio Garc=EDa P=E9rez wrote:
> =20
>
>>>1. What's the best way to implement a GUI for a RT app?
>>>     =20
>>>
>>Make it non-RT. The "U" in "GUI" is user. Users are not real time.
>>
>>   =20
>>
>
>Not true. That thread must be mapped to Xenomai in order to use
>rt-mutexes. Otherwise, one has to use rt-pipes.
>
>Jan
>
> =20
>
I was talking design. Anything that requires user interaction is by
definition non-realtime, so,  if you have the choice to leave it out of
the RT domain, do it. You'll save a lot of headaches.

Of course, if your GUI is so tightly coupled to your RT processing that
you cannot do without rt_mutexes and/or other sync primitives, then you
must map it to Xenomai.

Nacho.

