Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D671CE70E
	for <xenomai@lists.linux.dev>; Sat, 14 Sep 2024 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726319443; cv=none; b=LhfRXgDenQ5FB07jL0rgJuFpmU4A6QJsuepZT3XxCHqBV6p/rodTWVYtciwL6fQmooqCm7y15f4oa/Qj2vhR3TC0qSG6GmtJhCxOcjL2Yaw2kBeMt7MNXdEH9FYFJmyAiz1Z99j1CnlAiUpVVXvg9d5RFcXSJZCPh1Io/L3V/zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726319443; c=relaxed/simple;
	bh=9cBM7XQ7jHI/FYXzpwGQFQSrNMt8E0rthRj190zULC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ePHO/YFzfoWDdVuIilK6M836uUpOrOlftmjqE5kYONTAZm9S7yOpbOBmoJSN5iTzuGrGgW2GVJQ6xqmxTaKJKB1xCSuVKugLOR+SlFB8n7AMUrUlPRhGH218SRJSyaCWF31R+ud1BI3/FstUKsjRm4Ai07Nu3L8Owhh0CTBUq9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=Js5Wnlcz; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Js5Wnlcz"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-374c7e64b60so1870218f8f.2
        for <xenomai@lists.linux.dev>; Sat, 14 Sep 2024 06:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1726319440; x=1726924240; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=irWwjRvbrXgYO6G1q2SNe2GMMklB2ljpt6PH6bfCvYA=;
        b=Js5WnlczuYuszWo7OB70cm/PRoOdfA9PDAWlCWFI+wPmCSc5rZ+AvA3q4HkaE81WLb
         0tpcgaljG3sviXz2O0c9U8l6VbZVjU76eapjqZ98tk3QpKVv1OiFO6mmkNoN0WVq/jZu
         Sw+EBxPR2/cJL1j8kgSmRyUYmei25eBb37axc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726319440; x=1726924240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=irWwjRvbrXgYO6G1q2SNe2GMMklB2ljpt6PH6bfCvYA=;
        b=Kw4CpHWsMpx8f22aHFXuvHoAHrRMvKGZK8q/rXUeDZjUn6Y4dYrRVOy7S0xNSurqaN
         zsO4+Stt83tAv7y71yDPNkz7M4MxkzLkVLZ4dwgzs3VJEz9XxeI3Hg9P+BPZTblLVpsb
         ccWWGFgqNAxeY5Jw911FugwL58FiwXZKDtD40mizZWGInHFAD6RgyYUGSWc57X5KhSbo
         BFvlELxUiGgkjggFmQVqcFNQmNpHUCcITV19b69UcyhIHpb6pvmbwBamJzecjv0MJ4nn
         EeNUKyGhSQb4xXNrUm/TagMfyUH1o9os6ED+wbuIJTCo1mm8iX17tITgmDk8vqUJpAcY
         leag==
X-Gm-Message-State: AOJu0Yxb8sbVsNH2wMgkSv8GXFlt9TrIT6lWiKM41A7wkYUeI3Wle+W2
	i7KXsnd76SISALztyVmTjJ9FFvFb+oD3pzOJxk922AVYgaqYbgifjyRqzxoOg8qZlquaNiESGxa
	SyqycRg==
X-Google-Smtp-Source: AGHT+IEVsZRlzVWvuNtZukQ8aUSAg+m9qYIvV1gpvylSuvLgVZq39xNhuvnyP4wkJJaYq0h/wY0gwA==
X-Received: by 2002:adf:f6c6:0:b0:374:baf1:41cb with SMTP id ffacd0b85a97d-378c2cfedebmr5576893f8f.4.1726319439164;
        Sat, 14 Sep 2024 06:10:39 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.lan ([2a02:61:a2:0:e74c:3b5d:e13e:6e77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f97d6sm1731010f8f.52.2024.09.14.06.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 06:10:38 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: xenomai@lists.linux.dev
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: [PATCH 1/1] smokey: fix build failure
Date: Sat, 14 Sep 2024 15:10:26 +0200
Message-ID: <20240914131026.1035993-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch fixes the following building failure raised on bumping Xenomai
to version 3.2.5 in Buildroot:

In file included from helpers.c:29:
../../include/smokey/smokey.h:258:39: error: unknown type name ‘bool’
  258 | int smokey_modprobe(const char *name, bool silent);
      |                                       ^~~~
../../include/smokey/smokey.h:27:1: note: ‘bool’ is defined in header ‘<stdbool.h>’; did you forget to ‘#include <stdbool.h>’?
   26 | #include <xenomai/init.h>
  +++ |+#include <stdbool.h>
   27 |
In file included from init.c:33:
../../include/smokey/smokey.h:258:39: error: unknown type name ‘bool’
  258 | int smokey_modprobe(const char *name, bool silent);
      |                                       ^~~~
../../include/smokey/smokey.h:26:1: note: ‘bool’ is defined in header ‘<stdbool.h>’; did you forget to ‘#include <stdbool.h>’?
   25 | #include <copperplate/clockobj.h>
  +++ |+#include <stdbool.h>
   26 | #include <xenomai/init.h>
helpers.c:299:39: error: unknown type name ‘bool’
  299 | int smokey_modprobe(const char *name, bool silent)
      |                                       ^~~~
helpers.c:30:1: note: ‘bool’ is defined in header ‘<stdbool.h>’; did you forget to ‘#include <stdbool.h>’?
   29 | #include <smokey/smokey.h>
  +++ |+#include <stdbool.h>

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---
 include/smokey/smokey.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/smokey/smokey.h b/include/smokey/smokey.h
index cf9701966db8..45dd0dcd017b 100644
--- a/include/smokey/smokey.h
+++ b/include/smokey/smokey.h
@@ -19,6 +19,7 @@
 #define _XENOMAI_SMOKEY_SMOKEY_H
 
 #include <stdarg.h>
+#include <stdbool.h>
 #include <pthread.h>
 #include <boilerplate/list.h>
 #include <boilerplate/libc.h>
-- 
2.43.0

