Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3299F2D877B
	for <xenomai@lists.linux.dev>; Tue, 31 Mar 2026 23:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774998936; cv=none; b=Ty2OKzLVTSFirPZdcYN+9JTRCS8fCeVe3XrXyFP/cLstGfOA854t1md6A6c1MjQF4d25AyCvAmo4X+XasDiKtIB8SlKrq7VYUd6jho57d8dQOkSzH9ugcXi0O1/cHfwBQjdw0oWdwPgiRfirfuXzFIw5Qbd+2djRhjyIfpUaoYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774998936; c=relaxed/simple;
	bh=xiDKbFj/hbU/tglEYqeUkUop60fEpzNq193mMd1dEa8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oMhgpKtyT7LGCekqwt3AuJjPorboqKGWVNbrdZZSn0+d9BdkKNiF+W8rtmpDzrz1F9LthCCEyoJYOD6YPfVgP/UVvv2Eih2CxMvgp51vYa5AFWBcukKo8D08VoYvFiiLxnBI9UvfO6swVBbfBaPrh2ii6fw/QPc2c8leylPXdbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpuOlbbi; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpuOlbbi"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12732165d1eso8672757c88.1
        for <xenomai@lists.linux.dev>; Tue, 31 Mar 2026 16:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774998934; x=1775603734; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xiDKbFj/hbU/tglEYqeUkUop60fEpzNq193mMd1dEa8=;
        b=bpuOlbbi06JKSnbcsxY135i3RRA+K1qknpsO3DJrnIz00tzG89+d0/ZjaLQST2RvT8
         dioXwKtIO3V8CumaeiR/hjN8D7yW1khe0I32djBa7ZCi9+2NuIbO4Z3j/dE1F1Y49R9i
         1Jw0C/6Uar40PLr27tQUKc3Oqvs7IQM7I/04UW9ZogsP+bi8SOOBESagvnWR+NY4NTmg
         cKMm7WUf9rCnUhdxA6WtLE19gBWAnq32XXNXYx87qlFKo4WJaPmCo1nHkGrtU18t7J2B
         6zBBxamktYFLC7o80TSR2pOOK2AJpAarSGm5vfehmUdqrmxPfcf1qQQ5Tfi6yRElTh0/
         170Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774998934; x=1775603734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiDKbFj/hbU/tglEYqeUkUop60fEpzNq193mMd1dEa8=;
        b=TtMfewbIQ8V3wz2cZgpRUTnZHmh4MsooGglTpZtARFLYhrJvq0d6W0FLU/VFZJqE1I
         eRHrswSZ0tshfkon1YLgn08T+Q8IDfkfxJAx15JzkTeeR3FTfmpUDls4krmDborklLjC
         c0uWV34djJP1I7Z1X4osahBbSiOm0PHYWpnT35rC485gn8h8eOmf6LMjm+xleQ0LPVxb
         niUeqgIsLovhNEPh/NMu2P7ipNDG8iX0fNfTW6WWj2ZLHX9vgbGjEe2J1LfYWgIH2DZ4
         ALTcgbYHojeyX+ofmHMa1DPU/wQgAW/8EEAKYGoBVOjlz+oTqsYS1e590BrjylGY8+C5
         4PNg==
X-Gm-Message-State: AOJu0YyRbXUvQo8sxoeHuD3XOOpMBtAJUDqHnGvL9ZYRHNY8MkHGFOpJ
	hS4z6z7LZwS3sBG6bYRGLXhBVBCiKjyxnATpjnnapnLo98nq5W206m4NmAi+oA==
X-Gm-Gg: ATEYQzzbEc1Ivx4Lq8+HPoZtxoXsRNyYqeZnzK1uQAVR6SKQDfSDEM2H9LrLXaw2e+n
	PZDQmaz8zw+eMdWhLmfbphEvkJRV96/ESrg7LYADLGAN8awUUUtCEU6g/UBBaTSQn6iwEchR0Pt
	Y3+9mZ6iePJhj3PmVrlQYcd13RkPZC/vVOYxa5w8oFp9l/EOjm/wjNTXnCgKvBgK+6pRzCTg5te
	05ygUk9NnkOiEA4XulxCLjemqVsQmfgexaSoVNDMVE9PZa9AhrGDINuOgSoY5t0JE9arX8hwInj
	lAuLuWyUpOtYxz6C/yRWbTZY6A7zyEe3uuq1ROr05814JP6xRtuhNfsPDune+vFweKluxqFHT0k
	xIEaaGsAj26fPwPOqiYL4tXAi0GcUaLS3xalkVahqMXEaPfu7/Px7M8IIOU66473mXBQj8/z9Pe
	eGENmLrDQ0XbetD6M0iL1Lz+qCPGhGHCRFnqkxY1ZWX51GmBzqVJMX
X-Received: by 2002:a05:7022:4398:b0:128:d9a1:b68b with SMTP id a92af1059eb24-12be65988famr756348c88.33.1774998929384;
        Tue, 31 Mar 2026 16:15:29 -0700 (PDT)
Received: from brho-desktop.RELATIVITY.company ([136.226.6.69])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2c89135747csm3069933eec.12.2026.03.31.16.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 16:15:28 -0700 (PDT)
From: Brandon Ho <brandonho667@gmail.com>
X-Google-Original-From: Brandon Ho <brho@relativityspace.com>
To: xenomai@lists.linux.dev
Cc: Brandon Ho <brho@relativityspace.com>,
	Jay Sridharan <jsridharan@relativityspace.com>
Subject: Minor page faults from memory compaction causing in-band transitions
Date: Tue, 31 Mar 2026 16:14:47 -0700
Message-ID: <20260331231457.141480-1-brho@relativityspace.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xenomai team,

I'm working on a real-time control application using Xenomai and we've been
experiencing unexpected in-band transitions caused by minor page faults during
kernel memory compaction. Even though our RT threads use mlockall(MCL_CURRENT |
MCL_FUTURE) and we've pre-faulted memory, the kernel's compaction process seems
to temporarily invalidate PTEs on our locked pages, causing faults when the RT
thread accesses them.

Has this issue come up before? I'm wondering if there's a mechanism to reserve
a section of RAM that's excluded from compaction/migration entirely, or if
there are kernel/Xenomai configurations we should be using to prevent this.

Any guidance would be appreciated!

Thanks,
Brandon
