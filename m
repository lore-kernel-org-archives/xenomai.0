Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795002555;
	b=rZkLDukCUVvBU57O5UOPjU2F26p13YTZldFHF0bXHk0wqTb5qk0e0fqvz2OC6kFreld8
	 HfqygXancWGXeh9TJw+Xo6qVGsQXh1g6/2hqZ5g7cD8fsG6N/ULqSSBPAozt4WJvbDFJd
	 9D/B8b1qGOv7oZzSSIJWluKhRZxGW6073A2v/QS+CDxT/x+4ESPzqdmWjOf0Vot+O4EK7
	 JIet91yG7S8TzAnyOLV3wtiF25RMMOGncWnDZItGrCbJHHcUK7boJE2Nb7Zkfj0QGf6rz
	 9pQ58s08VHXcgRdaTgJWFz/JnLdmjS6LwKbuH2DFuI4sTpT+whqER2Bz9gH2+ZT+ODw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795002555;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eDkde7eW4Qu6yOl0PndwzgbT/dr+rnaaefhnzOnfl3g=;
	b=KZkD/BaxUNFD/q5caH8Drw97AVFpCA7Ys5gsuoXvslzFkGBowH7txLoRHVnnSzvkwTqU
	 BFeMUbpJRCh89l0GKlK9VueoAPQw/ohRiTlYxCYWFxvD/dgk+UurlOopUWzuXps2iPMuh
	 sEhz0gQzEAZN7xLuJmswg/mnlhI3iA+EPk3jjBgb8VbfKMKZewxQxLx/7H8OthJi8cCXN
	 Krt5YCr4E5C8Yav+rtauETC18KcuGC44h75vyrsvpZrv9XybrA8KcTXXZDR9HveA4gil2
	 u5pxNtSzFV1qnkAySpHdEeRYPGH83cCqqy0ZRfJ4NtweMeTrlH339M95re1iRjRdEJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=BLMsQQgV;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7EC606A31C
	for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 11:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA7EC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=BLMsQQgV
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b88d143160so861069a12.1
        for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 03:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795002553; x=1795607353; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eDkde7eW4Qu6yOl0PndwzgbT/dr+rnaaefhnzOnfl3g=;
        b=BLMsQQgVVWYp7DXKCLwLjIlRkUOkUNhc/8ocb0Tl9NcZBrmtNacLgTlT8ZUh+D3k74
         1GboaAjdPULgNJilEts3/jBy96Z5oJ82jjvfOCpVHD2kiqrtEosM0liFvj22S99GSzyM
         rpsRzpk45iHcNCqNyZEjuD4kCXAKJEJFA8B73A2t4OTWMSGD9CoGe1d06JwOyH94Lnsp
         w2ay7x5lYB2kgjbwPVs9YdQtSiHIpF+8rQORG9XYWD+7/yvgEBF7PPyhoBxfZf9iGzoG
         ykDYiZDShipZM740XgbnxIA0hkW+eLj4gdKIv2VvDkf5Fgix9gxpe2NNFpCKmx4ef4B4
         wnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795002553; x=1795607353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eDkde7eW4Qu6yOl0PndwzgbT/dr+rnaaefhnzOnfl3g=;
        b=veqbciN8ufkArWyU2ddT/JrFMmjDX6H31cRjBz23L1Z7d4ROZ33zWyr+67ujskbw+E
         xyXh340lnQ9ATeJixT/srbRjr4syXuvqzPGHGbEMm303p4LggtF35McMQt/1R3zVBUX5
         K5uakcacCkRa3rxssEduK+4HSkOesNgRTXON2SLxmqVEXEbEYki8MRPaxIpdLIm8eXqF
         CX1swD2SlAbGxjL+RCue6bKEHD+2PFiVmmB8E/KduQxb9DOs9l4i/FAuWbie8O8phklK
         twaWG1h5KYuPi8ESuTXstAnYJzssKYKcx5Mj+GViVauSg/EDbLbDUZKU6wPiz8oC0g/s
         dV8g==
X-Gm-Message-State: APuU4Z/FhAQkBSbp7h+wtaNyrAM1vCu7SsCXjgy93gY4GqSmHzFg24rf
	uPc2/2yJA3MyUYuV7Ozw4S4Uw21KejSfP6xBQnHaP9qQZBlCMlCJRX0LwzW5dA==
X-Gm-Gg: AYBFou0uhwE5uwPFmNvkIl4bP9G4kzrLL8ZMIrZVuv5+732kbMpB0pGoza4gzCTGBE4
	Hr15rr65cgMbvi8XEZ0gkFwFfeZV4y94lfOxjZwOZEeKeoDgPpW4qZAn8O5nszESxCEQrXTRrR+
	oO4kJl0SJePyjpjTW6lVKNnOTyVI3AmzZKIxJKYTwzcXAn0ndHTx0FtGHbgVIRvh4KjgGDW7wHf
	cC7GBmYatKyV6p1xS9aQZyN3F0iLYy93ysWuX/dIkT9klY5P2C4FgICajQJW4/U3de7qVjHklfD
	Zwn1kHwcaHZKvDyuVt8GTELJTJ2wFvZJ8cluNm4tlgkLKE3bXB/cykeJtKFd07Lb8JPp6GOM1sa
	o6TqpxUm0bMk2N6Sx2IehAdA/DHn8FWj9LWePyKLFvlvJQSuUz+fUrNyYbJ9qwwCnHp889UjZP/
	+Q5His2m3LzHV81MtRIXn64D5LshgO3Lua5szQUzAstHWXHDyoKobQXAXtVtuaTrx462e9ytoe7
	oE0zc0HvuZ/lLYijqI0zOGfw/lMeLKaEGtz1K2HzdZ8ifcW5ukCeP8D9lPzwoMtNzMzvXpHz1eo
	ZQJ6z6GllPNu5JIqJGhifFxQSSZrO6wrDR6/QzMPkVfMNIDn3/5RY+EMapdZ9Uo6yHaXOj9Plqn
	xxS6WJO4f
X-Received: by 2002:a05:6402:13c5:b0:6b7:245a:a50a with SMTP id 4fb4d7f45d1cf-6b887f03688mr1927616a12.41.1795002552808;
        Wed, 18 Nov 2026 03:49:12 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b888ef94a5sm917931a12.4.2026.11.18.03.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 03:49:11 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH 2/5] utils/autotune: Drop unused sample counter
Date: Wed, 18 Nov 2026 12:49:06 +0100
Message-Id: <20261118114909.3030884-3-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118114909.3030884-1-yegorslists@googlemail.com>
References: <20261118114909.3030884-1-yegorslists@googlemail.com>
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

The n counter in sampler_thread() is only ever written. GCC 16 now
warns about variables that are only incremented, which breaks the
build due to -Werror:

  autotune.c: In function 'sampler_thread':
  autotune.c:95:34: error: variable 'n' set but not used [-Werror=unused-but-set-variable=]

Remove it.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 utils/autotune/autotune.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/utils/autotune/autotune.c b/utils/autotune/autotune.c
index f52733b7a..2e25daef9 100644
--- a/utils/autotune/autotune.c
+++ b/utils/autotune/autotune.c
@@ -92,7 +92,7 @@ static const struct option base_options[] = {
 
 static void *sampler_thread(void *arg)
 {
-	int fd = (long)arg, ret, n = 0;
+	int fd = (long)arg, ret;
 	__u64 timestamp = 0;
 	struct timespec now;
 
@@ -102,9 +102,7 @@ static void *sampler_thread(void *arg)
 			if (errno != EPIPE)
 				error(1, errno, "pulse failed");
 			timestamp = 0; /* Next tuning period. */
-			n = 0;
 		} else {
-			n++;
 			clock_gettime(CLOCK_MONOTONIC, &now);
 			timestamp = (__u64)now.tv_sec * 1000000000 + now.tv_nsec;
 		}
-- 
2.34.1

