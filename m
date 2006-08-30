Message-ID: <44F5FA88.3030206@domain.hid>
Date: Wed, 30 Aug 2006 22:52:24 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig58F468753255A2271FD8E97C"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] refactor and enhance rtcanrecv/send
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>, Wolfgang Grandegger <wg@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig58F468753255A2271FD8E97C
Content-Type: multipart/mixed; boundary="------------060700000608040107080407"

This is a multi-part message in MIME format.
--------------060700000608040107080407
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

For review:

This patch folds the rt-threads of rtcanrecv/send into the main thread,
assigns unique thread names, and lowers the priorities to some less
critical level. Furthermore, rtcanrecv is enhanced by a printout of the
CAN device and support for listening on all interfaces. On reception of
RTR frames, no more data is printing now. I also kicked out the
rt_timer_set_mode call, please speak up if it was there for a reason.

Jan

--------------060700000608040107080407
Content-Type: text/x-patch;
 name="rtcan-utils.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="rtcan-utils.patch"

Index: src/utils/can/rtcansend.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/utils/can/rtcansend.c	(Revision 1525)
+++ src/utils/can/rtcansend.c	(Arbeitskopie)
@@ -69,7 +69,7 @@ void cleanup_and_exit(int sig)
     exit(0);
 }
=20
-void rt_task(void *arg)
+void rt_task(void)
 {
     int i, j, ret;
=20
@@ -107,7 +107,6 @@ void rt_task(void *arg)
 	    printf("\n");
 	}
     }
-    loops =3D 0;
 }
=20
 int main(int argc, char **argv)
@@ -115,6 +114,7 @@ int main(int argc, char **argv)
     struct sockaddr_can addr;
     int i, opt, ret;
     struct ifreq ifr;
+    char name[32];
=20
     struct option long_options[] =3D {
 	{ "help", no_argument, 0, 'h' },
@@ -252,16 +252,14 @@ int main(int argc, char **argv)
 	}
     }
=20
-     rt_timer_set_mode(TM_ONESHOT);
-
-    ret =3D rt_task_spawn(&rt_task_desc, "", 0, 99, 0, &rt_task, 0);
+    snprintf(name, sizeof(name), "rtcansend-%d", getpid());
+    ret =3D rt_task_shadow(&rt_task_desc, name, 1, 0);
     if (ret) {
-        fprintf(stderr, "rt_task_spawn: %s\n", strerror(-ret));
+	fprintf(stderr, "rt_task_shadow: %s\n", strerror(-ret));
 	goto failure;
     }
=20
-    while (loops)
-	usleep(100000);
+    rt_task();
=20
     cleanup();
     return 0;
Index: src/utils/can/rtcanrecv.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/utils/can/rtcanrecv.c	(Revision 1525)
+++ src/utils/can/rtcanrecv.c	(Arbeitskopie)
@@ -15,14 +15,13 @@
 static void print_usage(char *prg)
 {
     fprintf(stderr,
-	    "Usage: %s <can-interface> [Options]\n"
+	    "Usage: %s [<can-interface>] [Options]\n"
 	    "Options:\n"
 	    " -f  --filter=3Did:mask[:id:mask]... apply filter\n"
 	    " -e  --error=3Dmask      receive error messages\n"
 	    " -t, --timeout=3DMS      timeout in ms\n"
 	    " -v, --verbose         be verbose\n"
 	    " -p, --print=3DMODULO    print every MODULO message\n"
-	    " -n, --name=3DSTRING     name of the RT task\n"
 	    " -h, --help            this help\n",
 	    prg);
 }
@@ -30,7 +29,7 @@ static void print_usage(char *prg)
=20
 extern int optind, opterr, optopt;
=20
-static int s =3D -1, running =3D 1, verbose =3D 0, print =3D 1;
+static int s =3D -1, verbose =3D 0, print =3D 1;
 static nanosecs_rel_t timeout =3D 0;
=20
 RT_TASK rt_task_desc;
@@ -75,18 +74,20 @@ void cleanup_and_exit(int sig)
 {
     if (verbose)
 	printf("Signal %d received\n", sig);
-    running =3D 0;
     cleanup();
     exit(0);
 }
=20
-void rt_task(void *arg)
+void rt_task(void)
 {
     int i, ret, count =3D 0;
     struct can_frame frame;
+    struct sockaddr_can addr;
+    socklen_t addrlen =3D sizeof(addr);
=20
-    while (running) {
-	ret =3D rt_dev_recv(s, (void *)&frame, sizeof(can_frame_t), 0);
+    while (1) {
+	ret =3D rt_dev_recvfrom(s, (void *)&frame, sizeof(can_frame_t), 0,
+	                      (struct sockaddr *)&addr, &addrlen);
 	if (ret < 0) {
 	    switch (ret) {
 	    case -ETIMEDOUT:
@@ -100,12 +101,11 @@ void rt_task(void *arg)
 	    default:
 		fprintf(stderr, "rt_dev_recv: %s\n", strerror(-ret));
 	    }
-	    running =3D 0;
 	    break;
 	}
=20
 	if (print && (count % print) =3D=3D 0) {
-	    printf("#%d: ", count);
+	    printf("#%d: (%d) ", count, addr.can_ifindex);
 	    if (frame.can_id & CAN_ERR_FLAG)
 		printf("!0x%08x!", frame.can_id & CAN_ERR_MASK);
 	    else if (frame.can_id & CAN_EFF_FLAG)
@@ -114,9 +114,10 @@ void rt_task(void *arg)
 		printf("<0x%03x>", frame.can_id & CAN_SFF_MASK);
=20
 	    printf(" [%d]", frame.can_dlc);
-	    for (i =3D 0; i < frame.can_dlc; i++) {
-		printf(" %02x", frame.data[i]);
-	    }
+	    if (!(frame.can_id & CAN_RTR_FLAG))
+		for (i =3D 0; i < frame.can_dlc; i++) {
+		    printf(" %02x", frame.data[i]);
+		}
 	    if (frame.can_id & CAN_ERR_FLAG) {
 		printf(" ERROR ");
 		if (frame.can_id & CAN_ERR_BUSOFF)
@@ -138,6 +139,7 @@ int main(int argc, char **argv)
     u_int32_t err_mask =3D 0;
     struct ifreq ifr;
     char *ptr;
+    char name[32];
=20
     struct option long_options[] =3D {
 	{ "help", no_argument, 0, 'h' },
@@ -153,7 +155,7 @@ int main(int argc, char **argv)
     signal(SIGTERM, cleanup_and_exit);
     signal(SIGINT, cleanup_and_exit);
=20
-    while ((opt =3D getopt_long(argc, argv, "hve:f:t:p:n:",
+    while ((opt =3D getopt_long(argc, argv, "hve:f:t:p:",
 			      long_options, NULL)) !=3D -1) {
 	switch (opt) {
 	case 'h':
@@ -200,19 +202,6 @@ int main(int argc, char **argv)
 	}
     }
=20
-    if (optind =3D=3D argc) {
-	print_usage(argv[0]);
-	exit(0);
-    }
-
-    if (argv[optind] =3D=3D NULL) {
-	fprintf(stderr, "No Interface supplied\n");
-	exit(-1);
-    }
-
-    if (verbose)
-	printf("interface %s\n", argv[optind]);
-
     ret =3D rt_dev_socket(PF_CAN, SOCK_RAW, 0);
     if (ret < 0) {
 	fprintf(stderr, "rt_dev_socket: %s\n", strerror(-ret));
@@ -220,17 +209,26 @@ int main(int argc, char **argv)
     }
     s =3D ret;
=20
-    strncpy(ifr.ifr_name, argv[optind], IFNAMSIZ);
-    if (verbose)
-	printf("s=3D%d, ifr_name=3D%s\n", s, ifr.ifr_name);
+    if (argv[optind] =3D=3D NULL) {
+	if (verbose)
+	    printf("interface all\n");
=20
-    ret =3D rt_dev_ioctl(s, SIOCGIFINDEX, &ifr);
-    if (ret < 0) {
-	fprintf(stderr, "rt_dev_ioctl GET_IFINDEX: %s\n", strerror(-ret));
-	goto failure;
+	ifr.ifr_ifindex =3D 0;
+    } else {
+	if (verbose)
+	    printf("interface %s\n", argv[optind]);
+=09
+	strncpy(ifr.ifr_name, argv[optind], IFNAMSIZ);
+	if (verbose)
+	    printf("s=3D%d, ifr_name=3D%s\n", s, ifr.ifr_name);
+=09
+	ret =3D rt_dev_ioctl(s, SIOCGIFINDEX, &ifr);
+	if (ret < 0) {
+	    fprintf(stderr, "rt_dev_ioctl GET_IFINDEX: %s\n", strerror(-ret));
+	    goto failure;
+	}
     }
=20
-
     if (err_mask) {
 	ret =3D rt_dev_setsockopt(s, SOL_CAN_RAW, CAN_RAW_ERR_FILTER,
 				&err_mask, sizeof(err_mask));
@@ -271,19 +269,15 @@ int main(int argc, char **argv)
 	}
     }
=20
-    rt_timer_set_mode(TM_ONESHOT);
-
-    ret =3D rt_task_spawn(&rt_task_desc, "", 0, 99, 0, &rt_task, 0);
+    snprintf(name, sizeof(name), "rtcanrecv-%d", getpid());
+    ret =3D rt_task_shadow(&rt_task_desc, name, 1, 0);
     if (ret) {
-        fprintf(stderr, "rt_task_spawn: %s\n", strerror(-ret));
+	fprintf(stderr, "rt_task_shadow: %s\n", strerror(-ret));
 	goto failure;
     }
=20
-    while (running)
-	usleep(100000);
-
-    cleanup();
-    return 0;
+    rt_task();
+    /* never returns */
=20
  failure:
     cleanup();

--------------060700000608040107080407--

--------------enig58F468753255A2271FD8E97C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFE9fqJniDOoMHTA+kRAn8lAJ9g3CFYuRzic2qvlRozMsPAS6ex3QCfSirI
JGQ68SqqjtykclQallf7Vd4=
=5L34
-----END PGP SIGNATURE-----

--------------enig58F468753255A2271FD8E97C--

