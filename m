Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5713523A
	for <xenomai@lists.linux.dev>; Fri, 15 Nov 2024 07:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655787; cv=none; b=cF2JV0dG4SFjzwy4QZ44nZHOtv031ABHm3eBiMy7NJfOLDnaxsn6exUufJ3L39qrEMjqO3BrdI35QTq3MMrJA9/bvePT/eUj+wdsIeFt+8reEqKvtL8pM3aeQ9BXxKHEQbx0cRuAYKQkzyCoaYnxueoehwUIQ3J1UZqRbEoQ3KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655787; c=relaxed/simple;
	bh=w1+FaFydNfFTH3bm13esytmUtDV6zR8LcoZJQ3nqD4w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=TrkdlGWu2NNmH7t3hN+hQpw6Hg29DjMLkJwRcez0Ec7py94ADZEKWS9+Ypd8SOerpU8igl4g5wbBGbabFe2X5HJ3Z1xnDi1XeX24UXFD4lh3sbNJzqoB0LYRILw9ipRIuAWPXhRIxlHkTjCew0OIJA42/QrmKM5W6J9T+PJpYPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8SLhHzw; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8SLhHzw"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso68138266b.1
        for <xenomai@lists.linux.dev>; Thu, 14 Nov 2024 23:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731655784; x=1732260584; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CMp+VeNlHn84nvT2zi1Y8DMHPDnIulnJvx5EUdg+cH8=;
        b=e8SLhHzwPbNCY1rUV5PPXJnM4v1ZXG9FcERvaPxgy/gXsSUSCw99Pqr9WvQNcfqTYn
         KUXVcJdFzjm/nDNC4vCRtbS5IzF87kpVptY7wSENyxAJnuvmYUxvBGrWnHM/iU8yKAA/
         kZ2SJsvSXuIP02P6zWVJ6GNUNerwdjR18yRszpCrUYmFPiPgUDn5WaG79CSr4P5ex2uR
         fnpPHEEka64GDMkMwkfU3+TFBBpL5ReNDRuktJyUa34RiWgEMfsl/t/unAdY6I+08ccL
         /+lQL+FFBXp5JKxrc2IgK3dQrs28q0WCEwAgGeb9INf5ZDmd3QaEsmWDxrs0rbOCOx8r
         X/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731655784; x=1732260584;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CMp+VeNlHn84nvT2zi1Y8DMHPDnIulnJvx5EUdg+cH8=;
        b=JmOOJmj5Eb3b94p/WKSRZ7LrhJK4reJ3DXq8oGy7gt1Q4IbMwpV+bJCuTO4jL82/OU
         SdqM6r0fiPhikD9CVcc9utwlTkZV33zHRQGGqqqU4vaoZUdF6q30PW2LLPMaPIUsXU3s
         p/udYXEahXCJTX0nsuU/ZRCf/h2vZncG7Os9SsnKpBFXuzjYWaAmHUQlhfQOnPPppWIh
         T8R6O7DoK5shSxpkYN2NuYleu7szGOztEPMiYOdMxG/fnrYZRQttMVrWAjlKakhKsszR
         CO2L+NZhCxnByLoxflKiOxC5qZ6slsO50HwB/fbfbH1LHpvn+bbB2yQJaf+c4KRBlCMf
         AZCw==
X-Gm-Message-State: AOJu0YxHCNZ8sbUPZtDs7iwhTUnN/YleabTmv7vsOTKBCvCsqz/MImRF
	8v3YeonHmRwLXGF1E10aeOWKhPtY9dS7rr5FOzIUiTkqMg7854dSB80izcIdTKV3sPHLF3Z7Wt/
	1MacZ6i8Bakfn4dm3DcMTPBQX39LuMEgh
X-Google-Smtp-Source: AGHT+IGjHpGpUVsPhjIM6LcckCIWZj3Y74rtGheh0/8KzlzaCSkYbgTrV2Nx6gN6owZyiGLdITV91Q8M1OyVaM96ypE=
X-Received: by 2002:a17:907:981:b0:a99:f779:ae0c with SMTP id
 a640c23a62f3a-aa483450acbmr140528866b.25.1731655783705; Thu, 14 Nov 2024
 23:29:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Thu, 14 Nov 2024 23:29:31 -0800
Message-ID: <CA+K1mPEtkU71sT7Dz6U2N-uXLiuuTsXEtvniU5jWBog81D1gvw@mail.gmail.com>
Subject: CPU threads supported?
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Does Xenomai support the _threads_ of an Intel x86 processor, or just the cores?
I'm using Cobalt kernel Xeno 3.2.5  kernel 5.4.281
I have this 8-core CPU: 11th Gen Intel(R) Core(TM) i7-11850HE
I don't see anything in my kernel config that indicates thread support
is enabled.
lscpu says there should be 2 threads per core but does Xenomai 3.2 use them?

thanks,  -C Smith
