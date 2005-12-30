Message-ID: <43B58FED.6070404@domain.hid>
Date: Fri, 30 Dec 2005 20:52:13 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] I-pipe + latency tracing patch
References: <43B5658D.3030004@domain.hid>
In-Reply-To: <43B5658D.3030004@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD08D32384B5CF173C9A03A1A"
Sender: jan.kiszka@domain.hid
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
Cc: adeos-main@gna.org, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD08D32384B5CF173C9A03A1A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> 
> I've just rolled out two patches, the first issue of the 1.1 series for
> x86, and the accompanying tracer patch contributed by Jan Kiszka and
> Luotao Fu. With the latter patch, the I-pipe shall trace the longest
> stalled path of the domain with the highest priority. Apply them in that
> order:
> 
> http://download.gna.org/adeos/patches/v2.6/adeos/i386/adeos-ipipe-2.6.14-i386-1.1-00.patch
> 
> http://download.gna.org/adeos/patches/v2.6/adeos/i386/tracer/ipipe-tracer-2.6.14-i386-1.1-00.patch
> 

Two remarks: First, the tracer patch claims more in its config option
than it actually provides - mea culpa. The patch itself does not contain
any instrumentation of ipipe. This has to be fixed. Meanwhile, please
have a look at this posting for instrumentation options:
https://mail.gna.org/public/xenomai-core/2005-12/msg00076.html

Philippe, do you remember the issues I described about my original
ipipe_trace.instr? How can we avoid too short worst-case traces due to
domain unstalling followed by re-stalling inside the same IRQ context?
Do you see further issues with this approach? I think it would be best
if we can provide a clean CONFIG_IPIPE_TRACE_STALLS for the highest (or
later maybe even for an arbitrary) domain together with the tracer.

And second, the separation between both patches is not clean. There are
tracer related fragments in the 1.1-00 base patch, intentionally? What's
the idea of the separated patches? I mean, doesn't this increase the
maintenance effort?

Jan

--------------enigD08D32384B5CF173C9A03A1A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDtY/tniDOoMHTA+kRAkP4AJ4q2KcgYeqwV/9UG1XQzMw4rBWeDgCeIaAy
EgMQcHBxAJkMIdwjg2/Pz4A=
=k7Vu
-----END PGP SIGNATURE-----

--------------enigD08D32384B5CF173C9A03A1A--

