Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E376169AD2
	for <xenomai@lists.linux.dev>; Tue,  7 Jul 2026 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432604; cv=none; b=NoDjvuEXd22ow1mwGtG+nMfgjTXXcI6p2uQ2jPyJYvBzO4xCSDCYQ8uPDd3S17Hpu8dom9nJwYqDRAGoVpH2VT0MBhjwcIfri1Cfej9s2pxW1n3PGXcm2eCUpwARnQqz9aTiDzJCWDO5meKyydRX2zUUY7u3Q5sMPhpgZ0FOArM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432604; c=relaxed/simple;
	bh=sI0ESUqjDK9oj2dKvqCuDYJlQ+Eld56E0AR1ocPC2W0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YuRXyaT0WBa/uDhlwbu3cFE2WVSkwmkPG0hiX7KWp6iO58zfyE6nkA6HDcWtiQiurFkEA5rSBNhWyvpZXPToBQOoq/43S1mPq3KWkVDFz9a7xEhTirgH8zUwIbyrFB0Lj7FqFwiQ1m9PJKfMRkwik2KAXhIDF4bf97GoTrwPLHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=SOP/Wwf4; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="SOP/Wwf4"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 69B413EC91;
	Tue,  7 Jul 2026 13:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783432592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0snP9/QNKT8dg3ynEvAIViBS2K4EjSYsNXD/VN8H9Q4=;
	b=SOP/Wwf41Q0sOLTOWde2Jkv6UQoKKwEXGCFhdGQkJpQk5JsKcB+271gppGeQhGyD5ckDFx
	fjPubDCoDqcjfCvBDJmBlj/1wH424x40bKVphP4dzyqnAW6Nfl7OoZdb2pfh+rrHhgOxtx
	S/FSMiZj12QrnF9bubWW9JrdsgDa9+7cigZko5YI7vj85pQGUg6+CsTeM1S6Z+g4jUGx8W
	aPWuh73NwtX/IJMKfY74zii8vtj6aXDJn0Y/tLdUK52yNMLG+zSS48wngYgQuB2hCFEk7L
	3eVxjSAjnGZFXoAjCzHc58Q6dBfXadbIBlUOTTSbrthoATBW/VWcnJF/Nqx+/Q==
From: Philippe Gerum <rpm@xenomai.org>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "Schaffner, Tobias" <tobias.schaffner@siemens.com>,
  "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>,  "Kiszka, Jan"
 <jan.kiszka@siemens.com>
Subject: Re: [PATCH dovetail v10 00/11] riscv: Add dovetail support
In-Reply-To: <8bbe1df3070e3d031950851525c67386b03cd1e9.camel@siemens.com>
	(Florian Bezdeka's message of "Tue, 7 Jul 2026 10:51:05 +0000")
References: <20260706182927.281078-1-tobias.schaffner@siemens.com>
	<aea1bc068740212737bd02d3b6317dac1eb8fbc8.camel@siemens.com>
	<8bbe1df3070e3d031950851525c67386b03cd1e9.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 07 Jul 2026 15:56:31 +0200
Message-ID: <87tsqavr74.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTFCwdW/wo3hQR8cJe3sfva/TtGYuWr/zGDxBnkGGVNUQ58+jTOMdCKyANuFeSncbMmMm+OcAl65zloLepVMZN+bwGKDAnFtmQxeRd7SNyRC1D8w3iHJkVwZ99+wFN2HM/WYu9+E4yqRO2gzdF49TVvTQTMWnSZPvGFZziqxDarAQhPW14MXYyQvxMMyNHkVJj78t28UDXzH26HnwGINPZytKM47Jl94/WxMjQqIfk44x+kwTUfORcocGdIkeuqgu2ingGfW56dhCo+lXD23SIKNtJU4xXORa267zf8W4YW4AqGHxTifeZmPcYw0xnPBzOjza0MCcu6Jo5VKbLAuxOMVoMpvg/014doW8JquG3REqaD5weOOvBtLUV7Xv2Fj4W8v5bV9DcwJapBSnA1+RlqAt6o/y+NM35UKb+Jf/n2bhntmGCKfyx1Vd7NTkrbO0A3wLYxRYjjzv63zk6EzYERsoZC4Ld/DbMkUG5DAOfdZiuyQ+xSLpxSouIJWu9957QNL57iCH630oX51nyN4FTSgCV31YFy3h3NEbdhINFzrnq2YzkJAv2otTGSYaOy3C2luEZj0+7aAsmcS6gGD2Tx1v+wHxU2SKPARl2QQxxuAdAP2SUc4UN9iCmmuiRuicHbEfq/PfHzl0OTNQixCC4/AUEcVvfJ8+LVnrurQ0ufnIw

"Bezdeka, Florian" <florian.bezdeka@siemens.com> writes:

> On Tue, 2026-07-07 at 12:02 +0200, Florian Bezdeka wrote:
>> On Mon, 2026-07-06 at 20:29 +0200, Tobias Schaffner wrote:
>> > Hi all,
>> > 
>> > this series introduces initial support for Dovetail on RISC-V.
>> > 
>> > Feedback, suggestions, and especially reviews are very welcome.
>> > 
>> > Changes since v1:
>> >  * Disable independent irq/softirq stack usage when pipelining
>> >  * Drop KVM changes as long as they can not be properly tested
>> > 
>> > Changes since v2:
>> >  * Rework trap handling
>> > 
>> > Changes since v3:
>> >  * Included the IRQ pipelining patches to have all riscv specific
>> >    patches included
>> >  * Rebased to dovetail/v6.18.y-dovetail-rebase
>> >  * Merged most of the fixes
>> >  * Fixed IRQ Stack handling and enabled IRQ_STACKS again
>> > 
>> > Changes since v4:
>> >  * Rebased to dovetail/v7.0.y-dovetail-rebase
>> >  * Applied suggestions from the last patch set
>> >  * Added starfive-visionfive2 board support
>> >  * Introduced raw console device based on sbi debug console
>> >  * Reworked pipelined irq handling
>> > 
>> > Changes since v5:
>> >  * Rebased to tip of dovetail/v7.0.y-dovetail-rebase
>> >  * Applied suggestions from the last patch set
>> >  * Use mark_trap_entry/exit_raw for kernel mode exception paths which
>> >    use irq_nmi_entry/exit for now, as the nmi irq handlers expect hard
>> >    irqs to stay off. This may be be subject to further optimization at
>> >    a later stage, but I do not see any negative impact latency wise in
>> >    my tests.
>> > 
>> > Changes since v6:
>> > Address the review comments from the last patch set:
>> >  * Keep the virtual irq state in sync with the hard irq state in trap
>> >    handlers
>> >  * Fix irq_nesting imbalance when running with disabled IRQ_STACKS
>> > 
>> > Changes since v7:
>> >  * Simplify Trap handling
>> >  * Rebase to wip/flo/v7.1-dovetail-rebase
>> > 
>> > Changes since v8:
>> >  * Further simplify trap handling adressing Florians suggestions and
>> >    recent fixes to irq-entry-common
>> > 
>> > Changes since v9:
>> >  * Fix checkpatch finding in patch 11 "riscv: Add dovetail support"
>> > 
>> 
>> Thanks, applied to the following branches:
>> 
>> dovetail: wip/flo/v7.1-dovetail-rebase
>> evl:      wip/flo/v7.1-evl-rebase
>> 
>> Philippe, final test run has been scheduled, expecting both branches to
>> be taken over by you. Any left overs?
>
> Yep. I forgot two commits 64afd165 and 0679eb1e from the 7.0 branch.
>
> I will fix that in a minute.
>

Ok, please strip the reference to "cobalt" in the CLOCK_EVT_FEAT* commit
when reconciling the evl trees, this might be confusing.

-- 
Philippe.
