Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F47DA57
	for <xenomai@lists.linux.dev>; Mon, 20 Jun 2022 14:17:30 +0000 (UTC)
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id CE0C0CDDD8
	for <xenomai@lists.linux.dev>; Mon, 20 Jun 2022 14:10:44 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 2DBA6200008;
	Mon, 20 Jun 2022 14:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1655734237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y3hcGKRIXal49xPKOHBTejF/O5Je5Wc5h8XF1+Z6g7M=;
	b=PtQ7or2y23hS5uG2gx20/Ms1eIrlIUVJQzCJz3805PdSWp9VyxTrp+WglMAxX4Y5A2Vl9/
	Yr2ukDq8icLGUKoFCDwtDXVCWr3OOi6ri9t8cFsm2WHS/fJI18v55PAWANbIPHPR2L8+XQ
	Bh3hxXxkgplbHGeNqEpt2WiFP0p7Bkwpg2fgWuKXTLwR9EZYYhwNN/WXkez9NN8h1KC5M2
	wr5tcQ8Cdse5JV8TwN14H/+jGuSiwb1UE6NpTFdRMont8QrbC9pQwObbdmQipZL4NVTsKl
	j43FnV3R21aX4MsXQn7HXLZrx2CKKOvojm7xA/o0RN9DFCY1uvwHKdVV3aan0A==
References: <20220523140444.2632658-1-guntgrau@bbl.ma.philips.com>
 <59e12ca2-6c6f-09ff-5365-985586dc4e4e@siemens.com>
 <87fsk6pddt.fsf@xenomai.org>
 <06fc6d18-891c-e0b0-51a7-4b21f49e2add@siemens.com>
 <87bkuupad5.fsf@xenomai.org>
 <b6d70f96-0e67-241b-fb4f-4d822933d05e@siemens.com>
 <e876977a-4f17-d075-b9e7-1a096ea29949@siemens.com>
 <cd3fcfaa-0432-feaa-b69e-f3983f200529@siemens.com>
 <AM7P122MB02294E1A0DF3037F0F3C929DF2B09@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
 <AM7P122MB0229933887662FDFFF9A43C0F2B09@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
 <3dc03baf-12fb-60f3-0284-6631db21acad@siemens.com>
User-agent: mu4e 1.6.6; emacs 27.2
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Grau, Gunter" <gunter.grau@philips.com>, "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>
Subject: Re: [PATCH] rtdm/drvlib: Prevent pagefaults on arm on io mapping
Date: Mon, 20 Jun 2022 15:58:27 +0200
In-reply-to: <3dc03baf-12fb-60f3-0284-6631db21acad@siemens.com>
Message-ID: <87tu8fifxf.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 20.06.22 12:44, Grau, Gunter wrote:
>> Hi,
>> 
>> I added a dump_stack() in cobalt_assert_nrt() where the XCPU signal is generated.
>> Maybe you can give me advice if you need better information.
>> 
>> [   13.690407] CPU: 1 PID: 581 Comm: UT1  Tainted: G           O      5.4.191-00703-gbfba1d43d087-dirty #23
>> [   13.699901] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
>> [   13.714083] I-pipe domain: Linux
>> [   13.717347] [<8010f314>] (unwind_backtrace) from [<8010b824>] (show_stack+0x10/0x14)
>> [   13.725118] [<8010b824>] (show_stack) from [<8084604c>] (dump_stack+0xd8/0xf4)
>> [   13.732365] [<8084604c>] (dump_stack) from [<801d8318>] (ipipe_trap_hook+0x1b0/0x33c)
>> [   13.748287] [<801d8318>] (ipipe_trap_hook) from [<801be9d0>] (__ipipe_notify_trap+0x98/0xdc)
>> [   13.748304] [<801be9d0>] (__ipipe_notify_trap) from [<80114114>] (do_page_fault+0x20/0x444)
>> [   13.748317] [<80114114>] (do_page_fault) from [<80114800>] (do_DataAbort+0x3c/0xe0)
>> [   13.782231] [<80114800>] (do_DataAbort) from [<80101f7c>] (__dabt_usr+0x3c/0x40)
>> [   13.789655] Exception stack(0xc2129fb0 to 0xc2129ff8)
>> [   13.794735] 9fa0:                                     6c1d7000 00000600 72c61910 0000013c
>> [   13.802954] 9fc0: 72bff024 72c618e8 004247c8 76ba5000 ffffffff 00000000 004247c8 6a87da3c
>> [   13.811155] 9fe0: 6c1d9000 6a87da20 00020000 72bb5c68 20010010 ffffffff
>
> OK, a regular page fault that the out-of-band code in I-pipe was not
> able to fix up. The question is whether we lack some logic there to do
> that or if that fixup really requires Linux.
>
> Can you trace which resolution Linux applies to this after switching to
> non-RT? Or do you already have a suspicion, Philippe?
>
> Can this be reproduced in qemu-arm as well? With some dummy device and
> driver? Would allow to examine it also with Dovetail.
>
> Jan

The I-pipe is wrong at:
https://source.denx.de/Xenomai/ipipe-arm/-/blob/ipipe/master/arch/arm/mm/fault.c#L564

Reporting a trap entry to the real-time core should be postponed until
__do_kernel_fault() can attempt to fixup the exception, in which case
we would remain on the oob stage as expected:
https://source.denx.de/Xenomai/ipipe-arm/-/blob/ipipe/master/arch/arm/mm/fault.c#L265
https://source.denx.de/Xenomai/ipipe-arm/-/blob/ipipe/master/arch/arm/mm/fault.c#L200

Dovetail has it right:
https://source.denx.de/Xenomai/linux-dovetail/-/blob/v5.19-dovetail-rebase/arch/arm/mm/fault.c#L557
https://source.denx.de/Xenomai/linux-dovetail/-/blob/v5.19-dovetail-rebase/arch/arm/mm/fault.c#L279
https://source.denx.de/Xenomai/linux-dovetail/-/blob/v5.19-dovetail-rebase/arch/arm/mm/fault.c#L205

-- 
Philippe.
