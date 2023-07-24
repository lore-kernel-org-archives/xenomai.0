Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE59C8F1
	for <xenomai@lists.linux.dev>; Mon, 24 Jul 2023 13:53:00 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-51ff0e3d8c1so6292037a12.0
        for <xenomai@lists.linux.dev>; Mon, 24 Jul 2023 06:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1690206779; x=1690811579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4T/h8f7UA0MwJtvuR5Ih4P1FPPGqFQNWXoqmPtCy13Q=;
        b=Y76opnDL69FXXesDYZHhKj3t5qggSP3Ll0Arz1r6lU1cIt7CpNTAmvoJKFUCIuKep0
         vcXTuXImt5K8LefonAwb1xq+nrZEPVFI87xrfXp4w6e+9Kxo7P9ZEjqTqjRug11cZb3J
         RSWiaXAw9WOQoqd24L2VBWAmPTr09D1CGP4z1reURttfJe4wvFR3srT+04A6mUxVrjYJ
         w2SMMJ6/YtO9UvNGh4nKsoX8vk5WmKf0MM+e0ae5Ls14HgdVPlPKFsyqzp+4pCvH3IOX
         rPcG4WAkliOfVTOpnGwVYLNF2nY3J/lx+T73W/AzeRWkdpHQ6rwGTB/TwVun2oxbZBCs
         KkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690206779; x=1690811579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4T/h8f7UA0MwJtvuR5Ih4P1FPPGqFQNWXoqmPtCy13Q=;
        b=fSW9ydhnaS11jyfiJ1skLisuXl90Be5BASdO8cvSrUPiRl7AObopn0Dmt8q3501tvL
         noUruG6idBYykltEd+ENaRp/MhplYHE0fzONJhZWhOqIHQYuKUKWfWOg0XvWZ/6EyMr1
         JQ1rWBbF+L0Ah1J/N7n9m7DxW7TuC5sET76fVJTHxuibICXjHf/K1Yj8J1dxK6+6M++A
         uJLZHs5tSMCLsAdllNXhyZUQ0qfOzmSJtVv96aui88N86JGdwVATt762pEGxzUAKmGlg
         LgtMbZX1D7ckVhTQ2jkVZ7glB/2HK8pNwn/uVecU1XGV0extWKL85fWNNiIgoq1E/WHX
         9/VQ==
X-Gm-Message-State: ABy/qLbO30LJzTZF+11ZFZ+3TcRv3V0yanZ70rOSZXOlyis9AkuJ5ONj
	Qy5gsaAgI7Dcz7gYqbwAcvdej6ADxr2DXBCx+Z0=
X-Google-Smtp-Source: APBJJlF4HYo/+3MMUHQMrj8rqOtbgaCSGjqZYNJQS/dLe2PcQURizAyiDsYImCk9Wj4/L6llIKjypw==
X-Received: by 2002:a50:ed0f:0:b0:522:3abb:5bba with SMTP id j15-20020a50ed0f000000b005223abb5bbamr1141596eds.24.1690206778965;
        Mon, 24 Jul 2023 06:52:58 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id v2-20020aa7cd42000000b0051bed498851sm6239100edw.54.2023.07.24.06.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 06:52:58 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 08/10] alchemytests: Fix task-2
Date: Mon, 24 Jul 2023 15:52:37 +0200
Message-Id: <20230724135239.10579-9-aaron@sigma-star.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230724135239.10579-1-aaron@sigma-star.at>
References: <20230720145150.24607-1-aaron@sigma-star.at>
 <20230724135239.10579-1-aaron@sigma-star.at>
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

