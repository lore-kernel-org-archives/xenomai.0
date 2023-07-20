Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B944182D7
	for <xenomai@lists.linux.dev>; Thu, 20 Jul 2023 14:52:13 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-977e0fbd742so150322966b.2
        for <xenomai@lists.linux.dev>; Thu, 20 Jul 2023 07:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1689864731; x=1690469531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SzOT8BUrNaP6fiwMHPU6OFn8dJ3haI5rujiB9K1D2U=;
        b=A94f1mJ1TkGjmrYIzUIW1/NuoUPzqxKQG5fkqF3PB1nwYp2ZfXPJ3jy8+6L2Ut5eVt
         2WqWK5iX9AgNKt5AKa9qoqTJCan2tbQqp+VnSXPgnYhrA2Uv0HTGufEzBbeMuVdrZ/EC
         fCajvEh8GVvHKjMU3lH9IL4B72yU5f7JmJDjsvdq0bAVlz2P8O16lgsdEyOriXNuppNM
         wPSB1o3vHDfp0xXeu7R4s2KVOXlcqPtX138w5uDzGMK4RecwyInT0u6XZd5YisMUMX4e
         jWdEL44mkMdBWqqpGZMVhrAV9iXrIelGmMTPKUhbbZjheMjRYa0ttGyH2hZ9EZ+JSh7o
         D8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689864731; x=1690469531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9SzOT8BUrNaP6fiwMHPU6OFn8dJ3haI5rujiB9K1D2U=;
        b=Jl6WBfIrsUEEBo3QDsE1LPH4N75NNk3X+6gZthax2JkxJD9daoXbpJsV2S+x7qtJMI
         YtAQxEYgEq/Bu2BKeEeMYPFBUjbWzVATo1S2UVl4gJ65JzmTalkDzRuAoG/dAD0PeTVu
         SpbbwLqtStab6Hgh/cQhmwAUlc9tHd3qSl7VkbR0GH2jDcFPIiap8RYmaHdLXCAOB674
         Rq6Lx+OOKmvLFgGJCgANp4SYv6RHutSVs+dukOdE5Ia+Gh8eeTMv6s4OE/2YGA/eKMjA
         UunuZhDaho7n7p7DEbpMYYt6QdXc5FFOBqP3AlcVvnr5EeNQJEiwsRdrpY5H3mNdes81
         5yoA==
X-Gm-Message-State: ABy/qLb99+xhlWUV99c64Nr4dAeJs/yYZXXy7EP5CxWSxbDN9LTxY4+A
	Nsu0oT+lFqgfA6xySpnNzGly6CD842JnMyb0lbc=
X-Google-Smtp-Source: APBJJlGRNkM7wD9tI5cZz5vCOHbNxwPyYqBIBthA4pv6VXNwlbUccG3SULCePp+3+Sre3EYTXbKBhg==
X-Received: by 2002:a17:906:6a1b:b0:98f:ab82:8893 with SMTP id qw27-20020a1709066a1b00b0098fab828893mr6243249ejc.73.1689864731618;
        Thu, 20 Jul 2023 07:52:11 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id h13-20020a170906854d00b0099290e2c163sm793462ejy.204.2023.07.20.07.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 07:52:11 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 08/10] alchemytests: Fix task-2
Date: Thu, 20 Jul 2023 16:51:48 +0200
Message-Id: <20230720145150.24607-9-aaron@sigma-star.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230720145150.24607-1-aaron@sigma-star.at>
References: <20230406103341.2914-1-aaron@sigma-star.at>
 <20230720145150.24607-1-aaron@sigma-star.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

https://lore.kernel.org/xenomai/2065449276.254073.1649941119506.JavaMail.zimbra@nod.at/

Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
---
 testsuite/smokey/alchemytests/task-2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testsuite/smokey/alchemytests/task-2.c b/testsuite/smokey/alchemytests/task-2.c
index e751ddd34..9d5281c75 100644
--- a/testsuite/smokey/alchemytests/task-2.c
+++ b/testsuite/smokey/alchemytests/task-2.c
@@ -28,8 +28,10 @@ static void background_task(void *arg)
 
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

