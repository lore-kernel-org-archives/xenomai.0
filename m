Message-ID: <4AC45D39.3010605@domain.hid>
Date: Thu, 01 Oct 2009 09:41:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AC1BCF9.8050908@domain.hid> <4AC4561B.5070004@domain.hid>
	<4AC45853.2040107@domain.hid>
In-Reply-To: <4AC45853.2040107@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA7DC84C78CA1C83751886562"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [bug] accept() in non-blocking mode fails with
 EPERM instead of EAGAIN
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA7DC84C78CA1C83751886562
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Matthieu Nottale wrote:
>>> Hi,
>>>
>>> I believe I found a bug in the Xenomai Posix skin while trying to use=

>>> boost::asio: The accept() call in asychronous mode
>>> fails with ENOPEM instead of EAGAIN. Other than that, the call 'works=
'
>>> in the sense that calling it again after a connection is established
>>> returns a new file descriptor.
>> On what kind of file descriptor descriping what kind of socket are you=

>> calling accept()? So far I'm not aware of any RTDM driver providing th=
e
>> corresponding service - well, at least not a public one (our RT-TCP
>> stack is yet to be released). Or is it intended to pass the call to
>> plain Linux, switching the caller into secondary more?
>=20
> There's a sample attached. Yes, it is a TCP stream. Howeve accept is
> wrapped, so it may happen that EPERM is the result of the wrapping.
>=20

Oops, missed that. Indeed, patch below should fix it.

Jan

diff --git a/src/skins/posix/rtdm.c b/src/skins/posix/rtdm.c
index 6e347fb..4e6685f 100644
--- a/src/skins/posix/rtdm.c
+++ b/src/skins/posix/rtdm.c
@@ -404,18 +404,21 @@ int __wrap_accept(int fd, struct sockaddr *addr, so=
cklen_t * addrlen)
=20
 		pthread_setcanceltype(oldtype, NULL);
=20
-		if (fd >=3D 0)
-			fd +=3D __rtdm_fd_start;
+		if (fd < 0)
+			return set_errno(fd);
+
+		return fd + __rtdm_fd_start;
 	} else {
 		fd =3D __real_accept(fd, addr, addrlen);
=20
 		if (fd >=3D __rtdm_fd_start) {
 			__real_close(fd);
-			fd =3D -EMFILE;
+			errno =3D EMFILE;
+			fd =3D -1;
 		}
-	}
=20
-	return set_errno(fd);
+		return fd;
+	}
 }
=20
 int __wrap_getsockname(int fd, struct sockaddr *name, socklen_t * namele=
n)


--------------enigA7DC84C78CA1C83751886562
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkrEXT0ACgkQitSsb3rl5xSTOwCfQQCRD8W1d3C1wfQ8TFSsbMdK
8n8An2ZD/vGxB7RCZWFjLinOQtUuBPX2
=T9oN
-----END PGP SIGNATURE-----

--------------enigA7DC84C78CA1C83751886562--

