Message-ID: <20060323023533.70822.qmail@domain.hid>
Date: Wed, 22 Mar 2006 23:35:33 -0300 (ART)
From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-core] Interrupt priorities
In-Reply-To: <4421D80D.9020504@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai-core <xenomai@xenomai.org>

--- Philippe Gerum <rpm@xenomai.org> escreveu:
> ...=20
> A way to pull the brake when some interrupt channel goes wild is to=20
> activate Xenomai's NMI watchdog, which is never pipelined on any Adeos=20
> implementation.

Where can I find more information about this feature?

> This requires an APIC to be available on your x86 CPU=20
> though.

I need to verify that on college. My PC is a P4 1.7Ghz, Intel motherboard I=
 guess.

> ...=20
> Having a reusable template would already be nice, and likely appreciated =

> by the RTDM people too, since that's precious on hand information.

Ok, I'll probably do that after finishing my master thesis, probably after =
June. Or if I got
permission from Data Translation until there I could send the code as it is=
... :) But as I'm not
counting on this, we'll have to wait until I have time to reorganize the co=
de and remove the
specific Data Translation code...

Thanks for the explanations,

Rodrigo.


__________________________________________________
Fa=E7a liga=E7=F5es para outros computadores com o novo Yahoo! Messenger=20
http://br.beta.messenger.yahoo.com/=20

