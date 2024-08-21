Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179801A4B65
	for <xenomai@lists.linux.dev>; Wed, 21 Aug 2024 07:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724226349; cv=none; b=ext4zxm+sMwPGhZrqhPBpfYITfhEQcrbM//7Ryy9kWAID5I8T+ZufPnJGj3EDpCm9CnVJ3TstyRHNvUZ2neHQ6N0Q2uuMay5ghq+68gb5SKDMVoHYH6y4nwYB3euXpstKBqwTpTMmNhJBkS6gi2IwlHsXTPCav6FGINjOdpDt78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724226349; c=relaxed/simple;
	bh=hfc12bmc5MMOul4Mv/0BZHd0P9gCbuWGqlAuitLF5Oo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=EbDze3bIyiCCKUMxE3VOwn2lrkNynLE/MiKonml9KzYqJFHHoMVHlfXihy20cBR2nCFIUGNCZkh+sapog2zAjCwCDZSIhCmaysaMLHts0OmMTnNgL+GkL9AAhtVEcQY4JsqsuRCrU9aajYzkRXDOT9aHSD5b7p/TwRdxt5Ba1Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3/VCDp1; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3/VCDp1"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7c691c8f8dcso4284710a12.1
        for <xenomai@lists.linux.dev>; Wed, 21 Aug 2024 00:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724226347; x=1724831147; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ivAZ6JW6IrF6/EyPMieRwfl0epuDvBaxjrpG5OFWM2k=;
        b=b3/VCDp1JuugjEZjltjgQIVGdisCri5rgKRobMllYUWdDKy6g+8ffubNudsFVOlfcN
         M/YyaLtD6cES02FenW9POm/9yIaNnB0O2TIM9gKw6Au7+XbO7RBEHv33p2BtBNWHTCtP
         /Kd9RFH04/z9Pa+/m5MumWYL8JclDN23H31PxeH4GqVp50yoqv8hdd17CP2Yl4MXU2e6
         lkyd4hGVETpH+83i6K6DLVs3l++zeiEl7Jio5ntzX//MnnlyE/Yio3NnGlkOuv0fVB+u
         67ZGQI6cVfS9ALdVYV3kh+2SL1VHX8ELrisiCCigXf9ytYp31Gq3t9Q5U33zS4PyFa1G
         bblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724226347; x=1724831147;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ivAZ6JW6IrF6/EyPMieRwfl0epuDvBaxjrpG5OFWM2k=;
        b=J4xBTD1+w/mLRVbIl+HyRNHLx9pe65bFJb6XYf6uzsnSGbr8Ero/2nmQXV8XoegKVs
         VhDzz7978WvUSr0uJn2CW4X9+6hoORjpWrEzkKeAr4NqZvSXkPVj+3VzpFdFfuE/THdJ
         o9F9o41H8umvTtzaRofvtLgkInolKKrHU8vEisBGZjGLOzS8ULqMQwtA8JAynILqDjhW
         elZbFccN0s5gWmo9zwpOAh4dXX9eVfCY5E3bnuZ4/K2RASe469P9Mw6XVz8lIqSO01kl
         GAbItGjKNdDEDk5MYOAfuxzfUuEgN+B5rFsfCMGqsbHijE7ilqgMj84zzUO0suTiwzhL
         hfLQ==
X-Gm-Message-State: AOJu0YxjKMX/Q3POrevhlpgcHL/rezGp9lEGX9GEc6xaT+WJp0cXjWwo
	mFsNNvDg2OUu1zPg4wJm2b2gRmXd3RXHhudRtpOsMjq4wTzqG1wfl/vMiVD/3EtV05FmfRpH7tQ
	idFIygnHsH7/R2InCcRDykbwbQnEgRNUL
X-Google-Smtp-Source: AGHT+IGdJq/OWUcJ8boXKNXNn3nLACieMydqddRSxoXO14UxFNgfJ5DKaRJy44PWDaWc3dzBt0Syai2jZQ5r6lgeKM8=
X-Received: by 2002:a05:6a20:4c25:b0:1ca:dcb1:a443 with SMTP id
 adf61e73a8af0-1cadcb1b26dmr652551637.9.1724226347184; Wed, 21 Aug 2024
 00:45:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 21 Aug 2024 09:45:34 +0200
Message-ID: <CAFLxGvyx86iSB1MAZK43qMT2inBHE9ie3KzQtTpEzoctxOsSLw@mail.gmail.com>
Subject: [ANNOUNCE] Xenomai Meetup at Open Source Summit Vienna in September
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi!

We plan to have a community meeting on Wednesday, 18.09.2024, around
18:00 at a local beer garden.
Please add your name to this nuudel poll if you plan to attend:
https://nuudel.digitalcourage.de/kMUiqrUD6cofTEcM

I'll reserve a table a few days before and send a mail with all details.
See you there!

-- 
Thanks,
//richard
