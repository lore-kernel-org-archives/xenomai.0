From: Stefan Kisdaroczi <kisda@domain.hid>
Date: Wed, 11 Jan 2006 22:56:35 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1384735.Kv09EBNrhe";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601112256.41723.kisda@domain.hid>
Subject: [Xenomai-help] question about task migrating to primary mode
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

--nextPart1384735.Kv09EBNrhe
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I have a question about migrating a task to primary mode.

=46ollowing code is from Captain's  "Hard Real Time Serial Port (RS232)=20
Example" [1]:
=2E..
  while (1) {
    /* switch to primary mode */
    ret =3D rt_task_set_mode(0, T_PRIMARY, NULL);
    if (ret) {
      printf(WTASK_PREFIX "error while rt_task_set_mode, code %d\n",ret);
      goto exit_write_task;
    }
    ret =3D rt_task_wait_period();
    if (ret) {
      printf(WTASK_PREFIX "error while rt_task_wait_period, code %d\n",ret);
      goto exit_write_task;
    }
    sz =3D sizeof(buf);
    written =3D rt_dev_write(my_fd, &buf, sizeof(buf));
    printf(WTASK_PREFIX "rt_dev_write written=3D%d sz=3D%d\n", written, sz);
    if (written !=3D sz ) {
      if (written < 0 ) {
        printf(WTASK_PREFIX "error while rt_dev_write, code %d\n",written);
      } else {
        printf(WTASK_PREFIX "only %d / %d byte transmitted\n",written, sz);
      }
      goto exit_write_task;
    }
  }
=2E..

Is the rt_task_set_mode(0, T_PRIMARY, NULL) call really necessary?
I seems the call is used here to migrate to task back to primary mode if a=
=20
error-"printf" switched the task to secondary mode.

=46rom the "Native API Tour"-Document, page 8 [2]:
"By=A0convention,=A0all=A0Xenomai=A0services=A0which
might=A0block=A0the=A0caller=A0cause=A0such=A0transition=A0when=A0necessary=
;=A0in=A0other=A0words,=A0real=AD
time=A0tasks=A0blocked=A0on=A0Xenomai=A0resources=A0are=A0always=A0aslept=
=A0in=A0primary=A0mode."

As the next call is rt_task_wait_period which should block, i think its not=
=20
necessary to force a migration "by hand" to primary mode. Is this true ?

Thank you Hannes for all your examples.

Thanks
kisda

[1] http://www.captain.at/xenomai-serial-port-example.php
[2]=20
http://snail.fsffrance.org/www.xenomai.org/documentation/branches/v2.0.x/pd=
f/Native-API-Tour.pdf

--nextPart1384735.Kv09EBNrhe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDxX8ZIPTw9rIdn6oRAsU7AJ98wh1CEJaR1Z7rODvCzu6P8RI4uQCfQy+g
kcIUP7sCxQBOCsiWVQ5/6Pw=
=LovT
-----END PGP SIGNATURE-----

--nextPart1384735.Kv09EBNrhe--

