Message-ID: <4533AA30.5020001@domain.hid>
Date: Mon, 16 Oct 2006 17:50:08 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Problem with rt_queue
References: <20061016153937.54204.qmail@domain.hid>
In-Reply-To: <20061016153937.54204.qmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAC95C0B7D61E4BE80F515618"
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
To: mani bhatti <imranbashirbhatti@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAC95C0B7D61E4BE80F515618
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

mani bhatti wrote:
> Hi all
> I am trying to broadcast a message to a queue  from a producer by using=
 function=20
>=20
> rt_queue_send(&queue_input, msg,sizeof(TInputData), Q_BROADCAST);
>=20
> I have two consumers waiting for the data from producer but the problem=
 is producer is not broadcasting actually to all consumers and  at one ti=
me if i run both consumers than only one of the consumer receives the dat=
a from producer the other consumer receives nothing and remains blank (th=
e consumer which receives data from queue  is not fixed it is arbitrary).=
If some one has encountered the problem before please advice me in this r=
egard-Thanks all.The producer code is given below
>=20
>  while(!end){
>                rt_task_wait_period();
>                void *msg =3D rt_queue_alloc(&queue_input, sizeof(TInput=
Data));
>                 if(msg =3D=3D NULL) {
>                         printf("rt_queue_alloc(queue_inout, %d) failed\=
n",sizeof(TInputData));
>                      }
>                 memcpy(msg, &sendData, sizeof(TInputData));
>                 int bytesSent =3D rt_queue_send(&queue_input,msg,sizeof=
(TInputData), Q_BROADCAST);
>                 if (bytesSent <=3D 0) {
>                         printf("rt_queue_send(queue_input) failed: %d\n=
", bytesSent);
>                         rt_queue_free(&queue_input, msg);
>                 }
>                 sendData.counter++;
>         }
>=20

May I cite myself?

https://mail.gna.org/public/xenomai-help/2006-10/msg00032.html

Don't get me wrong, your observation might very well have revealed a
Xenomai bug, but it is *far* easier for us poor hackers to analyse and
discuss the issue based on *common* test code.

Thanks,
Jan


--------------enigAC95C0B7D61E4BE80F515618
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFM6owniDOoMHTA+kRAohMAJ9oUuOuLENVjMNUGaRHRiwutV7dIwCfYqok
/ky4wMCZ5cYHW7EwKOnu5dM=
=Yi+N
-----END PGP SIGNATURE-----

--------------enigAC95C0B7D61E4BE80F515618--

