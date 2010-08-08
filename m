MIME-Version: 1.0
In-Reply-To: <4C5E9E34.9020207@domain.hid>
References: <4C5A26C4.3050702@domain.hid> <4C5A631B.1040604@domain.hid>
	<4C5CC360.7070707@domain.hid>
	<AANLkTikC5DvkOQDfGFWL7b8KXFYd+1OkZrQ0Gc+GzzZr@domain.hid>
	<4C5E9E34.9020207@domain.hid>
Date: Sun, 8 Aug 2010 22:32:17 +0800
Message-ID: <AANLkTi=4x6Wo_63XZrDJVRoqHpn-mhxp6XzixAPpuJck@domain.hid>
From: Everett Wang <everteq@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] RTDM driver structure - an update
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
Cc: xenomai@xenomai.org, Bob Feretich <bob.feretich@domain.hid>

On Sun, Aug 8, 2010 at 8:08 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Everett Wang wrote:
>> Hi Bob,
>>
>> Great job. :-D Do you have plan to port SPI to RTDM? Last time when I
>> checked the rs232 driver
>> in RTDM for omap3 still also had problem. I don't mind to work on
>> that. But I am driver-challenged person.
>
> If you are referring to the problem described here:
> https://mail.gna.org/public/xenomai-help/2010-05/msg00166.html
> Wolfgang answered here:
> https://mail.gna.org/public/xenomai-help/2010-05/msg00167.html
>
> If you are referring to another problem, it would be nice to receive a
> real bug report, not just "omap3 has problems".
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>

Hi Gilles,

Sorry that I was not clear on the rs232 for omap3. I encountered a
problem when I tried to
run cross-link example for beagle-board on xenomai 2.5.3. Wolfgang
helped me for compiling
and loading the xeno_16550A.ko driver for rts0 and rts1. That was
resolved successfully. But I
still couldn't make cross-link example to run.

Wolfgang mentioned a potential problem in regshift for omap3. This
what he said:

quote

Wolfgang Grandegger to me, xenomai-help
show details May 26
.....
Next I would try to load the xeno_16550a.ko as described earlier. Then
you need to fix the register access by introducing a proper regshift, at
least. I can't tell if other fixups are necessary but if you are lucky
it will already work. And yes, implementing a RTDM SPI driver is even
harder, unfortunately.

Wolfgang.

end of quote.

I can't get the mail link from our mailing list since google groups
were blocked inside of China. :-(

Everett

