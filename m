Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D479D2E4241
	for <xenomai@lists.linux.dev>; Fri, 22 Aug 2025 07:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755848058; cv=none; b=VdVKaFSxN/TuCB0OarYCENckPG6NWlLkAah/VS1rA5s6P15q5FXV7QXJG6y+dUjyS9p4W1Cncr93PTBeHUS7T+Fu5ttL4dGH/VOW9GphTHKbGL+jSllaT/gat4xenYr3e7MDE99Ypy9gf0EnY2pLc76b44049b9fGttuFZsZ8O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755848058; c=relaxed/simple;
	bh=X2lJ5YiFGS9PQysEYU9MU7lvtIw59fiDn253VG3QYYg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TDJNoda8QaC4d1lRCWT6xRKuX/Tm968j4XnKjgr+EFMPXtR9rEr3NdvFqnYdSNTXeNLL9GXcn3dTGdJY+84MG0m7yDOVJtv+EHMzw+UiX9XO4qkQievMGiTNYXNQx/g9T43+tsGkKgs94W61zULioKAZvidf0DedQRnJQXZ75Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=oNnqmOWN; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="oNnqmOWN"
Received: by mail.gandi.net (Postfix) with ESMTPSA id CA47843992;
	Fri, 22 Aug 2025 07:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1755848048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pgYUEsfBTqS7hmWvFQTPVwgURNl/cl8qTqrj8Kq4xJg=;
	b=oNnqmOWNIQSBGA8tRVnv00KMUocIqHvnvhOMf9ZpVYMRSO4GHQD49qmsaeuStjkIhed3VF
	WG6+XM/+QxfPVEvHLVQ/ceyC+1X46kAjtR/Rr/1zd31g/y06uAQNxdcnKx+jaMMb4v0qYY
	8S6CVHcyT6X9g1EY7aM6kttcYXD2VaMOd/vY8YR39HWqhfUeoKkT5CHOJyB8VxiBRPAI7Q
	iUiUe0X/5BLqXWupUwYketvPZWHmb+vwgFSXr236feeQny9OUrqg2wVfBQ0XZfIGJqcicV
	GKrrPbm9iekuKLgHo/zwXreaGmRFZ8Nkx1MhfZ0shGEEe8Vyxcw+XA7Urpg+dA==
From: Philippe Gerum <rpm@xenomai.org>
To: Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr>
Cc: xenomai <xenomai@lists.linux.dev>
Subject: Re: Simple Xenomai 4 API use examples and a question
In-Reply-To: <9330e95ad45a1742cedfdf2335141c3f79b7223d.camel@lapp.in2p3.fr>
	(Emmanuel Pacaud's message of "Fri, 22 Aug 2025 09:13:34 +0200")
References: <9330e95ad45a1742cedfdf2335141c3f79b7223d.camel@lapp.in2p3.fr>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 22 Aug 2025 09:34:07 +0200
Message-ID: <87jz2vhksw.fsf@xenomai.org>
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

Looks like a typo in the public path to the thread:

- fd = open ("/dev/oob_ioctl", O_RDWR);
+ fd = open ("/dev/evl/thread/oob_ioctl", O_RDWR);

-- 
Philippe.
