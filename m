Message-ID: <438E1FED.5040004@domain.hid>
Date: Wed, 30 Nov 2005 22:55:57 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [bug?] calling xnpod_delete_thread after     
	self-termination
References: <438E0807.6090000@domain.hid> <438E1DCA.7070607@domain.hid>
In-Reply-To: <438E1DCA.7070607@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7DF14B6D27291FF52932925D"
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7DF14B6D27291FF52932925D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> Jan Kiszka wrote:
> 
>> Hi all,
>>
>> as the subject already says: I face some warning of the nucleus (with
>> XENO_OPT_DEBUG on - useful switch) when I call xnpod_delete_thread for a
>> thread which has already terminated itself by leaving the thread
>> function. Is this double-deletion illegal? Or is it a cleanup-bug of the
>> nucleus?
> 
> 
> We could test the XNZOMBIE bit in xnpod_delete_thread() to prevent this,
> I guess.
> 

Would be better, I think. Otherwise, at least xnpod_delete_thread and
also rtdm_task_destroy would require a clear warning sign.

I was not aware of this restriction, so I did not worked around it in
RTnet - which is easy at RTDM level BTW: task wakeup for
self-termination + rtdm_task_join_nrt. This is cleaner anyway, so I will
patch RTnet now.

Jan

--------------enig7DF14B6D27291FF52932925D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDjh/1niDOoMHTA+kRAtWgAJ9F/MGzGacxMjdLrGMmpLdNXiqqiwCff1Bs
yH4P6VQskkIn3OmEzUJoyEA=
=S9x7
-----END PGP SIGNATURE-----

--------------enig7DF14B6D27291FF52932925D--

