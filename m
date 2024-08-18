Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A9817C98
	for <xenomai@lists.linux.dev>; Sun, 18 Aug 2024 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723980022; cv=none; b=U05JRq1oYZw1JKmRHFoRbatznFQIlyhbRrV+YoxTaoQSKhwR7o6Uj6JQwANdZYVGbaQum0xxMAYROsll+qtyEOW1geg4NF/vqfWoG3nmTI7LEiZKZQKe67SKczonho9L7XwzlgM6RHCYpvKno4/h9jcfV/5JaEFjbZxLINwnmGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723980022; c=relaxed/simple;
	bh=Fz6VlYQfFnj91i2Xno6JtoPdvHtFrbS6Q81kvENBk00=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a4G/mMVOCkvujpqyPyIL3zoYBCr8z3qS9rceeWOisigCg45jAyI77xoVF6aNMXSrN8qKvwR3Qdg3GqNpmv+c+Be4gj/DmFQpPd5fF7Q20x70X+XUCMtk3GsShFY/RVDbAYesHJcCGPvCOueJArrk4aKAaH1mUcYsWWc1psgia0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8A43E62A866A;
	Sun, 18 Aug 2024 13:12:23 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id wWbkWPN2-cpG; Sun, 18 Aug 2024 13:12:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id EA7B362A869A;
	Sun, 18 Aug 2024 13:12:22 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JAPOvI_QtFv0; Sun, 18 Aug 2024 13:12:22 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id BFC9262A866A;
	Sun, 18 Aug 2024 13:12:22 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH] iddp-sendrecv: Make it configurable
Date: Sun, 18 Aug 2024 13:12:08 +0200
Message-Id: <20240818111208.19026-1-richard@nod.at>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

By making it configurable, iddp-sendrecv can act as a powerful
tool to debug IDDP related issues in Xenomai.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 demo/posix/cobalt/iddp-sendrecv.c | 193 +++++++++++++++++++++++++-----
 1 file changed, 164 insertions(+), 29 deletions(-)

diff --git a/demo/posix/cobalt/iddp-sendrecv.c b/demo/posix/cobalt/iddp-s=
endrecv.c
index 6cec083a4..e2ee9ce15 100644
--- a/demo/posix/cobalt/iddp-sendrecv.c
+++ b/demo/posix/cobalt/iddp-sendrecv.c
@@ -26,6 +26,7 @@
  * optional.
  */
=20
+#include <argp.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -37,7 +38,15 @@
 #include <rtdm/ipc.h>
 #include <boilerplate/ancillaries.h>
=20
-pthread_t svtid, cltid;
+#define MODE_SERVER 0x1
+#define MODE_CLIENT 0x2
+
+static pthread_t svtid, cltid;
+static int mode;
+static int send_delay_ms;
+static int send_timeout_ms;
+static int max_messages;
+static size_t poolsz =3D SIZE_MAX;
=20
 #define IDDP_SVPORT 12
 #define IDDP_CLPORT 13
@@ -71,24 +80,26 @@ static void *server(void *arg)
 {
 	struct sockaddr_ipc saddr, claddr;
 	socklen_t addrlen;
+	unsigned int i;
 	char buf[128];
-	size_t poolsz;
 	int ret, s;
=20
 	s =3D socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_IDDP);
 	if (s < 0)
 		fail("socket");
=20
-	/*
-	 * Set a local 32k pool for the server endpoint. Memory needed
-	 * to convey datagrams will be pulled from this pool, instead
-	 * of Xenomai's system pool.
-	 */
-	poolsz =3D 32768; /* bytes */
-	ret =3D setsockopt(s, SOL_IDDP, IDDP_POOLSZ,
-			 &poolsz, sizeof(poolsz));
-	if (ret)
-		fail("setsockopt");
+	if (poolsz) {
+		/*
+		 * Set a local pool for the server endpoint. Memory needed
+		 * to convey datagrams will be pulled from this pool, instead
+		 * of Xenomai's system pool.
+		 */
+		poolsz *=3D 1024; /* bytes */
+		ret =3D setsockopt(s, SOL_IDDP, IDDP_POOLSZ,
+				 &poolsz, sizeof(poolsz));
+		if (ret)
+			fail("setsockopt");
+	}
=20
 	saddr.sipc_family =3D AF_RTIPC;
 	saddr.sipc_port =3D IDDP_SVPORT;
@@ -96,7 +107,7 @@ static void *server(void *arg)
 	if (ret)
 		fail("bind");
=20
-	for (;;) {
+	for (i =3D 0;;) {
 		addrlen =3D sizeof(saddr);
 		ret =3D recvfrom(s, buf, sizeof(buf), 0,
 			       (struct sockaddr *)&claddr, &addrlen);
@@ -106,8 +117,15 @@ static void *server(void *arg)
 		}
 		printf("%s: received %d bytes, \"%.*s\" from port %d\n",
 		       __FUNCTION__, ret, ret, buf, claddr.sipc_port);
+
+		if (max_messages && ++i >=3D max_messages) {
+			printf("%s: stop receiving after %u messages\n",
+			__FUNCTION__, i);
+			goto out;
+		}
 	}
=20
+out:
 	return NULL;
 }
=20
@@ -121,6 +139,16 @@ static void *client(void *arg)
 	if (s < 0)
 		fail("socket");
=20
+	if (send_timeout_ms) {
+		struct timeval tv;
+
+		tv.tv_sec =3D send_timeout_ms / 1000;
+		tv.tv_usec =3D (send_timeout_ms % 1000) * 1000;
+		ret =3D setsockopt(s, SOL_SOCKET, SO_SNDTIMEO, &tv, sizeof(tv));
+		if (ret)
+			fail("setsockopt");
+	}
+
 	clsaddr.sipc_family =3D AF_RTIPC;
 	clsaddr.sipc_port =3D IDDP_CLPORT;
 	ret =3D bind(s, (struct sockaddr *)&clsaddr, sizeof(clsaddr));
@@ -146,26 +174,19 @@ static void *client(void *arg)
 		 * iterations.
 		 */
 		ts.tv_sec =3D 0;
-		ts.tv_nsec =3D 500000000; /* 500 ms */
+		if (!send_delay_ms)
+			send_delay_ms =3D 500;
+		ts.tv_nsec =3D send_delay_ms * 1000000UL;
 		clock_nanosleep(CLOCK_REALTIME, 0, &ts, NULL);
 	}
=20
 	return NULL;
 }
=20
-int main(int argc, char **argv)
+static void run_server(void)
 {
 	struct sched_param svparam =3D {.sched_priority =3D 71 };
-	struct sched_param clparam =3D {.sched_priority =3D 70 };
-	pthread_attr_t svattr, clattr;
-	sigset_t set;
-	int sig;
-
-	sigemptyset(&set);
-	sigaddset(&set, SIGINT);
-	sigaddset(&set, SIGTERM);
-	sigaddset(&set, SIGHUP);
-	pthread_sigmask(SIG_BLOCK, &set, NULL);
+	pthread_attr_t svattr;
=20
 	pthread_attr_init(&svattr);
 	pthread_attr_setdetachstate(&svattr, PTHREAD_CREATE_JOINABLE);
@@ -176,6 +197,12 @@ int main(int argc, char **argv)
 	errno =3D pthread_create(&svtid, &svattr, &server, NULL);
 	if (errno)
 		fail("pthread_create");
+}
+
+static void run_client(void)
+{
+	struct sched_param clparam =3D {.sched_priority =3D 70 };
+	pthread_attr_t clattr;
=20
 	pthread_attr_init(&clattr);
 	pthread_attr_setdetachstate(&clattr, PTHREAD_CREATE_JOINABLE);
@@ -186,12 +213,120 @@ int main(int argc, char **argv)
 	errno =3D pthread_create(&cltid, &clattr, &client, NULL);
 	if (errno)
 		fail("pthread_create");
+}
+
+static error_t parse_opt (int key, char *arg, struct argp_state *state)
+{
+	switch (key) {
+	case 's':
+		mode |=3D MODE_SERVER;
+		break;
+	case 'c':
+		mode |=3D MODE_CLIENT;
+		break;
+	case 'd':
+		send_delay_ms =3D atoi(arg);
+		if (send_delay_ms < 0)
+			argp_usage(state);
+		break;
+	case 't':
+		send_timeout_ms =3D atoi(arg);
+		if (send_timeout_ms < 0)
+			argp_usage(state);
+		break;
+	case 'm':
+		max_messages =3D atoi(arg);
+		if (max_messages < 0)
+			argp_usage(state);
+		break;
+	case 'z':
+		poolsz =3D atoi(arg);
+		if ((int)poolsz < 0)
+			argp_usage(state);
+		break;
+	default:
+		return ARGP_ERR_UNKNOWN;
+	}
+
+	return 0;
+}
+
+static struct argp_option options[] =3D {
+	{"server", 	's',	0,	0,	"Start an IDDP server" },
+	{"client",	'c',	0,	0,	"Start an IDDP client" },
+	{"send-delay", 	'd',	"DLY",	0,	"Delay in ms between messages sent by th=
e client" },
+	{"send-timeout",'t',	"STO",	0,	"Send timeout in ms in client" },
+	{"max-msg", 	'm',	"MAX",	0,	"Maximum number of messages consumed by the=
 server" },
+	{"pool-size", 	'z',	"PSZ",	0,	"Size of receive pool in KiB, specify 0 t=
o use system pool" },
+	{ 0 }
+};
+
+static struct argp argp =3D {
+	options,
+	parse_opt,
+	NULL,
+	NULL,
+};
+
+int main(int argc, char *argv[])
+{
+	sigset_t set;
+	int sig, ret;
+
+	ret =3D argp_parse(&argp, argc, argv, 0, 0, NULL);
+	if (ret) {
+		return 1;
+	}
+
+	if (!mode)
+		mode =3D MODE_SERVER | MODE_CLIENT;
+
+	if (send_delay_ms && !(mode & MODE_CLIENT)) {
+		fprintf(stderr, "--send-delay works only with --client\n");
+		return 1;
+	}
+
+	if (send_timeout_ms && !(mode & MODE_CLIENT)) {
+		fprintf(stderr, "--send-timeout works only with --client\n");
+		return 1;
+	}
+
+	if (max_messages && !(mode & MODE_SERVER)) {
+		fprintf(stderr, "--max-msg works only with --server\n");
+		return 1;
+	}
+
+	if (poolsz !=3D SIZE_MAX) {
+		if (!(mode & MODE_SERVER)) {
+			fprintf(stderr, "--pool-size works only with --server\n");
+			return 1;
+		}
+	} else {
+		poolsz =3D 32; /* 32KiB default */
+	}
+
+	sigemptyset(&set);
+	sigaddset(&set, SIGINT);
+	sigaddset(&set, SIGTERM);
+	sigaddset(&set, SIGHUP);
+	pthread_sigmask(SIG_BLOCK, &set, NULL);
+
+	if (mode & MODE_SERVER)
+		run_server();
+	if (mode & MODE_CLIENT)
+		run_client();
=20
 	__STD(sigwait(&set, &sig));
-	pthread_cancel(svtid);
-	pthread_cancel(cltid);
-	pthread_join(svtid, NULL);
-	pthread_join(cltid, NULL);
+
+	if (mode & MODE_SERVER) {
+		pthread_cancel(svtid);
+		pthread_join(svtid, NULL);
+	}
+
+	if (mode & MODE_CLIENT) {
+		pthread_cancel(cltid);
+		pthread_join(cltid, NULL);
+	}
=20
 	return 0;
 }
--=20
2.39.2

