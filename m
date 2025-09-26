Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDB528AB0B
	for <xenomai@lists.linux.dev>; Fri, 26 Sep 2025 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758876864; cv=none; b=dOv/4VJus0Yu9TjLSspgKUdluKMfWF9maoBFwYhbzxYU5Vk8xqxpSKVxchutTsTL9bhYVrh9QCfT3Z73losTWW0gpv/u7XTbJUn4TI527osAxdHTa/+Z2h2S53h6R8+J9J7Q5+MkjkaVPIy72ZdGI2i2aiz1kajDE/UUApB6UpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758876864; c=relaxed/simple;
	bh=2Klne/zkx3TzRWLdj4iDM9cx52lcTdB6Mw4XdnnHKgU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e91aeFWupVmaT7KUcqmg22Vj2WeUKuo6GcRG8xk56k3ilGCwAv3WvEOXTf6dwd2ZBFPYO1jEl/K5WqisUDr/9yCsuNzCxxAbCL3EqL99Pw2hPKFIyImCkS0ZnpCN9WGcXcwClFwJx6MxEVBnbEqBZUBp/AlSSrWohG+y0YA2bw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=RsoRe5nC; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="RsoRe5nC"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id F3D3B580B50
	for <xenomai@lists.linux.dev>; Fri, 26 Sep 2025 08:47:12 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6E6CC431F3;
	Fri, 26 Sep 2025 08:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1758876425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1+lCXnjSqVCIHtOmRApZPqx9839+hn/TN4uEG8VqE9I=;
	b=RsoRe5nCF/Aw4L5y9RvMc/2wC7TEhARMDezOn1JUbndAuHkdE3bE7sGIRYN51qNaBN8WQe
	qhOqUk5esFeNXm+EFwvG6t17NZz7/0WVs/db4YWEr4ybBIM5Z6cd4dxBecB7j9owTk3JFj
	xC7w5+gMkEYe50JvMLkbolKez4eDPL3c+teY9Wf4GYKNrcHjKr2mD6wKmHRlDtB9P5fSMN
	/2UN+HvZYLQkZVL7N2qIvxWIpzoHUXB++NR582cuC/7EKs20c++IGXp4HvfCYg87WmH2Te
	vfL+QUEiWzfMU/vEJQy+ujJzZaJuFyv2FecDOInFeftdZ1JXzDuMOALeHwC8iw==
From: Philippe Gerum <rpm@xenomai.org>
To: Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: Running main() in the Xenomai domain
In-Reply-To: <CAFc1U0vEL8-2vhaZpw5wHFjxCSMPCniQWL5AL7R_w+kQC=5PMA@mail.gmail.com>
	(Pierre FICHEUX's message of "Thu, 25 Sep 2025 19:25:19 +0200")
References: <CAFc1U0vEL8-2vhaZpw5wHFjxCSMPCniQWL5AL7R_w+kQC=5PMA@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 26 Sep 2025 10:47:04 +0200
Message-ID: <87o6qxha7r.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeikeelfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepveeuieegueetgeelveehieefveevueefveevhfejvdetiefhvefgjeehieefteehnecuffhomhgrihhnpeigvghnohhmrghirdhorhhgnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehpihgvrhhrvgdrfhhitghhvghugiesshhmihhlvgdrfhhr
X-GND-Sasl: rpm@xenomai.org

Pierre FICHEUX <pierre.ficheux@smile.fr> writes:

> Hi,
>
> Maybe it's a silly question but I think I did it some years ago but I
> don't remember how to do it.
>
> Is that possible in Xenomai 3 ?
>
> Thx
>
> Regards

Yes, see [1].

[1] https://doc.xenomai.org/v3/html/xeno3prm/group__cobalt__api__sched.html#ga14f50e1f5d815c90f1f4225eca5d3a8c

-- 
Philippe.
