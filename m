Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13B738DE3
	for <xenomai@lists.linux.dev>; Wed, 20 Sep 2023 13:53:08 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9a9d82d73f9so875375066b.3
        for <xenomai@lists.linux.dev>; Wed, 20 Sep 2023 06:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1695217987; x=1695822787; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0kdUvD9io9jDHnS8+x48a7n3TkrXHen5y52mn0sSvc=;
        b=t50mg/O2L9ZpbHKJKyMw2g3OFGacVhVrwAMvPLWfQ+00c3ceT7zVd96v/YC7gQRz1A
         v4KjMsmQfLKuBWfYgMDklwID9At9TYnmGfGEgzTjkdaG5smolSi7SArgeTW55QnrKxMg
         K6REoFfPFa4Tp81XoUhTGQ3KwC+c27QQkEP0URs1iC7udVlSVYxJnOJWkzj41/cfq8ST
         LhCdWmli5mf9SYIQMhoSUk8IZzoF4gG0xFVy2L+mXRFw5d2OAMO4gwQENqp0SegH1bwB
         AJuxiWZ/eEtsnjTEfTgBSPMs4WNDXH0MpfXo6KWnmfuh4hq0/3rIyvTTXN+fJ5NZ8WH+
         6T0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695217987; x=1695822787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0kdUvD9io9jDHnS8+x48a7n3TkrXHen5y52mn0sSvc=;
        b=h6laD6Ku40bHvRwjsDOUH+/AndJZdy9KXl6ML71222miyJc7rWjJfDwGET6SEdln7r
         TCP5nFz0N39x+wDKs8P0omy4BZ+pcsO5K+xKrRzyCjkILt0+5EcZPACvid4GE1zH/Cgy
         imBopvJ3Ed3abERbkh5OFgnJJL7td56jGTqn1m5ZanVMDeboi9iJPd4O1Jc5OiHf/291
         3PRtDXUBNKEkoYaZDrGvhkm88n9gCpo1uBqlhm7myE1CfW0m7uDivUCIxKU/ZDeykp7w
         6l4hxblgoo+Myg9CswZQuKb1vNPWtC5t6/r2R1l90bmBfLqmjx5YMhH67+4m6DiXwYm8
         GJLA==
X-Gm-Message-State: AOJu0YxqllETfcxONsUCZLJZOWAiLrT0UgJxCXrjCwGimvmajO5U7yNn
	eDLBX6tbiAAHAD0usDmjc/V8FFaj0WEJoMtRJZE=
X-Google-Smtp-Source: AGHT+IFJ5XgXvOGB86RLKMDfLOG0KVG4WjF1ncvii9gME2/ncrTdglRZlt/NouUDXSRrE69VwQT9/A==
X-Received: by 2002:a17:907:2c54:b0:99e:5d8:a6f9 with SMTP id hf20-20020a1709072c5400b0099e05d8a6f9mr2085491ejc.66.1695217986300;
        Wed, 20 Sep 2023 06:53:06 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id mc17-20020a170906eb5100b0098733a40bb7sm9324008ejb.155.2023.09.20.06.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 06:53:06 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 1/5] lib: Add smokey_run_extprog as helper for testsuite
Date: Wed, 20 Sep 2023 15:52:49 +0200
Message-Id: <20230920135253.5842-2-aaron@sigma-star.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230920135253.5842-1-aaron@sigma-star.at>
References: <901c80cc-d506-445e-add9-00aa0e536803@siemens.com>
 <20230920135253.5842-1-aaron@sigma-star.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
---
 include/smokey/smokey.h |  2 ++
 lib/smokey/helpers.c    | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/smokey/smokey.h b/include/smokey/smokey.h
index 0ac1e8df4..4d0fe011f 100644
--- a/include/smokey/smokey.h
+++ b/include/smokey/smokey.h
@@ -259,6 +259,8 @@ int smokey_modprobe(const char *name, bool silent);
 
 int smokey_rmmod(const char *name);
 
+int smokey_run_extprog(const char *dir, const char *name, int argc, char *const argv[]);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/smokey/helpers.c b/lib/smokey/helpers.c
index 0fc450ff6..dfd63b409 100644
--- a/lib/smokey/helpers.c
+++ b/lib/smokey/helpers.c
@@ -410,3 +410,18 @@ int smokey_rmmod(const char *name)
 
 	return err;
 }
+
+int smokey_run_extprog(const char *dir, const char *name, int argc, char *const argv[])
+{
+	int ret;
+	char *tst_path;
+
+	ret = asprintf(&tst_path, "%s/%s --cpu-affinity=0", dir, name);
+	if (ret == -1)
+		return -ENOMEM;
+
+	ret = system(tst_path);
+	free(tst_path);
+
+	return ret;
+}
-- 
2.35.3

