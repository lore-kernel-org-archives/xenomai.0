Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111975;
	b=GIk095lPj0vq1sZ2CQ3R5Gavqx2vcr9A3KswL0/piNUwVloCQkB4mMpbaEnRSwPaZWls
	 VpJFwE+34OEneA+iJixWRjAXMpRECarKepZRXlN/cPN3n2f8H1JcUgYA3G8ubfGcZFklQ
	 CZKrf0GidbparXdXjspginiEwbV6GIb/WBRGL0p2h95yWaM2RKtyMrJHRcQ9QgZIDYDXj
	 u1rWDmvdkKPRLiRhuRQ7gUEqkQtEgglaBhoyx4GSr437c3T8qOzOs/T5x69BLIZjVmnEH
	 DKo096bkfg3xBQR1CFVCx0IifCmJ9ssoWLfEJuTHsGEqTJW1dMmqBv7j3hYVw9GtItw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111975;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:User-Agent:
	 MIME-Version:Date:Subject:Message-ID:X-Forward:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
	bh=/Eddem9tTs6S6UmB2YfVfGh7Naak5eCgZwRKMFkLRC0=;
	b=NTjJfnhQrYZ+CV2ltMp4tqlJYTy8GTbNRfZCa2pUaS8B4ekMS9scZzZdvsWvDrwnThTC
	 KOqIDjdveOLBJfvvMbfOlowDixoD0Pf8j0RdmBYMea189dT54hdoY7NOxzxmeyb8BuEUh
	 faLTxhmBz8++0Kv+5nN9nfkjS6MEvNiZVUTjamAUz9kA+/L6+Qk1gRTCeZnSm8CTQiu/0
	 RNlW8VDDqgciHwGt0KJTArqJeSt0eWt/KPRIIj8A15u6Bk4Pq5vzQAJebTnLW3tz875kI
	 5Kq1Q3Zgr0+oQ9culakz4KT0TbutVSss5V24qr/J//zuFbmwTPFSZoNLKt8zTEoNzgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=eventlab.fr;
	spf=pass smtp.mailfrom=eventlab.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=IslpqakJ;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAF9606A31E
	for <xenomai@lists.linux.dev>; Tue, 27 Oct 2026 14:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AAF9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=IslpqakJ
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp6-g21.free.fr (Postfix) with ESMTPS id A07D578035B
	for <xenomai@lists.linux.dev>; Tue, 27 Oct 2026 15:39:30 +0100 (CET)
Authentication-Results: smtp6-g21.free.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=IslpqakJ;
	dkim-atps=neutral
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 69REdTTq1367158
	for <xenomai@lists.linux.dev>; Tue, 27 Oct 2026 15:39:30 +0100
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=eventlab.fr;
	s=default; t=1793111970;
	bh=PBTUfzPTN4C0wwaipF4X8lMVf6oLWg6Z/s5sJohNXks=;
	h=From:To:Date:Subject;
	b=IslpqakJyCQKZdH7OyEJe6NzYaif9QWGd5Lz3ApykXvvw99bqBTKp+nxiXbro0QbT
	 q7KH3dRxwrd58jH0yQF0+VEO9YYEJlJtI0bez4OvcgI8Ua7en4f876i5whvHZH6UW+
	 MNhWeXQJ5gGCNilRVs1J3VTHjaZXQIAD7o0QsX/vr7wfp4tOxd8S+9JzU1oxN/n00i
	 g90OyMWAZR86yFXa/y9QDLLWOi2MY36r3eA627TOWedKIrqwSKV6qLWG4Lz1a6VE+m
	 YnndTbUPCQO8+Uj/olJaFDFk+6hbiB7ALhK7rsuFOODozEHvGpMfFrmL3HP3sks6+S
	 F0DiqSJZzIe+g==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>
To: xenomai@lists.linux.dev
User-Agent: SOGoMail 5.0.1
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Tue, 27 Oct 2026 15:39:29 +0100
Subject: [PATCH v3] Fix missing time64 wrappers
Message-ID: <115efd-6ae0b780-3-36f80d40@211094435>
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
so it is correct to route the time64 services to the native "time=5Ft" =
syscall.

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
+		   (int fd,struct msghdr *msg, int flags))
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

