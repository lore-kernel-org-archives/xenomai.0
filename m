Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D8428EA
	for <xenomai@lists.linux.dev>; Thu, 21 Jul 2022 10:07:18 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id bv24so1539171wrb.3
        for <xenomai@lists.linux.dev>; Thu, 21 Jul 2022 03:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N6Hv9PPid1itRm4I9bTwANJXSS1bzRCjcw9Z1XPeUVk=;
        b=VSHJ9MnV7d3uiJfr2WvxJ9JUzmJEs662CAZw2ItJ/w8+ZCqFHioqszHUt31zm24sDL
         CRauOuxkvuj6ArLz5VxfLmcEdlDW9EYN0cLNuYnGZwhCbrcBpyVeAIf3QyAeosVQ8e6x
         S5BMog4X3BbMNxkn6rmXqrZds/UCtPWTqzms24DxgO6SJdcB5f+VyKcP2DstOYJi9Pdh
         PD1XqWXKdmSCOcflUadKKbXZ1Y3ZZXbnkjutiheBVrXgxOuIJeZkRp1qCpYdzXZEwseh
         bp7YToBbtdyCZZ4lnlT//VYhSSUpE99qqZftgxdR4qCOuTymU1g7GAsAGgsQJpSqlYaP
         Zwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N6Hv9PPid1itRm4I9bTwANJXSS1bzRCjcw9Z1XPeUVk=;
        b=rgBzOvKgdnqqTcFVGl2okfz/4LdF+LWqOogKHiS8L9FgFo8NglMWLlPEt8B2aAFJgw
         PcTKvJ0Isn0mE0enrnyeISq562Vb3D5usIa8E/IbBW0+XilWyqYsCbB2CUuLfv2aQAG6
         2RFfK8/m+0ny8PbKRLdgZdmIUSKfHZOPNexRnX+DTfi6aSaUWG7e01Ia+RY57YsS4Ofj
         kHyYZZrOkKPTKo4EArs4CXHhnQ0cUtWMa7yePKhj4D3AxhIt8Wqk9lrGb0UwytkhgLTR
         MITG66bonpO7sOsuZeEMeDSiInEdmMxziT2SR7g9nl1gHqH6vzbWSjNSgpzCbkYBhwTT
         Dzxw==
X-Gm-Message-State: AJIora8FsTixrFuXQVlE/uhadKVIVTKTtZHGbw7SvV3ijaT9o7aKiEzD
	vJgpDGyJl3NxuzJZEp/GM7qOnykOLog=
X-Google-Smtp-Source: AGRyM1sOFAA/JUfaCotLSjxHQfH+TWXl0i910qKLa28L2lWaDcj/DwmOTYCvwBOBLmSQV2qTXN9Jaw==
X-Received: by 2002:adf:d1c9:0:b0:20f:c3dc:e980 with SMTP id b9-20020adfd1c9000000b0020fc3dce980mr33322428wrd.552.1658398037086;
        Thu, 21 Jul 2022 03:07:17 -0700 (PDT)
Received: from lano-work.. ([80.120.136.76])
        by smtp.gmail.com with ESMTPSA id j13-20020a5d448d000000b002167efdd549sm1415811wrq.38.2022.07.21.03.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 03:07:16 -0700 (PDT)
From: Norbert Lange <nolange79@gmail.com>
X-Google-Original-From: Norbert Lange <norbert.lange@andritz.com>
To: xenomai@lists.linux.dev
Cc: Norbert Lange <norbert.lange@andritz.com>
Subject: [PATCH] fix build with clang
Date: Thu, 21 Jul 2022 12:04:31 +0200
Message-Id: <20220721100432.672540-1-norbert.lange@andritz.com>
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
 testsuite/smokey/memcheck/memcheck.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/testsuite/smokey/memcheck/memcheck.c b/testsuite/smokey/memcheck/memcheck.c
index a33700f49..c12d658a4 100644
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
 
-- 
2.35.1

