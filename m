Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] Kernel-OOps
Date: Wed, 28 Feb 2007 08:59:52 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB01B5387C@is-hdq-exchange.marel.net>
In-Reply-To: <1172603004.10171.24.camel@domain.hid>
References: <DD39B5C3F4963040ADC9768BE7E430CB01B5368C@is-hdq-exchange.marel.net>
	<DD39B5C3F4963040ADC9768BE7E430CB01B536B3@domain.hid>
	<1172587094.27967.10.camel@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01B53705@domain.hid>
	<1172603004.10171.24.camel@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
>=20
> It's not a magic value, it means that up to 32 memory contexts may be
> stalled in the drop queue at any point in time, waiting for a normal
> Linux task to be switched in to flush them, while a large number of
> Xenomai threads is going through frequent domain migrations. Hitting
> this limit _is_ where the problem lies, not the static limit itself,
> and it tells that something needs to be fixed in the application, so
> that it does not starve the regular Linux activities this way.     =20
>=20
> IOW, it's ok to raise this compile-time value to account for
> applications living on the edge, but we should not make a feature out
> of an application design issue, by adding such a configuration knob. =20


I do not understand. In my opionion no application behaviour should ever
cause the Kernel to oops. Playing around with Kernel configuration
values, to come around such Oopses is where the problem lies and not in
the application itself. I do nat have fully understood what exactly does
the Kernel cause to oops in this specific case, but a killall of an
application is similar to e.g. a caught SIGSEGV, which might happen in
normal development, and looks very weird if it leads to a Kernel crash
whatsoever. In my opinion the BUG_ON() call inside sched.c is a bug and
should be replaced by something that handles the situation more
gracefully.



Best regards,

Daniel Schnell.

