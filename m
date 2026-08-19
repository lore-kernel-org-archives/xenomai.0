Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D89D48EBE4
	for <xenomai@lists.linux.dev>; Wed, 19 Aug 2026 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787161554; cv=none; b=D0L2H3zu9PIwTB0xgrvJqkdOdbcRomgtsM6aV4WbAdBCgIKpxNBsH9rqI4399EnqgV8klpwuZ30vqmB1xloyhS0gKG9bI6eDOyZVxuKDfkQehOHAGBroFrLIh5aZ2Xyf6RiPgrvu9I7zuWEDUYDqeW2PKkp9Vpu/wGLEI2GyVkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787161554; c=relaxed/simple;
	bh=i6STENIC7OOBTClRYaSEljx/oYCCGImPLuvbwc+G3xc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wwze1KcS0sr/OE86ELEVV+rutriK9go4yZW3EqqS8WOZ2Ga8gdVmUc4SMLrpmQ6XxLZlIcrQUMLb/8gyCPDwHBrpS8jIuzg7eMLvxEYWRCQPuubQDshrhnKG2CY4ZBkmkH+//eACgHwoplWflGs6yN1Hejx9+hnY/D56oPFrXHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=LjYv9VdX; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="LjYv9VdX"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6D0B43F5A3;
	Wed, 19 Aug 2026 17:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1787161539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ox8KghPnb73FfhFzpNjfI9Cgh0aEDXwWo7hZ1pyJjMM=;
	b=LjYv9VdXthp1KFTw5GfFC+aPwjp/FwxF9P6OB+IBHvAkt1rDAOypxklVcanOXl9yfuycRJ
	ZBDTgJ13KGgKhyoORl/kLmi9lroMW9vPFLONk93dIrdUmOrgdxMZUSIb70dtINuW2+sv3S
	S+DqUDl2yicnkYkBtZCzxaK28pXNFOjiN9tFLBb6oai8xpUaVxKRqQNeFcVAedjzgaX5Oe
	5FS2ZJLOzRcKTUJ9gxTBRJBtkqUKZyhD5wrX6IygZkfoZC+OtttE7rVQwQ6+xhRb06jxBt
	HrWumV/99G6fliqemy1ety3FDFu0t68gNR9+Q9tJ99Xm/wHEng198LOznulk3g==
From: Philippe Gerum <rpm@xenomai.org>
To: Brunet Yorick <yorick.brunet@heig-vd.ch>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: revl + timer
In-Reply-To: <ZR1P278MB1040F902CEB569D53789E125D2A52@ZR1P278MB1040.CHEP278.PROD.OUTLOOK.COM>
	(Brunet Yorick's message of "Wed, 19 Aug 2026 16:37:20 +0000")
References: <ZR1P278MB1040F902CEB569D53789E125D2A52@ZR1P278MB1040.CHEP278.PROD.OUTLOOK.COM>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 19 Aug 2026 19:45:37 +0200
Message-ID: <8733waovge.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTFQLP8W2SGXC574CtWJ7oKc8VuESEMzweq9T5oBx1i4F21tMiaR2Ku30XQnZ8x+0VLWh68tkE6ok7gBWCmJUzWjtEouk39sToZ57XYhZMwAkFoPZ4OjW1iJO9dmjD7orxpaEvqotOv/YkK6/HIPUJbWCyIPJKA+UJFiU9HCcIAtEWEljxwE0FzfPLdZiAe9MGShwaRdtWt1/zI+3ag1y3v6B26UEnFvqr1tdg1sYHMdO+0+CixuLgiDfe53kXy87hCo99uQMClUFnx2vO7mIY1qfnHnjiiYVXTntifOTUpDIzQF1FbNt8mv34hYWo4cRzBVilfhIfuUo6QF0X5+wilXCQi+/QfJh9WUshgDAdBJwGu6OymES1vYHrV7T2kf9FOBNo0j+qRmfPIc/14P2J/+/Am0BWsUdRZhODqOdmITd4Lv5O/+SpE89SKcN9dD8c49J8yypt5jAA/kh28wpwFjq4VBLxOQspfaWEPovle7skm0wz/6hqLT4nkjZpSLYrpFnNaqfL8uMATQfQZqnKs0UsDCk5MtngNuESMAoq6xnE3gkaOtcJZQLnBuC0ldW4wqTaEwuPbrQCACxlJHVWMfuBJmyZcnanVw+CmhBX9ub9MPu7wJeSdCh8BpCiu0A0gXiAXlfMJayo3IQkrANMxS71MNqFJ+0MCXzAiJnKST5Q

Brunet Yorick <yorick.brunet@heig-vd.ch> writes:

> Hello,
>
> I originally posted this question in the matrix channel but got no answer. I try with the mailing list.
>

The matrix channel is dead, at least nobody is monitoring it anymore due
to lack of sustained interest from users, and lack of time on my end
too. This is the reason why the matrix URL was dropped from the website
information a year ago or so. I may have to close the channel and lose
the messages posted there. This mailing list is indeed the right place
to inquire about xenomai stuff.

> I have been using `libevl` for some time. I am now testing `revl` as I want to move forward Rust.
>
> As a first step before going on the embedded board, I'm using "qemu virt64".
>
> First, I noticed that https://gitlab.com/Xenomai/xenomai4/revl/-/blob/master/Cargo.toml?ref\_type=heads doesn't refer a valid `evl-sys` as it points to the main branch and not a tag. I had to clone `revl v0.6.2` and change manually Cargo.toml to
>
> ```
> -evl-sys = { version = "0.32", git = "https://gitlab.com/Xenomai/xenomai4/evl-sys" }
> +evl-sys = { tag = "v0.36.1", git = "https://gitlab.com/Xenomai/xenomai4/evl-sys" }
> ```      
> (or v0.32.1)
>

I'm not sure to understand the issue. Cargo should pick v0.32.1 since it
tries to upgrade automatically as long as it finds a newer compatible
version, e.g.:

$ cargo build
   Compiling autocfg v1.1.0
   Compiling proc-macro2 v1.0.89
   Compiling unicode-ident v1.0.1
   Compiling memchr v2.5.0
   Compiling glob v0.3.0
   Compiling cfg-if v1.0.0
   ...
   Compiling evl-sys v0.32.0 (https://gitlab.com/Xenomai/xenomai4/evl-sys#381404f7)

Which is evl-sys v0.32.1, as it should be:

$ git log -1 381404f7
commit 381404f7ab5a38744b6a771f60a4620b865d208d (tag: v0.32.1)
...

This said, I agree that using tags would be clearer and follow the
recommendation from the Cargo docs.

NOTE: in the version/tag information v0.x.y for evl-sys, 'x' refers to
the libevl API number this FFI is compatible with, and 'y' is a patch
level fixing minor issue(s) in this context.

> Then I tried to use the timer with
>
> ```
> let timer = timer::Timer::new(clock::STEADY_CLOCK).expect("[ERROR] timer create failed\n");
> let now = clock::STEADY_CLOCK.now();
> let period = Nanoseconds(1_000_000_000_u64);
> let first_expiry = now + period;
> timer.arm_periodic(first_expiry, period).expect("[ERROR] timer arm failed\n");
> loop {
>     match timer.wait() {
>         [...]
>     }
> }
> ```
>

Which error is this, precisely? e.g. using .unwrap() on the result
instead of expect() would give better details.

> or
>
> ```
> let timeout = clock::STEADY_CLOCK.now() + Seconds(1_u32);
> assert!(clock::STEADY_CLOCK.sleep_until(timeout).is_ok());
> ```
>
> Both cases fail, either on the `timer.wait()` or `sleep_until()`.
>
> My system is composed of:
> - uboot
> - buildroot (I included the libevl r59, revl v0.6.2, and evl-sys v0.36.1 packages but I'm not sure that it was necessary)
> - linux-evl v6.18.29-evl2-rebase
>
> rustc 1.97.1 (8bab26f4f 2026-07-14)
>
> The Cargo.toml of my project is:
> ```
> [package]
> name = "evl-periodic_task-rs"
> version = "0.1.0"
> edition = "2024"
>
> [dependencies]
> revl = { path = "../../../../revl" } <--- points to v0.6.2 with changes presented above
> libc = "0.2.189"
> embedded-time = "0.12.1"
> ```
>
> Do you have any idea on the issue ?

1. revl::init() was not called prior to issuing any of those requests. I
would suspect ErrorKind::Other to be returned by Timer::arm_timer().

2. Thread::attach was not called prior to attempting to sleep in oob
mode on the steady clock. In such an event, receiving
ErrorKind::PermissionDenied would make sense.

> How can I retrieve more logs from EVL?
>

There isn't, this is a system call (low-level) interface, so no cosy
application-level message logging in such layer.

-- 
Philippe.
