Date: Sat, 9 Sep 2006 03:15:33 +0200
From: Bernhard Walle <bernhard.walle@domain.hid>
Message-ID: <20060909011533.GE1192@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k4f25fnPtRuIRUb3"
Content-Disposition: inline
Subject: [Xenomai-core] tdm_event_timedwait documentation
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

IMO the documentation of tdm_event_timedwait is a bit unclear. There
are two timeout values: the timeout and the timeout sequence. After
reading the source code the behaviour is clear but from documentation
I would have expected following behaviour:

   - the sequence timeout is the sum of the timeouts over all calls
     (which is in case)

   - the timeout in the parameter is the maximum timeout of this call
     (which is not in case)

If I didn't get the source code totally wrong

        if (timeout < 0) {
            err =3D -EWOULDBLOCK;
            goto unlock_out;
        }

        if (timeout_seq && (timeout > 0)) {
            /* timeout sequence */
            timeout =3D *timeout_seq - xnpod_get_time();
            if (unlikely(timeout <=3D 0)) {
                err =3D -ETIMEDOUT;
                goto unlock_out;
            }
            xnsynch_sleep_on(&event->synch_base, timeout);
        } else {
            /* infinite or relative timeout */
            xnsynch_sleep_on(&event->synch_base, xnpod_ns2ticks(timeout));
        }

the timeout value is only interesting if RTDM_TIMEOUT_NONE or
RTDM_TIMEOUT_INFINITE otherwise it's not relevant because it's
overwritten by the value of the timeout sequence. That should be
expressed in the documentation.

Maybe

 * @param[in] timeout Relative timeout, see
 * @ref RTDM_TIMEOUT_xxx for special values (any positive value
 * means the timeout specified in the timeout sequence)

or something like that.


Regards,
  Bernhard

PS: As there are more and more RTDM-related questions (not only from
me :)) -- what do you think about a mailing list for real-time drivers
only? Which means a common list for RTAI and Xenomai.=20

Because I'm using both systems for evaluation I'm always a bit unsure
to which list I should write (well, if it's not RTAI specified I wrote
to the Xenomai list because I know you're working on Xenomai and the
RTAI implementation is from Paolo Mantegazza ;)).
--=20
"Freedom is just another word for nothing left to lose,
Nothing don't mean nothing honey if it ain't free, now now.
And feeling good was easy, Lord, when Bobby sang the blues,
You know feeling good was good enough for me,
Good enough for me and my Bobby McGee."        -- Janis Joplin

--k4f25fnPtRuIRUb3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBRQIVr+iVHo+2lFT9AQLGmgP7BRkh0JklfS/4DJPQ/r81ctgn8NQ+GB8W
9ydBqoEflCAr3nQYWrYyky0O0Qnx3x1b2XglEEM+1nQeAjj1W2dfDYquqGXzSYK9
ytP2qLaEaD+2WJmq7BN3kCCe98qoCatLxUoeQ+23E9jbd1d8wUBRhGQao8/WpVZI
NacH7Evp8r4=
=Tf34
-----END PGP SIGNATURE-----

--k4f25fnPtRuIRUb3--

