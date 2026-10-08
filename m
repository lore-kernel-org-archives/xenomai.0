Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9D2441619
	for <xenomai@lists.linux.dev>; Thu,  8 Oct 2026 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452886; cv=none; b=ChVpNE3F9ObkNauNce71fkD1PuVhMnEnEWd6gXpD+Eq7x+LNFRAvbCWKo6U8VpL7Ah1n2juSXnZDHzJHZe2D/CGDVB6RSoXIlQtvdL+XmBzhXwTf/TIL8Oj8dJOUkucrEKEP5h9d5JK/TZrhicpdKBE573EFVEvpedmA70QPkck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452886; c=relaxed/simple;
	bh=8EITpcNYU2ZoT3QiuCCfcsF7rfai/VakHLMBqPqttm4=;
	h=From:To:MIME-Version:Date:Subject:Message-ID:Content-Type; b=F68LDC4nTOz10F2bO4EjXouOiPQJbarwhGSGjjwMeq8d/PXJ5lsdH+HdrYBYPWHUxM55JJXKi5dWx8hKCUcV06L81XNS2qm9tLBeVH9q4Z/AV9MA+mKqMdfQ8iIDj0FpTFFsSrGJk2Wz4qiPniyIQQSwHQMS1hFoLPXFi5VaxS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr; spf=pass smtp.mailfrom=eventlab.fr; dkim=permerror (0-bit key) header.d=eventlab.fr header.i=@eventlab.fr header.b=s6VD3NR1; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=eventlab.fr header.i=@eventlab.fr header.b="s6VD3NR1"
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp6-g21.free.fr (Postfix) with ESMTPS id 87244780395
	for <xenomai@lists.linux.dev>; Thu,  8 Oct 2026 11:48:01 +0200 (CEST)
Authentication-Results: smtp6-g21.free.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=s6VD3NR1;
	dkim-atps=neutral
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 6989m09s484861
	for <xenomai@lists.linux.dev>; Thu, 8 Oct 2026 11:48:00 +0200
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=eventlab.fr;
	s=default; t=1791452880;
	bh=8EITpcNYU2ZoT3QiuCCfcsF7rfai/VakHLMBqPqttm4=;
	h=From:To:Date:Subject;
	b=s6VD3NR11Qx5/a0SQvIikZHKsjfDr0D2Hq5OObm2ifCTHk1sbtsZZisTGi7ue18L6
	 AXMmEQNtmKO8l0662k0np24jIZPUYRd7hTgbG3xzixVW8X9PlNZLPe+kosQoWeJyGW
	 BddyCvSXfOgX94ZwTuAHDfAV2gn0C7EqyTgqWOBGaYbXlZXOZ069bS0rwIxNomQ8We
	 uSfAqT/HGE1BofXYbvl5ZHDOtQbb4L3IrZnr/7/pBsRTgGUmFv91HFgAYp/jI5kWoD
	 sx8qaOOYt9IrXROtKQ9NzC2m2UaSD7xSz52+PrSyOP/TAttM9RSwN+ePrsS7icmP/Q
	 2ezPuTNWjlz1Q==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>
To: xenomai@lists.linux.dev
User-Agent: SOGoMail 5.0.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 08 Oct 2026 11:48:00 +0200
Subject: [patch] fixed missing time64 wrappers
Message-ID: <1208-6ac76700-4b-2c92e940@166990483>
X-Forward: 80.13.28.252, 194.9.100.114
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at tls-srv-02
X-Virus-Status: Clean

There are missing wrappers for 64 bits time in xenomai 3.3 :
- =5F=5Frecvmsg64
- =5F=5Fsendmsg64
- =5F=5Fsendmmsg64

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
@@ -254,7 +254,7 @@ static ssize=5Ft do=5Frecvmsg(int fd, struct msghdr=
 *msg, int flags)
 	return ret;
 }
 
-COBALT=5FIMPL(ssize=5Ft, recvmsg, (int fd, struct msghdr *msg, int fla=
gs))
+COBALT=5FIMPL=5FTIME64(ssize=5Ft, recvmsg, =5F=5Frecvmsg64, (int fd, s=
truct msghdr *msg, int flags))
 {
 	int ret;
 
@@ -301,7 +301,7 @@ static ssize=5Ft do=5Fsendmsg(int fd, const struct =
msghdr *msg, int flags)
 	return ret;
 }
 
-COBALT=5FIMPL(ssize=5Ft, sendmsg, (int fd, const struct msghdr *msg, i=
nt flags))
+COBALT=5FIMPL=5FTIME64(ssize=5Ft, sendmsg, =5F=5Fsendmsg64, (int fd, c=
onst struct msghdr *msg, int flags))
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

