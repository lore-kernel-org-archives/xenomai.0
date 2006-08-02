Message-ID: <44D0F5DE.3010508@domain.hid>
Date: Wed, 02 Aug 2006 20:58:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Re: problem with reading from rt_pipe with a normal
	linux process
References: <eaqrtk$vkb$1@domain.hid> <eaqsbk$vkb$2@domain.hid>
In-Reply-To: <eaqsbk$vkb$2@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAB1873AA9EA7CFC023062B81"
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
To: Marco Jackel <ich@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAB1873AA9EA7CFC023062B81
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Marco Jackel wrote:
> Mhmm, strange, I can read the data with a "cat /dev/rtp0"....
>=20

Hint: read returns its error code in errno. What does that one tell you?

Jan

>=20
> Marco Jackel wrote:
>> Hi,
>> i do the following:
>>
>> - create a pipe:
>>
>> rt_pipe_create (&data_pipe, "data_pipe", PIPE_MINOR, PIPE_SIZE);
>>
>> - write data to the pipe:
>>
>> rt_pipe_write(&data_pipe, &pipe_buf, pipe_buf_sz, P_NORMAL);
>>
>> - open the pipe from a normal linux process:
>>
>> pipe_fd =3D open(DATA_PIPE, O_RDONLY);
>>
>> - read the data from the pipe:
>>
>> ret =3D read(pipe_fd, &pipe_buf, sizeof(pipe_buf));
>>
>>
>> Opening works, but the reading doesn't work. I get the error code "-1"=
,
>> Operation not permitted.
>>
>> Permission for the device file is ok:
>>
>> voyage:~# ls -l /dev/rtp0
>> crw-rw-rw-  1 root root 150, 0 Jun 21  2006 /dev/rtp0
>>
>>
>> What am I doing wrong?
>>
>> Thanks
>> Marco
>>
>>
>> Linux voyage 2.6.16.1-03-xenomai-2.1.2 #1 PREEMPT Tue Jul 11 10:17:15
>> GMT 2006 i586 GNU/Linux
>>
>> Gnu C                  17:
>> util-linux             2.12p
>> mount                  2.12p
>> module-init-tools      3.2-pre1
>> e2fsprogs              1.37
>> pcmcia-cs              3.2.5
>> PPP                    2.4.3
>> Linux C Library        2.3.2
>> Dynamic linker (ldd)   2.3.2
>> Procps                 3.2.1
>> Net-tools              1.60
>> Kbd                    69:
>> Sh-utils               5.2.1
>> Modules Loaded         xeno_16550A xeno_rtdm uhci_hcd ohci_hcd usbcore=

>> dm_mod
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help



--------------enigAB1873AA9EA7CFC023062B81
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE0PXeniDOoMHTA+kRAspwAJ913min4ljXAQoObHayxOXorrLhogCfQID7
jUKJHD3Abk+DSLDsM+DDZpI=
=5+Iu
-----END PGP SIGNATURE-----

--------------enigAB1873AA9EA7CFC023062B81--

