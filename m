Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795877016;
	b=5D9bS2rUNYjt7KcEVVxCTbaTtry0S9lwUfI2pQnC8oqT6o33VibMwHiIdVi4iHoABluu
	 AYReU1F6f83zto84KuOe1R/KVuLnHKwaU3aJeHrJaEcS44/cc4dvlVzXMjpTr6FaqyCfU
	 cjoQq8xO5UVbQTrMTYDKK6JizwL+lU9Y5YY719Mrw9cwOUNFjV7Pt7ZO4jgDTXq75NmVL
	 TL9Cj+2dMkBERY25Rs/D+dd0u9C/v0ByekNvd48jUX7fFNtMp4jfKC34tJCR3N5Pr5aRR
	 usRYJayZhSIJRQddEvxsXgwVSUaqthyeUAnG5ClzOx5ARBv6AKBIJH0j7oOSbxxfHtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795877016;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=CpTwaNFsn4sY9ArX/APRxIKZlcchVX02/MAAMmCks1Y=;
	b=b3WaacHf7wGfHPeoAijH+TGoCDONO14ClfBNNJ6bKeR7biw7lJCft4eyEy89vgMQa4t8
	 bu9LF7zTPLKqftWZj8PYT6CV3FoxfqrMlGiuyOEusxOfe2dk9oy6vD/XhQ9+dm9QE0QvU
	 Tvwgd72O8ox9wgpWcY2cVVJX0cS5jC9s20FS9zsZVfDJij6YPIEUP6X+IImDK90x77mnt
	 jmJ66NTz+vrTCK7yHKhKvwksjHRj0xe3K0MLUy+bU3eXlPio7mNAgWRVE6+vImZjKKmgY
	 C2HL0qNwTk8x8aDiEEzufwj2S94b0S/+2XDZwhTDRqKB7/ownVFi3xQrqLQ/cVc+ONg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=RScdy93n;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D3A606A31C
	for <xenomai@lists.linux.dev>; Sat, 28 Nov 2026 14:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73D3A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=RScdy93n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Cp
	TwaNFsn4sY9ArX/APRxIKZlcchVX02/MAAMmCks1Y=; b=RScdy93ndOxAW4ItH+
	ssLeJqMiEIXnuFmmSU640uPgMERtCO6nu9FcMSe7w+hXZMj97mVE7oU6zTKwyMgr
	HhU9bJ+HeKdJDb6Jd7l4y4w/rmoUS0oJ3l+ZjbodxGRzP2pm43CcHjM2DZk/sp7n
	ETLhhSniMgnNB//AbY4loCgCI=
Received: from debian.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wAnBhKJ6AprBkGYKw--.52103S2;
	Sat, 28 Nov 2026 22:43:28 +0800 (CST)
From: Guangfeng Wang <guang_feng_wang@163.com>
To: jan.kiszka@siemens.com
Cc: xenomai@lists.linux.dev,
	Guangfeng Wang <guang_feng_wang@163.com>
Subject: [PATCH] cobalt/posix: Remove duplicate clock_getres trace events
Date: Sat, 28 Nov 2026 22:43:19 +0800
Message-ID: <20261128144319.2612-1-guang_feng_wang@163.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnBhKJ6AprBkGYKw--.52103S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw45tw43Ar48GrWkCryfZwb_yoW8Xr18pr
	47tFZYkr18AF10qF4UKa1kXrWkWa4Dtw13CFnI9w45Arn3Xrsrta4jqF92yrWjvrna9390
	qF1vgrW8ur45u37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUylkxUUUUU=
X-CM-SenderInfo: xjxd0wxbih0wxbzd0wi6rwjhhfrp/xtbC+RC7NWsK6JBgLQAA3z

Both clock_getres and clock_getres64 emit a cobalt_clock_getres
trace event in their syscall handlers, although
__cobalt_clock_getres() already emits the same event.

Testing on native x86_64 with Linux 6.12.90-cip24 showed
that ten successful clock_getres64 calls generated twenty
events before the fix and ten afterwards.

Additional tests covering both syscall interfaces, three
clock IDs, NULL pointers, inaccessible user addresses and
invalid clock IDs passed before and after the fix. The
number of clock resolution events decreased from eighteen
to ten, with unchanged return values and clock resolutions.

Fixes: 8325e4c3076f ("cobalt/posix/clock: prepare for 32bit syscall emulation")

Signed-off-by: Guangfeng Wang <guang_feng_wang@163.com>
---
 kernel/cobalt/posix/clock.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
index e6c187ca4..696705bd0 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -88,8 +88,6 @@ COBALT_SYSCALL(clock_getres, current,
 	if (u_ts && cobalt_put_old_timespec(u_ts, &ts))
 		return -EFAULT;
 
-	trace_cobalt_clock_getres(clock_id, &ts);
-
 	return 0;
 }
 
@@ -106,8 +104,6 @@ COBALT_SYSCALL(clock_getres64, current,
 	if (u_ts && cobalt_put_timespec64(&ts, u_ts))
 		return -EFAULT;
 
-	trace_cobalt_clock_getres(clock_id, &ts);
-
 	return 0;
 }
 
-- 
2.47.3

