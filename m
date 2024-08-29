Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E47189912
	for <xenomai@lists.linux.dev>; Thu, 29 Aug 2024 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920535; cv=none; b=j3iU7+gfq+uDuT0y7M7NT5mHE6iwoVG4JHWhL4Zxkd2ORy5t7WMs+XVxlbJ1Ymqz/S3XQAfDrrjCoIS5fS2nbvVnKC2f4fn3igYKvLUjT33FLYjt0hWMd/Jm6KsyefdTPetZ0ji/qEN5zop+P/HHT5xiJJ31OQeNxsau/QLOfOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920535; c=relaxed/simple;
	bh=SrSykEixuTjnkACIsHAt8US0F1tv0IPKsEb5Iz59Mts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TPGOoe52VjYTM2XBL26YBti5zns1blfJiNJVjoN0DpAIZvpsNNvPDuQDVn9keotz8npiWn6VikWQZZfwsy5UhOvAJAlXknAJou+1IoRYFMEAc53Hxn0oKQnKgEhRH95Su9/Do+BzYHD7mqjBZaVJTe3UWC/bMYAQIzl0NpMDBdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=qoROQqdh; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="qoROQqdh"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42808071810so3484885e9.1
        for <xenomai@lists.linux.dev>; Thu, 29 Aug 2024 01:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1724920530; x=1725525330; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jhHw7Da51YH5uyeGxHGeen5BTlGnwJFkcGPX8HaIFqU=;
        b=qoROQqdhAsmgbJ7ScjbqLyOA2L7Y1lSCiqXVBqOLxBHGUrexjpEfW6sD4ktIy/QOKv
         Bse7KP+Pq9ePxyLlpBLHbt8BWmnA6stBWHWT6YCnpxW/98+jytzB7i97SZe+F7E/PYZW
         lUR/oRG/ak2V/bmCuY3yyXTvacNwf/i7MI/mjXauyRo2IeI7P6HwlJ8MjmHHS9PCTYdw
         0CDCtWPAyCMDHow2yZEEjCT2p7EJZmzKADwk4s5TJCZlt0Z5y/RlC3T/XaUQcsLKfSr+
         YzLMOAn5AZ9CQICK92LYD7swBP1Tacch0jyThzPbaMMWaMoHb4idJ4RG5Qi4hyXbhXmd
         8Dig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724920530; x=1725525330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jhHw7Da51YH5uyeGxHGeen5BTlGnwJFkcGPX8HaIFqU=;
        b=wDQs2HfDJp4eHiMwqB2sv9nOUKdWEes9qYenOmILntNmFLvI1uQKBLQ9qzEvYglOEb
         ykD8FVTat66W1OjtUy6Eb3rBiYLn8rsYoe506GAQItkRrKtORGMX7tbQXXJCK0PDL9kz
         NUWFyJyqfQqKuWivuL79AkFQTqbgi52y+d/oJ52vIAG+Vd0gCbygX/mSUj/mD6Qmi8rM
         mxn46W0E7PY5Ftb9T8GVzSryhkJQiRQlh2idSS4BsVuaZ7ZS4KLvCmnhONUZwq8HbJf6
         RU0TfuWu+rN0vspXAYjND7H/xm/27+auWoF3qgEdLvAk84fCQbg/Bohz2+9SKHG4i5ly
         2AMQ==
X-Gm-Message-State: AOJu0YyMkrbLAyVaWRM6EbNkRxEPxWquDC9JBPQhH/EnF+WQeT+N5b6r
	ZJU1t08gcKUhbnt7ZteGTXbQkpIW3cT8dzwcQM8wwUEF2KlJ1cazedRMMa4YYeznmyA8Y5Qz+c4
	0kpQ=
X-Google-Smtp-Source: AGHT+IE5v4XxPRJI2YQoqkVDHqnrvTUobjvU6ZPigZFm18HYxkg/WILn1SlhcCKSuSiqmkHK9dBCQA==
X-Received: by 2002:a05:600c:4505:b0:426:60b8:d8ba with SMTP id 5b1f17b1804b1-42bb27a9ca8mr16224295e9.28.1724920529727;
        Thu, 29 Aug 2024 01:35:29 -0700 (PDT)
Received: from localhost.localdomain ([144.208.200.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0adbsm9995815e9.15.2024.08.29.01.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:35:29 -0700 (PDT)
From: Simon Graber <simon.graber@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Simon Graber <simon.graber@sigma-star.at>
Subject: [PATCH 0/4] Add env vars for session and cpu-affinity
Date: Thu, 29 Aug 2024 10:35:22 +0200
Message-ID: <20240829083526.24536-1-simon.graber@sigma-star.at>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Revision 3 of this patch adds documentation for the new
environment variables.

Changes since v1:
 * Usage of environment variables is documented
 * lib/copperplate/init.c: Conditionally query XENO_SESSION_NAME
 * Reformat patch 2 to adhere to code style

Simon Graber (4):
  lib/copperplate: Get session name from env var
  lib/boilerplate: Get cpu-affinity from env var
  alchemytests: Set cpu-affinity by env var
  Add documentation for env vars

 doc/asciidoc/README.INSTALL.adoc             |  7 ++--
 lib/boilerplate/setup.c                      | 39 +++++++++++++++-----
 lib/copperplate/init.c                       | 21 ++++++++---
 testsuite/smokey/alchemytests/alchemytests.c | 10 ++++-
 4 files changed, 58 insertions(+), 19 deletions(-)

-- 
2.46.0

