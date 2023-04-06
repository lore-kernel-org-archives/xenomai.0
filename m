Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D6D7EA
	for <xenomai@lists.linux.dev>; Thu,  6 Apr 2023 10:34:25 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-947cd8b2de3so133615166b.0
        for <xenomai@lists.linux.dev>; Thu, 06 Apr 2023 03:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1680777264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBSd7xjFuX3DVgRfLGbrYfs4lvUTsejpg8nMI2K7W4M=;
        b=K9CfYIiesoVnUBCsBrxSjW3Z2FSKYqOGIl6EuCBt3yGFVxNH5V5nAJxMiNbL6f08ab
         OyN6aoMQGS8kHdVKmLzKVSLqnPZgTBpB3Um7jXfWYl4vLdJsn0Xi59PnnHBB+GxDwfXj
         eZTJiKInxR/8RJWXL3rSiN6/7nmXJZnxvFwMhzMwboD1xRqe7xu6+ezhfI0PyiX4feaS
         52fNxbKE4a+PvcN2+NQMoZ8dFB4HfQzTvi70nyNbm3F4Q3c0i2J2m36z8RuSXO7PFKI0
         cxiyFx+3HxuKyTEj+OU/9Nf/dKv88GSobF/mlgd8ZKNW3xzdAKsagU0zNW/SHu4u6T/t
         T0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680777264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBSd7xjFuX3DVgRfLGbrYfs4lvUTsejpg8nMI2K7W4M=;
        b=MpxApEWFZqxBSH1IwjadiCrYxnRVhv4isrUN48PMOhiI5bt7UvqKYMJo2n/oZ2c5Ux
         xcmj2fA5BxfQs7ZTPomFFAU+H3xi2OymCaxs7QQZbGM9LSAkifSLqBnvrHAflbJBkDJO
         nUdW1IzlDCZK3f/pcTDZ7ezbswZ01hZW7vfnofWf45jYbfP3+rclZpLkJvTWoUxl5zby
         AQrUqswXAcOHxwb4I6qfG+ixT5dOFSvKIt2BIfo9t20MHeyz9cE1CirIEyoDsLB42bvR
         979gxK3WXcGxLA/tgydQ7WB/Phzw/DDfJqKl9yq12pq9BfokrZVwWSYkbZ7sqjO56ddX
         bjCg==
X-Gm-Message-State: AAQBX9cdqu/dzFudbu03OTE4eXtpoNpq7uQyQ83GYBDZeRb6AQ6ZDshF
	msuY5ivMcF197CRu1LGWp4g2tilqsI2n3WbnK9g=
X-Google-Smtp-Source: AKy350a/1j+YVrpmuQpnGUxIsiSBUR0NSc7sYO+RYJ10kn/YK2f/83mhc25uXBxL4dKBqim8NjVxeA==
X-Received: by 2002:aa7:d5c9:0:b0:500:40f4:f8 with SMTP id d9-20020aa7d5c9000000b0050040f400f8mr5298739eds.0.1680777263975;
        Thu, 06 Apr 2023 03:34:23 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id r7-20020a50c007000000b005021d210899sm574795edb.23.2023.04.06.03.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 03:34:23 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 04/11] Remove old alchemy tests Makefile
Date: Thu,  6 Apr 2023 12:33:34 +0200
Message-Id: <20230406103341.2914-5-aaron@sigma-star.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230406103341.2914-1-aaron@sigma-star.at>
References: <20220413215819.22954-1-richard@nod.at>
 <20230406103341.2914-1-aaron@sigma-star.at>
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
index a831c999e8..0000000000
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

