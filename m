Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528991;
	b=ZrXDv9xjpkchjAo7yyphjdujFJDlcUsmcul09qwClyAyjPFK24t/daerDEn/VdLgT7gt
	 usy0udvzK9f3eAIcbEG+ay/lNZ2ng2ZaRLzV2joqwNMP97wJkzWk/Ev3+MRkYbChlJgd6
	 Ug0ipi8ZiwCaI1i0+mUqF6M9EsPHKspc41mbcyV6BCW4r41dl8B2N/IlD2sgog03zk3yr
	 op9VU+uKDZW/B2RGnW/y+bM7iOcJdK+gkUANv6h6Wa1oOiLXrJCiOqVMB2ZaIpA5vIqB7
	 O69v917OZC+wSezCpDnLsqmw6BhLNwZ35mITyN6lFj88RpUdhiGo+9f9aisRoy51Dgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OYvsskZPh2HKNncyj2wSG/6a2wt4ZL94BdQJiOt5lU0=;
	b=03PE8lTXkLVqoK3FrIqJ84IrFAH2kBBsFvpzx7GiVd32bPaNj4TRyHMR2mDDU19svwJ+
	 slNXF1mcSltiDMhQ49miDI7kbQnEFEMxi3BVCFRBe4ClsDb9DnYD8bd220wAXpk0yuQsz
	 FpdgwowhKr8oLDj1imNy3c7u2ybzlD5nM92VAvZL76zWXvJuGDIud/RpJFqFCaVlFEceQ
	 Va7lVoYRMzC162HmBaqJ226K6jVy/JkGd9Gxb5dkxVlDZ6eMrMdzbGN0mgDQ/vMRX2Gdh
	 IS/lzhqGMpJQ5x7+XhtihUMBl5rryJ9fLxwgK43C8abV9wQmvw1+Pzexj+ujqF/2+Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b="p/xddrfA";
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA28606A335
	for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 14:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EA28606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=p/xddrfA
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c5127c7abd5so713540266b.3
        for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 06:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795528990; x=1796133790; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OYvsskZPh2HKNncyj2wSG/6a2wt4ZL94BdQJiOt5lU0=;
        b=p/xddrfAHCkUKfUdITQOwoMR29nMw98zyN2Udjc36kAh6ARdBlX2geqyaDm6MSTiFC
         OdSR8uL/RnS0pXEOQgNVwjNA0weSvaRKAybxT94EPrdzBXZEwPUMOe9uQzhAta09epyS
         p4Rctjz3G7D1WuC5zB4WUQn1LA4EDVnfzLv6QmP1hajDb5E7TGN5vbso3rWCkQ0Qj67A
         bXKTOvdsmHI0a/RwBtKQUfFPsJkfeKdMkpP5ke2sgolBg+9Y5AAYjw3OnDb2AV9x8Lue
         xKMKSK+4JDLd4MTw9DVVsFjh8zkWeOMZT6+JyZFEVpExWpoxj+0P6Xr0wqR4CSfAJKLc
         63hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795528990; x=1796133790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OYvsskZPh2HKNncyj2wSG/6a2wt4ZL94BdQJiOt5lU0=;
        b=EA1Vvm/86PsjpG2LFEyTtDUuB9kUsyVyvu9OAhlsSb2ALNmBjqVukmwXHMMK5tAReA
         upDA8hAXgU6kLBpMWE5fjSXZpFYFLZBAFEsG59fLUuXK+9NOVrsb3tIjkKLcuTW1uB/a
         Nx9RMug8WOlKcyoQP5Bat47sFTfkCUYTE68z0yhKFXV76p7JQeQ39p4YNKd8s3s5xpnQ
         zTPV0zi5CXgc+i3tUll70b0utMJSaApjwt43y78Za4uy2f5V5cLoWfgjoqxPm2C1zTcs
         V3ZwSTMAaYQSh3+rv81mfLOGKR4I9KBBbS39/Ip3PewWkoJUuwCPF4U07iKOid24++jh
         Pbsw==
X-Gm-Message-State: APuU4Z9xnoufbBBiEq8caU/YjOwsa7Y1/NXY+pCcQp/pWHWWWFAI2TZ5
	umsSBWObU+gqs7OThFdpQhMxmm7Iuq5MdL1HQPs5nOjq0/FOcJMjX4JzyqCO7A==
X-Gm-Gg: AZFdTZf+SxPlYYCbKcrtEcHXmr8xaYxu562CgLggwdljC/tLeIj0XKlAA+Ck+sbGzea
	gIjptLXorkd5rjUMuRKOtqZSrDrdOCPjKCunRBhwqD182nKG7DV8nOrs5dYUZlT3wfmvX2SXMs6
	sqM4YD4lThP+EmgOtlcGEysiDpjcA1SXxjDffGcS7TeEbEJ4GCzzlSMNEZyDs2K/ThOzF5Yv6K1
	n5cjIrgCb0MREIxnixZIMqeImI8AEHjeX/L0R1rdP6AbAJCatTOfMfAM6D0QokBy6HIyvc+Nqsc
	8J4GW1aAVom33Tk+MrdaQzT9ysA3pYE9G8iEM4rwy08B3O5iocBBg1idoaceFfn8zxB93NLJjZd
	lLjQLAovU58GM76KIesW50YuM11/IMqZ0njQQY4bDoe9fxp/R2GW2iKVnmr3AHgc/OynUDWoc7l
	flKHQr8ipTAhWuy96U4fwF/ueDJmP6nFk+famvdaYDE5cb+8ofjWHBPiyz9UkXCDLZnn0qf24vd
	bEr6SmI0HCT1CVi/xZ+2Sx5UyUcOVoS2+X6MSnYy40O3Z5Eeuv4MmHTeOv7DYCXVkgX3dJtYZKm
	Bn6gvbAi48Z2aFN4C2PXArBu01DICAah5JEYsXIkN3Wcn+H/5fE13DHu6tSONm+lGr4Af0vkstJ
	tPh0cE68k
X-Received: by 2002:a17:906:eec9:b0:c51:5589:35a1 with SMTP id a640c23a62f3a-c515589d211mr886099666b.5.1795528989251;
        Tue, 24 Nov 2026 06:03:09 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513a8678cdsm510486566b.0.2026.11.24.06.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:03:08 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: xenomai@lists.linux.dev
Cc: Yegor Yefremov <yegorslists@googlemail.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 1/4] lib/cobalt: Don't rely on glibc's __OPEN_NEEDS_MODE
Date: Tue, 24 Nov 2026 15:03:00 +0100
Message-Id: <20261124140303.3336015-2-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124140303.3336015-1-yegorslists@googlemail.com>
References: <20261124140303.3336015-1-yegorslists@googlemail.com>
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
libcobalt fails to build with other C libraries such as uClibc-ng:

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

