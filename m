MIME-Version: 1.0
In-Reply-To: <7A843E24-17B0-4F91-96DA-84CE8007AC5A@mah.priv.at>
References: <1491832.238.1355257934434.JavaMail.poli@jacqueline>
	<FE9848C4-D19F-4628-8047-5E67A667A2E9@mah.priv.at>
	<50C8330D.8040305@xenomai.org>
	<325B0F26-79FE-4C8B-A41E-10ED40FC0B3B@mah.priv.at>
	<50C849BB.9090307@xenomai.org>
	<7A843E24-17B0-4F91-96DA-84CE8007AC5A@mah.priv.at>
Date: Wed, 12 Dec 2012 10:47:53 +0100
Message-ID: <CAOiXNkC-R0EdK2QdkzYOPTQ7mTfmAyp8cJcG4Y28r5pW=SwUFQ@mail.gmail.com>
From: Andrey Nechypurenko <andreynech@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] RT GPIO with Raspberry Pi
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: xenomai@xenomai.org

>in that particular application, the GPIO's are used, among
>others, for generating stepper pulses, and the thread running
>this should be as fast as possible; in the RTAI/parport version
>of that code that's anywhere from 20-50uSec
>
>nothing else though except wiggling pins, in particular no
>interrupt-driven input; so I dont see any extra functionality a
>kernel driver could provide

If pulses should be preciese with low jitter (and I assume that in
case of steppers they should), then, most probably, kernel driver is
anavoidable because the timing precission achievable in the kernel is
much higher then in the user-space. You might be interesting to take a
look at our blog post here:
http://veter-project.blogspot.de/2012/04/precise-pwms-with-gpio-using-xenomai.html
where we describe our attempts to generate precise PWMs to drive the
servo motor. We end up with RTDM kernel module which uses timers
(instead of periodic tasks) to get acceptable jitter.

