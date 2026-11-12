Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794507070;
	b=owXWwL2I3NjJaGEq41NLHUCU5OqwFaz76vbQ5ncqlftB9N6ObtxCKGl7Wo/kByqqq7Gh
	 Tv2YUisFgTf5sL8gyI+2cZr+H3TebmYDpxi3aY0es960j5gw0KKcfP95MbswSsZfa1dm7
	 pB9TtSJsFvuDgPrAyGRV4ilZSGPMEdYp52o1cfpRdFVQb2C+PDJeVYz6FfKNpHBznLNxA
	 8dViecqKi0gv6sSasunJ9wsDR/oK6x2tZ124lxSijvo7K7Bc2dwfUytBWdg8kdKUuGrq/
	 cYfltqdmwM8+1ZcNGPp4qYjthTvnqxtyy7sxAPuGh2JPcXa5jdNAz5QJloeX2LUp71w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794507070;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:User-Agent:
	 MIME-Version:Date:Subject:Message-ID:X-Forward:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
	bh=iGQAvboz2lNB/0Ik2mmwTT28X87z5F++9i5hyPLkdf8=;
	b=DT59znDF3JzuG8iF9bG1meEv3pq3mDBUV53hUE25Uy/eVSItSzyLfr09Q6jlvJi3bXy7
	 PX5QdKlHZWctZL4Vlo9taBGHvO6WC4XfB2oEs7UnNLPbcqgQN6YYpDWMvS8F5K53cREA+
	 oZN08r2j7IAGYQRnHXvuE1kYcJOvo9Op5ve6LpHox66ocmjzM06Yi6SnTxB4mSVt3S+oI
	 J+pM4iZEhRo+M/VvQSPhuFkPJIEPsu7tZXOcWJwZj4du4nLVKpfRLIeJ/7r1/VyoMHLly
	 +32zKURbZzwhs+2bC5tIi9mD9+Zx8zr0m4vsmCsTdEsTSFsv2Fr5PyR6hgIFhklibXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=eventlab.fr;
	spf=pass smtp.mailfrom=eventlab.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=tZ+5WdRy;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC85A606A31C
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 18:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC85A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=tZ+5WdRy
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp6-g21.free.fr (Postfix) with ESMTPS id 54CEF780530
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 19:11:08 +0100 (CET)
Authentication-Results: smtp6-g21.free.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=tZ+5WdRy;
	dkim-atps=neutral
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 6ACIB75i2922668
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 19:11:07 +0100
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=eventlab.fr;
	s=default; t=1794507067;
	bh=lniyUXHndcjkHSPS0mz8WvQVPCe9KRYQUR9Bp5r0n+4=;
	h=From:To:Date:Subject;
	b=tZ+5WdRyx24WeysS2711deC5bqhD4kjZErh/4oCMqKVMMLRI+LrmH+LZgogaUwged
	 puFp4jsU0Ydi47BQ20tL0dxEyMTSxh4mSXsOGBJMiMKWyG7mI0TuIRlNJ+lnsg/f7d
	 1+JpQH4bkh7GeYM0Xq1X0XuOSdM55o18fIh9euRKbi9TAC/GH4WkJo4V8x6ZThx5tN
	 cvcR7XXGk/37zMvkEK9lBu8juNMePgkXT1gal3eub16uDJag7M/I6+A1LTuPAB2zWY
	 TnYgh5xUM+zcA7d28Ovejh9Sd7cu5+fYt8utlQxX57dGDTg+MzleSSY9GHNQnhA7eL
	 0vv0CjsPClXeg==
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
Date: Thu, 12 Nov 2026 19:11:07 +0100
Subject: [PATCH] Fixes broken mmap patching on 32bits archs
Message-ID: <115efd-6af60100-33-36f80d40@101055323>
X-Forward: 217.109.173.233, 194.9.103.72
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at tls-srv-02
X-Virus-Status: Clean

mmap is broken on 32 bits arch when =5F=5FUSE=5FTIME=5FBITS64 and =5F=5F=
USE=5FFILE=5FOFFSET64 are set
in that case, libc translate calls of mmap to mmap64 because file offse=
t argument is a 64 bit value.
We fail to catch that with the decoration logic (=5F=5FSTD/=5F=5FRT) an=
d plain libc mmap is called.

Signed-off-by: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>
--
diff --git a/include/cobalt/sys/mman.h b/include/cobalt/sys/mman.h
index e291f50ef..b6d650876 100644
--- a/include/cobalt/sys/mman.h
+++ b/include/cobalt/sys/mman.h
@@ -28,16 +28,10 @@
 extern "C" {
 #endif
 
-COBALT=5FDECL(void *, mmap,
+COBALT=5FDECL=5FOFF64(void *, mmap, mmap64,
 	    (void *addr, size=5Ft length, int prot, int flags, int fd,
 	     off=5Ft offset));
 
-#if defined(=5FLARGEFILE64=5FSOURCE) || defined(=5FGNU=5FSOURCE)
-COBALT=5FDECL(void *, mmap64,
-	    (void *addr, size=5Ft length, int prot, int flags, int fd,
-	     off64=5Ft offset));
-#endif
-
 #ifdef =5F=5Fcplusplus
 }
 #endif
diff --git a/include/cobalt/wrappers.h b/include/cobalt/wrappers.h
index a5645a1d4..82c9aaa69 100644
--- a/include/cobalt/wrappers.h
+++ b/include/cobalt/wrappers.h
@@ -46,6 +46,23 @@
 #define COBALT=5FDECL=5FTIME64(T, FN, FN=5F64, I) COBALT=5FDECL(T, FN,=
 I)
 #endif
 
+#if =5F=5FUSE=5FFILE=5FOFFSET64 && =5F=5FWORDSIZE =3D=3D 32
+/*
+ * Make =5F=5FRT() and =5F=5FSTD() usable in combination with time64=5F=
t related services.
+ */
+#define COBALT=5FIMPL=5FOFF64(T, FN, FN=5F64, I)                      =
              \
+	=5F=5Ftypeof=5F=5F(T) =5F=5Fwrap=5F##FN=5F64 I                       =
                  \
+		=5F=5Fattribute=5F=5F((alias("=5F=5Fcobalt=5F" =5F=5Fstringify(FN)),=
 weak));     \
+	COBALT=5FIMPL(T, FN, I)
+#define COBALT=5FDECL=5FOFF64(T, FN, A, I)                            =
            \
+	=5F=5Ftypeof=5F=5F(T) =5F=5FSTD(A) I;                                =
              \
+	extern T =5F=5FREDIRECT=5FNTH(=5F=5FSTD(FN), I, =5F=5Freal=5F##A);   =
                  \
+	COBALT=5FDECL(T, FN, I)
+#else
+#define COBALT=5FIMPL=5FOFF64(T, FN, FN=5F64, I) COBALT=5FIMPL(T, FN, =
I)
+#define COBALT=5FDECL=5FOFF64(T, FN, FN=5F64, I) COBALT=5FDECL(T, FN, =
I)
+#endif
+
 /*
  * 
  * Each "foo" Cobalt routine shadowing a POSIX service may be
diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
index 00c1aaf4b..11a6e86e6 100644
--- a/lib/cobalt/rtdm.c
+++ b/lib/cobalt/rtdm.c
@@ -542,7 +542,7 @@ COBALT=5FIMPL(int, shutdown, (int fd, int how))
 	return =5F=5FSTD(shutdown(fd, how));
 }
 
-COBALT=5FIMPL(void *, mmap64, (void *addr, size=5Ft length, int prot, =
int flags,
+COBALT=5FIMPL=5FOFF64(void *, mmap, mmap64, (void *addr, size=5Ft leng=
th, int prot, int flags,
 			     int fd, off64=5Ft offset))
 {
 	struct =5Frtdm=5Fmmap=5Frequest rma;
@@ -574,8 +574,3 @@ regular:
 #endif
 }
 
-COBALT=5FIMPL(void *, mmap, (void *addr, size=5Ft length, int prot, in=
t flags,
-			   int fd, off=5Ft offset))
-{
-	return =5F=5FCOBALT(mmap64(addr, length, prot, flags, fd, offset));
-}

