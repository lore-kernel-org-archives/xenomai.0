Message-ID: <48D34C63.90304@domain.hid>
Date: Fri, 19 Sep 2008 08:53:23 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48CE8CE7.6030209@domain.hid> <48D177B1.7000009@domain.hid>
	<48D2184F.3000009@domain.hid>
In-Reply-To: <48D2184F.3000009@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB42366E4388EE5DDAF615542"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] keyboard interrupt
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Harco Kuppens <h.kuppens@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB42366E4388EE5DDAF615542
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Harco Kuppens wrote:
> Hi Jan,
>=20
> Thank you for your answer! But I still have some things I do not really=

> understand.
>=20
> In Life with Adeos=20
> <http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Life-with-Ade=
os-rev-B.pdf>
> I read :
>=20
>    The stage of the pipeline occupied by any given domain can be
>    stalled, which means that
>    the next incoming interrupt will not be delivered to the domain's
>    handler, and will be
>    prevented from flowing down to the lowest priority domain(s) in the
>    same move. While a
>    stage is stalled, pending interrupts accumulate in the domain's
>    interrupt log, and
>    eventually get played when the stage is unstalled, by an internal
>    operation called
>    synchronization.
>=20
>=20
> and further on :
>=20
>    When a domain has finished processing all the pending interrupts it
>    has received, it then
>    calls a special Adeos service which yields the CPU to the next
>    domain down the pipeline,
>    so the latter can process in turn the pending events it has been
>    notified of, and this cycle
>    continues down to the lowest priority domain of the pipeline.
>=20
>=20
> So from reading this I would suspect that multiple IRQs could be
> buffered (=3D interrupt log) between Xenomai and Linux so that Xenomai =
can
> finish it realtime jobs. Only when xenomai is done with its jobs the
> IRQs from the buffer are passed  to Linux
> But from your answer I suspect that it only holds for different IRQs,
> and when an IRQ X is on the pipeline not another newer IRQ X can over
> the pipeline until the first one is dealed with.
> Thus when the 'end-of-IRQ' signal is given.

Yes. For correct handling of shared IRQs, _all_ associate IRQ handlers
must have been executed before the EOI can be sent. The reason is this:

For level-triggered IRQs, all hardware devices that may have raised the
IRQ line must be checked and told to lower it again before sending EOI.
Otherwise the IRQ will immediately be triggered again and you end up in
an endless loop, bricking your box.

For edge-triggered IRQs, there problem is different. Here the shared IRQ
handling algorithm is to consult all handler in a loop until they all
reported "not for me" in a row. If you fail to do this, you risk loosing
IRQs. Consider IRQ source A and B. Now an IRQ is raised by B. First, the
handler for A will be called. It return "not for me". Now it happens
that A also raised the IRQ right at this time. If you now simply log the
IRQ for later handling by B and send the EOI, you take away the chance
for handle A to react on the IRQ. At best you create latency, at worst A
will never send an IRQ again...

[Hope someone feels motivated to move this explanation to our FAQ in the
wiki...]

> Who however gives this 'end-of-IRQ' signal? linux or the pipeline?

The last domain in the pipeline that listens to the IRQ.

> What exactly is this 'end-of-IRQ'  signal? Because interrupt are
> virtualized in the pipeline I would suspect  this is something used in
> the pipeline?

See above, this is a hardware dependency.

>=20
>> IRQ sharing between deterministic and non-deterministic code (here:
>> Xenomai and vanilla Linux) will never work, that's an inherent design
>> issue, nothing Xenomai or ipipe-specific.
>>
>>  =20
> with inherent design, I would guess you mean the intel hardware design =
I
> suppose?
> but than I would suspect that the 'end-of-IRQ' signal is something in
> the hardware

The issue is architecture-independent, see above.

HTH,
Jan


--------------enigB42366E4388EE5DDAF615542
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkjTTGgACgkQniDOoMHTA+k1NACeKWcIlIYDVD6AF7PisGXDjiw8
mNwAniVM1TE6Pa5vBDudGppwQPlxhlmU
=OhrX
-----END PGP SIGNATURE-----

--------------enigB42366E4388EE5DDAF615542--

