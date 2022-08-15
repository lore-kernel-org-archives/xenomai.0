Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4833D7E
	for <xenomai@lists.linux.dev>; Mon, 15 Aug 2022 10:28:56 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id D3D3CC567C
	for <xenomai@lists.linux.dev>; Mon, 15 Aug 2022 10:27:17 +0000 (UTC)
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 2632340004
	for <xenomai@lists.linux.dev>; Mon, 15 Aug 2022 10:27:10 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 1F23BAC0CE8
	for <xenomai@xenomai.org>; Mon, 15 Aug 2022 10:27:09 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 583D01C0002;
	Mon, 15 Aug 2022 10:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1660559229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZDBEBGmx4kFOOudhbbYUw/HakF+mi/lNdDC2xEgRiA=;
	b=IfsZMDtiviYFhporP+M9eV8ms1+JCMPbJosy4bWO3yglcSCpaQkQHVe/1H8FMgt7udi8aH
	pFDfXt+grot4j9vanlXnoQY+Tfq3437UQ+ZwgpbaTmuK87MyBRhex+4PbusWCNQ/i4p/Hs
	MHaAGk3dUMnMMOzWvhsZhYHU6TTGf6Z9yee1sP155fxuHBPu1rvt2XcE0B5hRqV08YlmAH
	UL2m4zSrOwDINhA4ZN02Io1hnD83pzHWvYI9a0f/bN7j2jSI0CYHubFZL+pKxJy+tc86Mq
	qpEsh7v5SfVsxY12j+z51wh3bBOVEGgtB9bFg+Ux1xQRetvuuJ0GhT8M2/9+mw==
References: <CAGjgvr9G4JpZ+krfnX9xWwbTiT6JbtG_2jUWiFJyqVtvFk=MKg@mail.gmail.com>
 <646b8cce-c73e-4976-3787-b3b337679915@siemens.com>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Yucong Chen <slaoub@gmail.com>, xenomai@xenomai.org
Subject: Re: Linux-xenomai hangs at "Starting kernel ..." on Jetson TX1
Date: Mon, 15 Aug 2022 12:24:12 +0200
In-reply-to: <646b8cce-c73e-4976-3787-b3b337679915@siemens.com>
Message-ID: <87zgg5iyys.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass (spool3: domain of xenomai.org designates 217.70.183.197 as permitted sender) client-ip=217.70.183.197; envelope-from=rpm@xenomai.org; helo=relay5-d.mail.gandi.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.s=gm1 header.b=IfsZMDti;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of rpm@xenomai.org designates 217.70.183.197 as permitted sender) smtp.mailfrom=rpm@xenomai.org


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 11.08.22 11:03, Yucong Chen wrote:
>> Hi all,
>> I'm very sorry to bother you, I'm currently working on xenomai
>> evaluation, mainly to observe the real-time performance of xenomai on
>> different hardware platforms. Recently, I encountered some problems
>> when porting Xenomai to Nvidia Jetson TX1. We tried for a while and
>> couldn't locate the problem, so please help me analyze the root cause
>> of the following problems. The specific problem is described as
>> follows:
>>        1. Kernel version: 5.15-dovetail,
>> https://source.denx.de/Xenomai/linux-dovetail
>>        2. Compile the kernel method:
>> https://elinux.org/Jetson/TX1_Upstream_Kernel
>>        3. The kernel of 5.15-dovetail can be successfully started, but
>> xenomai is not enabled, and the dtb file in the 5.15-dovetail
>> directory is used to replace the official dtb (Corresponding kernel
>> version is 4.4) file provided by Nvidia
>>        4. Recompile the 5.15 kernel, but enable xenomai and use the
>> dtb file in the 5.15-dovetail directory
>>        5. The 5.15-xenomai kernel compiled in step 4 cannot be
>> started, and stays in the "Starting kernel ..." stage
>> (linux-5.15-xenomai+upstream dtb combination cannot be started)
>>        6. On the basis of step 5, we used the official dtb file
>> provided by nvidia. The kernel can be started, but it will be stuck in
>> other places (linux-5.15-xenomai+nvidia dtb). In any case, the kernel
>> can be loaded and executed. The reason why the system does not start
>> normally is the mismatch between the linux kernel and the dtb file.
>> 
>
> It's likely more complex than that. If the kernel/dtb tuple starts with
> Xenomai off but not with Xenomai on, you have something IRQ or timer
> related not working as expected. The reason might be that some irqchip
> or timer needed on that platform has not yet been enabled for use with
> Dovetail. Philippe, was the Jetson platform enabled/tested already?
>

Some people have expressed interest in enabling Xenomai for this
platform years ago, but nobody contributed any code. I never worked on
this hardware either.

-- 
Philippe.
