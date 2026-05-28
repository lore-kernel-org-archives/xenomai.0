Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC372E6CB8
	for <xenomai@lists.linux.dev>; Thu, 28 May 2026 19:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779997643; cv=none; b=KDLVQ96WIWmYqnTJirAtrIkSm6CDnkIEzO67BRqI79qkdyOgMKPeA0JLJmjK1bY/YFJxQjzoHorDecWphVxe5cV1QCEaIU6GqWNJEyOzP7It/lPwvdnuhQ82/4CSi7ylUQRxfhxbJpiYrsWhZimJn7UaijwSCtENzUP+5Wvvglo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779997643; c=relaxed/simple;
	bh=hFm5CEnn95jITjiZBvnLzVwxTDM033gFk3mRGLK2hq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WUvpAjKl6mV4iU4PBe788pjjlsgz/D53ZlgBo9pimV7UblkZ28Nm4n+sfel9smLfgbZDwkvrW6IEBZzn7g11u+hayHtlIaPWEr6poYlI2mV3SPLVR4g1qvGb0nfDwTayxu9B7ERY2gn8gygkAk50de9gxoC78/dDzIp3Cc0u39M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amUERs1V; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amUERs1V"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49068493267so34161485e9.1
        for <xenomai@lists.linux.dev>; Thu, 28 May 2026 12:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779997640; x=1780602440; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9XFFy33IYIBQ04bnuAOCkMNqMeoWci/dMEuparg2HcY=;
        b=amUERs1VqU8DZk4rnuhg/6Iqvm2oXYd+QMDsvRRnJO2bvjpL+0y45JrfSoyK2u7nv9
         ERiGjnd1FSbFP1tyFoCL9dr62mrj+8FVSgH1429sx9BGCqMg2pZ/IWfG0MeScmps9KnI
         RjArZPT5oTJdtb/ZPfxYDU7DvY7+vMSlDUEnl2iQ/0Uqxa7QVC51kQFDV6cVWYCX3fnU
         7Qx4eWm+WSWnxwY9EI5wdIUW1w1aYbx6JhGc4IMMM3u85mFj4+cE1l/JZIZ9dpzrunRW
         J0pb3eC16scFQSBad6rsdbvAaDAyOMERApnQQTN0fycsjFA1YlMNRaMBf3b7Vq4qJkbt
         DpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779997640; x=1780602440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XFFy33IYIBQ04bnuAOCkMNqMeoWci/dMEuparg2HcY=;
        b=HPljaj5dSJMUQccSTgk/H4hQyDQdMlCuSi+8ZHsZQn/Yuw/b5mOgDfFUz4gMLPLMmJ
         SnWOIrnrsSgLI4OnvdYyPjaUR26rg7mnKalI72uy26guGx7hlLabgoKHx5rVK1ja4bDp
         V1QxFCAOsNZBvXphJTGwbe9ndCWNCfPzLfkFQdQzZn4tZ+KCgjR24bTc40nLuQzQ0yKN
         IYC9e7birL+pP+nbQIbXQDDF9CGz1801GugMHGKpjL/pkIpHP4khEV5bJE2HhLAmjXD6
         wdQcuntxNaqnbqexqOCGIHFC43TzaGIwZcGahEFPQQCiEDxtRGqBCrFNNOopHJF06VVJ
         OVlg==
X-Gm-Message-State: AOJu0YxCsHxQAM5pCnWSBVXQwiCC1tOI9A1a3X7BvkKvFiYF9SSf19wM
	MwEPx8fedYNRMd+IvpCgX9OUMclXTdCBJhjWgJx9NxR7V6s4xBOucS89C8dTUA==
X-Gm-Gg: Acq92OGcPYLApMUHyOqqZMmklJOaKO7CC2gm21r5eJ1KBCS2qIFgrr2qbuXgJrskfsM
	fdhAxB/wlGU7WFtIS/duwbs+xeNx7nEizGzWiVn4danLmsZliDNiFDdCmEFCvk/dzRj8OuJFiZf
	y5n0wOyNatfCY6YF7nFYOjIrqpIELCBql4dI8LYykzGPlngJMsi6qIAvmjiDUrgEMc/6Kqw6Sz0
	xfOetXG9y5Y+WxQ8VYpsqA3o4rNM/gdrq6pRgEyeI04Ebwg2gL0tcKz1DlMoLckGLv0Q9oQAvLe
	qLa7JyMrR27Vz4W4jWUu24aDcGaD87nW7DXUyxt/j0Aic9XeEZVYIz6MwV2hTFi4t55JcTjsWih
	UzGnNgcUuawnjd7N5KJtnYmS+xJcU1SIJC9BtFGbcz9OdA9JdBq/sv5x8mqLTf1kogeOP31u0N4
	6BI4nVf/1kzG5rbJVBSxkS/sjDjrv6yygfQuyR
X-Received: by 2002:a05:600c:64c8:b0:490:5cb3:e94a with SMTP id 5b1f17b1804b1-4909bf7b574mr1056235e9.2.1779997639918;
        Thu, 28 May 2026 12:47:19 -0700 (PDT)
Received: from localhost ([213.55.168.64])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49092a902bfsm103277685e9.12.2026.05.28.12.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 12:47:18 -0700 (PDT)
From: Hannes Diethelm <hannes.diethelm@gmail.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: Hannes Diethelm <hannes.diethelm@gmail.com>
Subject: [PATCH 0/1] tidbits: net-udp: solicit new client for server mode
Date: Thu, 28 May 2026 21:44:58 +0200
Message-ID: <20260528194459.6117-1-hannes.diethelm@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As discussed in [PATCH] tidbits: net-udp: add server and client mode, 
evl_net_solicit() is also needed for each client in server mode.

I went for option 2, it is not to lazy and I did not find any way to
ask evl if an ARP is already done.

While testing, I also discovered that EINPROGRESS can appear after some
time. I think this is due the kernel garbage-collects the ARP entry.

With this patch, this issue is also gone.

Hannes Diethelm (1):
  tidbits: net-udp: solicit new client for server mode

 tidbits/oob-net-udp.c | 58 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 50 insertions(+), 8 deletions(-)

-- 
2.47.3

