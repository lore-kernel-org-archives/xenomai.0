Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F75022CF00
	for <xenomai@lists.linux.dev>; Mon, 13 Jan 2025 11:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736768302; cv=none; b=lrSrv7nNSd1AS46QfjAlpu/dtFzqZ1lskc6CC2WJVsR2leeeoe1uesHxAMWYMC/RWCXe+7rJmz4DNkNCxQEGTZv342xDposozo+TuyhXfwncn9lEAARETW7lLZRe+gvoe7+cfpyekh1+xWscRFh8K/OftoUexNp70wI1wCNkaDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736768302; c=relaxed/simple;
	bh=JGRujTc05aKYv4peGCeguIs1Ud2vk1iSPCNDQaQvL7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hodGNLfZpyyhjDY+Zn4F5rjYhgGqcL3nsbeoaIXvy5bWkMd/YdQ2nJ3LQjhXfbfD0o1dMFRKqbfxwwtCIi3lBi6udgDVmMyv3KItEvU9hvyHgUyVpybjILEi3ZsPE63wnC0YY3m+1Qw4afLwz50q039LE/Hdk60z49H4cEdvCeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EBfb3d8k; arc=none smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EBfb3d8k"
Received: from spool.mail.gandi.net (spool9.mail.gandi.net [217.70.178.218])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id E27D6240002
	for <xenomai@lists.linux.dev>; Mon, 13 Jan 2025 11:38:10 +0000 (UTC)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by spool.mail.gandi.net (Postfix) with ESMTP id BA7BB43AF3;
	Mon, 13 Jan 2025 12:38:09 +0100 (CET)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=163.com header.s=s110527 header.b=EBfb3d8k;
	spf=pass (spool.mail.gandi.net: domain of powertree@163.com designates 117.135.210.5 as permitted sender) smtp.mailfrom=powertree@163.com;
	dmarc=pass (policy=none) header.from=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=XZdqdalSYY5QPzkjpExkH6MnZ6uhO/pWX1xSvDZSTCI=;
	b=EBfb3d8kTU3O0FsLUmNncjhk10zACGKDYkixTm2xIiz/eYYR95w2L2RAfEHPjf
	EXZcvFAKAFVN+DU8TQUU5UgWwATFg0cns8RbqbyvkzQNKJhsBVMgfAtQQhhXSDrR
	Rz14iAL6x245CQEmVNtB4u52TS4jUG829yYF9XNhgvcJM=
Received: from [10.10.80.200] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDnv7EW+4RnQWufFg--.10445S2;
	Mon, 13 Jan 2025 19:37:58 +0800 (CST)
Message-ID: <34c915a8-8d4f-45f9-9f80-8703184e14bc@163.com>
Date: Mon, 13 Jan 2025 19:37:57 +0800
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: calling __get_cpu_fpsimd_context twice in a row when
 kernel_neon_begin running
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@web.de>, "xenomai@xenomai.org"
 <xenomai@xenomai.org>
References: <867aed54-563a-4c06-b750-4a7727e6e4c0@163.com>
 <103fdf7d-d3c8-45a9-b25d-283c9af400eb@siemens.com>
 <77c3e1fd-dab9-4b7c-b4f7-67c38dfc37bc@siemens.com>
 <79e83ee2-7406-43c1-9a71-e79cb2cbd127@163.com>
 <d799980b-fbfc-467b-87b7-5a4fbc6ddf50@web.de> <87ttmwo7by.fsf@xenomai.org>
 <8dbe101.93d4.1944a9bae5f.Coremail.powertree@163.com>
 <25336e91-c3e2-41bd-88c1-90822fea4d46@siemens.com>
 <a42668f5ef9a620cf7caebd59e3fcbcb71989c9b.camel@siemens.com>
Content-Language: en-US
From: powertree <powertree@163.com>
In-Reply-To: <a42668f5ef9a620cf7caebd59e3fcbcb71989c9b.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnv7EW+4RnQWufFg--.10445S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXrWkKr4DWr15trWfuF45Wrg_yoWrWrWxpr
	yUWF40yr4UAF15Z342yw4jvryFq34Utr15Xwn8Wr13Aa4qqFn2qr4IyryY9FyDur18uF1j
	v3yjyF92q3WUtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Us4SrUUUUU=
X-CM-SenderInfo: psrzv2pwuhvqqrwthudrp/1tbiqQrTlWeE18K7ngACs0
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedgfedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfhisehtkeertddtvdejnecuhfhrohhmpehpohifvghrthhrvggvuceophhofigvrhhtrhgvvgesudeifedrtghomheqnecuggftrfgrthhtvghrnhepkeekvefgjeffjeffueetieduudffkeetjedvgeevveffueevheffieekgeefkeefnecuffhomhgrihhnpeguvghngidruggvnecukfhppeduudejrddufeehrddvuddtrdehpddvudelrddugedvrddufeejrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddujedrudefhedrvddutddrhedphhgvlhhopehmudeirdhmrghilhdrudeifedrtghomhdpmhgrihhlfhhrohhmpehpohifvghrthhrvggvseduieefrdgtohhmpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheprhhpmhesgigvnhhomhgrihdrohhrghdprhgtphhtthhopeigvghnohhmrghiseigvghnohhmrghirdhorhhg

I don't have any plans recently to backport this patch to the lower 
versions of the Dovetail kernel.
When I'm free in a few months, I might backport this patch to the lower 
versions and conduct some tests. I will keep everyone informed of the 
results.
Thank you for your advice, Florian Bezdeka and Jan Kiszka


On 1/11/25 00:43, Florian Bezdeka wrote:
> On Fri, 2025-01-10 at 17:21 +0100, Jan Kiszka wrote:
>> On 09.01.25 11:28, linz wrote:
>>> Hi,  all
>>> I think the following patch can resolve the bug,  it allows oob threads to safely preempt kernel_neon_begin() / kernel_neon_end sections.
>>> https://source.denx.de/Xenomai/linux-dovetail/-/commit/9b19700e623f96222c69ecb2adecb1a3e3664cc0
>>>
>>> But this patch has been merged into the Linux kernel version 6.8. At present, I have no plan to upgrade to version 6.8.
>>> I'm not sure if I understand correctly, but if so, is there a plan to backport this patch to a lower version, such as 5.10?
>>>
>> Have you tried to backport it to your kernel already to confirm that it
>> helps?
>>
>> Unfortunately, it looks like a cleanup to upstream, so we may not get it
>> in via normal LTS. But if it help, picking it into dovetail LTS trees is
>> imaginable.
> That patch at least depends on
>
> 13150149 ("arm64: fpsimd: run kernel mode NEON with softirqs disabled")
>
> There is more work to be done to have that properly backported, or
> update to one of the recent LTS versions.
>
> Florian
>
>> Jan
>>
>>> At 2024-01-29 16:42:38, "Philippe Gerum" <rpm@xenomai.org> wrote:
>>>> Jan Kiszka <jan.kiszka@web.de> writes:
>>>>
>>>>> On 25.01.24 04:18, linz wrote:
>>>>>> I think my patch is not suitable after listening to your suggestions.
>>>>>> And I don't have any other good solutions.
>>>>>>
>>>>>> I think x86 is ok because there is no operation of writing global
>>>>>> variables in the critical zone.
>>>>>>
>>>>>> kernel_fpu_begin
>>>>>>      =>kernel_fpu_begin_mask
>>>>>> =>preempt_disable // enter the critical zone
>>>>>>          =>WARN_ON_FPU(!irq_fpu_usable());
>>>>>>          =>WARN_ON_FPU(this_cpu_read(in_kernel_fpu));
>>>>>>          =>flags = hard_cond_local_irq_save(); // leave the critcal zone
>>>>>>
>>>>>>
>>>>>> But in arm64, there is operation of writing global variables in the
>>>>>> critical zone, unfortunernaly.
>>>>>> efi_call_rts
>>>>>>    =>__efi_fpsimd_begin
>>>>>>      =>kernel_neon_begin
>>>>>>        =>get_cpu_fpsimd_context
>>>>>> =>hard_preempt_disable // disable interrupt, enter the critical zone
>>>>>> =>__get_cpu_fpsimd_context //  first call, modify global variable
>>>>>> fpsimd_context_busy
>>>>>> =>hard_cond_local_irq_restore // enable interrupt, leave the critcal zone
>>>>>>
>>>>>> handle_arch_irq_pipelined // Latency timer interrupt triggered
>>>>>> =>handle_irq_pipelined_finish
>>>>>>    =>irq_exit_pipeline
>>>>>>      =>xnsched_run
>>>>>>        =>__xnsched_run
>>>>>>          =>pipeline_schedule
>>>>>>            =>run_oob_call
>>>>>>              =>___xnsched_run
>>>>>>                =>pipeline_switch_to
>>>>>>                  =>dovetail_context_switch
>>>>>>                    =>__switch_to
>>>>>>                      =>fpsimd_thread_switch
>>>>>>                        =>__get_cpu_fpsimd_context // second call
>>>>>>
>>>>>> So, I think there are more todos on arm64. Do you have any other good
>>>>>> suggestions?
>>>>>>
>>>>> Philippe, some input on this issue would be helpful to know what the
>>>>> next step needs to be. It's still unclear to me how fundemental this
>>>>> issue is (false positive warning or real state corruption?).
>>>>>
>>>> This is a current limitation on arm64 which amounts to a bug
>>>> actually. x86 has the proper implementation, which allows oob threads to
>>>> safely preempt kernel_fpu_begin() / kernel_fpu_end sections.  Since
>>>> kernel_neon_begin() re-enables hard irqs before leaving, it is creating
>>>> the opportunity for a mess.
>>>>
>>>> The way to fix this is to implement the x86 logic to arm64 when it comes
>>>> to in-kernel fpu usage.
>>>>
>>>> -- 
>>>> Philippe.
>>
>> --
>> Siemens AG, Foundational Technologies
>> Linux Expert Center

