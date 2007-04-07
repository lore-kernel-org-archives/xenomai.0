Message-ID: <46177761.2000806@domain.hid>
Date: Sat, 07 Apr 2007 12:50:09 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD0E08FAB34392DC6C3A0D9E3"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] fix native ppd cleanup
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
--------------enigD0E08FAB34392DC6C3A0D9E3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Not beautiful, but required.

For a bean-counting approach, we could also make xeno_resource_holder ele=
ments conditional.


Index: xenomai/ksrc/skins/native/syscall.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/native/syscall.c
+++ xenomai/ksrc/skins/native/syscall.c
@@ -3818,15 +3818,33 @@ static void *__shadow_eventcb(int event,
 	case XNSHADOW_CLIENT_DETACH:
=20
 		rh =3D ppd2rholder((xnshadow_ppd_t *) data);
+#ifdef CONFIG_XENO_OPT_NATIVE_ALARM
 		__native_alarm_flush_rq(&rh->alarmq);
+#endif
+#ifdef CONFIG_XENO_OPT_NATIVE_COND
 		__native_cond_flush_rq(&rh->condq);
+#endif
+#ifdef CONFIG_XENO_OPT_NATIVE_EVENT
 		__native_event_flush_rq(&rh->eventq);
+#endif
+#ifdef CONFIG_XENO_OPT_NATIVE_HEAP
 		__native_heap_flush_rq(&rh->heapq);
+#endif
+#ifdef CONFIG_XENO_OPT_NATIVE_INTR
 		__native_intr_flush_rq(&rh->intrq);
+#endif
+#ifdef CONFIG_XENO_OPT_NATIVE_MUTEX
 		__native_mutex_flush_rq(&rh->mutexq);
+#endif
+#ifdef CONFIG_XENO_OPT_NATIVE_PIPE
 		__native_pipe_flush_rq(&rh->pipeq);
+#endif
+#ifdef CONFIG_XENO_OPT_NATIVE_QUEUE
 		__native_queue_flush_rq(&rh->queueq);
+#endif
+#ifdef CONFIG_XENO_OPT_NATIVE_SEM
 		__native_sem_flush_rq(&rh->semq);
+#endif
=20
 		xnarch_sysfree(rh, sizeof(*rh));
=20


--------------enigD0E08FAB34392DC6C3A0D9E3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGF3dmniDOoMHTA+kRAu0yAJ4s4TG7LywH+Czj9dSmtal9jgN2+QCfQD/1
4XTp2lwCj69d3AVMPXQB2bE=
=xe+2
-----END PGP SIGNATURE-----

--------------enigD0E08FAB34392DC6C3A0D9E3--

