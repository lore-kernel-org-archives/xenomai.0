Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF0248788
	for <xenomai@lists.linux.dev>; Wed, 20 Dec 2023 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id DA3DE6343B29
	for <xenomai@lists.linux.dev>; Wed, 20 Dec 2023 20:49:09 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id vOxIt7s1M7Gl; Wed, 20 Dec 2023 20:49:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 742E06343B2F;
	Wed, 20 Dec 2023 20:49:09 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YuBykj5N39ho; Wed, 20 Dec 2023 20:49:09 +0100 (CET)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 49B976343B29;
	Wed, 20 Dec 2023 20:49:09 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>
Subject: [PATCH] [RFC] xnthread_set_periodic: Improve period adjusting support
Date: Wed, 20 Dec 2023 20:48:55 +0100
Message-Id: <20231220194855.8684-1-richard@nod.at>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently, when a periodic task invokes xnthread_set_periodic() multiple =
times,
the timer is reset each time.
Consequently, the period drifts because the elapsed time is not taken int=
o
consideration.
To improve the situation, account the elapsed time of the already
running time to the new start time if the time is smaller than
the new period when idate is XN_INFINITE.

Alternatively, callers of xnthread_set_periodic() could access
task->ptimer directly and pass an adjusted start time to xnthread_set_per=
iodic().

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 kernel/cobalt/thread.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index ff12f288a..a5304cc8a 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -1335,9 +1335,18 @@ int xnthread_set_periodic(struct xnthread *thread,=
 xnticks_t idate,
=20
 	xntimer_set_affinity(&thread->ptimer, thread->sched);
=20
-	if (idate =3D=3D XN_INFINITE)
-		xntimer_start(&thread->ptimer, period, period, XN_RELATIVE);
-	else {
+	if (idate =3D=3D XN_INFINITE) {
+		xnticks_t start =3D period;
+
+		if (xntimer_running_p(&thread->ptimer)) {
+			xnticks_t elapsed =3D xntimer_interval(&thread->ptimer) -
+						__xntimer_get_timeout(&thread->ptimer);
+			if (elapsed < period)
+				start =3D period - elapsed;
+		}
+
+		xntimer_start(&thread->ptimer, start, period, XN_RELATIVE);
+	} else {
 		if (timeout_mode =3D=3D XN_REALTIME)
 			idate -=3D xnclock_get_offset(xntimer_clock(&thread->ptimer));
 		else if (timeout_mode !=3D XN_ABSOLUTE) {
--=20
2.35.3

