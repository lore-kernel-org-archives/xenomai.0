Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD901F790F
	for <xenomai@lists.linux.dev>; Tue, 22 Apr 2025 23:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745364238; cv=none; b=Ks+5pijZGyQRWeQrZ6tyHL2bDDIFMffKjYkXFrDZuGRvBH3AbiMksZkYIEJ04CvFBY5OK5bUnHtYIRrj93TeCFjCMA/FRsMj1gD0CTK0YlZcM44B5pxxmvPTNpPvEw6HySzcxRw+M+tSsZEl4tqyTuXqRXBVVqkVLMxsm7eFgPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745364238; c=relaxed/simple;
	bh=syAMmT80qIEohgmfi7FkWbNX4uYSBj9KM8SfQuLB6Ew=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jlEKcFgK46L3yWEG67ocUaTGodg4UJU9KSDqPcm7TMagpGESV0CXOyW5qAyGAMY8d5eYoU93bGj5HtgdoVR/eSqK0TmhsIZIpuESs38M8xBhwZZtlYEGfAtIrd7J2hvzRdEy4qR0sHLR+MACYh61mQnhibNvXaHCbpCfAskZEaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3ejhe7Y; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3ejhe7Y"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac345bd8e13so822597266b.0
        for <xenomai@lists.linux.dev>; Tue, 22 Apr 2025 16:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745364235; x=1745969035; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=88l670XAVgwyfgzF3ub7gSABst8pT35IHuBtaaM2gAI=;
        b=E3ejhe7Ykkm3sAxza8gHWsV58lGA0kILkC3jMJdgk4LOaHei15+Tss6KSU715899Gc
         DB+nvklLSjcIXC3O+fXe5oMx5pbCd8XmALvuArz2juIbXRcdbZNmBReOvrsRtkl2HY5a
         92XvJ48d8jaNg/DtkzV9rEs037OC98D8DJjmzUME5Eweoi4Oxnrst7o65w2NxWXhoRf+
         ORbfp/8uTd8lXpccebbqDGlVucHUmO8tn8rjxMYx03tO0JT5/9+iXA8Icr8UTUEm8U49
         w1dAiCipOtEIiMX2IStqtoPRqSxXMsh+DeDHJIV+J9PieU4DXr0Nvn0jbow2iKDlOmVw
         UswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745364235; x=1745969035;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=88l670XAVgwyfgzF3ub7gSABst8pT35IHuBtaaM2gAI=;
        b=vDIidNNxkCAcKWL95s71nh7u+XbCZH6CF+uJqzOk77o6DbdW7lAPHVJqF5pUfILxCu
         SqtMnHD+p7V6G9vN4fMbcs20fnRJf++arDpYv9+1BZrFvfljuudIDFrX9oOUuX/UVicX
         vCxB3Xux+D02TkzNSQgDeCK70CeVr/jIXFSQqRblZwn/X8nN+A0xls2Edxn4ZoaGorxz
         v1ZhJuMu8u3ATKxc7p0krLFI6QTIGML26d5ohqKpd4AXDi0aJu8tZYhYlbjJg6kbJDFi
         mw1GkiClU24RHLiHwRlU41rCF7PcVtxU4LvRmGCQiBzJ2MuEYI82G3DGsyo7uvh3Y2Tj
         Rxqw==
X-Gm-Message-State: AOJu0Yx4kixMF37JlmX/VDStS310hd78nm+97/a10cM3m1cIjgxxgiAT
	gzTBGAJyfvcPgdxS19MT1243T2Qw1SHYlLi8RVrmbv9AZt70ECi/RtC3xbs50oQ/kQNwQSZY88+
	U+dXkXmT9aXmRTo+buraR7m7frMriu1yu
X-Gm-Gg: ASbGncul5DiDB1Ev5T+aB0CEKCzWcdB0GPxo9CMh5ygR5yyqcl4FV+asvc/JN8L8L1w
	6vp8uM8M/xgNsVFeEFTemYxSZk1XsmSQWurPc9xx+wEZHw/uqgyFn9uxu3cOxVVMQ9fESsd4qsU
	bEbwhOUEs2MsJcSQ2W7Vb5nE2c
X-Google-Smtp-Source: AGHT+IHWu6liN3GMvAODaEZ/fESqQ7pps21yVVETdJjCbgF+b3VUipscDpnphEOTeh7/cDCa+nuPcoO1s44l0PP72n8=
X-Received: by 2002:a17:907:3f1e:b0:ac7:3918:752e with SMTP id
 a640c23a62f3a-acb74e134d3mr1553984666b.59.1745364234597; Tue, 22 Apr 2025
 16:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Tue, 22 Apr 2025 16:23:43 -0700
X-Gm-Features: ATxdqUG_DtA9Tk-TNf-i9bYPEZpmnyoBHFP1v5LWmj1uUCmsdFkOVHXcbiyGqYc
Message-ID: <CA+K1mPFJgDYmyM5iZV80JwP21n6vSnrdsQaHV1jGfrhw=+WKFw@mail.gmail.com>
Subject: Atomic double writes
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

I have a Xenomai RT Task which instantiates shared memory and is
writing doubles to that area. A Linux user space task is attached to
that shared memory and reads the values asynchronously. Is the write
of a double atomic such that the userspace will see a valid value at
all times?

I am using: Xeno tag: v3.2.5, ipipe patch to kernel 5.4.281

thanks  -C Smith
