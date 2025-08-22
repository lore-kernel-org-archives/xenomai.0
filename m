Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E87285C8D
	for <xenomai@lists.linux.dev>; Fri, 22 Aug 2025 07:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755848122; cv=none; b=M8jY0svokyIEOtC4CdCabGXG2nG2PdU+vds9PU+UFd4W2ijNc6QKi2KLtQelQ15MQnehyq2lfLw+MjiHdoov3tQsDW48o3w/ov64EukP67k0G3x3VPCbD2SVKzv2Y+AUDM40VSrwQzk8jGXSi+p4sdkPqJKn/ytfOMuIi7G0BPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755848122; c=relaxed/simple;
	bh=3vtHTUvIWYW6PSLPR2JirD1JCw7OnPn/ve1zkbudCzE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FIxJ2W8Q3syrcG1tVMU4TSs9NQy7OtoTzew3/vB0AHSOI2FVBIuNcspHm+Rm1gPyZVQHWOMS6W2GAZ4gnJsjvq1NWagOn6NUGoqEIeCFEQAwgk1QNifWvX0TuraSWpK+MxY1M5XSj9nW6udNzPDrd1InkNsxxYwnj0H8uYdTxs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=MisK66Cu; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="MisK66Cu"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5915E4438F;
	Fri, 22 Aug 2025 07:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1755848118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ZYnfb83oIkpDpmHezNrPAShYp1IMTruGgYhTM6z0ms=;
	b=MisK66CupY2nOJkOdhDFD73dq0C1apxwtsP/E7qVm2kotMWjf+HFk1UZsAnXRKe7dYLhcz
	+bTn81cwNrtzNxmoE1OECfLiwvxBgjuQGecjWo3JUlkTqQP6lRyjAoKg/AmBA4MpfRLOY8
	uHWap4pe97f9zc6+KJwfbWhndgUGhscTAErKCSk3NISs4NSYlMmEydoA2/eoLqUHwWnsSe
	d4iU7c+qlP9vYp0hpKjPcBB7lzM80068OFXYc2lF8WVZQw79zAO38FkjuZ7E7ZQCt9Fdm9
	jbdu7jpC1e99VilJZ5QZWSTu/h6rv71xual+h9W3AjGm860iNy+aCnmaJR5g5g==
From: Philippe Gerum <rpm@xenomai.org>
To: Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr>
Cc: xenomai <xenomai@lists.linux.dev>
Subject: Re: Simple Xenomai 4 API use examples and a question
In-Reply-To: <87jz2vhksw.fsf@xenomai.org> (Philippe Gerum's message of "Fri,
	22 Aug 2025 09:34:07 +0200")
References: <9330e95ad45a1742cedfdf2335141c3f79b7223d.camel@lapp.in2p3.fr>
	<87jz2vhksw.fsf@xenomai.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 22 Aug 2025 09:35:17 +0200
Message-ID: <87ect3hkqy.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieefudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpeevuddtteekjeelgeejieeikeegteelteegvedvhfeuvdektdehhedtuedvhfegheenucffohhmrghinhepghhithhlrggsrdgtohhmpdhgihhthhhusgdrtghomhenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepvddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepvghmmhgrnhhuvghlrdhprggtrghuugeslhgrphhprdhinhdvphefrdhfrh
X-GND-Sasl: rpm@xenomai.org

Philippe Gerum <rpm@xenomai.org> writes:

> Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr> writes:
>
>> [1. text/markdown]
>> Hi,
>>
>> I have started to work on a repository which is intended as a
>> collection of very simple (dumb) examples of Xenomai 4 API use. Each
>> example is an application, sometimes coupled with a kernel module,
>> with the strict minimum around the actual API use. Applications and
>> kernel modules are built using meson. The meson files are also kept
>> the their simplest form. That was easy for the application building,
>> not so for the kernel modules.
>>
>> The repository is here: <https://gitlab.com/emmanuelpacaud/xenomai-c-examples>
>>
>> It is similar to what I did for my own project: <https://github.com/AravisProject/aravis-c-examples>. I do think this sort a simple example collection are useful to understand how to use an API.
>>
>> It is a work on progress, the code should be more commented.
>>
>> But to be useful, all the examples should work, and I'm blocking on the oob_ioctl example :(
>>
>> * <https://gitlab.com/emmanuelpacaud/xenomai-c-examples/-/blob/cd9f849d4325b57565edcd691021255adc486b90/oob-ioctl.c>
>> * <https://gitlab.com/emmanuelpacaud/xenomai-c-examples/-/blob/cd9f849d4325b57565edcd691021255adc486b90/modules/oob-ioctl.c>
>> * <https://gitlab.com/emmanuelpacaud/xenomai-c-examples/-/blob/cd9f849d4325b57565edcd691021255adc486b90/modules/oob-ioctl.h>
>>
>> The ioctl call fails with a `Bad file descriptor` error. What I'm doing wrong ?
>>
>
> Looks like a typo in the public path to the thread:
>
> - fd = open ("/dev/oob_ioctl", O_RDWR);
> + fd = open ("/dev/evl/thread/oob_ioctl", O_RDWR);

Sorry, stike that. I missed the point. You want to open the driver, not
the thread element.

-- 
Philippe.
