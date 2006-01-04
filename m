Message-ID: <43BC500D.70202@domain.hid>
Date: Wed, 04 Jan 2006 23:45:33 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] enjoying the trace
References: <43BC430C.5080204@domain.hid>
In-Reply-To: <43BC430C.5080204@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig88776C1E3D3A1889E53F8170"
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
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig88776C1E3D3A1889E53F8170
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> Hi all,
> 
> after a long day of experimenting with a new tracer revision (will get
> posted later), I'm looking now for some external wisdom.
> 
> I changed the instrumentation for high-domain stall times such that I
> now attach to local_irq_disable_hw & friends instead. In case the
> hard-IRQ status doesn't change, only a ipipe_trace_special is issued, a
> trace_begin/end otherwise. Additionally, I grab the entering and exiting
> of __ipipe_handle_irq and suppress two IRQ on/off points in
> arch/i386/kernel/ipipe-root.c. See attached patch (will likely become
> part of the tracer).

I failed to include the changes of entry.S, see the full patch posted in
the related thread.

> 
> Ok, this works significantly better than the previous approach. I just
> tormented an Athlon 800 MHz box with Xenomai 2.1 revision 357 (old ipipe
> IRQ layer) about 50 minutes with
> 
> 	latency -p1000 -t1
> 	dd if=/dev/hda of=/dev/null
> 	ping -f -s 1400 [from external]
> 	cachebench [part of llcbench]
> 
> The result was a maximum latency of 38 us (in-kernel periodic task) and
> some traces which correlate quite well. I attached two of them, showing
> the similarity between the final and last but one outputs of
> /proc/ipipe/trace/max. Note that the instrumentation and the trace
> recording add some overhead, how much is just going to be measured.
> 

Result: 33 us without the tracer but otherwise identical boundary
conditions.

Jan

--------------enig88776C1E3D3A1889E53F8170
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDvFANniDOoMHTA+kRAnsEAJ9Nt2MsexPiGyjGzCgLynofqoO/0QCfUCxD
/dfT4lGCBmUrWSbR/rkAQhQ=
=pNws
-----END PGP SIGNATURE-----

--------------enig88776C1E3D3A1889E53F8170--

