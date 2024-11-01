Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4FA19F436
	for <xenomai@lists.linux.dev>; Fri,  1 Nov 2024 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730481337; cv=none; b=kIn8/RLIsMCkrs59pqXBXBfivDAalnErJ9Lw0JR2g/rxE6+wIEXiYgpEPnliGZn4Ufm22t0Z4m3wxcUdK0rUL5mqktRdNRp9svExT8lWiyU73E7SOB0SFkdo/g5Q9xSwgKga6IoCA/IBMeybQEcpTrbjQAWqIWn1ijOj/WixQPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730481337; c=relaxed/simple;
	bh=iAb9xyIQpXFSBVtK7jNktpvm7nMqfuKGEC5v/ZYwEcQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X/taBIJMOYDYN36gvmYnRALiXOjwkAy5m+Mzbbx/t/MDnjw6s/ehxq7cyUVZurnoWbyJoJIwuCOOUrf5icY7t2HvWWj+bsmWQDWYWos3h6R8b2/2bAAXI/NxLTwuXuXQGROO7Cmm7fbO8OU2BFhde+wFo7RuRSr/KkwTPyY7fdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d3ecad390so2046055f8f.1
        for <xenomai@lists.linux.dev>; Fri, 01 Nov 2024 10:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730481333; x=1731086133;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SbeyF0y8CFyHqiwbFoi/2//5FnXCdliR7DQCTIA53Q=;
        b=rJB3dm1KZccZqe/wQecWg8Z99ipe1D6vYv91+Q8I0hRJW3MmqWW+xZHUWU1gUMUVn+
         FfFJQ3FALAs3Q1k8D0N6tAlNtlWpM0RM25iMWYHqo60vzfVDKwOPdsG2VOwXpX0rGzb0
         OqYdJxTNTqgxNc2TdmohNOMnVhJKdqpEp5r0hJC/hD2ENIyByKFsPeBlWV1qeiycQO5V
         xbJTXNKuCVDz7z0L1iWhg0Yr36j6I00L1N8/Fqm3YYzdTNmMLaN1jurjOGgWMT4xjBRT
         NMmXm5BgSOHeAelOH4RNlYgGZGQR5TmgwbQe3dudzYOYs2KEdFGci7PsrWH+dlfd5JBs
         0idg==
X-Forwarded-Encrypted: i=1; AJvYcCW7Nh6vTH0Ybek+5Kbc2pTdJycAmqLuVnT23Gg5WYkWGK/k6b7dQ6DeMz8WtGolzg3mTxFlvQ9U@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0duuOqVbi5t1NbGiV0GL1BNOS02MOI8bMJ8Yob1bO8ueb2n7X
	c215qg31W9nBr6FrY4Z4upcDDABk/6DvuHgDdaJlrhOzPPT1VL5B120aSdEZ
X-Google-Smtp-Source: AGHT+IFTpCL6YLM8CdrnVoH1rULJmjz1xaCE5krBbAbFXkU3oPQxDH98IFrJ4QvKLh1IwTNIBpPHbA==
X-Received: by 2002:a5d:59af:0:b0:37d:3b31:7a9d with SMTP id ffacd0b85a97d-381c79e3b6amr3553468f8f.23.1730481333233;
        Fri, 01 Nov 2024 10:15:33 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7b65sm5851477f8f.4.2024.11.01.10.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 10:15:32 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: "Jorge Ramirez-Ortiz, Gmail" <jorge.ramirez.ortiz@gmail.com>
Cc: "Schaffner, Tobias" <tobias.schaffner@siemens.com>,  "Kiszka, Jan"
 <jan.kiszka@siemens.com>,  "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>
Subject: Re: [libevl][PATCH 3/4] evl-test: Start evl-test with load by default
In-Reply-To: <ZyUH7BV50dlhvc92@trex> (Jorge Ramirez-Ortiz's message of "Fri, 1
	Nov 2024 17:55:08 +0100")
References: <20240613134557.4013044-1-tobias.schaffner@siemens.com>
	<20240613134557.4013044-4-tobias.schaffner@siemens.com>
	<87jzisrkfo.fsf@xenomai.org> <87v82cpvl8.fsf@xenomai.org>
	<ZmvxUGDwvbyg3vnW@trex>
	<5802c802-6002-4652-9a23-89ac70b2bf3a@siemens.com>
	<79b2f354ea9a0c2fe5cbe0de9c1305cf34aa6a3e.camel@siemens.com>
	<Zx6QxE+CNTmQqZDk@trex> <ZyUH7BV50dlhvc92@trex>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Fri, 01 Nov 2024 18:15:25 +0100
Message-ID: <87msiig9jm.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Jorge Ramirez-Ortiz, Gmail" <jorge.ramirez.ortiz@gmail.com> writes:

>
> [RFC]
> I would like to update latmon[2] to the tip of Zephyr - it has fallen
> behind - I'd like then to propose it upstream (if accepted I would like
> to propose that it is removed from EVL). Anyone disagrees?
>

Fine by me.

> IMO We should also take latmus to its own separate tree dedicated to RT
> benchmarking and extend it to support scheduling latency metrics based
> on GPIO data.
> [\]
>

We would need to make it evl-agnostic then, assuming you want the latmus
<-> latmon (Zephyr) combo to be broadly available off-the-shelf to
others.

-- 
Philippe.
