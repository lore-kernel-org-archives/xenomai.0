Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795072670;
	b=LEEaPN0TlVGjwZaPwCRQwC3DE0fZpo92yGKqAQ3a7H/9bPYjxXoS567SU9pdLnxfxrsf
	 QUYx+IIm+Yb+SfblUH3U82MjiiU66WnWjLHbcI25PHfAtpQfi0RwwMvkxZ2N6gbBsLkB8
	 oGnlGURezQBRUNyqqeSrE28L8+9dho1BgrvDNhO87NMMuITEp+YPqnlxIsIRN8TUZQ0Ta
	 hBDCsT3rPY/l7aVrqVmGi8a2gtvowlkNUmgXVPAlzidGFZEuyJJkRZnE85CYMXtZt2pYt
	 ktUg+XhkX0BqEgqhzymI3Z/jZB5Vm661aOddIChl8eQE9E5+VD/Y891m0HKXcvpQIpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072670;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NB+/DQw+R5yX13wJ5rT9AuPgxEpA+KvH/c6A5+MmSzs=;
	b=sv7es8lf9IVaBWK8sLRazs4HjhFP0BnkmSjAvo5bXW95QVlYAMsbxwMVH4UghdIpqESV
	 IDT0+ZXQ8sNibMf170Ynidr9K9rzIy0GIUhgZAtwMSubS3YEl2QMlWNj3nBz1eJ3arn/I
	 P1DDDJBKB07WrWb9QsTNDKWjOBwnOOUrHtsGzIu98binfx6QbN9WGI6uE70TyvM8O1Wz7
	 NF7ZDNdl1K7RkIKiWl2jVrRZ6n9/1RkZ0vLiiEdOChc+TgXzWdUIG9APCreZi8zgsXsZp
	 +fSIT/S9f+VPrGASQ32AkkROwYGZ5Nib5c8QjqbOAunI8ql7KfhUag/bPop7jzQSJNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=xe6ouILB;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C176606A324
	for <xenomai@lists.linux.dev>; Thu, 19 Nov 2026 07:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C176606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=xe6ouILB
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b8a52db5f9so1750566a12.3
        for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 23:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795072668; x=1795677468; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NB+/DQw+R5yX13wJ5rT9AuPgxEpA+KvH/c6A5+MmSzs=;
        b=xe6ouILBKY5KKhNPgtpaeuVf/O2Z+tZ8BL+2+244i7XNk6oCg1oEUXqIv3rNmFpzOo
         gsJdcqbExDPhb8MjTbsiOEWvnzVPaTsTK5bOFFrRQdo5V7DleDZqMS7CzVkpbzdRjIC4
         LOSnuTxFHLH3qP0AwivXV7/YtFvGctTIuzzEFVdXeNaEetkvSwKvvvGNL7WElVszt6ay
         3M6TZfRrWeOJqS84n0jHt320ZQyTJfAZtyiW9pWdtE3jiti6gmChmP3ss/Z/9HUTq3+r
         a/3IyDU8nJfEbke5J7u8oMLQWnlLoAP6waFV8+E3zI7Bgz+SCxK14McGWwGW/lBHbZn4
         2R2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795072668; x=1795677468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NB+/DQw+R5yX13wJ5rT9AuPgxEpA+KvH/c6A5+MmSzs=;
        b=TUS/1Uf7N3MXg3T317rMzPPtPMaKFzPJSHN4/PiWjw0Xj2m1wteuNoXN3dEkI62234
         DCnKOeGkNwg+Tih39cfJpj3BLQCO3wXc0w+vJU5pP5jdgVgKqhfrTYKmk6eKI/8VO2e0
         cPSSWph/SKbeeWXfAF0VGTNJfHn3mNBTVimk2rcQKT+BpmR8pmG323zpaKkVeK6G2mSH
         A9F53RvfG/alp414LQ+9uXJjky4tkNzEpmaUXZ6mWr6t1R3xWsNH6Xt1hSEDytyp2TBv
         wDZEIjkipVzMhiLDKv83ZbXrQvcH4j0ioDFnsA3qlSuTsHv+O7q9/1OAk9Hmt66hfiAg
         O9mQ==
X-Gm-Message-State: APuU4Z+mwgo1NKwTh+Fo/7NoNsQm4OLFEXem1luhPLBPkZzGcojY3mGp
	VEbHzdEo/gbKY7a2KLKZMPM+aTTA8rpIw+oHIQ66DDZCJRjNyQO8VVfj3cPFRQ==
X-Gm-Gg: AYBFou0IpOKNRXm1lVsq4LPu1TJUL6ZvX0ig7N7LEIs4TM2uraja9doqB/cGhf3GDlB
	qX2es0ABHopF98rq7YLIpcdjvljHPcwtXtC8o65gATldLRrAcdT9yTIkprtvmCnZg4iODCzl+C6
	pZn1SMWqL5FoJs9jXptBDtbzZmi55b7LsN6o3CVG8lmvZc9YbceglaZvzRgde91PQFzZIUEoQQ0
	AMnxlD0jWdb1L0NE9hXo39clFDid/cJ98lHeeOrMEk77qjXQ3jyizkd+eylrBqsUkblqZ8xBWj7
	fiAY965/5ONjmFIxSjqs+FbCNCjfDfErMe8eadZMg+Ic0uOTCB7lXFenslMqD/J+FpsoQnroQep
	2BONGTzDmBMZf+PpT7TiqjSyskK2NkyY0vVznWvYYrAU7fME5dnmj/tmyLA0TvV30ipsYdl/6oX
	wv/4ZXg9Zzyq5Bd1MiMK3OPn5jyDiIP1zBXsE4sHRgNOXfEgr4nu1BiuiWD4Ppm0r42twmk3pBq
	UFzyyx2t8mp2UD3Yf4U151j+o9xNwgOiiFACcHXTgep2gMBibu4o7mKG1bFxX992BBvJ5mtKIpx
	QIWdawzXX34iiSZ+NOCc49O8tdpeiQIKfrtg+5CHHprRXS0DDDiYB17oSDqh5POxXpDlDaPzZba
	YD4yeULxl
X-Received: by 2002:aa7:d74f:0:b0:6b1:ca87:c588 with SMTP id 4fb4d7f45d1cf-6b887ec885emr3786167a12.37.1795072668457;
        Wed, 18 Nov 2026 23:17:48 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b889a3315dsm2061733a12.10.2026.11.18.23.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 23:17:47 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH v3 2/5] testsuite/smokey/alchemytests: Fix build failure with core !cobalt
Date: Thu, 19 Nov 2026 08:17:42 +0100
Message-Id: <20261119071745.2409665-3-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119071745.2409665-1-yegorslists@googlemail.com>
References: <20261119071745.2409665-1-yegorslists@googlemail.com>
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

From: Florian Bezdeka <florian.bezdeka@siemens.com>

Taken from lib/alchemy/Makefile:
if XENO_COBALT
libalchemy@CORE@_la_SOURCES +=  \
	pipe.c                  \
	pipe.h
endif

That means that all functions part of pipe.c are missing in libalchemy
when build for non-cobalt cores. The following configuration triggered
a build/linking error, that revealed that some tests need to depend
on the same condition:

./configure --with-core=mercury

The linking errors:

/usr/bin/ld: alchemytests_pipe1-pipe-1.o: in function `rt_pipe_read_until':
pipe-1.c:(.text+0x130): undefined reference to `rt_pipe_read_timed'
/usr/bin/ld: alchemytests_pipe1-pipe-1.o: in function `realtime_task':
pipe-1.c:(.text+0x172): undefined reference to `rt_pipe_bind'
/usr/bin/ld: pipe-1.c:(.text+0x1cd): undefined reference to `rt_pipe_read'
/usr/bin/ld: pipe-1.c:(.text+0x26d): undefined reference to `rt_pipe_write'
/usr/bin/ld: alchemytests_pipe1-pipe-1.o: in function `main':
pipe-1.c:(.text+0x4dc): undefined reference to `rt_pipe_create'
/usr/bin/ld: pipe-1.c:(.text+0x512): undefined reference to `rt_pipe_delete'
/usr/bin/ld: pipe-1.c:(.text+0x612): undefined reference to `rt_pipe_create'
/usr/bin/ld: pipe-1.c:(.text+0x67f): undefined reference to `rt_pipe_read'
/usr/bin/ld: pipe-1.c:(.text+0x73d): undefined reference to `rt_pipe_read_timed'
/usr/bin/ld: pipe-1.c:(.text+0x7ab): undefined reference to `rt_pipe_read'
/usr/bin/ld: pipe-1.c:(.text+0x981): undefined reference to `rt_pipe_read_timed'
collect2: error: ld returned 1 exit status

Fixes: b72fd2d8c013 ("testsuite: Fully integrate alchemytests into smokey")
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 testsuite/smokey/alchemytests/Makefile.am    | 17 ++++++++++++-----
 testsuite/smokey/alchemytests/alchemytests.c |  2 ++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/testsuite/smokey/alchemytests/Makefile.am b/testsuite/smokey/alchemytests/Makefile.am
index 5fe481c29..fd9e909de 100644
--- a/testsuite/smokey/alchemytests/Makefile.am
+++ b/testsuite/smokey/alchemytests/Makefile.am
@@ -21,7 +21,6 @@ test_PROGRAMS =				\
 		alchemytests_mq3	\
 		alchemytests_mutex1	\
 		alchemytests_mutex2	\
-		alchemytests_pipe1	\
 		alchemytests_sem1	\
 		alchemytests_sem2	\
 		alchemytests_task1	\
@@ -36,6 +35,11 @@ test_PROGRAMS =				\
 		alchemytests_task10	\
 		alchemytests_task11
 
+if XENO_COBALT
+test_PROGRAMS +=			\
+		alchemytests_pipe1
+endif
+
 alchemycppflags =			\
 	$(XENO_USER_CFLAGS)		\
 	-I$(top_srcdir)/include
@@ -75,10 +79,6 @@ alchemytests_mutex2_SOURCES = mutex-2.c
 alchemytests_mutex2_CPPFLAGS = $(alchemycppflags)
 alchemytests_mutex2_LDADD = $(alchemyldadd)
 alchemytests_mutex2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
-alchemytests_pipe1_SOURCES = pipe-1.c
-alchemytests_pipe1_CPPFLAGS = $(alchemycppflags)
-alchemytests_pipe1_LDADD = $(alchemyldadd)
-alchemytests_pipe1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
 alchemytests_mq1_SOURCES = mq-1.c
 alchemytests_mq1_CPPFLAGS = $(alchemycppflags)
 alchemytests_mq1_LDADD = $(alchemyldadd)
@@ -143,3 +143,10 @@ alchemytests_task11_SOURCES = task-11.c
 alchemytests_task11_CPPFLAGS = $(alchemycppflags)
 alchemytests_task11_LDADD = $(alchemyldadd)
 alchemytests_task11_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+if XENO_COBALT
+alchemytests_pipe1_SOURCES = pipe-1.c
+alchemytests_pipe1_CPPFLAGS = $(alchemycppflags)
+alchemytests_pipe1_LDADD = $(alchemyldadd)
+alchemytests_pipe1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+endif
diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
index b596a1e17..24f6fa913 100644
--- a/testsuite/smokey/alchemytests/alchemytests.c
+++ b/testsuite/smokey/alchemytests/alchemytests.c
@@ -14,7 +14,9 @@ static const char * const tests[] = {
 	"alchemytests_mq3",
 	"alchemytests_mutex1",
 	"alchemytests_mutex2",
+#ifdef CONFIG_XENO_COBALT
 	"alchemytests_pipe1",
+#endif
 	"alchemytests_sem1",
 	"alchemytests_sem2",
 	"alchemytests_task1",
-- 
2.34.1

