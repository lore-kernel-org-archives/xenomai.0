Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 31 Jul 2008 12:45:52 +0200
Message-ID: <406CC9939904F143B9D42CEEA3E56E563AC093@domain.hid>
References: <406CC9939904F143B9D42CEEA3E56E563AC067@domain.hid>	<48918FF9.6030804@domain.hid>
	<406CC9939904F143B9D42CEEA3E56E563AC08E@oab1mx1.oneaccess.intra>
	<489194FD.8000004@domain.hid>
From: "Filip Van Rillaer" <Filip.VanRillaer@domain.hid>
Subject: Re: [Xenomai-help] xnpipe EPOLLIN starvation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Hello Gilles,

Thanks, but unfortunately it doesn't cure the problem.

Best regards,
Filip=20

-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org
Sent: 31 July 2008 12:34
To: Filip Van Rillaer
Cc: Gilles Chanteperdrix; xenomai@xenomai.org
Subject: Re: [Xenomai-help] xnpipe EPOLLIN starvation

Filip Van Rillaer wrote:
> Hello Gilles,
>=20
> EPOLLET is indeed enabled.
> The first time EPOLLIN is received in the 2nd domain, I do a read (it=20
> receives 1 byte in a buffer of 256).  So the read is exhausted and I=20
> expect that the next time data arrives I should get the EPOLLIN (as it

> BECOMES readable).  But even adding another read (which returns=20
> -EAGAIN) did not make it possible to receive the EPOLLIN when a little

> bit later data is written at the Xenomai side of the xnpipe.
>=20

Does this help?

--- ksrc/nucleus/pipe.c	(revision 4044)
+++ ksrc/nucleus/pipe.c	(working copy)
@@ -1029,9 +1029,12 @@
 {
 	xnpipe_state_t *state =3D (xnpipe_state_t *)file->private_data;
 	unsigned r_mask =3D 0, w_mask =3D 0;
+	spl_t s;

 	poll_wait(file, &state->readq, pt);

+	xnlock_get_irqsave(&nklock, s);
+
 	if (testbits(state->status, XNPIPE_KERN_CONN))
 		w_mask |=3D (POLLOUT | POLLWRNORM);

@@ -1046,6 +1049,8 @@
 		 */
 		xnpipe_enqueue_wait(state, XNPIPE_USER_WREAD);

+	xnlock_put_irqrestore(&nklock, s);
+
 	/*
 	 * A descriptor is always ready for writing with the current
 	 * implementation, so there is no need to have/handle the

--
Philippe.

