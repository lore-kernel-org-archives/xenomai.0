Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC0C17C69
	for <xenomai@lists.linux.dev>; Fri,  2 Feb 2024 07:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706858753; cv=none; b=YCZsccDk0RSTreDFPf8lY7i45p0MVhC0PGy5E/UCzX5uWUBxxYq/zfNHAfPhMaDa9YJHXMOBOD3JOsF8/hpJN5itIajNtc95T55vM/8LXKS8Y2zVsqg0UKt83WheZ2+8JlRe/VmaReRlSGsGmiearxo3JWvbu50qBP3MIJtEhSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706858753; c=relaxed/simple;
	bh=CO37xQK7N0N8iqNGlrYCD0ysOCaF3cPyMsBMCNOHwkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KhjHaVHs8cYx/pj+mdhlAOKil8dZdKJr31MCX23Lz9lnpRfSErMTZvL/XdNlVsbWJjO+oN4TGbia4YXgVQ36BBRpqhWDeQHvPX3+0G5VOToRi2aJqMNA9YtdCBmLU2Ud4nIc6T1e1FxrzpI23Dr+AZkvV6VMJ7SSIemXOYkOfPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Gb+P1iJA; arc=none smtp.client-ip=217.70.178.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Gb+P1iJA"
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id E75F180004;
	Fri,  2 Feb 2024 07:25:41 +0000 (UTC)
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by spool.mail.gandi.net (Postfix) with ESMTP id EE60C7803D9;
	Fri,  2 Feb 2024 07:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=iJrp+0GxhD7YeZA8ePoj6y7DcgHmMF5oRgxSHmEptKM=;
	b=Gb+P1iJAalJUBzdifNi4Tmk9x23pj30o4DpssIxRS6MgIwGQBeNO6FMGyNH3SP
	n/soUQA/1yOa4dVKaKtOCs5h35btMJwAT0vNgIrDko69NVq4MPKBlFA1yz7/YrpK
	+6+7PZANv1TPkA1lXYBxIdGpnBKM2uNciFvbyZwlx80Wc=
Received: from [10.10.80.177] (unknown [219.142.137.151])
	by gzga-smtp-mta-g0-4 (Coremail) with SMTP id _____wAHrSfpmLxlbY8wCA--.28656S2;
	Fri, 02 Feb 2024 15:25:29 +0800 (CST)
Message-ID: <ff580dec-096d-45cb-b906-527446c4fa87@163.com>
Date: Fri, 2 Feb 2024 15:25:29 +0800
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: calling __get_cpu_fpsimd_context twice in a row when
 kernel_neon_begin running
To: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@web.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>
References: <867aed54-563a-4c06-b750-4a7727e6e4c0@163.com>
 <103fdf7d-d3c8-45a9-b25d-283c9af400eb@siemens.com>
 <77c3e1fd-dab9-4b7c-b4f7-67c38dfc37bc@siemens.com>
 <79e83ee2-7406-43c1-9a71-e79cb2cbd127@163.com>
 <d799980b-fbfc-467b-87b7-5a4fbc6ddf50@web.de> <87ttmwo7by.fsf@xenomai.org>
Content-Language: en-US
From: linz <powertree@163.com>
In-Reply-To: <87ttmwo7by.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHrSfpmLxlbY8wCA--.28656S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww18Gw1xCr4xJFyfur4fGrg_yoW8Kr1kpF
	y3WF10yr4DA3WYvasF9F4Ivr1Fq34Utr13W3s8Wr1fCayqqF9Fqr42krya9F9xur18Z3W7
	Z3yqyFZaq3Z5ta7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uj1v3UUUUU=
X-CM-SenderInfo: psrzv2pwuhvqqrwthudrp/xtbB0g54lWWXv2DX6gAAsh
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=163.com header.s=s110527 header.b=Gb+P1iJA;
	dmarc=pass (policy=none) header.from=163.com;
	spf=pass (spool.mail.gandi.net: domain of powertree@163.com designates 45.254.50.220 as permitted sender) smtp.mailfrom=powertree@163.com

I understand, thank you. Do you have a plan to solve this problem?

在 2024/1/29 16:42, Philippe Gerum 写道:
> Jan Kiszka <jan.kiszka@web.de> writes:
>
>> On 25.01.24 04:18, linz wrote:
>>> I think my patch is not suitable after listening to your suggestions.
>>> And I don't have any other good solutions.
>>>
>>> I think x86 is ok because there is no operation of writing global
>>> variables in the critical zone.
>>>
>>> kernel_fpu_begin
>>>      =>kernel_fpu_begin_mask
>>> =>preempt_disable // enter the critical zone
>>>          =>WARN_ON_FPU(!irq_fpu_usable());
>>>          =>WARN_ON_FPU(this_cpu_read(in_kernel_fpu));
>>>          =>flags = hard_cond_local_irq_save(); // leave the critcal zone
>>>
>>>
>>> But in arm64, there is operation of writing global variables in the
>>> critical zone, unfortunernaly.
>>> efi_call_rts
>>>    =>__efi_fpsimd_begin
>>>      =>kernel_neon_begin
>>>        =>get_cpu_fpsimd_context
>>> =>hard_preempt_disable // disable interrupt, enter the critical zone
>>> =>__get_cpu_fpsimd_context //  first call, modify global variable
>>> fpsimd_context_busy
>>> =>hard_cond_local_irq_restore // enable interrupt, leave the critcal zone
>>>
>>> handle_arch_irq_pipelined // Latency timer interrupt triggered
>>> =>handle_irq_pipelined_finish
>>>    =>irq_exit_pipeline
>>>      =>xnsched_run
>>>        =>__xnsched_run
>>>          =>pipeline_schedule
>>>            =>run_oob_call
>>>              =>___xnsched_run
>>>                =>pipeline_switch_to
>>>                  =>dovetail_context_switch
>>>                    =>__switch_to
>>>                      =>fpsimd_thread_switch
>>>                        =>__get_cpu_fpsimd_context // second call
>>>
>>> So, I think there are more todos on arm64. Do you have any other good
>>> suggestions?
>>>
>> Philippe, some input on this issue would be helpful to know what the
>> next step needs to be. It's still unclear to me how fundemental this
>> issue is (false positive warning or real state corruption?).
>>
> This is a current limitation on arm64 which amounts to a bug
> actually. x86 has the proper implementation, which allows oob threads to
> safely preempt kernel_fpu_begin() / kernel_fpu_end sections.  Since
> kernel_neon_begin() re-enables hard irqs before leaving, it is creating
> the opportunity for a mess.
>
> The way to fix this is to implement the x86 logic to arm64 when it comes
> to in-kernel fpu usage.
>

