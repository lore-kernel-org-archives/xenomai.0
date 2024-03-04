Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2ED7CF33
	for <xenomai@lists.linux.dev>; Mon,  4 Mar 2024 23:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709595850; cv=none; b=TbZgnHF5MYW7kzxtsNSzJa4wz4p8/HSxprl6UVi9wKJCiX7FX+HqBU+yZMzbMgGMBkEueykF2HywpCc3lK+IIc80wIbe2Bs4m7d6L+96xBvidRmrms+KK6tJ5SfcS/6FUbvVexxdd4oFHo/MsFTd+UiL2bB3OG0mHlEiJN2N24Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709595850; c=relaxed/simple;
	bh=2eH9yL4IY5noHNH+08hx/5oAtzhCSIcowUv7GvpNQR0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=I67oS6fQDYD6Lmo5OFGjKBHMLJI9WSdkRB3fKsK/hQVJo8Zw1sEW8L30DHA1i/+10Prpe/2aU/pXMFRCHA77JjDJa9JbuM/GJNfTy/30cutIgN3EQ/VhnaMP3PQgL03RCQHepBlAkIuRP1JarSisQrG1uR6df6uXbxfLJa2o8o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=CnBlzyYG; arc=none smtp.client-ip=217.70.178.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="CnBlzyYG"
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id 81191200003
	for <xenomai@lists.linux.dev>; Mon,  4 Mar 2024 23:43:59 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by spool.mail.gandi.net (Postfix) with ESMTPS id A3C86941DFB
	for <xenomai@xenomai.org>; Mon,  4 Mar 2024 23:43:58 +0000 (UTC)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2d23114b19dso63217501fa.3
        for <xenomai@xenomai.org>; Mon, 04 Mar 2024 15:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1709595837; x=1710200637; darn=xenomai.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Unw9fkwJHGA8rZeDCzz2XZzsayJMozolMkmQgYKFcTI=;
        b=CnBlzyYG9tDFIkcgeTuJA/RDAZFyJwz2FChsRz1+s3K+I3r6rTcI14l7OdVqsRCBga
         XaT1GuN9oS0EF6xdrWCqlmc+kG82N+y3FahoO8gipaW6osBEq29GMO1T1MwFpCz1Xi/2
         dgwlDLwDdB7GoudS315D0Nx47YVX4qJN9GUbVyxyaVKSdvvt9zQ/o9t2o0PD5JwnjN9m
         Z+1WKtM7YYUSh2o1B+IdSjmZLFmH2ET09o9b7Q5bWzlADs7S4pS6ua5+RHK3hvjoaBC+
         uuQ7csQhOSTUe9USwgz6P+GJrXON/L7TJFF60/g4XFG21A5nyvXtauAcNJll4WvriOyM
         I6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709595837; x=1710200637;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Unw9fkwJHGA8rZeDCzz2XZzsayJMozolMkmQgYKFcTI=;
        b=YsDwzCEeF7coxvCRq2frUBLVGLcKWSGucxe2g8PMYBpC7nw/GVzgyXirBgnp/FBbfW
         U9a1PzxLy301BCLEyLLJ4F+Y8cfWHaSRgL31U6mKmdiuIyR1yvIvB4ZRQkFmTuUyY2Oi
         GGidmPNMJZYct4bfH51huLmeO9ZFmfCQrROMMp89AYwJUE95FkgGbkaFsLrfYO2vsJfo
         JkMU1Q2No1c+hmSjUn7qOwgzHkURCyRKIeAVNl3wEak/iCKNm7vlQEgfJiSitmSO+/2L
         eY+7HqQF9w5vFunUgdaEXH1yDraXdRbjz+w88Nt7IRQheK5N/bfuzP4Myw3Ir98SSM7F
         swVg==
X-Gm-Message-State: AOJu0Yy3J+k5tLOS0oT7ZoStmyLWgb7l5Hnh27EyZBPz182WlSPe8mik
	5dy5AV2OGdW6Xoga4tWAsyoyIwPTKNKXI63XchSY/uGUwLEpwNlhjgwQ9AdjWpkcNxF7tWJM+qN
	AF7P4zyS+4I4FiGCyZSw5D1KDhdLFotx1bLYgieyHqySZNc8ePD8=
X-Google-Smtp-Source: AGHT+IGiY8rRLzcUUDGT2+TP96dD52xJhn6ngDjspqZLmx4dBDZGQTZ6pIccz4Mw6laKHDt1Wq9L4i2kDGh183extDo=
X-Received: by 2002:a05:651c:22e:b0:2d2:b506:d2b7 with SMTP id
 z14-20020a05651c022e00b002d2b506d2b7mr241681ljn.6.1709595837397; Mon, 04 Mar
 2024 15:43:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Tue, 5 Mar 2024 00:43:46 +0100
Message-ID: <CAFc1U0sy7hK6-4_BiC6npmSduU2XMJNQjBAR3GnkX9bqkW4MVg@mail.gmail.com>
Subject: DYNAMIC_FTRACE and I-pipe patch
To: xenomai <xenomai@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: spool.mail.gandi.net;
	dmarc=pass (policy=none) header.from=smile.fr;
	spf=pass (spool.mail.gandi.net: domain of pierre.ficheux@smile.fr designates 2a00:1450:4864:20::236 as permitted sender) smtp.mailfrom=pierre.ficheux@smile.fr

Hi,

One of my customers uses a 5.4.70 kernel with an iMX8M board and a
custom I-pipe patch (with Xenomai 3.1). It looks like all the I-pipe
patches disable the DYNAMIC_FTRACE option :

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index f3f2fc8ad81a..98d7c64b7b8f 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -532,6 +532,7 @@ config DYNAMIC_FTRACE
  bool "enable/disable function tracing dynamically"
  depends on FUNCTION_TRACER
  depends on HAVE_DYNAMIC_FTRACE
+ depends on !IPIPE
  default y
  help
   This option will modify all the calls to function tracing

That's not the case for a recent Dovetail based kernel.

Could you give me some information about such a limitation ?

Thanks in advance.

regards

-- 

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
