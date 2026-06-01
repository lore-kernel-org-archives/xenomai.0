Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DA837DE97
	for <xenomai@lists.linux.dev>; Mon,  1 Jun 2026 13:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321403; cv=none; b=jsIjLWvuMGZyCSc+0ssxlHJhtY4OBDyy6P7NVc/GwNIPFx6HawaTiOfYIi2Ph5Vchd0fbqDttiBJOOqUj60fORPfH7jLza9PO14WCaUzcDUANK3mGdNvIoQU6L8eiQGpoyhIEv5a2G/cLgoYKRC2nZVfzzrgcHHanQKTlI8lCEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321403; c=relaxed/simple;
	bh=3YV5CkE0hdMjRIFNhJnWHTQ6bywF0bfV1UbQ483PsfI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O+Y56hjRwI6QWGCrYbqUBUtOwd8g1rznL5VTdSFxh9cvh76rMPlztoszUzqrm7DFrUBQGOdmQkFxyHAJyB3UC7TOs1wnzVbvykRgM0xX56MA2Z/LI3c6n9UFHFrHKE8GgTGyEJaFLyfwO+WPVtyoyZTOUdmlYt14cmh+NsPlgDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=OQPqasEl; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="OQPqasEl"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2328420650;
	Mon,  1 Jun 2026 13:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1780321393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2touMXhrA1p80GntmUxvtnp/JRcQPzTGKnPDNkjyATo=;
	b=OQPqasEl0K4z5LM7Fe1LVS60KTWE4YXphayL8StReHJCgNS8q5yI0ps38gb4qohKGGBd57
	4evjNROD9oaviN/BmSneRDCbH16FGWknX1l0ysu8Xafa4u9eidny2KJ+ItPPQmIw1ApEHi
	049g/aw+s2IILvSgd4OwyF8hv5uXbbLxq4Tt8RHDBgk2hrw4Avm+BLH79MaBn/tshUl3VH
	CyfT/zH1h+LNRNSGKXHilEKNWKgq1kKlOVox8EYdCd7LLoCjJ91Fhjlv5mw/Xxz0gnh7dv
	PgF8OxtbBW1rig2E21GPK0cFi6C7TQEnY9rFU2X03QWOkJpxxqxg6XsaNvLe8w==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Tobias Schaffner
 <tobias.schaffner@siemens.com>,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: Dovetail 7.1-rc6 updates pushed
In-Reply-To: <aea902f9f55316c2c357b9fadbbd8e9b716e92ff.camel@siemens.com>
	(Florian Bezdeka's message of "Mon, 01 Jun 2026 11:49:03 +0200")
References: <aea902f9f55316c2c357b9fadbbd8e9b716e92ff.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 01 Jun 2026 15:43:12 +0200
Message-ID: <87y0gy4brj.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTEL52XqwlPU+RMEbB8IKG/Vmmsn/9XJa9h5sGovV0XtK5ISmarR+7TnyZdGItAROjymAvMUfqFpN6eDkBUzczh/MKhVR2LRO4eidQwyhSLEzP6V0DgjwSNJ0cToiGcn8nt/8yqcP6orNOaSY/4A8w6h+zp+Jrvqs+BLjvxxCa8fDriimx3xoCfbr629qAExZnES2k575b768u4+UNbX6V5wLG7oNvzO19q3YPHXsxA4PQoRkakQ4ufcyhFJNhN14TdIIKEGm2RxAUwJYeJe6pps2h5RFvEqBWVLq4YwR2kACv4xK2vy2ZKaqfHYEJHybNfZxsbcLMSZg6WTbaqYEkGmHcXGnKIFmHVqF16DuvUHAyFan0UJdsW4uuA5USqjrNyXvuxOQaZNH90GiEmRgJnUTwIFRkDZMsNY5lLpPraS7c5Typ7lMbuby868DrKss3FhqBath/jwDhsWh/3VbZme/TN2SdL2UuONy0G2OxcV9uG7mNAD+SayEfExl8GHYEeMyghaqwQ1XJePe9aDeoCiMFrdJ1G3tI29d+/vxsZXPl0hA+3Q3+9N4Y5hxxspq1OyVKgR2pyv47H1o0dTGhtMAlReaSLUMSVrG8YiAU/BKewHSu9s6YxeDr+n4NS6P0RMcfR5G6KdLE2ATB4CJp62wA3oVCh4uickNCAOhXVWfA

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi all,
>
> I just pushed the following branch updates for Dovetail based on 7.1-
> rc6:
>
> Dovetail:
> wip/flo/v7.1-dovetail-rebase
> wip/flo/v7.1-dovetail-rebase+riscv
>
> Evl:
> wip/flo/v7.1-evl-rebase
> wip/flo/v7.1-evl-rebase+riscv
>
> The +riscv branches are containing v8 of Tobias' riscv enabling series,
> maybe we need v9, let's see.
>
> Any additional testing on those branches is highly appreciated.
>
> @Philippe:
> I'm still waiting for some feedback for [1]. That seems now to be a
> invalid combination of kconfigs, which is dovetail specific. Upstream
> thread at [2].
>
> Can you remember why KVM_INTEL is not selecting X86_FRED in case
> IRQ_PIPELINE is enabled? I haven't checked the details yet, nor tried to
> remove the dovetail specific adjustment.
>

Maybe because the pipeline never supported X86_FRED, doing so would
required to rework the irq-entry trampoline macros, which is deemed
painful work.

-- 
Philippe.
