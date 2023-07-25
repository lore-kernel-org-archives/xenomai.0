Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62095156C1
	for <xenomai@lists.linux.dev>; Tue, 25 Jul 2023 08:30:10 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-991fe70f21bso835126166b.3
        for <xenomai@lists.linux.dev>; Tue, 25 Jul 2023 01:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1690273808; x=1690878608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+El33RZAEEY0jlf/tLKduSvoPPneXyFUmg4Fbyb7/AA=;
        b=cKj2QdOO8QpWUxlNcqanO4Eaal4iiYbMS1EeEB7QCFTLWoPlfms8Y3YEkehRQ+sFZQ
         q/iQ8OWeZaQpGK5tdljR7VBf3dwaEPAr7n0wWKMVhK7ImGjBBe0ZSS4xYbCH+Bq4Cz8i
         26fdSkysSRJpG95EFnmX+LFeBoFXIZAPfcSUWDhLinFHOGx7dtP9VzegmWh8uvV54Zm6
         zHiNV4Fp5wHIJ5p04AaRBPi2BqvrhyBDrJIrBoz8wG7lWah4MEgdwDLS2+4Lk72t4DCK
         I8q5vtJZPFhL/idXqY5ozhwHR90TPYLR42pUy820UK26YZIdXe6VNc5FJJZjvRRhIQAp
         iJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690273808; x=1690878608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+El33RZAEEY0jlf/tLKduSvoPPneXyFUmg4Fbyb7/AA=;
        b=ADT+m6ucR5iB9fDfN594DgZ2+ouNPOUp6hxnCdz/DerTCSKb1JsB9gjWL80MV5kG3L
         cikHsyxe6lrdi2FTl6rCv4m8vo5y1ARxLUkHL9v9G8tXmafrl3WySB/UwgoHFA1oc9BP
         QjPeDtCTN0cSzSFWJ2ewgZrORHLmADZxmBcOmrucG8TgK5Z/mUgITF/QGqByFrcTfCUq
         5ytDD55T0igIxDJbSvLgbdofUwrdTU/HEP3pkZNG4j7tM3p7LJw+dlF22vFPh0ISrQLS
         IZOawl3sAXEs7WVkFdvm67R3zx/Uv/EORYKNDXm4SPmupVpGzW+/2HaIdo+qKuNAMUbO
         Rgrw==
X-Gm-Message-State: ABy/qLbb3vccEpVmN8EJD3TBsl+QNUirHg7vJbUiEORKEDusXirNb56v
	0tUFWWJpAQ++la+SZsM9d2cPvkiroqgbrsE4GLU=
X-Google-Smtp-Source: APBJJlEUM2zvlghjeo0kf43f2mY90AA+KJ/SlGQA10wYxllz3KxGfyRNDpR4dI62fDdrrrpN/+VP8g==
X-Received: by 2002:a17:906:8e:b0:997:ea90:96b4 with SMTP id 14-20020a170906008e00b00997ea9096b4mr11341076ejc.61.1690273808514;
        Tue, 25 Jul 2023 01:30:08 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id l2-20020a170906230200b00997e52cb30bsm7752080eja.121.2023.07.25.01.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:30:08 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 08/10] alchemytests: Fix task-2
Date: Tue, 25 Jul 2023 10:29:57 +0200
Message-Id: <20230725082959.5144-9-aaron@sigma-star.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230725082959.5144-1-aaron@sigma-star.at>
References: <1753829974.221010.1690209596711.JavaMail.zimbra@nod.at>
 <20230725082959.5144-1-aaron@sigma-star.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

task-2 seems to suffer from modern gcc, changes to safety and count are dead
stores. Uses a compiler barrier to mitigate this behaviour.

https://lore.kernel.org/xenomai/2065449276.254073.1649941119506.JavaMail.zimbra@nod.at/

Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
---
 testsuite/smokey/alchemytests/task-2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testsuite/smokey/alchemytests/task-2.c b/testsuite/smokey/alchemytests/task-2.c
index 592f2ed20..1284a8b61 100644
--- a/testsuite/smokey/alchemytests/task-2.c
+++ b/testsuite/smokey/alchemytests/task-2.c
@@ -29,8 +29,10 @@ static void background_task(void *arg)
 
 	traceobj_mark(&trobj, 2);
 
-	while (--safety > 0)
+	while (--safety > 0) {
+		compiler_barrier();
 		count++;
+	}
 
 	traceobj_exit(&trobj);
 }
-- 
2.35.3

