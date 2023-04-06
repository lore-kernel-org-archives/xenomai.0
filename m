Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9367233C5
	for <xenomai@lists.linux.dev>; Thu,  6 Apr 2023 10:34:30 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id g18so224008ejx.7
        for <xenomai@lists.linux.dev>; Thu, 06 Apr 2023 03:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1680777269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4umFF5pA06FHjrxScYg7TOJOw2C3yAyFTXhCZh4ZNY0=;
        b=Zu97eJN2BsPX4XW0Rq5UqqoKVAjIWiejo+1JRyGzW7gUB1uWaWnQeF2GHcmChnbRQa
         ePT8yj7jYnWnGOfhoCH4MHc/AVdQ4Ng/1NZ30xSvhq85r3DSPom+6s/SMiTydMfjbNKN
         wiZxJCJHfCn9N2nfz2G34SkQjVn8BxB+cT6SUBq7yKeT6lHV8r3eMI6YxWvIyQdl2tk6
         uDqbGkOZZW0idVt96rx6FGFJTUvj0lY1OSvHXkzsiXncCLQhBsMe9QNSb7ueAzM8BqKJ
         ZXWQlmahy8PG8Pg9zsiozDlJYdXsUdFE+YCMJVR9msSM8HorCwZdM62WEkO2WWv9GImf
         wVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680777269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4umFF5pA06FHjrxScYg7TOJOw2C3yAyFTXhCZh4ZNY0=;
        b=XPxEZbYNxrzImaeY2g6+WjGIoliLtAV0lluwHL/RxhC1R0tbvQyz2Mvv94JHKD/Dkx
         dnooutBplXRXOsjSlhF+hw6EoGRqrVksFc+vqQ3eaCMAN2F34iXLxxqhU8l3aei3lhsJ
         zDKz7KbVYtffizuSlXq6z76b7MfzgHYSuKttxD8po/L2ourwhJ/CNfRTqbSjbp8hT/oV
         8tpIdzDYIvAMYsbSy6KiryQKz8MtDVBMDzy6bG4uP7aVDjzOEeYwD9Dz8It3NO6DP43m
         E/hNEuRyl7pWEnncIFMWuq/NELtMc6kY0Epn55tthvKaKd8ZK7GHW/EmJraTUb4Z4Jr4
         PDQw==
X-Gm-Message-State: AAQBX9cwqjSZSM74c37TQZtALgQcrpaHAcxpqT6WNLs88chElxmeVShe
	HinCK3OnLhfm6BD6HZwJNWsXtdm78r7B1wns0MQ=
X-Google-Smtp-Source: AKy350ax/V9wzshW3lA/eqjjL4vJV9If2i3gcj4/fMJ1o1hxnC2cswcL8Ug+p2f1+1kT16UdmUbLkw==
X-Received: by 2002:a17:906:3a09:b0:931:19f8:d89c with SMTP id z9-20020a1709063a0900b0093119f8d89cmr5788728eje.73.1680777268898;
        Thu, 06 Apr 2023 03:34:28 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id r7-20020a50c007000000b005021d210899sm574795edb.23.2023.04.06.03.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 03:34:28 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 11/11] vxworkstests: fix Makefile.am reference
Date: Thu,  6 Apr 2023 12:33:41 +0200
Message-Id: <20230406103341.2914-12-aaron@sigma-star.at>
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

Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
---
 testsuite/vxworkstests/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testsuite/vxworkstests/Makefile.am b/testsuite/vxworkstests/Makefile.am
index 39cdd043b3..2c7c77e6ea 100644
--- a/testsuite/vxworkstests/Makefile.am
+++ b/testsuite/vxworkstests/Makefile.am
@@ -28,7 +28,7 @@ vxworksldadd = 					\
 	-lpthread -lrt -lm
 
 lst1_SOURCES = lst-1.c
-lst_CPPFLAGS = $(vxworkscppflags)
+lst1_CPPFLAGS = $(vxworkscppflags)
 lst1_LDADD = $(vxworksldadd) -lpthread -lrt -lm
 lst1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
 
-- 
2.35.3

