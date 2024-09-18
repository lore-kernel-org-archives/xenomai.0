Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AA4132105
	for <xenomai@lists.linux.dev>; Wed, 18 Sep 2024 08:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726648004; cv=none; b=kZinxY1mASkkQycoIu4l8qzeFpvBz6YrdMelptfpgZTEAMDzADmCbJS+D1GUrpMCohCd+pPqcKCi+uGMP8o9X+/i8W1Q89LgSK2GzuAbLo21nq5KtmqkIZ3rKg0hdUMPVCKpA68DzXsSbmnmJJqLSNigEM0ezCcnqFU5oZa+GeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726648004; c=relaxed/simple;
	bh=e+SfVR4au6MujhIFzAotRzk8qzv+ATQZm9JBWMCyGZU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sxQOYJ1+yuDBN/FT3SEGBeGcg3ydin/f5eDF/fWXjIxKPKuTT1EViiEKRy/CghYxbbB3qXf++tLyVsq9ZVzGq5GyfzgTzRRGx5YtBithnokhBcWoYBWkvmfHITLMDYD8FOhNqW+xeClUvkG7JcmPWHOosACEuKa+rCpnr2yGXTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c42e7adbe0so4181715a12.2
        for <xenomai@lists.linux.dev>; Wed, 18 Sep 2024 01:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726647999; x=1727252799;
        h=mime-version:message-id:date:user-agent:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sxCr32pUTA0Qq4iHt0MJcfAlQahXiSSBQ+d6gpabxuE=;
        b=RAAuqqVybioJzoXwzIbw8GEPzHVgkpKBJrLEhhS8KrKXVDhdggp3coP33IreIf7BeB
         2mQLJ+SpdHPtZs8N/NT6QY6f1Y+xvuqIDD+jSkcJ4zm3y4oCxMys2Q6sLSJQfN9lfekC
         8Tulh8Nc14f445FFoZ2iQj6nqkIYvn16miyJj9jwMon/9pR9cjv+vmBs2ebPMNBrpTt1
         bwxAwvrNmiNBEZuAVvoJMTzEW2YknjMR7bPV6HfBnIoFv8KG/iJq9jrOwWDi92u+1F3d
         P5LYbzFWKz+bfXFofD/P5X6Je/Yb+hfSLuBZaThUNhqtd7oZOHoL4XitcTURweFZlSx/
         +2dA==
X-Gm-Message-State: AOJu0Yw8AX+3bTbW4gg2kMYDcJotL7zvVq1hAOtFJ5cekFhL7EMhRNWH
	ViCu/XPFuqfTmNXqx4tGpjYUN6QR4lOlUwp/fnd7EjKepgxsfFiFvEvdQcn7/C5cvA==
X-Google-Smtp-Source: AGHT+IGf7vCRnSSigNSH9HOR+wSZxFNphYaVMw/a+KiofWqC/pT8YGgG7918N5dLAGj5SLuZ+MJjdQ==
X-Received: by 2002:a05:6402:254d:b0:5be:eb19:ee56 with SMTP id 4fb4d7f45d1cf-5c413e4beb1mr18673701a12.24.1726647998438;
        Wed, 18 Sep 2024 01:26:38 -0700 (PDT)
Received: from bogeyman ([91.112.223.58])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bc88fedsm4604822a12.92.2024.09.18.01.26.36
        for <xenomai@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 01:26:37 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: xenomai@lists.linux.dev
Subject: Heads-up: UDP support for xenomai4
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Wed, 18 Sep 2024 10:26:31 +0200
Message-ID: <87y13pnz9k.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


At [1], you will find the latest milestone in the xenomai4/evl network
stack, which now provides UDP support. This work was sponsored by Exail
SAS [2], big thanks to them. This code is currently available for v6.1.y
and v6.6.y, forward ports to v6.10, v6.11 and detailed documentation are
upcoming (once I'm back from Vienna, basically).

The code is split into two parts: the Dovetail support which provides a
way to interface with the regular network stack in order to redirect
packets (skbuffs) to a real-time core, managing their lifetime as well,
and the EVL-specific code which makes use of this interface to provide
raw packet and UDP layers with bounded time guarantee. Both the Dovetail
and EVL (rebase) trees have been updated.

[1] https://source.denx.de/Xenomai/xenomai4/linux-evl/-/tree/v6.1.y-evl-rebase?ref_type=heads
    https://source.denx.de/Xenomai/xenomai4/linux-evl/-/tree/v6.6.y-evl-rebase?ref_type=heads
[2] https://www.exail.com

-- 
Philippe.
