Message-ID: <45427AA3.1030607@domain.hid>
Date: Fri, 27 Oct 2006 23:31:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] enable/disable all interrupts from user space
References: <200610261639.36013.jweber@domain.hid>	 <45420A72.8000700@domain.hid>
	<1161983506.4983.48.camel@domain.hid>
In-Reply-To: <1161983506.4983.48.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5168EA8409727BFD51BA838F"
Sender: jan.kiszka@domain.hid
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
Cc: Xenomai Help <xenomai@xenomai.org>, Jeff Weber <jweber@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5168EA8409727BFD51BA838F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Fri, 2006-10-27 at 15:32 +0200, Jan Kiszka wrote:
>> Jeff Weber wrote:
>>> How do I enable/disable all interrupts (Linux and Xenomai) from user =
space? =20
>>> (native skin preferred)
>> For x86:
>>
>> iopl(3);
>> __asm__ __volatile__("cli/sti");
>>
>=20
> Gasp...
>=20
>> Ugly hack, typical a sign that something should be moved somewhere
>> else... (there are a few exceptions, though)
>>
>> We once had some discussion if we shouldn't export domain stalling
>> features to user-space in order to support things like X-servers that
>> currently come with such code, toasting any RT kernel. May come one da=
y,
>> but this will be primarily for legacy non-RT code.
>=20
> Providing "cli" emulation to X-Servers would only make sense in order t=
o
> stall the Linux domain; controlling the interrupt shield dynamically
> using the T_SHIELD bit would allow that already.

As far as I understood, the I-shield doesn't come for free. So, having
at least an API to stall the root domain from user-space should be cheape=
r.

> If I understand
> correctly, we are talking about stalling the Xenomai domain too, and
> this is a completely different story. The day we would provide such
> "feature" as an official API, we would trigger tons of misuses of this
> hack, a bit like we have now with the T_PRIMARY bit, a number of people=

> sprinkle over their code to control the task exec mode, which is most o=
f
> the time utterly sub-optimal, and automatically handled by the nucleus
> already. IOW, I'm not convinced at all that adding such API would be th=
e
> right thing to do.

When it comes to *emulate* hacky RTAI APIs - I would not immediately
refrain from considering this. But I agree that this can open Pandora's
box, and having it in the native skip could mess up a lot. Unless we
will see a widely compatible RTAI user-space skin one day, it's probably
better to keep status quo /wrt to non-root domain stalling.

>=20
> For the time being, it should be possible to write a simple kernel
> module using either the native or RTDM API from kernel space, which
> would handle such requests from user-space. For instance, one could use=

> rt_task_notify() from user-space to signal a helper task in a kernel
> module that carries out the job, depending on the signal received. The
> same goes for a trivial RTDM driver only implementing the ioctl()
> support for the same purpose.

That still remains a hack, though now platform independent :). I would
simply use the assembly + a big fat warning sign saying "This code needs
serious refactoring!"

Jan


--------------enig5168EA8409727BFD51BA838F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFQnqjniDOoMHTA+kRAufDAJ4pyiZ3Z9bR6pkjPUtGvVxdimJ/sACfXRza
KKXK1inVDqfnsWKJlCoDgHI=
=qUWl
-----END PGP SIGNATURE-----

--------------enig5168EA8409727BFD51BA838F--

