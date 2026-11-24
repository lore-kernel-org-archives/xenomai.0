Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531909;
	b=1z4nKjy1+K4VAg4ZSiFPMPA6b8Zo3S0CPbEDguDu3CKO5JZORvImqsH2ihiKIl2SF7os
	 KKUlqiK+RJADs8TsdhUCk39XXNQgS81kSHvSbZ2sapHM8Hyj4mu5ymDHumB1EM7UC6pWi
	 6AdtY/DWyu5Y9oiSooGjuAbB04veSTvSvmfiYBL5DvCFi8VI/9mdvIRzK6tM8zHy/V3h4
	 mNXM0BWZilAEJp7qumtvmKaVyaN5/6gzwjM1bXGkfGFupr8IDFVKHG1F129GSgsEIT/Yz
	 Tb+xkrf/WoTLD78W2VL7k0/S2+btw7inDygM+w8awfYQ0/OrhaOIJuRYKaImzrJGFmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531909;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NgofwjeJ4ryG00y5OaPNUbT5brS33lq4SwdyUpuUrXA=;
	b=nClsl7QcXnVHVfHopHWaIYauaQrB+3AG2P9W6lQ/oGTSHEXFPw1/arQl1od8mb6iWmFZ
	 0aicOJJ2FvHEvXi/AhirGPYA1cAGvBiTLadNwW/H0pdwezkuYhWspQ1CcYFtxqZJfRgyi
	 D7DABRbtEkCNcI2uR75edDhCetf8OzwrblOuj8k9dHpNjYADJbF0abwvd8lL7ZpR4smWv
	 964CJohV0ADij1saUk0/tV2F76yZ8b3s1i84TogWhfP+6cnUl70d/miCFvJkEuHqliDOL
	 mW+MJl4vrZgWQxOad1oI01V3NaFZrIn6O74vs1Ptz/CootyyLZprhhs+YU/itLEmhYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=NNf3Gkxa;
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33266606A331
	for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 14:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33266606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=NNf3Gkxa
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6ba12b00c76so4799139a12.0
        for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 06:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795531907; x=1796136707; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NgofwjeJ4ryG00y5OaPNUbT5brS33lq4SwdyUpuUrXA=;
        b=NNf3GkxaP/LiXblF7TQ8CK/OoQ4KOCOvwqYFrX6yj2ufFILwlX7n2Ka7CFCM3PMCVY
         c+Lk24ACxAFy4/3/AbE8sB5gyBy4vJJJfkgEyNicG41eavL8IvAn8VCkCtnwkFdI39PY
         f35+/gjoHa/2VWlRG6IR3yMIqJ+dr7tu3gd5zqaerYQdj+MKtStThlfhL9WjLV8IqWc9
         +1G/FU6YLhZ9jNJX2fW2RkbnjQC+EUFhpuWqN9B2JU4cY/SHY3BIej4fETpZskYYp8hJ
         RcW7T8qPWh/rupKNnUB9HyuCJBklN92DbLrwtEf/bc6cVqs6YG7pbZ+KCZlZxUduSEL6
         qcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795531907; x=1796136707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NgofwjeJ4ryG00y5OaPNUbT5brS33lq4SwdyUpuUrXA=;
        b=uX9NSVZx5OvLblF/wbNTr+Bv5ZQoO08dfxnPJKrCO6LHxpcmSX0mOEFOCaWjq9ng7z
         erzEGsuJVyUZ/5LsYDqW6VjQ7BB3mkzmLy6Sw+9OdU+9FlylFrebLJORxDz36K6mgxDV
         xGDvLiaC9yPL+vHOcm1b6qkCURyKaUEuPAO/NjHMio9PnQbLwe2d5xBUutsFU0/gbmhS
         lknySa7Ajnsb0ZekB38pYFzIfFgp49bjR3xHuaoyljSlFTFUJ/jtJGZiPcBa5lKJJAWr
         sbXDS9ZvirpSSWXLER16SBr/B4PVT1XNTvJPKbXotGPyotm7BEh6cbC2C6tIP02n0ioS
         Dqdg==
X-Gm-Message-State: APuU4Z95y99Vu1pmSLNOPJrBonlIh5ICTAT1dYMWyBY5aEK/VCd64rCK
	Scvbk5RsTWtuJKP+QCQaSjVSIuLuPQpMYH+J4IccRMmrD17q4chKtPz58rq3DQ==
X-Gm-Gg: AZFdTZfVOpLIrkaRy21oQDPVOQTSkbreznC0CLLteeE73VBO5fXbCyRNjUuUmUmEIGQ
	HtgZNdz4nXf9IU/MxXn1hnmn0UUO81mmLuMJD8SadfM8mMPSXE7uGXqsXp36QVSA6uVKYvGTyUy
	JX30Fd1ysWjeS8lvmGz3gmz0ELWSTM0/W1npkALR336Cazlpcb62eXG4Q+lK25rSjKzDhcpFzvh
	R5APnIvswfpFVnowrjMEszPY5/qjmX8OkuW7KoXn2eKjD6Fkc5U7AD2fbob2soSZQxVWGwNooTN
	ASOe7f84hjl4TglX70Y0AYUcdj9+IT40/WL5LBH5KhZz4bk12BBgrrJyZa9y5Dh4R3Hs5f/5lbv
	ZdkB6mahnBStAJfqDFAz3n0wFvC3QSryOic6e9/YqpbR6US+uERcOyeSNv9rZVOYIdlCA2dVBTw
	7D77E2Nl9hFWegbCKQwgiWkLwWbVIz4Ds7JhCeAk+UPmtXLhLuKwBOhsFYPqR4hNC/8QdN1tBiI
	2DUTTFDejux+Zpp9WzTWnv7ChZ6lPZNINGZdPVbsOcsCcwwd5inDqZv6cclYLpP8qUvIowD7e6t
	SG6dp6Q39VGVHbSKxXkJI7+equvCCnlRnNUqmCHZp/7B8c9lFZzB5wFYFQOV4oiiP574y0WryhW
	LBGbj0EOD
X-Received: by 2002:aa7:d587:0:b0:6b7:a647:c28d with SMTP id 4fb4d7f45d1cf-6ba37eb44b0mr7250324a12.32.1795531907328;
        Tue, 24 Nov 2026 06:51:47 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370e8ad0sm6937861a12.18.2026.11.24.06.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:51:46 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: xenomai@lists.linux.dev
Cc: Yegor Yefremov <yegorslists@googlemail.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 1/3] lib/cobalt: Don't rely on glibc's __OPEN_NEEDS_MODE
Date: Tue, 24 Nov 2026 15:51:42 +0100
Message-Id: <20261124145144.3411177-2-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124145144.3411177-1-yegorslists@googlemail.com>
References: <20261124145144.3411177-1-yegorslists@googlemail.com>
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

__OPEN_NEEDS_MODE() is an internal helper of glibc's <fcntl.h>, so
libcobalt fails to build with other C libraries such as uClibc-ng and
musl:

  rtdm.c:94:13: error: implicit declaration of function '__OPEN_NEEDS_MODE'

Factor out the check open() and open64() already do into a local
helper and use it in __open_2() and __open64_2() as well.

Fixes: 89f00a2e5458 ("lib/cobalt: Wrap __open_2/__open64_2 to support _FORTIFY_SOURCE")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 lib/cobalt/rtdm.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
index df7aa7eb6..58d943804 100644
--- a/lib/cobalt/rtdm.c
+++ b/lib/cobalt/rtdm.c
@@ -36,6 +36,12 @@
 #define O_TMPFILE (020000000 | 0200000)
 #endif
 
+/* like __OPEN_NEEDS_MODE(), which only glibc provides */
+static inline int open_needs_mode(int oflag)
+{
+	return (oflag & O_CREAT) || (oflag & O_TMPFILE) == O_TMPFILE;
+}
+
 static int do_open(const char *path, int oflag, mode_t mode)
 {
 	int fd, oldtype;
@@ -62,7 +68,7 @@ COBALT_IMPL(int, open, (const char *path, int oflag, ...))
 	mode_t mode = 0;
 	va_list ap;
 
-	if ((oflag & O_CREAT)  || (oflag & O_TMPFILE) == O_TMPFILE) {
+	if (open_needs_mode(oflag)) {
 		va_start(ap, oflag);
 		mode = va_arg(ap, int);
 		va_end(ap);
@@ -76,7 +82,7 @@ COBALT_IMPL(int, open64, (const char *path, int oflag, ...))
 	mode_t mode = 0;
 	va_list ap;
 
-	if ((oflag & O_CREAT)  || (oflag & O_TMPFILE) == O_TMPFILE) {
+	if (open_needs_mode(oflag)) {
 		va_start(ap, oflag);
 		mode = va_arg(ap, int);
 		va_end(ap);
@@ -91,7 +97,7 @@ COBALT_IMPL(int, __open_2, (const char *path, int oflag))
 	 * parameter to the functionality of open(). It may be used when the macro
 	 * _FORTIFY_SOURCE is defined when compiling the application code.
 	 */
-	if (__OPEN_NEEDS_MODE(oflag)) {
+	if (open_needs_mode(oflag)) {
 		const char *msg =
 			"invalid open call: O_CREAT or O_TMPFILE without mode\n";
 		ssize_t n = __STD(write(STDERR_FILENO, msg, strlen(msg)));
@@ -105,7 +111,7 @@ COBALT_IMPL(int, __open_2, (const char *path, int oflag))
 COBALT_IMPL(int, __open64_2, (const char *path, int oflag))
 {
 	/* just like __open_2() and open64() */
-	if (__OPEN_NEEDS_MODE(oflag)) {
+	if (open_needs_mode(oflag)) {
 		const char *msg =
 			"invalid open64 call: O_CREAT or O_TMPFILE without mode\n";
 		ssize_t n = __STD(write(STDERR_FILENO, msg, strlen(msg)));
-- 
2.34.1

