Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258A914A99
	for <xenomai@lists.linux.dev>; Tue, 25 Jul 2023 08:30:08 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-993a37b79e2so836898966b.1
        for <xenomai@lists.linux.dev>; Tue, 25 Jul 2023 01:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1690273807; x=1690878607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oYSiQJOfTOkadrBpzsusxC7onjqteGDwjUEKwng54o=;
        b=pUCmCPaFrdwIUjxSHwGtCCzXbM/ykvghXALlcgvCACyCa2+n82pqPHbYyyWMh9b4IR
         kFLX1dQHdMcsCpseRil3S3x5+WwHCh7CpKHqQynVoVhZmNjA930WSGocD0tvd8Dumkjf
         8/R6B4ZN2YBQlx4nxEqyMIiJlr1Ducl1qde3RZWluHUk7mN1ayWk7uWOmEJmqUGvUwov
         lQNBXaB5kuAHy9OKCxyBR2ulKUsOjzhHMpaY8/pMZbhdhfshi2pRmFJrW1kSfxZNF6pw
         EzursrSxyr7IGhrvzAowlJkGFq5v3R4ocORX1Ao3bGT7HgWVzrJwCFFAQ7hEVkWIodS3
         oapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690273807; x=1690878607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5oYSiQJOfTOkadrBpzsusxC7onjqteGDwjUEKwng54o=;
        b=O5SMnrXiQVlGiiH7AEJnJ3J+xEiH7fKhQ8zfpCzI5Ve2DbFOsLK5WbnNgfBLKvd/Ym
         sF2Hszxlf7g+L1JUw/7SOa9RBhLCEf+i+Vj+n/bBbNnN9Cz9EzGXjdfcn+kogtsVKviM
         MuxJ1uagFgEjosbXYthf6trTLf727A47mo4rMw3Urae58RmAWNNhQNv0ccflVybMeLx9
         V98V5P/RgQOOsg2wON+IWh4fNzkUiGvI5/+FRbmn8WKDPi8ZBGw1ONh76oh3G34LaDT6
         ZI+cWV+O9yYHWUpYN/EAGg3ovTQNqpHBVdf3xhEkWi5tCAsE7Md21J+XcrXzydvZf5M4
         8GcA==
X-Gm-Message-State: ABy/qLYp+72hfQL7GKFWCAXMg7NRE/rO/QRUQYPFXm791mXuYPha/ckY
	rDybZ+WaXMRoEUBIfsk7QE6sEhBhSr/kquLSsp4=
X-Google-Smtp-Source: APBJJlHp4B5chiGe56NrlDsugNSZ8I9w+bXz/k1wGJfH73ubA8uVf7x1+PpVYtQ/2h+JknQny5J9jA==
X-Received: by 2002:a17:906:3041:b0:991:e458:d14 with SMTP id d1-20020a170906304100b00991e4580d14mr10674948ejd.34.1690273807212;
        Tue, 25 Jul 2023 01:30:07 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id l2-20020a170906230200b00997e52cb30bsm7752080eja.121.2023.07.25.01.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:30:07 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 06/10] alchemytests: Fix gcc warning in task-9
Date: Tue, 25 Jul 2023 10:29:55 +0200
Message-Id: <20230725082959.5144-7-aaron@sigma-star.at>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Richard Weinberger <richard@nod.at>

Make it static, no prototype needed anymore.

Fixes:
task-9.c:13:6: error: no previous prototype for ‘sighandler’ [-Werror=missing-prototypes]
 void sighandler(int sig)

Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
---
 testsuite/smokey/alchemytests/task-9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testsuite/smokey/alchemytests/task-9.c b/testsuite/smokey/alchemytests/task-9.c
index 56cc7bfeb..9bb43efbd 100644
--- a/testsuite/smokey/alchemytests/task-9.c
+++ b/testsuite/smokey/alchemytests/task-9.c
@@ -11,7 +11,7 @@ static RT_TASK t_test;
 
 #define ONE_SECOND  1000000000ULL
 
-void sighandler(int sig)
+static void sighandler(int sig)
 {
 	/* nop */
 }
-- 
2.35.3

