MIME-Version: 1.0
Sender: dothemango@domain.hid
In-Reply-To: <4C9D0B69.4000507@domain.hid>
References: <AANLkTim0ROW9R84M2cmxBOKc3m2EUuPOUK5og0p5ErcN@mail.gmail.com>
	<4C9D0ACB.1000004@domain.hid> <4C9D0B69.4000507@domain.hid>
Date: Mon, 27 Sep 2010 14:05:01 +0200
Message-ID: <AANLkTimtQT3U=pdjLY3aDu9zFK2h6oG59vqN1cQHk=uA@mail.gmail.com>
From: martin mangard <martin@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] rt_task_start returns -38 (ENOSYS)
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

Hello

I did some more research.
What I haven't memtioned is, that I'm using openembedded to build
xenomai. It turned out that the reason that caused the ENOSYS error
was the same as descibed in:

https://mail.gna.org/public/xenomai-help/2009-08/msg00047.html

I changed the CFLAGS and the latency test program worked without
errors. It seems to me that some people have made xenomai recipes but
none of them made their way into the
openembedded repository. Maybe I will post my recipe in the
openembedded mailinglist to discuss the possibilities of a xenomai
integration in openembedded.

Thanks for your help

Martin


On Fri, Sep 24, 2010 at 10:34 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Gilles Chanteperdrix wrote:
>> martin mangard wrote:
>>> Hello
>>>
>>> I installed Xenomai on a x86 machine (kernel 2.6.30 wih xenomai
>>> 2.4.10). In order to verify the installation I ran the
>>> latency-testprogram from the test-suite.
>>> The latency test program aborts with the error ENOSYS :
>>>
>>>
>>> =3D=3D Sampling period: 100 us
>>> =3D=3D Test mode: periodic user-mode task
>>> =3D=3D All results in microseconds
>>> latency: failed to start display task, code -38
>>>
>>> This output ist generated if the call err =3D
>>> rt_task_start(&display_task, &display, NULL); ---> fails.
>>>
>>> As mentioned in the documentation this error occurs, if not all
>>> necesary modules are loaded or configured.
>>>
>>> during the startup following messages occur:
>>>
>>> .
>>> .
>>> I-pipe: Domain Xenomai registered.
>>> Xenomai: hal/i386 started.
>>> Xenomai: real-time nucleus v2.4.10 (Flavor Crystal 7) loaded.
>>> Xenomai: starting native API services.
>>> Xenomai: starting POSIX services.
>>> Xenomai: starting RTDM services.
>>> Xenomai: starting RTAI emulator.
>>> .
>>> .
>>>
>>
>> Please send us the full logs, from the boot up to the point where your
>> program fails.
>
> As well as the "latency" command line which fails.
>
>>
>
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

