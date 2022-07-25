Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826FC37E
	for <xenomai@lists.linux.dev>; Mon, 25 Jul 2022 08:42:48 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id q18so4496089wrx.8
        for <xenomai@lists.linux.dev>; Mon, 25 Jul 2022 01:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bMPJAomjt2vCT1HkAqfgc9qwIwEdJAqkVImmTA9B5Sc=;
        b=RhUF7PS88ORP2EQ26WStAo7lHxXTL9vqFADQm8vSErZekx+9A8LO/m56NZ2+jPb/jK
         QfKJD0/XwWS+QdMp8Q2+bxq6Zz3dyIYIIC59ItSZ0YPp4hCcTkNp8yOTGZi2fCGnxfUQ
         TjgKOKj9cVvhbwNCehw80Dpz8wRtK9zOFK1+D+jfqIgRk89XcbBd+nnVknw8vPGBzc+i
         cVbX1KKpghac976TbhrTtRLj8mJUYtgfeBX837MlJCf3X81+VWG+ciRhbV6IDGjPyetv
         nWwMLBqArP7rizrA8iMxeGSgCsbly5ykqpkYBILvAZPGKDj3nM4atj0UR4Blp3zHSPA0
         gB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bMPJAomjt2vCT1HkAqfgc9qwIwEdJAqkVImmTA9B5Sc=;
        b=N/QGQzIplPLtjRoaW11GeQRJzksumBrkhWh5vELrPpfLzjUUfbz3nL5FQUU5E+9ibv
         wDjlnj6OuXdqbQ1vdT6fZM/+XN/ZTETVTp0YntTET+HyXHPrBuHwy1UghOt4GxVhaXE4
         lHrMSqdPbb/CexvPfTcvEgzQGnfM4dlS0WUtYGiqUu/Fsg3FrytK0uQyohRDKoWnlQfR
         wL7vUiLm/pmNdaZFdYozv2fC3Gu8r0OjbmljHc/uXrZeJ3nV8LqIGTb4fdPxfr/edCZS
         gNwcsMkh5a57TG5ClB4ldvt8ZTjI7sVLZonSvE5O8mIXqh01+e08V+vk0tK2o8H9fjjG
         R6+w==
X-Gm-Message-State: AJIora9y3a8DFhX6c5yoiXJ1jkk1eLJnQ35V5QJkQ5hjxxmqerNn/dB5
	S1IFr90zfQp037JuYHlbfh9+VT+84eM=
X-Google-Smtp-Source: AGRyM1vvo3UVSheVOZNZf2TyXNNQ52tRFnSsxALVeUZWjFvWJbQLIJqI6lXK3mSp5NMd4pd5IJDUkA==
X-Received: by 2002:a5d:4608:0:b0:21e:5755:98a3 with SMTP id t8-20020a5d4608000000b0021e575598a3mr7033121wrq.240.1658738566620;
        Mon, 25 Jul 2022 01:42:46 -0700 (PDT)
Received: from lano-work.. ([80.120.136.76])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm29010463wms.3.2022.07.25.01.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 01:42:46 -0700 (PDT)
From: Norbert Lange <nolange79@gmail.com>
X-Google-Original-From: Norbert Lange <norbert.lange@andritz.com>
To: xenomai@lists.linux.dev
Cc: Norbert Lange <norbert.lange@andritz.com>
Subject: [PATCH v2] fix build with clang
Date: Mon, 25 Jul 2022 10:42:31 +0200
Message-Id: <20220725084231.8584-1-norbert.lange@andritz.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clang will never support 'variable length array in structure',
and there does not seem to be a reason for this weird construct.

Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
---
v1->v2:
*   fix algorithm
---
 testsuite/smokey/memcheck/memcheck.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/testsuite/smokey/memcheck/memcheck.c b/testsuite/smokey/memcheck/memcheck.c
index a33700f49..b11d2babd 100644
--- a/testsuite/smokey/memcheck/memcheck.c
+++ b/testsuite/smokey/memcheck/memcheck.c
@@ -80,9 +80,7 @@ static inline void swap(void *left, void *right, const size_t size)
 
 static void random_shuffle(void *vbase, size_t nmemb, const size_t size)
 {
-	struct {
-		char x[size];
-	} __attribute__((packed)) *base = vbase;
+	char *base = (char *)vbase;
 	unsigned int j, k;
 	double u;
 
@@ -92,7 +90,7 @@ static void random_shuffle(void *vbase, size_t nmemb, const size_t size)
 		k = (unsigned int)(j * u) + 1;
 		if (j == k)
 			continue;
-		swap(&base[j - 1], &base[k - 1], size);
+		swap(base + (j - 1) * size, base + (k - 1) * size, size);
 	}
 }
 
-- 
2.35.1

