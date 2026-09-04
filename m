Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D133A49251A
	for <xenomai@lists.linux.dev>; Fri,  4 Sep 2026 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788526806; cv=none; b=KdiEVosgsvbyjbxt1DKQIdPPrSOeOb0OYsbBzSDrF13L+dl30Ea/bMR4zkyNGjgeshQXR3ZeZjVt0+spP2Z/+PfdekM1w+RBet2bju6Zi6MCBCi4BQMMgw5anOYtuuaVVdnHDD/AIsBfEw//isr0GoeLWrU/QYYrrXYGPSYodwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788526806; c=relaxed/simple;
	bh=PU9ilqKjKJTBfJp4fnmr6zixGedQvH3fHSJMFDqZ+Qw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qpMXrzzulHcvkHkBAwQLMBGcFsP2zG/CxsNzNIAPm77tD/vHQe1C5ZnRppFJMor5VMh6Q9pzTxSO+ehyXFp4VULsa3tJY6h9ikIVxRHeDOgy3+0czCnBpwqmedXZ1NGqpOQwQVqPCLk3WDHeQ5xfGrcLCLqZ6rjgT2ytMw5+R2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=hXo7JNhs; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="hXo7JNhs"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 867C53EC8C;
	Fri,  4 Sep 2026 13:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1788526802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U9KCxnZ5R1Ng75cWI/pYTK/P81FLeBfkoySi/DN9OYs=;
	b=hXo7JNhs8rh4yvIUkHN+WAAIoTQS5/RkhvVXsO57iXsjk2ffjps1VY+VygNO9lJvN5lWUN
	V2DAdRx+zcQV5C6FBHf/Q0+R0S68dUsIRcc8QXRs6GkT0du/Y+aZkYweIMnxApNlTBuFRS
	Y6FGVUrz8WbQ8img2YxVb1ro1AfDr9XRF1W+UJHY84OZttjtsU4Zu3rdhtmzTNH/Yg19qi
	RHMnCKQyJWutW5Fa5nX98Se37WWq0CW38Zc1ls5axrQtWkKL4lOwsx9AbbP7l+CiSvRlhI
	uDm2yoR1qZezOUtSaJBV0kr5EHY8hUBvQKZrS073eCriKYthUoeCmVKyaUMZ9Q==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: Dovetail + EVL: RISC-V + 7.2
In-Reply-To: <776fa79b-bd7b-4309-95c1-bb659793d63d@siemens.com> (Tobias
	Schaffner's message of "Fri, 4 Sep 2026 14:46:03 +0200")
References: <878q5he1ei.fsf@xenomai.org>
	<776fa79b-bd7b-4309-95c1-bb659793d63d@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 04 Sep 2026 15:00:02 +0200
Message-ID: <8733vpdve5.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTEk1Xzk7kd06I3tI28fKVA4sb/TdVrDzh8akf1qAG42u6uu0EzJpOeOx2NzhP2WV7EnAfBXyj0v+EJJJ7OaIl/D3COLRzmGra+HYvtqUhDNNL2BQeFlF14iTJbxmRtfi/0HdBi10TDBM5u2t3jBb2Z/JQ50VTOetOo9vVZbpDNwmftutmT9iTVdXsLcziLB0pwj0rg5Jd04TsD4D/7G2zGw3IN5GqQcEd98PccSyrYn7CMuocgch1IlmqfLyUX6d9jkSBw7Y3oKCBpbd7HTcUsv/I3raIE5HlBaKY3v/le0Nnr1y6xuBrl3nBchEltK/gpng0+cL1vOJ81BUs2zSXGsFirTyoMWszO3koc7WPqwD4PIAFnCA5H5sMzkPETX9co2X3nhkEKzl4wSyqfC9cOcmj24ErMP4fPn0WjpQyJi6uv1DCZbpwSwqqr4Qxud8LA/lHqLNbAv1Wpo9GQZH4DkELcG9wTXZU2xtnopi95dpmbu+hp35dg8rHY7NUSk3agKi307FnKTB6TYcMyzNd8sjud3K9u9TRLM8iwC1DD8xckdsjUd+RV4tJpTesSBc4RI2PmFd53NIE9MF1Hxo4InoB4UkAJUIpRj6jH6+L3FLiEpG9AcYB9Nw32ZnuHvdoPf3pyu+qgerFQHfK185tNk5ZPdJk2Y2g0lwGBPMftN1Q
X-GND-State: clean
X-GND-Score: -100

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> On 9/4/26 12:50, Philippe Gerum wrote:
>> The (slightly overdue) Dovetail and xenomai4 (aka EVL core)
>> implementation targeting the 7.2 kernel is now available from our
>> development trees [1][2]. Starting from this release, we support the
>> RISC-V architecture, thanks to Tobias's work.
>
> Thanks Philippe!
>
>> Building applications for 7.2 requires libevl r61.
>> [1]
>> https://gitlab.com/Xenomai/linux-dovetail/-/tree/v7.2-dovetail-rebase?ref_type=heads
>> [2]
>> https://gitlab.com/Xenomai/xenomai4/linux-evl/-/tree/v7.2-evl-rebase?ref_type=heads
>> 
>
> Will there again be a evl/next/v7.2-evl-rebase branch or is there no
> next branch needed anymore from this release on?
>

linux-evl/next/v7.2-evl-rebase is now open. next/ branches are here to
stay, matching libevl -next.

-- 
Philippe.
