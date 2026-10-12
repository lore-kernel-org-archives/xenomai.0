Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0440355803
	for <xenomai@lists.linux.dev>; Mon, 12 Oct 2026 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823805; cv=none; b=aI5neXzkl9zGiwrHSkMS+mbE0WJww2h4jjQcFFJ54ULpVSqwzJjKqJRqWsXTofZXxruVyoia1GflXN4ZYgyxHKNSxgQJBmVzK1UDbfgHK9a/ZD7JXgbRrY3/2hHKXhZomKaSNo+Ke3V4veLmFTi7a41c6E5X1cAIMOw6EztN2Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823805; c=relaxed/simple;
	bh=dSm+UuDf3rBx/sHVtZf3bfU3pGvrRcyn3xrks2e9nuo=;
	h=From:To:MIME-Version:Date:Subject:Message-ID:Content-Type; b=H3WyCt8Y9IEsgK12PrpSfNFYFDex+D6H+VCigahT9i8nxSBZbB7M5Zhhr9RoUdpeji/XKO9RNzWmcsWqunAvVLDEqPaQUdiU5z41uTv5AdoghxvQtvZI2ycWSVBF21A/d0D+X0AcS8dvW0N7VQ3y4QdGlBb5gzLcsUigLdH6OEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr; spf=pass smtp.mailfrom=eventlab.fr; dkim=permerror (0-bit key) header.d=eventlab.fr header.i=@eventlab.fr header.b=tVnnwJHm; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=eventlab.fr header.i=@eventlab.fr header.b="tVnnwJHm"
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp6-g21.free.fr (Postfix) with ESMTPS id 9C583780383
	for <xenomai@lists.linux.dev>; Mon, 12 Oct 2026 18:49:54 +0200 (CEST)
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 69CGnr5N678637
	for <xenomai@lists.linux.dev>; Mon, 12 Oct 2026 18:49:54 +0200
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=eventlab.fr;
	s=default; t=1791823794;
	bh=dSm+UuDf3rBx/sHVtZf3bfU3pGvrRcyn3xrks2e9nuo=;
	h=From:To:Date:Subject;
	b=tVnnwJHmzfX0cToUo6tMMSlreo5Gm81HUz5Mj8N9yXWJYbdflBjZdR3KpE0/+4vjQ
	 tgsyx1FLpbRojKpXixGCDU1wS3vb3wJ/dbNvFF0ngI/ZuSEGUkME5QnOD5iVct6gkg
	 IRe0UZr2sA0vtEzpZzuxhpO2hSE3NwDpkcmWCs7fuAdD6bJrW8upqK0gK6wHiY1Gt3
	 6dZ2Adxc3xM00dOHWxIiOmWP0/SntFpK9YONwI8jT6RnZZo9nVe2Auu2UfhyoJpeK/
	 RgENUN13SAfSHMJgBIt1UGrXLHvfESrUqU18qGFb8uWUlBjtSnPl5PhqAC6vidSfp/
	 Pjs4Lnw/l7BrA==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>
To: xenomai@lists.linux.dev
User-Agent: SOGoMail 5.0.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 12 Oct 2026 18:49:53 +0200
Subject: [PATCH v2] Fix missing time64 wrappers
Message-ID: <1209-6acd0f80-73-5a2d1100@131663125>
X-Forward: 217.109.173.233, 194.9.103.72
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at tls-srv-02
X-Virus-Status: Clean

There are missing wrappers for 64 bits time in xenomai 3.3 :
- =5F=5Frecvmsg64
- =5F=5Fsendmsg64
- =5F=5Fsendmmsg64

For =5F=5Frecvmsg64, the only options which shall write to msghdr.msg=5F=
control are :
-RTCAN=5FRTIOC=5FTAKE=5FTIMESTAMP which always writes RTCAN=5FTIMESTAMP=
=5FSIZE (64) bits
so it is correct to route the time64 service to ne native "time=5Ft" sy=
scall.

Signed-off-by: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>
---
diff --git a/lib/cobalt/cobalt-glibc-time64.wrappers b/lib/cobalt/cobal=
t-glibc-time64.wrappers
index 0bf895ca9..483a8ce24 100644
--- a/lib/cobalt/cobalt-glibc-time64.wrappers
+++ b/lib/cobalt/cobalt-glibc-time64.wrappers
@@ -8,7 +8,10 @@
 --wrap =5F=5Fmq=5Ftimedsend=5Ftime64
 --wrap =5F=5Fmq=5Ftimedreceive=5Ftime64
 --wrap =5F=5Fsigtimedwait64
+--wrap =5F=5Frecvmsg64
 --wrap =5F=5Frecvmmsg64
+--wrap =5F=5Fsendmsg64
+--wrap =5F=5Fsendmmsg64
 --wrap =5F=5Fpthread=5Fcond=5Ftimedwait64
 --wrap =5F=5Ftimer=5Fsettime64
 --wrap =5F=5Ftimer=5Fgettime64
diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
index 00c1aaf4b..264de8ace 100644
--- a/lib/cobalt/rtdm.c
+++ b/lib/cobalt/rtdm.c
@@ -254,7 +256,7 @@ static ssize=5Ft do=5Frecvmsg(int fd, struct msghdr=
 *msg, int flags)
 	return ret;
 }
 
-COBALT=5FIMPL(ssize=5Ft, recvmsg, (int fd, struct msghdr *msg, int fla=
gs))
+COBALT=5FIMPL=5FTIME64(ssize=5Ft, recvmsg, =5F=5Frecvmsg64,
+		(int fd,struct msghdr *msg, int flags))
 {
 	int ret;
 
@@ -301,7 +301,7 @@ static ssize=5Ft do=5Fsendmsg(int fd, const struct =
msghdr *msg, int flags)
 	return ret;
 }
 
-COBALT=5FIMPL(ssize=5Ft, sendmsg, (int fd, const struct msghdr *msg, i=
nt flags))
+COBALT=5FIMPL=5FTIME64(ssize=5Ft, sendmsg, =5F=5Fsendmsg64,
+		(int fd, const struct msghdr *msg, int flags))
 {
 	int ret;
 
@@ -312,7 +312,7 @@ COBALT=5FIMPL(ssize=5Ft, sendmsg, (int fd, const st=
ruct msghdr *msg, int flags))
 	return =5F=5FSTD(sendmsg(fd, msg, flags));
 }
 
-COBALT=5FIMPL(int, sendmmsg, (int fd, struct mmsghdr *msgvec,
+COBALT=5FIMPL=5FTIME64(int, sendmmsg, sendmmsg64, (int fd, struct mmsg=
hdr *msgvec,
 			    unsigned int vlen, unsigned int flags))
 {
 	int ret, oldtype;

