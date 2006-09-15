Message-ID: <450A6566.1070200@domain.hid>
Date: Fri, 15 Sep 2006 10:33:42 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <58168.129.217.4.64.1158067468.squirrel@domain.hid>	
	<1158091876.5020.8.camel@domain.hid>	
	<b647ffbd0609121358v5b5bff80o6e4e08c859eb110a@domain.hid>	
	<450727D1.6060203@domain.hid> <4507C49A.5070909@domain.hid>	
	<b647ffbd0609140055t328fec1fi3b5d86da178d790e@domain.hid>	
	<1158223595.5040.16.camel@domain.hid>	
	<b647ffbd0609141512t47b1835em49c9873985aa5fb3@domain.hid>
	<1158308512.5009.35.camel@domain.hid>
In-Reply-To: <1158308512.5009.35.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig18A3EE3BFA3CA3D53F771A3B"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [Xenomai-help] Bad EIP kernel-Oops
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig18A3EE3BFA3CA3D53F771A3B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> diff -uNrp 2.6.17-ipipe-1.3-10/kernel/ipipe/core.c 2.6.17-ipipe/kernel/=
ipipe/core.c
> --- 2.6.17-ipipe-1.3-10/kernel/ipipe/core.c	2006-09-15 10:13:15.0000000=
00 +0200
> +++ 2.6.17-ipipe/kernel/ipipe/core.c	2006-09-14 20:09:22.000000000 +020=
0
> ...
> @@ -638,6 +642,7 @@ int ipipe_control_irq(unsigned irq, unsi
>  int fastcall __ipipe_dispatch_event (unsigned event, void *data)
>  {
>  	struct ipipe_domain *start_domain, *this_domain, *next_domain;
> +	ipipe_event_handler_t evhand;
>  	struct list_head *pos, *npos;
>  	unsigned long flags;
>  	ipipe_declare_cpuid;
> @@ -649,8 +654,6 @@ int fastcall __ipipe_dispatch_event (uns
> =20
>  	list_for_each_safe(pos,npos,&__ipipe_pipeline) {
> =20
> -		next_domain =3D list_entry(pos,struct ipipe_domain,p_link);
> -
>  		/*
>  		 * Note: Domain migration may occur while running
>  		 * event or interrupt handlers, in which case the
> @@ -659,11 +662,22 @@ int fastcall __ipipe_dispatch_event (uns
>  		 * care for that, always tracking the current domain
>  		 * descriptor upon return from those handlers.
>  		 */
> -		if (next_domain->evhand[event] !=3D NULL)	{
> +		next_domain =3D list_entry(pos,struct ipipe_domain,p_link);
> +
> +		/*
> +		 * Keep a cached copy of the handler's address since
> +		 * ipipe_catch_event() may clear it under our feet.
> +		 */
> +
> +		evhand =3D next_domain->evhand[event];
> +
> +		if (evhand !=3D NULL) {
>  			ipipe_percpu_domain[cpuid] =3D next_domain;
> +			next_domain->cpudata[cpuid].evsync |=3D (1LL << event);

Isn't there still a race window between grabbing evhand and setting this
bit here? If yes, can this be solved by moving set/clear flag out of the
condition?

If this is not the solution, I wonder if we should really care that
much. Unregistering an event handler remains a rarely used scenario
which actually never happens with the nucleus built in. Shouldn't we
better put some grace period after it and live with the fact that on a
*very busy* system it *may* cause troubles once in a while? Reminds me
of the fact that procfs handler unregistration with private data
attached is also racy by design...

Jan


--------------enig18A3EE3BFA3CA3D53F771A3B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFCmVmniDOoMHTA+kRApqfAJ44nEcxEXz99R9q4abLPnk4D26OAQCfbhVw
Jsvx/6dT0Uu1IGsj5jDnhk0=
=KUXX
-----END PGP SIGNATURE-----

--------------enig18A3EE3BFA3CA3D53F771A3B--

