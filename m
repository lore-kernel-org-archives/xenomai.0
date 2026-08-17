Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D76939182F
	for <xenomai@lists.linux.dev>; Mon, 17 Aug 2026 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786960072; cv=none; b=s8CbDVdcpGFrrAxAvo+M79uBSysGhUKHwKFhKw4Xkz6VDRvTD1a2aw33dnvPVN7ofnfJd2rfqYojUVD16IaAbo18lCLPbfh7YoCwz6vCRtrxJ1QqqMZ+/pZ/Hxfq9XftEDKBUFNyvvhPo3FNS6V0nRpqmCZUtS+GjtrJNFa9ixo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786960072; c=relaxed/simple;
	bh=brbQI9DE9Es2EvQarnGHIYr+WTve2RK7nWIGD7wiozQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FKAbBiTMJgLtoDCOD+POJX4ktl607aoG6VtCTZhOlfKV8XLtUVHynLDspEHUifQ+n1gzd0HsQy6B2sGEGycMIFHUj/flZMcbvHWTSWs5TsWXlwp9OvpprnWNeJMOqCATjzj1Ae1yZeA648yQ1GBSg6zojpKnFL9g0/R0hL8YJfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=LsazTRiK; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="LsazTRiK"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 49FB83E95D;
	Mon, 17 Aug 2026 09:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1786960067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vw/YXuj3mjHFU/PgK5ecNDKeopCUAXeIFvMyWXCpyRI=;
	b=LsazTRiKBl+q6Dh9VeJEmdGNtB/3p54Dvz24jwuJlXVlJNNb4Si/tjz/etkg21xbMUqOHN
	tTL+XMo3zbtQ4JR87bFANoT3ZnAY/zWfntlI3bDMDyl3yy0Pp+Vkx5ez5qx2e+933J7iB0
	jf7LPdTDmiA8SIy7wjEAfEI1aYzZa237om+x0u0n8a2qotIc9BMZUOIJy5t6PuXi/vtwmG
	h4Kw3TrUJ/aUjmHMGdAV9PrUPnAwHpc50JZKAs2bj36XZSQgwVWlthIKZGifX/eDdPnsHj
	ZqU4v1sGK1cjPOBf8Q6L9mv8KUcvNJNAFJMqlViVkKuBRwh/UgajDHrfMkbHiA==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: liuyang <liuyang@sinsegye.com.cn>,  xenomai@lists.linux.dev,
  songjianwei@sinsegye.com.cn,  lixiaoning@sinsegye.com.cn,
  majun@sinsegye.com.cn
Subject: Re: [PATCH v1] x86/dovetail: pipeline the thermal APIC sysvec
In-Reply-To: <f19d66738d42006057609ef352a7d225bca79795.camel@siemens.com>
	(Florian Bezdeka's message of "Wed, 12 Aug 2026 11:13:11 +0200")
References: <20260811120521.1677006-1-liuyang@sinsegye.com.cn>
	<f19d66738d42006057609ef352a7d225bca79795.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 17 Aug 2026 11:47:46 +0200
Message-ID: <87pkzhkri5.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTGq+G3uoF7uDwZjg3FAwu+TjAncxZAeMMbzrYP6FEsiPRwkPnMY88i2/U1oLX11GjncbAmKlAO8UfdQRZC4V/ObT2Xm/qpH/0AUqyhCXnltioVlc8nVa0GcGD3EBoUvcUJXSoNA5ONmWmqEOL0DEFTUzngeYMIlOsjQnDGc4YlSLIaYHkNES+fEnD3rG7buZmiW7E6pARTLot+zKhztBN0WS0p2CGvFbPtaTqo5LDvReJm1M2TPnMADHTfz9Cc5sxV3GQVsr9VRJ7oWoUqdc7873klUAKNi3eaJNkhWDjF+dxzYQv5bTxgl4roW80i0c5yqWoxC1AuJVtHDqdNgl5dukBS00KYkl8zDd7RRBN3yRoelietGo8S5WoTAe8H3WSkfuYD7cybBUTG/MGmQBBzNvJhdP+oWk67XPA60xYmXmnop4A7LpFzpJOCHRp1Dkh37zqzKEJyqC6Ht2TfTl33uS6AqmcgK84fxbV29vX3P6XW+U80gFZYl4Xlg8Vgrs81aXEadqDcE6VGTvcE6VBBQhorZBe27YTztKdzC9VBc5DVeP7l9CP/H2PYPfbafpgeOhnOYrkGxyzHmRVczFp6konnm3TEBxT8ctHnG6bmKcRPW0FdUl3M9pEpZ5VSavFGDYQ2RnXbpROjhXKa8fiUkfP6gMIDFC+xHpNhikeIoYA
X-GND-State: clean
X-GND-Score: -100

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Tue, 2026-08-11 at 20:05 +0800, liuyang wrote:
>> sysvec_thermal was a non-pipelined DEFINE_IDTENTRY_SYSVEC (with a real
>> __apic_eoi()). Under thermal load we still hit stalls while that
>> handler ran against in-band timer paths (therm_throt_process ->
>> add_timer_on).
>> 
>> Handle THERMAL_APIC_VECTOR as a pipelined sysvec and dispatch it from
>> do_sysvec_inband(), so thermal runs on the in-band stage like other
>> pipelined system vectors.
>
> [ To +Philippe as the "Dovetail" prefix is missing in the subject line ]
>
> Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>

Merged, thanks.

-- 
Philippe.
