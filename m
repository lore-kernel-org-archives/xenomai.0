Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FC93B29D
	for <xenomai@lists.linux.dev>; Thu, 23 May 2024 07:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716449567; cv=none; b=tTfgCRubjgPZqJcve+FsbJNtQ1NDGmq16SrqIUmpl0KlGJdNjodC2Y+4fTm48lH34wIe6aRbKsiCFeg0P8NA/Z4ebdw/P9YZwIZcXmb7RYscCtNCzvpBXUxvmBRDr6sRVbyTPyXsPbeWGtGJIMWj0sc07tEpx3Zn6A2DtdJyhoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716449567; c=relaxed/simple;
	bh=YVO7i8QN+6EWRs64rPiwXuUptm4vYUI1OL2UyipzR5g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KUjLOfdw3GInyM8CyDps1qul74RXikB3VcBQI2uyA+CWJdAP3yeq91p0gNG7L6RsGrpHZP1ERtPmLGwsk9bc+MoQGEQHqa9ZZpkVDBLRYVFl1OQ/pD2YgWYdseZ5y3q8YD4WmzugeNrbP1/XaD5v91ETywfd5+NFjvk2EDqfdT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4Hs2+Jv; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4Hs2+Jv"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-43e415ae282so31601071cf.1
        for <xenomai@lists.linux.dev>; Thu, 23 May 2024 00:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716449565; x=1717054365; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m9y/Svvux7qhBy3odZVZCSDTXlTX6T1MqLqLDEhfTgo=;
        b=I4Hs2+JvsVj6YuNL6VAw3AikV4dIw3ggd7NpLZyQsehXCj7qrCfnKn2fm5Nx6+/JFM
         PnlSy/9iKFIV7jjBpEI0IY7ps33hI6YrZzxN4ebTAefLwh6nA0btsN+UiwlftWayjumN
         kZE/qpofFj++JbcZvr37AwuoXf05skGBjPdJGv89Ky8cpz2EwOjqbIJdU1z46D6xCGTq
         890a8vEAX5w6mk3ksi4e3R2lZ3xcFkHemIwa7X4pAwquu2FFC2H7fiEYQ9jiE6IwPxma
         HP/iZ9rQP44EkWsHsAXjICh5WmvzrRuby0q0XNXSF8PXJrMAtKaFoMimML43S0AUltSr
         d4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716449565; x=1717054365;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m9y/Svvux7qhBy3odZVZCSDTXlTX6T1MqLqLDEhfTgo=;
        b=GR4ztV/r85sQiNcxkqPvYEQCH48A2SLsSFZd5GoC7XnvJQY3ep6k5w6VIIjKW8VCtY
         xwHVdaj+mlh0mwI2eBbsR7lk/Pf9nzt9FyjdeQLFrVrMMJEHjXaaXcxVdtM9M5bsiaiT
         zjoG4au7acVFDl+OJxcheVAawt84FJpm7RCxp5flVF1koFPlxGycW+yGltK9OcKHSiFo
         SnhXdmf1mG488gzjKGcxKjyI/QHAKbj+dskioP6/q+L2KVlb2tGUYyH/CfqkkQH1KS5X
         +Ak8/feNnizTUlPiqwl6Xcdh0M8ygoZvtXlYb9WwhOEgTTHLBh1p3a0kulEJWXRRILAy
         zk0A==
X-Gm-Message-State: AOJu0Ywk1eRLvDpkAMl46XCCeImUyMCMcOx+uBVMvEilJmDPdF9hWCA4
	/omApkc4UlscFHZuYxL/DH0USBFHFvsral21rfOMpVmNe74SQwqzD23LgMHHPqJuzdEBJ8JFuK8
	ahSErzj1AtkImYvrnXO509PySK6FVD/di
X-Google-Smtp-Source: AGHT+IGkR/yeA2Oki8bg8gWOwX0Qodg+NDKXE/HUvE8GJoZq0Wv2krk51W7cbh6pMoVpBlQICvVTdppoB5kJauQ4FFk=
X-Received: by 2002:ac8:5e54:0:b0:43a:b1e3:d6db with SMTP id
 d75a77b69052e-43f9e17a448mr45362431cf.62.1716449564473; Thu, 23 May 2024
 00:32:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Norbert Lange <nolange79@gmail.com>
Date: Thu, 23 May 2024 09:32:32 +0200
Message-ID: <CADYdroMJCeW_UNvc6K1p_2dc2-hCDWyATXcDq6iHL5pVSrFknA@mail.gmail.com>
Subject: Dowload URL for ipipe patches?
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

the older URL's dont work, and I did not find any reference to the
replacement, even rather recent releases have non-working URLs [0].
So the links dont work, and the gitlab repository doesnt offer them
either, eg  [1].

Whats the plan going forward?

Regards, Norbert

[0] - https://lore.kernel.org/xenomai/E1qVdKL-0003yN-Ua@xenomai.org/T/#u
[1] - https://source.denx.de/Xenomai/ipipe-x86/-/tags/ipipe-core-5.4.255-x86-15
