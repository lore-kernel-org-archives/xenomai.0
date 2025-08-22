Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D92F27FD64
	for <xenomai@lists.linux.dev>; Fri, 22 Aug 2025 07:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755848757; cv=none; b=lahfco3K1gSn9DTnPZryJq/TP54yj/2hnuD60KCEUESRJKhRjRpMSnLF2sT2C3Ol9YiGMKn8y3nNSzVuEIDIkkRPzFruS+59EMPR2I6tlqHtrirm83GhVVsIxFg16UFLLsc7Soh2dm4eyM9CwcwFkEcnLBNXX7lF4JtFvMMFJqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755848757; c=relaxed/simple;
	bh=wsx/K+iMjyHjlL5wL+1Mt5X/rkNfZSIpD9LoGhCPCE4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uwiFtclLZfYHqISnwiIvLImO7+w4/agVjaZHxsEOA5e87IEOUYXret958rhSJ30jOyJfLvSKKhkfqew0PEDBwcI7VHkR5JJvuGwIiIHptrqfyTZijNi14Dy5QBUi+5JlwSn6C8MB4uzvL2IlARpTl938vcpytn3QChQwuAb3vOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=e7WzgyXc; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="e7WzgyXc"
Received: by mail.gandi.net (Postfix) with ESMTPSA id F065F442AD;
	Fri, 22 Aug 2025 07:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1755848747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/ucLuiJd+4mrj8PWvpqqGfcut383PhPs+gGtj4dQyas=;
	b=e7WzgyXcpqUocCY2Ht/tBN/XArOaSVs6YLCBCp778bibEQ8wKZ8e0YihhCz+DKFXkGemq2
	nbCSqgnBGHOZ09GyaFi0KSseJsNVccGBNUeCVy+IdR9FvzUSt9ED1KlZ7UuoavC3fKSpIk
	ZSFXiRwUNcsayLZHh1hyTXqq6EHFPfi0z4KUhs4YNCwnCHQFfBKRNp973XMuhAto3NwLZ5
	KV6DlnKWpcRIQCcVw8QhgcRvGzFGkvtTDxYK6kYXmakLeo7/mj5IQgNUVYDYjYuz4XGUOJ
	cQYbFNB4KrdTonAroC4N+lxpTzIjv0DW4vFYMA/iy/+ZFN9gLRRJo1rB+4ddEw==
From: Philippe Gerum <rpm@xenomai.org>
To: Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr>
Cc: xenomai <xenomai@lists.linux.dev>
Subject: Re: Simple Xenomai 4 API use examples and a question
In-Reply-To: <9330e95ad45a1742cedfdf2335141c3f79b7223d.camel@lapp.in2p3.fr>
	(Emmanuel Pacaud's message of "Fri, 22 Aug 2025 09:13:34 +0200")
References: <9330e95ad45a1742cedfdf2335141c3f79b7223d.camel@lapp.in2p3.fr>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 22 Aug 2025 09:45:46 +0200
Message-ID: <87349jhk9h.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieefudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvvefgueduhedvjeevieetgfdtjeehkefgleejfffftddvtdeifffgledtiefhvdenucffohhmrghinhepghhithhlrggsrdgtohhmpdhgihhthhhusgdrtghomhdpgigvnhhomhgrihdrohhrghenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepvddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepvghmmhgrnhhuvghlrdhprggtrghuugeslhgrphhprdhinhdvphefrdhfrh
X-GND-Sasl: rpm@xenomai.org

Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr> writes:

> [1. text/markdown]
> Hi,
>
> I have started to work on a repository which is intended as a collection of very simple (dumb) examples of Xenomai 4 API use. Each example is an application, sometimes coupled with a kernel module, with the strict minimum around the actual API use. Applications and kernel modules are built using meson. The meson files are also kept the their simplest form. That was easy for the application building, not so for the kernel modules.
>
> The repository is here: <https://gitlab.com/emmanuelpacaud/xenomai-c-examples>
>
> It is similar to what I did for my own project: <https://github.com/AravisProject/aravis-c-examples>. I do think this sort a simple example collection are useful to understand how to use an API.
>
> It is a work on progress, the code should be more commented.
>
> But to be useful, all the examples should work, and I'm blocking on the oob_ioctl example :(
>
> * <https://gitlab.com/emmanuelpacaud/xenomai-c-examples/-/blob/cd9f849d4325b57565edcd691021255adc486b90/oob-ioctl.c>
> * <https://gitlab.com/emmanuelpacaud/xenomai-c-examples/-/blob/cd9f849d4325b57565edcd691021255adc486b90/modules/oob-ioctl.c>
> * <https://gitlab.com/emmanuelpacaud/xenomai-c-examples/-/blob/cd9f849d4325b57565edcd691021255adc486b90/modules/oob-ioctl.h>
>
> The ioctl call fails with a `Bad file descriptor` error. What I'm doing wrong ?
>
> Emmanuel.

EBADF is likely returned because your driver does not register the file
as an oob-capable one, therefore it won't accept oob_ioctl() requests. A
typical way to implement the missing bits would be as follows:

struct foo_state {
	struct evl_file efile;
	...
};

static int foo_open(struct inode *inode, struct file *filp)
{
	struct foo_state *st;
	int ret;

	st = kzalloc(sizeof(*st), GFP_KERNEL);
	if (st == NULL)
		return -ENOMEM;

	ret = evl_open_file(&st->efile, filp);
	if (ret)
		kfree(st);

	filp->private_data = st;

	return ret;
}

static int foo_release(struct inode *inode, struct file *filp)
{
	struct foo_state *st = filp->private_data;

	evl_release_file(&st->efile);
	kfree(st);

	return 0;
}

The way this works is explained in this document:
https://v4.xenomai.org/core/kernel-api/file/

-- 
Philippe.
