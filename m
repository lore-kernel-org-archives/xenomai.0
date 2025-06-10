Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522E12135D1
	for <xenomai@lists.linux.dev>; Tue, 10 Jun 2025 19:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749584183; cv=none; b=u/RBd8E/svUDEX7VC6nOcyLnV5kgUnu2CqtIO2maKMG2sGk7et+CS+4VLrOmN78Fcr7d1QbiYjO9QSoW36awIdvcej3bguQKeLzRaJs8eI5kF/NwD9kjEq2B82NN0hlrkFeRfpC15JD0C06ua8oHMhs8eTW3xz0cuD7x/oUG/PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749584183; c=relaxed/simple;
	bh=n23fvWHvajIl0PPEO3kuv0b0oBltbJdYJ+o9it2yh7U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Ud4myDeNDzII/sKoEtmNLUABodQH7hStb4Gb/2uYLSpekDyC475OnulIvqPuyBD+nJXudDgyT11RmBKh6hfrSBn7IdyOn4EjTFFcWIiIiqPQpMpq+T2CTTWayW5ffAVwvMmbswuaX4L+eujdY3BTXXyUjgZJLNh26PmV4N402IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbCErAsE; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbCErAsE"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ade4679fba7so559163066b.2
        for <xenomai@lists.linux.dev>; Tue, 10 Jun 2025 12:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749584180; x=1750188980; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZWPofPiY1KLpb06v44oOusovXVW5kBAixpfqc/imnG8=;
        b=TbCErAsEaH6UiJadatFgfjboJvMmcZ3gxQD7QNZvRxnwaaV2g6bgUa27M8cQfDZglJ
         H6C3wfHSR8GBGy0LwApGCbQ7s+WcwvYXDMGN+llFoWbac1mPmzdzIBf6ApOE89B9UeyE
         lJgucj4Laayeamy83+fM1lLUgHEvfE8AvY0PhR7ix1/T+zEvJUr4hWjaD/NxNMAjckfn
         uPFVLwWSkrg1qOUV92C7Mi1Fgqzn9C2O+qJMBFxAEGUy4Abq9xyyK9gq5t6BCDCAz2La
         URV2KgwMdPbVn/bTH5p8FLoCR4nY/Ai/V6HqBQ6i8DycB6kXrGpJP5Fvc0bWCKgX2xWy
         6dfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749584180; x=1750188980;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZWPofPiY1KLpb06v44oOusovXVW5kBAixpfqc/imnG8=;
        b=A9A8nFj8SuALhHHkozQ/71p0UJ4Z5BSNyIxFA/iR7tOMOSI9adN3cu7e0lAcPVJ+Mr
         UMILy+/fGntZWC5qPPynAV0hOlGQt6VOwoDw/Fbjj9HRp6TElonPPNZlouo73FKYY6lC
         +0XwOl+1iaVFCdUkGbUKlBFeXqe7MAqfO2UwDxgIyPXBVvq5P5AEOA/qQYN1sAmDVDz/
         Tup/BDPt6o0MGfSwhry9O1IYiFnCfmlgjlODjdyuW8OJO7aGFGue2NzLHLoPY3muPpbr
         NsF2gnB8vTw/ddAVJOPCTasyRIYSz9McMhNqMy2bUpMVH2R3IfuM8gr5yph6QBS/aFWx
         l9SA==
X-Gm-Message-State: AOJu0YzNdqcx+pSb3BjdPx8lxaNPDwBjnjvL92IgT90a/yvit4eePpZ0
	ws5LgrDtOeLVqdPviC9oVht0keiwiZooGiCaoL06LFoTxWllxU3REYf1qhBrtvZ6DsxbLysgSfH
	Ht8jTjTE2PcQR8fblA6tTGlZZF74M75S6Ii6H
X-Gm-Gg: ASbGncteVTRCtJwVdSvY95wGlK52dtpKSHFKSQW9Wgqe5+lFXhEoYthH7Z0f2sCRhsh
	bp80xiDFOSnPeQcyBHWkeo0DLBb8usV30a7eQUKgQ3umsDWhKtljn2qiUWQ4mJmCrzmUEDenvuD
	KncE8gTMsFvBgrxmcma/YFKwUR50goVkUyZkIL3Cs3NiBs9g==
X-Google-Smtp-Source: AGHT+IE/6dG5km3MT+HfaDGFurStGvScY/B6Ta1gzIj9sysxUCoF7YHKQyU60U1rUAl9AjpwQCPy+Cx0dJEVeloJ15s=
X-Received: by 2002:a17:906:d555:b0:ade:4038:3256 with SMTP id
 a640c23a62f3a-ade897242b1mr54443566b.39.1749584180255; Tue, 10 Jun 2025
 12:36:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Tue, 10 Jun 2025 12:36:08 -0700
X-Gm-Features: AX0GCFsNSuaGDDmXzeQIX2xi4ANUlAKJFNXn9ycBztueHLsuNvtKf6YmEv_9DyU
Message-ID: <CA+K1mPGcTjSfPztq_YyDSaAJoYUvL=9B1pTP3cKJ2S0WOa+VAQ@mail.gmail.com>
Subject: printing device name
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

I'm developing an RTDM driver and I'd like to printk() its name
string. That used to be possible
in using "name_string" in the rtdm_device struct from driver.h, but
that is gone now.  Should I instead print rtdm_device->name?

I'm on Xenomai 3.1 and 3.2, cobalt kernel, ipipe patch.

thanks.  -C Smith
