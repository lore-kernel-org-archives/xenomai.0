Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADEE4695
	for <xenomai@lists.linux.dev>; Wed, 27 Sep 2023 11:10:03 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-405361bb93bso105911355e9.3
        for <xenomai@lists.linux.dev>; Wed, 27 Sep 2023 04:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695813001; x=1696417801; darn=lists.linux.dev;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bul2Z/IO1usViaWIFaZ3SyqVz5IDbPBzjPDv/+6boSI=;
        b=PJjPl80FK59mzCGx1r3alHqboHD9hj6dylv9H9fFngEkybSkQGVvbwXHW675yQ8aiS
         +W5ECaUoPQcg7jziJa9F5aZnwFaKv6WZXoZxG3Tod2R2fSEQYFjnpeRspog4OUhVfdEI
         UWi3sCJ2CkFkigRnmquZDmnzhssnNeGct0jkInspSh5BrtksPs9aHQk26w1+8WZmnr2L
         LbhwkWjfFqGpG3bYzDxmiANWvzn/S9M4MbAgo9Rys259GJZEDFi9JlCFeK+SKn9/vTzD
         BVsc+CkeZ38TXCSp8uOd9y2Tm7RUc8WbU7deKsX9KRbMcGx9VTHmIOO39S9j7k2a3kcl
         J+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695813001; x=1696417801;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bul2Z/IO1usViaWIFaZ3SyqVz5IDbPBzjPDv/+6boSI=;
        b=cu7SbcxEWTVvRqIMZxtzj9j7DjFRKTqXtLuyQ+W5jP0iCd1ClZaBQIffcKxfPOIEnH
         w3AdA0/d4KsR++SsYRwrmf+NJm462r0ZMtGdkg9AEA9jkuQMGCuq2nhGLIDd0z+Anayf
         bYu9gLH/ZhHPr60czUCbTpAmDNuwlUfvOVyXbJRlCWyAvgMv49fLhp83CHTcyFSc1xU6
         Ta76Fz0mh0UnlKtcdjjwN9azI8qpC+02h3ZQoTMe7TN1fh8MZn7D5I4KI+SgVwBnOEDV
         Pd2x/Ka5PNleJmiTKHA80BKI6o8LbLuEzv8Ctmn9Cz4KW9lO2Mf33j3URcRMIWTPP6oO
         rpKw==
X-Gm-Message-State: AOJu0Yxx1R8atlVg7OKqxzLTHm8oUGYIwqbBd8oZzJlaHruYJGwjkx4k
	jT+6OzZu0xMkrMbGrrN7M12rqGODmin2vYKL
X-Google-Smtp-Source: AGHT+IEgTnAYEKJNhYVgA33vozNr2ayfMOgIb4oG6XZCsr+DIwuNTuYShfduFPr0eNTygwnaaUr5/A==
X-Received: by 2002:a05:600c:2a4a:b0:401:b6f6:d90c with SMTP id x10-20020a05600c2a4a00b00401b6f6d90cmr1682801wme.35.1695813001326;
        Wed, 27 Sep 2023 04:10:01 -0700 (PDT)
Received: from smtpclient.apple ([147.78.177.76])
        by smtp.gmail.com with ESMTPSA id f18-20020a7bc8d2000000b00401d8181f8bsm20206912wml.25.2023.09.27.04.10.00
        for <xenomai@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Sep 2023 04:10:01 -0700 (PDT)
From: YinJie LI <liyinjie0418@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: [PATCH] core/user-api: correct the api name
Message-Id: <A25826ED-41FD-4738-9D5A-C379F4E00EED@gmail.com>
Date: Wed, 27 Sep 2023 19:09:56 +0800
To: xenomai@lists.linux.dev
X-Mailer: Apple Mail (2.3696.80.82.1.1)

Dear maintainers:


An API name correct was found in the online documentation.
Please help confirm.


Signed-off-by: Yinjie Lee <liyinjie@sinsegye.com.cn>
---
content/core/user-api/scheduling/_index.md | 4 ++--
1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/content/core/user-api/scheduling/_index.md =
b/content/core/user-api/scheduling/_index.md
index 00a2b62..263f3c8 100644
--- a/content/core/user-api/scheduling/_index.md
+++ b/content/core/user-api/scheduling/_index.md
@@ -13,7 +13,7 @@ module for a runnable thread in the following order:
1. [SCHED_FIFO]({{< relref "#SCHED_FIFO" >}}), which is the common
    first-in, first-out real-time policy.

-2.=20
+2.
    [SCHED_RR]({{< relref "#SCHED_RR" >}}) round-robin policy
    internally.

@@ -404,7 +404,7 @@ A thread group is represented by a unique integer =
returned by the core
upon creation, aka the _group identifier_.

Creating a new thread group is achieved by calling
-[evl_sched_contol()]({{% relref "#evl_control_sched" %}}). Some
+[evl_control_sched()]({{% relref "#evl_control_sched" %}}). Some
information including the new group identifier is returned in the
ancillary `evl_sched_ctlinfo` structure passed to the request. The
`evl_sched_ctlparams` control structure should be filled in as
--=20
2.25.1=
