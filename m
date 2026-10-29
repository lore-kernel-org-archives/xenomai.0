Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.254.241.31
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793262551;
	b=3DCcMcd3JNjqnHJgV9xwQSiBtA1y3atyy4C8Y9k9j/dVr2UCyB3Qv1rB2qKQWclvVeIj
	 0PFpa454Uq/iVI4a2rFMAP6v1Jx8CyHvbrZ3f59AWMXH5zYpLf4EMLiTWBjS9k4rcWrg9
	 KI1ZCqf6/BA+63BUF4FbdzbPNQ+0fEx7eTe+1QaalnM0kyH9nVQBVpFDLz9nZqsBtYOGo
	 SM3TE4LWtAzhPI6hfThS9L5fZLMRu9bXadAikxs3iJ1rQHLmZdssSkoBpHBqIs3d/TWuY
	 EjAsSoewKeZh1Aw/s0canbuAuUAsazsWsBdYYtl7jHKEM/pL5VzwIhN9QT6E2W+hdwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793262551;
	h=DMARC-Filter:Received:Received:Received:DKIM-Filter:DKIM-Signature:
	 Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:X-Virus-Scanned:X-Virus-Status:
	 Content-Transfer-Encoding;
	bh=C6fBBqOW6ighIM9xnDbNFswzsWAb5qKNp4VdzCbkiEw=;
	b=kgvMCwL4DBxExEX89zRu5HLLhZAd2QNWe4rpvlgdPNhV9cRrdvqJBJtTd/Q+HhvcVCFT
	 Z2JbuD+hywDWlVSo13macoz5vHFbyVvEsKuEqKKyyOG/AVZV1vG6w5xvk7a788S99236V
	 LoFwaya4R0Fbf6o1ZRRyukyGZwXS12dHc5iEHJ0LVU+sm1P2sTJ1LFb2BP2rYdT6kW67u
	 ie8OfJDJrsSU/5FP2NNFWyxUl0d81VK+YGfiKLny5jzaudw8kE7/QOS0BPLD0vWKeweR1
	 Py4FG6fuWDOgIz03uh+0r+rTQocDPmR77fpI6E1gphG/VKTdKzpOWs3lX88aR241yjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=etu.unistra.fr;
	spf=pass smtp.mailfrom=etu.unistra.fr;
	dkim=pass header.d=etu.unistra.fr header.i=@etu.unistra.fr header.a=rsa-sha256 header.s=CF3F7C4B-DA64-411C-B5F6-2447403EF5CF header.b=miX4BtFm;
	arc=none smtp.remote-ip=194.254.241.31
Received: from smtpout02-ext4.partage.renater.fr (smtpout02-ext4.partage.renater.fr [194.254.241.31])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1700606A31A
	for <xenomai@lists.linux.dev>; Thu, 29 Oct 2026 08:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1700606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=etu.unistra.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etu.unistra.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etu.unistra.fr header.i=@etu.unistra.fr header.a=rsa-sha256 header.s=CF3F7C4B-DA64-411C-B5F6-2447403EF5CF header.b=miX4BtFm
Received: from zmtaauth02.partage.renater.fr (zmtaauth02.partage.renater.fr [194.254.241.25])
	by smtpout20.partage.renater.fr (Postfix) with ESMTP id 0C61EC6F2B
	for <xenomai@lists.linux.dev>; Thu, 29 Oct 2026 09:28:59 +0100 (CET)
Received: from zmtaauth02.partage.renater.fr (localhost [127.0.0.1])
	by zmtaauth02.partage.renater.fr (Postfix) with ESMTPS id 016D8A0DF9;
	Thu, 29 Oct 2026 09:28:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zmtaauth02.partage.renater.fr (Postfix) with ESMTP id E2AE6A0EF9;
	Thu, 29 Oct 2026 09:28:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmtaauth02.partage.renater.fr E2AE6A0EF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=etu.unistra.fr;
	s=CF3F7C4B-DA64-411C-B5F6-2447403EF5CF; t=1793262538;
	bh=C6fBBqOW6ighIM9xnDbNFswzsWAb5qKNp4VdzCbkiEw=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=miX4BtFmCAW26Dht77npaEw+V5RyxQK2mG3BPTWJRhklxaC/9P7X2wnTMkX9fb/i7
	 YEMbo6eQt0wQa6pOTMq9jEs5Y9chQdwHDdmj3QJBbreYpnvOvPtgYd+u7yWTD5wTo9
	 hPeEdUDfW5oeApVnMlWVEtnnalphFThQ7C/JMftHgO+Mng9cEKXOow+d3cugZdO4dU
	 ApGFKLiqMfYFttAARrAAyOSlJ3cDbJSeOCp0hl7SyDECI6aqVo+WalB8Vbo+GPiZs6
	 2BANQLteetSZNW169munHR+3i06ct7/gsD8WHEiEsTlwTlqyGXU1BEsv9eQW+P7JbP
	 GZY9eXW6BtG2A==
Received: from zmtaauth02.partage.renater.fr ([127.0.0.1])
 by localhost (zmtaauth02.partage.renater.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id P8W-X40CLhsP; Thu, 29 Oct 2026 09:28:58 +0100 (CET)
Received: from 90.63.34.216 (unknown [194.254.241.240])
	by zmtaauth02.partage.renater.fr (Postfix) with ESMTPA id B2BA5A0DF9;
	Thu, 29 Oct 2026 09:28:58 +0100 (CET)
From: Luc Montier <luc.montier@etu.unistra.fr>
To: xenomai@lists.linux.dev
Cc: Luc Montier <luc.montier@etu.unistra.fr>
Subject: [libevl][PATCH] lib/mutex: init recursion count after trylock via the core
Date: Thu, 29 Oct 2026 09:28:48 +0100
Message-Id: <20261029082848.22006-1-luc.montier@etu.unistra.fr>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.103.12 at clamav04
X-Virus-Status: Clean
Content-Transfer-Encoding: quoted-printable

evl_trylock_mutex() takes the slow path to the core when try_lock()
returns -ENODATA, e.g. for a thread running in-band. Unlike
evl_timedlock_mutex(), it does not initialize gate.nesting once
EVL_MONIOC_TRYENTER succeeds.

For a recursive mutex, nesting then stays at 0 after the first lock
instead of 1. After N successful lock calls by the owner, nesting is
N - 1, so the (N - 1)th unlock releases the mutex and the last one
fails with -EPERM.

Set nesting to 1 after a successful TRYENTER, as evl_timedlock_mutex()
does after EVL_MONIOC_ENTER.

Signed-off-by: Luc Montier <luc.montier@etu.unistra.fr>
---
Hello,

This patch is against libevl r50-5 (e7dc1af, Jan 2025), the version
that matches my kernel (6.6.74, EVL ABI level 37, Raspberry Pi 5).
I could not test it on master, which requires ABI 47.

Reproducer: a recursive mutex, a thread running in-band when it calls
evl_trylock_mutex() three times, then three evl_unlock_mutex() calls.
The last unlock fails with -EPERM, and gate.nesting reads 0, 1, 2 after
the locks. With the patch it reads 1, 2, 3 and all unlocks succeed.

On master, this code now seems to live in lib/intrinsics/gate.c. Is
this already fixed there, and where would the fix belong?

I just want to if it is an issue from libevl or a misuse on my part.

Best regards,
Luc Montier


 lib/mutex.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/mutex.c b/lib/mutex.c
index 276e77f..832268f 100644
--- a/lib/mutex.c
+++ b/lib/mutex.c
@@ -332,6 +332,7 @@ int evl_lock_mutex(struct evl_mutex *mutex)
=20
 int evl_trylock_mutex(struct evl_mutex *mutex)
 {
+	struct evl_monitor_state *gst;
 	int ret;
=20
 	ret =3D try_lock(mutex);
@@ -341,7 +342,12 @@ int evl_trylock_mutex(struct evl_mutex *mutex)
 	do
 		ret =3D oob_ioctl(mutex->u.active.efd, EVL_MONIOC_TRYENTER);
 	while (ret && errno =3D=3D EINTR);

+	if (ret =3D=3D 0) {
+		gst =3D mutex->u.active.state;
+		gst->u.gate.nesting =3D 1;
+	}
+
 	return ret ? -errno : 0;
 }
=20
--=20
2.34.1

