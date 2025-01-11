Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD2B153803
	for <xenomai@lists.linux.dev>; Sat, 11 Jan 2025 18:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736618883; cv=none; b=pv7wA5X0pz79rBoc9YBjhJVqmK3w3hhPh9DUMdhGmuuSV59YMbRWVMS7kf84HDEZDvTR3WzPqSGPicsZnp+mhLoo3w7p6+0iJHoJjsqCbNxfBDZLCsMmMYdSgmakzaKMgEbVlnPZCLISQl1dQscuyXUKehf6ysD9Dl+I8l4z2ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736618883; c=relaxed/simple;
	bh=pbN2MOD8ZzfgYzrRc2qHIelalRLPIdw11nAJIln1TMA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K6GDSXEwfXW3DBRiR1IIL0ZhSCalY24jG4RJTixxbqBHdE+uWMaHzfAFT6VGGcqZT19h5RWMgvmc0BwvAqiHyRrzZNZFce2VVinoZWBa+aKQ9T2DrjHPighm6n/eXgVp3J/ai5lEu7Yfj23EQG4fOBv9JIfo9c11PJGCIGRmJHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=pRopvSwP; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="pRopvSwP"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 318C11C0002;
	Sat, 11 Jan 2025 18:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1736618877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x+pZH31gKQqyqC9+bA9T/CqcFK5rCMv5eFjWPr5Oypo=;
	b=pRopvSwPpSuvOseJq3W5VsfL3wm/eL1kOKG6mzPS2tTEUluQfIwoP+ldHPxJTmTWCWttsW
	r+DAw5PyL9wNegHS7VFZsz1i8RbMTCBhmFVyNywu4jWRc2WN2BAFxlroCmeP9JhXIu+LZC
	3IZ1GXmaU+Vmk1CcCg8KAPluDppWStDaqnXGbr6SWCJY06ydjQ9M9ximhOt4J0AigFNyjZ
	o/Xccb/ZQCmAXufA7pP8DRe88aqFLF+TX9tvkJeWwTMzNEIZm2r0U7aw6C6oDoh1VyS9QD
	2Nu64ysj+97inI/WBvg0+xlhiBLHS0w0LxAiFfh3TKfv42ImRwgLtwM5KuyAqg==
From: Philippe Gerum <rpm@xenomai.org>
To: "Rosenow, James" <jim.rosenow@mts.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: Relax tracing not working for me (solved)
In-Reply-To: <MN2PR04MB6255FE69E8FA3E63FA62549EE2132@MN2PR04MB6255.namprd04.prod.outlook.com>
	(James Rosenow's message of "Thu, 9 Jan 2025 19:48:28 +0000")
References: <MN2PR04MB6255403DD160D9EDA3319AA5E2112@MN2PR04MB6255.namprd04.prod.outlook.com>
	<87r05dve9r.fsf@xenomai.org>
	<MN2PR04MB6255FE69E8FA3E63FA62549EE2132@MN2PR04MB6255.namprd04.prod.outlook.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Sat, 11 Jan 2025 19:07:51 +0100
Message-ID: <8734hp4420.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org

"Rosenow, James" <jim.rosenow@mts.com> writes:

> Thank you, Philippe.
>
> This helped; I have located the call source of the MSW and now I am in need some guidance on how to go about fixing it.
>
> The offending calls look like this:
>
> Userspace call:
>
>   int dma_move( struct ioctl_dma_req *dr_p)
>   {
>     return( ioctl( fd, IOCTL_DMA_MOVE, dr_p));
>   }
>
> Kernel driver call:
>
> int 
> ioctl_dma( struct dma_device *dev,
> 	   unsigned int cmd,
> 	   unsigned long arg)
> {
>   int retval;
>
>   retval = 0;
>   switch ( cmd)
>   {
>     case IOCTL_DMA_MOVE:
>     {
>       struct ioctl_dma_req dma_req;
>
>       if( copy_from_user(&dma_req, (void *)arg, sizeof(dma_req)))
>       {
>         return( -EFAULT);
>       }
>       retval = dma_move( dev, &dma_req);
>       if( retval < 0)
>       {
>         return( retval);
>       }
>       if( copy_to_user( (void *)arg, &dma_req, sizeof( dma_req)))
>       {
>         return -EFAULT;
>       }
>       break;
>     }
>
> So my questions are these:
> 1) Is the MSW occurring due to the ioctl() call from userspace?

Yes.

> 2) Or is the MSW occurring in the kernel module?
>

There can be no _implicit_ MSW from kernel space, because that one may
only happen on crossing the user->kernel boundary when handling a system
call, depending on the syscall type. This means that calling in-band
code from oob context past this crossing is always unchecked, unsafe,
and the fastest path to train wreck.

> And finally,
> 3) In this scenario, which must be somewhat common for real-time systems, i.e., a device driver is needed to facilitate some sort of real-time hardware operation, how does one 'port' this properly into Xenomai such that it does incur MSW?
>

The answer mostly depends on the device, so let's focus on DMA
ops:

a) the DMA hardware is known from - and managed by - the regular
   'dmaengine' framework available from the kernel. IOW, this peripheral
   may be providing data transfer services to some (inband) driver
   already. In this case, one would have to provide oob support to the
   corresponding DMA back-end driver which deals with the nitty-gritty
   details of the DMA hardware. This kind of support code is currently
   provided by Dovetail [1] for the bcm2835-dma and imx-sdma [2]
   back-ends. So, in order to share a DMA device between inband and oob
   activities seamlessly for (kernel-based) users (like dma_move() in
   your driver), one has to implement the oob extension briefly
   described in the doc I mentioned. There is no other sane option for
   addressing this case. Actually, there is no other working option,
   period. Also, I'm assuming a Dovetail-based setup, which provides the
   required infrastructure for implementing such extension. Legacy
   I-pipe is not an option in this case either.

b) the DMA engine is hosted on some custom hardware of your own, which
   is not available to common kernel users. IOW, only your driver would
   know about it. This is the simplest case: you would implement the DMA
   transfer ops using oob-compatible constructs (e.g. hard spinlocks for
   serialization), according to your DMA interface specs, easy
   peasy. That would even be compatible with concurrent inband use with
   proper serialization. In that case, some driver of yours would
   provide the DMA management code for that particular DMA engine, and
   dma_move() would call that code (or implement such code, for that
   matter).

c) the two options above assume that you have real-time requirements for
   DMA ops, since you mentioned 'real-time hardware operations'. If the
   use case is actually more relaxed, i.e. you need to kick the DMA
   transfer from some oob thread, but you could live with some unbounded
   delay until the transfer completes, then there is the option for any
   oob code to offload the DMA transfer to a routine which would run
   inband "asap". That routine would use the regular dmaengine calls to
   manage the transfer, no need for oob extension of the DMA back-end
   involved then.

[1] https://v4.xenomai.org/core/drivers/dma/
[2]
https://source.denx.de/Xenomai/linux-dovetail/-/blob/v6.1.y-cip-dovetail/drivers/dma/imx-sdma.c?ref_type=heads
(see CONFIG_IMX_SDMA_OOB)

-- 
Philippe.
