Message-ID: <453FEA27.3020705@domain.hid>
Date: Thu, 26 Oct 2006 00:50:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Problem with rt_queue
References: <20061025143438.30247.qmail@domain.hid>
In-Reply-To: <20061025143438.30247.qmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7DEB1B5AC411EE95A975DA7C"
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
--------------enig7DEB1B5AC411EE95A975DA7C
Content-Type: multipart/mixed; boundary="------------090302010102070301010007"

This is a multi-part message in MIME format.
--------------090302010102070301010007
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

mani bhatti wrote:
> Hi Phillipe and Jan=20
> Thanks a lot for your help.I am sending the compilable
> source code so that you have an idea what wrong am i
> doing.I am sending the listeners which are listening
> to the same queue at the same time.But i dont know why
> at one time only one listener receives data from
> sender queue inspite of that i am using broadcast
> mode.Thanks a lot.I have attached files for sender and
> listener.

Well, interesting test case. It actually revealed bugs, but not where
expected.

Your problem is a simple bug in the listener tests. They both register a
task of the name "beta", only the first one succeeds (your code is a bit
hackish in this regard - when hunting problems, make sure to check ALL
return codes for potential problems!). Once fixed, your code runs fine he=
re.

Nevertheless, queue_sender by itself uncovered a problem of
rt_queue_send in broadcast mode when no one is listening. The message
reference count got messed up and the queue ran out of memory. The
attached patch fixes it:

Jan

--------------090302010102070301010007
Content-Type: text/x-patch;
 name="native-queue-bcast-fix.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="native-queue-bcast-fix.patch"

Index: ksrc/skins/native/queue.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/native/queue.c	(Revision 1747)
+++ ksrc/skins/native/queue.c	(Arbeitskopie)
@@ -631,7 +631,9 @@ int rt_queue_send(RT_QUEUE *q, void *mbu
 			prependq(&q->pendq, &msg->link);
 		else
 			appendq(&q->pendq, &msg->link);
-	}
+	} else
+		/* Ownership did not change, so update reference count. */
+		msg->refcount++;
=20
 	err =3D nrecv;
=20
Index: ChangeLog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ChangeLog	(Revision 1748)
+++ ChangeLog	(Arbeitskopie)
@@ -1,3 +1,8 @@
+2006-10-26  Jan Kiszka  <jan.kiszka@domain.hid>
+
+	* ksrc/skins/native/queue.c (rt_queue_send): Track message count
+	correctly when broadcasting to a queue without listeners.
+
 2006-10-25  Jan Kiszka  <jan.kiszka@domain.hid>
=20
 	* ksrc/drivers/testing/irqbench.c, doc/txt/irqbench.txt,

--------------090302010102070301010007--

--------------enig7DEB1B5AC411EE95A975DA7C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFP+ooniDOoMHTA+kRAn/eAJ90ojoiffHymYCO1Nsa4UhyuIk0BACfUcR/
P9Ce440iro31G/RVhWH/WdI=
=k1aK
-----END PGP SIGNATURE-----

--------------enig7DEB1B5AC411EE95A975DA7C--

