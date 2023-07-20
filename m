Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE9218AE4
	for <xenomai@lists.linux.dev>; Thu, 20 Jul 2023 14:52:08 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-9939fbb7191so205014266b.0
        for <xenomai@lists.linux.dev>; Thu, 20 Jul 2023 07:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1689864727; x=1690469527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1cQOc964HWxVz5/SRWF8kLGcrk3hDq1vbOJf8B2Nkc=;
        b=lsY3F0DsuxYiojerP6XFIVLN9g6yEKhNDYfaz0Zx6qyxCbWGKE3I32TFGgEWN8yYnN
         u3IysLbz8Bn+VJmDlbgmfxSpdatmIb/VLPnGXZJ62IRBSz23+6SlJg0CUVo+5nheZZVK
         RAhXM8GI46vTt0mbd/S4REOYCSIZhw7f0moy3DxcKg0xKeyIGZ6AhsFuF5wsusdvSLRP
         BbnF9jxiD5KYu+JoHq/SahlGJZXeVruOa9yInrXzKGF9O9ivFWD46p6U/p+c1DXoe2ga
         F70iSEGHkMVyL5iDa6CgXao3OC+R4Hcsd5I8iNopjM5r4lofYLs+tcRL2I4wKoYao+ZR
         nq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689864727; x=1690469527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1cQOc964HWxVz5/SRWF8kLGcrk3hDq1vbOJf8B2Nkc=;
        b=e4BnEADpnMjp47fatkjhB0XvwbGJ9Hph466B9za4z7vVm2fZ0+bvCSSBGSBLfzj4lL
         ApC2RHjWvIGg2/Egt8vD86ir/OQmjPIAlzYinjzso6Z9QtrLFXymez5kUrNFtw9Rg8rH
         AZsjYlb9QQRazbtXczTiDgI0/4IaORAywEzw89kZi8yijeH4MqeRgR4nVHNhBfCkuDON
         QEG+wYpelVHZdtjR0DlOv+6Td8SYRQpEbEXV2LKm2o9+DlNcBR51uzffN0mFhGR6BnvQ
         8p36uSLikJ8T9PVCoSGUxZyDQT1r400xIuWZx5RxeI0W27et5pqAO3UUPDjyd4dxezvk
         haZg==
X-Gm-Message-State: ABy/qLZlVETFWR6M6/dKCZst6rIEVObs5PiaxSpnLp2q28Knf/Rw24lG
	ZXAwN5rVPeVDI+9q6L9hBpLqQduXDsfF5RWv/tY=
X-Google-Smtp-Source: APBJJlF58aXe9gzTymxmuRbs0NAzizAkdVf2N6lW6hi60OYamrgpOYcjMTSA1uDaWWoR8piKPFs6zQ==
X-Received: by 2002:a17:906:51d3:b0:98e:370c:be69 with SMTP id v19-20020a17090651d300b0098e370cbe69mr5748778ejk.6.1689864726964;
        Thu, 20 Jul 2023 07:52:06 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id h13-20020a170906854d00b0099290e2c163sm793462ejy.204.2023.07.20.07.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 07:52:06 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 04/10] testsuite: Remove old alchemytests Makefile
Date: Thu, 20 Jul 2023 16:51:44 +0200
Message-Id: <20230720145150.24607-5-aaron@sigma-star.at>
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

From: Richard Weinberger <richard@nod.at>

Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
---
 lib/alchemy/testsuite/Makefile | 70 ----------------------------------
 1 file changed, 70 deletions(-)
 delete mode 100644 lib/alchemy/testsuite/Makefile

diff --git a/lib/alchemy/testsuite/Makefile b/lib/alchemy/testsuite/Makefile
deleted file mode 100644
index a831c999e..000000000
--- a/lib/alchemy/testsuite/Makefile
+++ /dev/null
@@ -1,70 +0,0 @@
-ifeq ($(DESTDIR),)
-XENO_CONFIG=xeno-config
-else
-XENO_CONFIG=$(DESTDIR)/bin/xeno-config
-endif
-
-prefix := $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --prefix)
-solibs := $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --libdir)
-core := $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --core)
-
-ifeq ($(prefix),)
-$(error Please add <xenomai-install-path>/bin to your PATH variable or specify DESTDIR)
-endif
-
-cobalt-only := pipe-1
-mercury-only :=
-core-specific = $($(core)-only)
-
-TESTS :=		\
-	task-1		\
-	task-2		\
-	task-3		\
-	task-4		\
-	task-5		\
-	task-6		\
-	task-7		\
-	task-8		\
-	task-9		\
-	task-10		\
-	mq-1		\
-	mq-2		\
-	mq-3		\
-	alarm-1		\
-	sem-1		\
-	sem-2		\
-	mutex-1		\
-	event-1		\
-	heap-1		\
-	heap-2		\
-	buffer-1	\
-	$(core-specific)
-
-CFLAGS := $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --skin=alchemy --cflags) -g
-LDFLAGS := $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --skin=alchemy --ldflags)
-CC = $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --cc)
-
-all: $(TESTS)
-
-%: %.c
-	$(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)
-
-install: all
-	install -d $(prefix)/testsuite/alchemy
-	install -t $(prefix)/testsuite/alchemy $(TESTS)
-
-clean:
-	$(RM) $(TESTS) *~
-
-# Run the test suite. We pin all tests to CPU #0, so that SMP does not
-# alter the execution sequence we expect from them.
-test: all
-	@for t in $(TESTS); do \
-		echo -n $$t...; \
-		sudo LD_LIBRARY_PATH=$(solibs) $(VALGRIND) ./$$t --cpu-affinity=0 --silent && echo ok || echo BAD; \
-	done
-
-test/%: %
-	sudo LD_LIBRARY_PATH=$(solibs) $(VALGRIND) ./$(@F) --cpu-affinity=0 --silent && echo ok || echo BAD
-
-.PHONY: clean test
-- 
2.35.3

