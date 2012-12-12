Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Apple Message framework v1283)
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <CAOiXNkC-R0EdK2QdkzYOPTQ7mTfmAyp8cJcG4Y28r5pW=SwUFQ@mail.gmail.com>
Date: Wed, 12 Dec 2012 11:30:51 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <71DCFC46-3931-4279-B9EC-DAC517874164@mah.priv.at>
References: <1491832.238.1355257934434.JavaMail.poli@jacqueline>
	<FE9848C4-D19F-4628-8047-5E67A667A2E9@mah.priv.at>
	<50C8330D.8040305@xenomai.org>
	<325B0F26-79FE-4C8B-A41E-10ED40FC0B3B@mah.priv.at>
	<50C849BB.9090307@xenomai.org>
	<7A843E24-17B0-4F91-96DA-84CE8007AC5A@mah.priv.at>
	<CAOiXNkC-R0EdK2QdkzYOPTQ7mTfmAyp8cJcG4Y28r5pW=SwUFQ@mail.gmail.com>
Subject: Re: [Xenomai] RT GPIO with Raspberry Pi
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Am 12.12.2012 um 10:47 schrieb Andrey Nechypurenko:

>> in that particular application, the GPIO's are used, among
>> others, for generating stepper pulses, and the thread running
>> this should be as fast as possible; in the RTAI/parport version
>> of that code that's anywhere from 20-50uSec
>>=20
>> nothing else though except wiggling pins, in particular no
>> interrupt-driven input; so I dont see any extra functionality a
>> kernel driver could provide
>=20
> If pulses should be preciese with low jitter (and I assume that in
> case of steppers they should), then, most probably, kernel driver is
> anavoidable because the timing precission achievable in the kernel is
> much higher then in the user-space. You might be interesting to take a
> look at our blog post here:
> =
http://veter-project.blogspot.de/2012/04/precise-pwms-with-gpio-using-xeno=
mai.html
> where we describe our attempts to generate precise PWMs to drive the
> servo motor. We end up with RTDM kernel module which uses timers
> (instead of periodic tasks) to get acceptable jitter.

Andrey,

thanks - I read your post on the issue, and that was quite valuable. =
Yes, jitter is an issue with loss of torque and eventually loosing =
steps; long thread periods also limit the granularity of frequencies the =
stepgen code can generate.

I did report what is being used in the RTAI/parport version of the code =
(which I didnt write to start with), and I am painfully aware this =
approach doesnt scale well
=20
in the case of the beaglebone port, the stepper code will be in the =
Programmable Realtime Unit which is capable of achieving very high rates =
at next to no jitter, so the RT OS is out of the loop except for feeding =
a stream of control values at > 1mS intervals

-m



