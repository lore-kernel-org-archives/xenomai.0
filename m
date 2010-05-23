MIME-Version: 1.0
In-Reply-To: <4BF949C3.2030800@domain.hid>
References: <AANLkTimhw6cOHeDP3D4Om8nBiT-aURPWxbIrT23hNcNW@mail.gmail.com>
	<4BF8F73D.3070008@domain.hid>
	<AANLkTikT2AgxYKn4rK1jHtHzcK_AwJBzNANjDtAnyrwt@domain.hid>
	<4BF949C3.2030800@domain.hid>
Date: Mon, 24 May 2010 00:12:05 +0800
Message-ID: <AANLkTikLhLMuRXGt4el8-mx8cl8hldtvAvoWKLMHohNo@domain.hid>
From: Everett Wang <everteq@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] problem with serial example
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

I think I didn't state correctly. It is not due to xenomai patch for my dis=
play
and USB. I am using Angstrom distribution. But I replaced its kernel and
modules with xenomai patched vanilla kernel 2.6.33.3. I think due to the fa=
ct
that Angstrom distribution is heavily patched kernel for display and
USB to work.
If I replaced its kernel with a vanilla one, many of the 3D and usb stuff c=
ould
be broken. So it is the kernel replacement that caused the display and USB
trouble.

Having said that, I really don't need 3D display. If I can get a console
display on my DVI, then I can use all the uarts for xenomai. Should I
use debian or ubuntu distribution for xenomai instead of Angstrom?

Best regards,

Everett



On Sun, May 23, 2010 at 11:29 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Everett Wang wrote:
>> That is right. Currently with a vanilla kernel and xenomai patch, my DVI=
 display
>> and USB keyboard, mouse do not function. So uart3 is the only way to int=
eract
>> with the beagleboard.
>
> That is not normal. If you are using the same configuration, things
> should work. Do you get any messages about this on the console?
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>

