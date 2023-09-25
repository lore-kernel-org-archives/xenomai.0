Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E9479E3
	for <xenomai@lists.linux.dev>; Mon, 25 Sep 2023 13:03:18 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50305abe5f0so9923027e87.2
        for <xenomai@lists.linux.dev>; Mon, 25 Sep 2023 06:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1695646997; x=1696251797; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSXDoBqP/41bZqVx0PAZ4UaeWw8TKZ3WGTh5E//xCjI=;
        b=jRX9J2GA0nnv6WzSEveng67FReQd3Q0JXGeZ14aIYAGDWQykoC4ftmtWMmwJo+uUj6
         sAbpDg5B+O6vAObTCjXmHMvPPE8S064p+XZatEOz0nbUyuN8NUdMYXCcBH+HlSgt96vs
         LTH90W4NenjIbpn9vs2H7trpncpasRmeAdGDfT1KpbD8CMVHJBSHP0qOFUnl5xKsLf/M
         gGS85MRWZtxNwdSpAFRA6PxxiJYmofO+s03ilwMTDHDcXoOPC7rEezBUY+rUPOTyS2Hg
         VzbT1ab386zuZ0A4askUHdWZrYBjQ1tfe7FUJsZapvtr5cdC5lUPu1IbXBXptdyEuiZk
         UOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695646997; x=1696251797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSXDoBqP/41bZqVx0PAZ4UaeWw8TKZ3WGTh5E//xCjI=;
        b=OKaerVN0jiY9Nc8DBfkQzYd+YgHv5vo/rsGkDhqNwNCieHS5zz0gdsnuLkjk2kDYBo
         8XwCn1LzGzrCDOEYK7TYPw0LaMHMqoRAYwiCh57/UruZG2M9NfPViS2Ucz6S1DPBn2AK
         iIyvGFWGU9ObDajcJ74FIF8KulURYUuShZ05jHx4n+vogYSr3E0ASzhmEL1C71slKj3Q
         GKXTYbH49fzGDeGdRgXMm5kuLcvLogxYswLZymVTSnAxjG1wiCwalxD8ZOIhmJW3FtG3
         /77bUnnDWXkYz9o7gFyIraRdX3MGe/ze/gpYBllqetVuShu/7byPtMI5ukWmMfe+KDO3
         7mlQ==
X-Gm-Message-State: AOJu0YxPDaUQVXCNMJfHaZRiSlAt4zGtwUnOrYIptSJXoaBZLX2ew/fJ
	o0/uNegWsabvkSUPVsQT6kJzcENlHVctTUQxDXA=
X-Google-Smtp-Source: AGHT+IF8rz3nNaLQytXRgmNITfQyYzDUFB8GITeIzkN2DVx/piYFREZkyiUcM9KParLa6r33hjIwOw==
X-Received: by 2002:ac2:5323:0:b0:504:51e9:89a2 with SMTP id f3-20020ac25323000000b0050451e989a2mr3165233lfh.32.1695646996679;
        Mon, 25 Sep 2023 06:03:16 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id e23-20020a056402089700b00530bc7cf377sm5469628edy.12.2023.09.25.06.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 06:03:16 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH] lib: Drop cpu-affinity=0 from skin-tests helper
Date: Mon, 25 Sep 2023 15:03:11 +0200
Message-Id: <20230925130311.17757-1-aaron@sigma-star.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <23cc119f-7301-49d8-9a95-03ff9e061ab1@siemens.com>
References: <23cc119f-7301-49d8-9a95-03ff9e061ab1@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alchemy, pSos and VxWorks tests assume zero CPU affinity, but we cannot
enforce that in general.

Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
---
 lib/smokey/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/smokey/helpers.c b/lib/smokey/helpers.c
index dfd63b409..b50d9fbb1 100644
--- a/lib/smokey/helpers.c
+++ b/lib/smokey/helpers.c
@@ -416,7 +416,7 @@ int smokey_run_extprog(const char *dir, const char *name, int argc, char *const
 	int ret;
 	char *tst_path;
 
-	ret = asprintf(&tst_path, "%s/%s --cpu-affinity=0", dir, name);
+	ret = asprintf(&tst_path, "%s/%s", dir, name);
 	if (ret == -1)
 		return -ENOMEM;
 
-- 
2.35.3

