Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2EC33A715
	for <xenomai@lists.linux.dev>; Thu, 23 Jul 2026 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816610; cv=none; b=EJkMM8KShbIWDp8nOvBp6y8AsdFIUCJqoJ7WK6IqU9vwF+wlN5fuJctGdc7YEs30UgysHXz9dpI6hMkrqSSb5yq0L00OXMAb0sDoBwuHVJltIb4DljK3vjsr2BIz3OYId5noRaITVbUhfTFE3jN4y+cBC/+wOoNZ1eq+Jb7yFjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816610; c=relaxed/simple;
	bh=6m11iw8zXzxL95ggjxUlx7DRjq4kaoiueUoHvBTQt3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=na6dtUDVzfzeQpKVjYX/spnWYWv6XxlMBAaOrdTBPehrKxBH4rtg06WGrN6LD2v0kEpKdeIaEHQ/38F/0yZ+4lrO8vlLCFpYkBkd99Dl9iHomKGCsQehHQve6/bbwr0q6rxdY+zdQzDrVkmBtaYefoji+3hGd0DRBQAI2qYfTzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=O+sFQyBH; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="O+sFQyBH"
Received: by mail.gandi.net (Postfix) with ESMTPSA id AA2C73ECCE;
	Thu, 23 Jul 2026 14:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1784816598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IED1+Xch5m8Qa/7i8FAz51FDAD4Yv23vCh+dk9yuxBU=;
	b=O+sFQyBHSYtI1jnKHOpAQ6jMYwAwFtHBfemlLmTF1cpjA/SPoBiFquQZuVYgJCQX+nCODl
	4+dxi99Og262U7eYS0HGNjr5hZGaV/6gNn6f+p22PXIy/Lce+w5oiH8jLfIUlywhQzNxnM
	XRQZjkrGS390MAsqhQ9r1fi2Fider5FGtgR803SXmnZU9XvnNxgeFqoY76MxJvhB5jlIbM
	rzH0urbbHMNLY/eSa+nTh3MZUS14Z54hT3hSd9cAkDqIJ8ZjAQDGgcB+8s/QSE75vZVXoF
	w0ghccZMLsMsH15EUridrGpgyFNLo7Dc2Xo6X7w4x65TdQwc1Hz6D209PIB0gA==
From: Philippe Gerum <rpm@xenomai.org>
To: Richard Weinberger <richard@nod.at>
Cc: xenomai@lists.linux.dev,  upstream+xenomai@sigma-star.at
Subject: Re: [PATCH 1/2] genirq: irq_pipeline: Don't run handlers of
 disabled lines on replay
In-Reply-To: <20260721081537.809383-1-richard@nod.at> (Richard Weinberger's
	message of "Tue, 21 Jul 2026 10:15:36 +0200")
References: <20260721081537.809383-1-richard@nod.at>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 23 Jul 2026 16:23:17 +0200
Message-ID: <877bml23ai.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTE36IXj9a0DnTdVMyXy6KoRtDcLUyXbnj9dCU5cKLCLY50OdcXMfniXwxeh9HvJlICf3hm3M9X7L2pF8lbKLvo1QaGI6vccHe6YP75EAlAzJrTl19wYCvRMBxLQHoJXiGLinjDcGA1szsRqpeIX13RtSerzW9IFLqx75OaUjUhOdoQQzeMxeCuMqQi6+Ic3ABbt2lwRhyuA5kim+3ojIzI5PIOqV1jl3qMmoNFiqkK3Hzcs0HlG1jUGegKG5PPVE1BTPYPeMOF+8W1KCI1G9z0kZZlur8sBjEUUsA+dTAB6RIDUD/SNWSk5Zp3a8URdTfZRYrZVxvsHJJ2yBDynMfN9tM4JW5d0+5Ggkz9mVRdEn+06adDaOXD8K9vLCM+ScPfJHzA56/oSUjkxyPS8zoRmHE00pjP1NfxmIwouc7wBYlTY1Jnq8mQWRRuVGerBCdhJH9MpA6j6T2NkbRSx+SW1H7h31iqzuq42d9A0dNLNJxiOAKMrKqajndIPmFbL821Yk5aW8xuYLA4dHJ+PibNNWaPDX7t/vgptSu2gOvYanOKxaakBo9cmAbl3MKoHTN52mfNHgLswBAJS1Vv8LMF9n/sa2rzI0jTUDZRYBIJC8D0jY0/LpZuductM+2U2uqM6e4IebBfdg6+KY3QUe7YJj4nmfkHl0iXbqpwxv96oLA


Hi Richard,

Richard Weinberger <richard@nod.at> writes:

> The pipelined handle_level_irq() function only checks unsing irq_can_handle()
> on the IRQ_FLOW_START path, assuming that an event which reaches
> the in-band replay path already passed this check when it was deferred
> at pipeline entry.
> This assumption does not hold for interrupts demultiplexed by an
> in-band parent action handler.
>
> This was observed on qcom hardware, the qcom-ipcc summary interrupt is
> an in-band line, hence its demux handler runs from the replay path.
> qcom_glink_smem requests its child IPCC interrupt with IRQF_NO_AUTOEN
> and only enables it once smem->glink has been assigned, but the demux
> delivered the interrupt early, dereferencing the still-NULL pointer:
>

Nice catch, merged, thanks.

-- 
Philippe.
