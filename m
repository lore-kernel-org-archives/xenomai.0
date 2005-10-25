Message-ID: <435DF423.5000800@domain.hid>
Date: Tue, 25 Oct 2005 11:00:19 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] How to implement a GUI for RT apps?
References: <435D7D8C.1010004@domain.hid>
In-Reply-To: <435D7D8C.1010004@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig341E623EA4B42F68AF330B0C"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Vincent Levesque <vleves@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig341E623EA4B42F68AF330B0C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Vincent Levesque wrote:
> Hello,
> 
> I'd like to have your opinion on the best way to implement a GUI for a
> RT application. The standard approach seems to be to split of the
> application in two processes that communicate using shared memory or
> queues. I've been using a different approach that's closer to what's
> done in many non-realtime apps. I tried to put both the GUI and RT code
> in a single process using threads, shared objects and mutexes. It seemed
> to work fairly well for a while but it stopped working after switching
> to GCC 4.0 (while upgrading Ubuntu Linux). After spending a few days
> debugging this problem, I get the feeling that I'm doing something
> "illegal" with RTAI/fusion that worked by accident until the upgrade.
> 
> Here's what I've been doing... I create some objects, each with its own
> RT_MUTEX. I then create two RT tasks: one for the GUI and one for my
> hardware. Both taks have pointers to the shared objects. They call the
> objects' methods directly. The object locks or tries to lock its mutex
> in its methods, as appropriate. Both tasks are thus using the same
> RT_MUTEX structure. I've been careful to lock the mutexes only for short
> amounts of time and to only try to lock it in critical code.

...and hopefully do not call any non-rt functions while holding the
lock. Note that you can install a SIGXCPU handler to catch such
potential accidental violations. Likely not needed if you only copy some
data between the shared objects and your local buffers (all locked into
memory - mlockall?).

> 
> To summarize,
> 
> 1. What's the best way to implement a GUI for a RT app?

Depends too much on your requirements, GUI toolkit, etc. to give a
general statement here.

> 2. Is my approach "legal" in fusion/xenomai?

Sounds sane to me. Which fusion version are you using? Already tried to
update some component (kernel, patch, fusion/xenomai) and watch
potential changes?

> 3. I remember reading that RTAI and X don't play well together. Is that
> the case with Xenomai? Will things be better if I use the two-processes
> approach?

Not a general problem, but a specific one related to certain graphic
cards and drivers (don't ask me which, we are only using head-less or
console-based boxes here).

Jan

--------------enig341E623EA4B42F68AF330B0C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDXfQjncNeS9Q0k+IRAlGXAJ0fyvEsuG52PFsbcdKx/Mo/IzAQIwCg5rFj
hsfvWUXaeys+d66k3t2FWnU=
=U9cA
-----END PGP SIGNATURE-----

--------------enig341E623EA4B42F68AF330B0C--

