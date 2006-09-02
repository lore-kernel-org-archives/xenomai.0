Date: Sat, 2 Sep 2006 13:49:16 +0200
From: Bernhard Walle <bernhard.walle@domain.hid>
Message-ID: <20060902114916.GB4486@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
Subject: [Xenomai-help] Question about interrupt propagation to Linux
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I have a question about interrupt propagation to Linux with the
XN_ISR_PROPAGATE return value in the real-time interrupt handler.

My question is: is the particular IRQ (not other IRQs) that is handled
by this ISR re-enabled after the *RT* ISR finished or is it re-enabled
after the *Linux* ISR has finished. In my understanding the interrupt
cannot be enabled after the RT-ISR because then the RT-ISR handler
would be called again and the Linux ISR would never have a chance to
run.

Thanks.


Regards,
  Bernhard
--=20
At least Microsoft offers updates to keep your selection of bugs fresh.
        -- Alan Shutko, hating Corel even more, in asr

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBRPlvs+iVHo+2lFT9AQJVQAP/bn1GxLHtXxWjSQslWMsNCLwb/zA5lpFR
UtyuD8kmveqRVu0syBns5GYOH+Xs22bAf5Y1Rjmg0Ncx49nOHHMgThPYm7G1g175
UsTscIEhkegeDkadHBdzj/nyG9J9dhiOQc8g1fNldnJieha5cuaHdSCBEsFbxVBh
FqIFuI4fsX4=
=Pskz
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--

