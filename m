MIME-Version: 1.0
In-Reply-To: <AANLkTinZ8j2LX009maJ5bva2UvJohisvnBuEB4UJqdov@domain.hid>
References: <AANLkTinZ8j2LX009maJ5bva2UvJohisvnBuEB4UJqdov@domain.hid>
Date: Wed, 8 Dec 2010 17:55:11 -0800
Message-ID: <AANLkTimSFv8vMRnC8C_Q2sgm4_sg+e+JtbMMZQUjswOV@mail.gmail.com>
From: Peter Pastor <peter.pastor@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Fwd: Xenomai on laptops
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org, asprakash83@domain.hid

Hey !

Sorry for bothering again, but I just saw the following 2 posts on the
mailing list:

-------
Dell laptop with i7 processors, multicore
    Typical latency was around 5 usec,  but at least once per second had a
long pass of approximately 700 usec.   Tried the xenomai SMI work around wi=
th
no noticable change in results.
-------
-------
> Hi,
> Is there any problems when using Xenomai on an i7 (-880 / Dell
> Precision T1500).
> Any tips/suggestions/experiences are most welcome.

I am using the same processor. Its working fine.
-------

...and I am wondering whether someone could report a laptop setup
(model?) that uses an i7 CPU and that does not suffer from "huge"
latency spikes ?

THANKS so much,
 Peter


---------- Forwarded message ----------
From: Peter Pastor <peter.pastor@domain.hid>
Date: Wed, Dec 8, 2010 at 5:32 PM
Subject: Xenomai on laptops
To: xenomai@xenomai.org


Hello !

I am looking into buying a laptop to run Xenomai (and RTnet) and I am
having trouble choosing the appropriate setup.

The plan is to run xenomai on the laptop and use rtnet to communicate
to some controller boards in real-time. I have done this with a
desktop computer and it worked just fine, however, now I need to run
the same thing on a portable device.

I might have to use a RTnet compliant PCMCIA card (if such a thing
exists) because most (Dell) laptops do not have rtnet compliant NICs
(do they?). It would be great to get advice on which gigabit PCMCIA
ethernet card works with Xenomai (and RTnet). Also, are there any
issues with i7 CPUs reported ?

I hope this question is not off topic.

THANKS for any help,
=A0Peter

