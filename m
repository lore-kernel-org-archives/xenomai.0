MIME-Version: 1.0
In-Reply-To: <20101220154041.48C75CDE29A@gemini.denx.de>
References: <AANLkTikiCm5B-KwteOfzTwtCV8RXj1QFgfQCAmCCoC8V@mail.gmail.com>
	<20101220154041.48C75CDE29A@gemini.denx.de>
Date: Tue, 21 Dec 2010 12:29:11 -0200
Message-ID: <AANLkTimODets-4o-oBwnB=xik8Eqs-bqK0nyi8miuV=f@domain.hid>
From: Flavio de Castro Alves Filho <flavio.alves@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai on Freescale iMX35
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Denk <wd@domain.hid>
Cc: xenomai@xenomai.org

Hello Marten,

I implemented once a port for iMX35. As the project didn't evolve, I
couldn't test it very well in order to share this information with
you.

The steps that I performed were:

* Applied the adeos patches corresponding to the LTIB linux kernel version
* Reviewed all the information according to this link:
http://www.xenomai.org/index.php/I-pipe:ArmPorting
* Applied the LTIB's patches
* Build the kernel and then the Xenomai user space

I could have a working Xenomai on iMX35.

Hope it helps,

Best regards,

Flavio



2010/12/20 Wolfgang Denk <wd@domain.hid>:
> Dear Marten Lootsma,
>
> In message <AANLkTikiCm5B-KwteOfzTwtCV8RXj1QFgfQCAmCCoC8V@mail.gmail.com>=
 you wrote:
>>
>> We have a platform with a Freescale iMX35 processor and we would like to=
 use
>> Xenomai. We have kernel versions 2.6.28 and 2.6.31 running (customized w=
ith
>> Freescale and our own patches for hardware support). I read that support=
 is
>> included for the iMX31 and 51 which are closely related. In the trac I s=
aw
>> some iMX35 related commits as well.
>>
>> 1. What is the status of the support for iMX35?
>
> Normally there is not support at all available for the LTIB kernels
> provided by Freescale. =A0Xenomai focusses on support for the mainline
> kernel tree.
>
>> 2. And if needed what is a good starting point for implementing/contribu=
ting
>> the port to iMX35?
>
> In the first step, support for the i.MX35 needs to be added for
> mainline Linux, and pushed upstream.
>
> [Please feel free to contact me if you need help doing this.]
>
> Best regards,
>
> Wolfgang Denk
>
> --
> DENX Software Engineering GmbH, =A0 =A0 MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
> "A fractal is by definition a set for which the Hausdorff Besicovitch
> dimension strictly exceeds the topological dimension."
> - Mandelbrot, _The Fractal Geometry of Nature_
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

