Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA9120C463
	for <xenomai@lists.linux.dev>; Fri, 31 Oct 2025 18:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761934161; cv=none; b=Awt5L85RWaeMF66DZeq37fcQ+CTtOsKXqdbP4Wa5lNmaZwkj9hpgD7F5NG4kFTMQR2MhSENdoQWiwrpUgLXahlnjn9bXL/s5p7hSji/N7qlKwukbeh710Zqr59c2mvldwYs0iFf2krMhG2pB2Nl3ZRMoC2pW5G8X+U/JJP5MMgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761934161; c=relaxed/simple;
	bh=epm65ZMP6ykh/2seY1/vEgG6dW5MoqKN9ZzEoZcQEac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OnFkGUXIohQNzp88cKaZf2M3mia2oAKj8cvCaPA2i6y2owD7R+S/t9Kj9fAdQV61seRvksgaUhWiSJHgDxaU26QOF6cT8EDgUbnjGSlC/Ek0OXKJ+0NPXWhNNFTmvRzAvGL0a7K0ELL5R/My3MnVLeJvjCjRf1UEoVkfzjxLkCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=jJhvILlf; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="jJhvILlf"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 55C9E4433E;
	Fri, 31 Oct 2025 18:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1761934150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKdByZHBR1k6vzZ6I1TKfDvEETuaqhhsyqc9sbApL6k=;
	b=jJhvILlfBKg3+fy0rpPqnhjt9vEeRS26W7X0hxgFLznFabeSKbGgaoX/1eRb+j6NGmjZLG
	NNkFyW4X0XnsFb/cXa3DTvKBmb49wHPdYzoD9Jb8iVyva7qm1ZogsmAaR5Iu35O3SyrRTM
	tlAHOZnZmE4/Vrr7OCLB4X9ODBYaKH08kVwipj45VKYUPVJ/Yi4Ck+xVECFS/ef6iT9Wwf
	vIvdoEkVEu3Lv+hbvbUVnJ30MaICOrBVMfq63s9ZJRX3ib+n0FIC0foqpG3N451fOtvPOT
	eART4gHo4uwQgnPYE4khRMwsg9IACU0S9hvaY9DZZN2sr7mhCGBvdXyDRX1dLQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: =?utf-8?Q?=C5=81ukasz?= Majewski <lukma@nabladev.com>,  Giulio Moro
 <giulio@bela.io>,
  Xenomai <xenomai@lists.linux.dev>
Subject: Re: Unexpected switches to in-band
In-Reply-To: <5c69758f-876b-4a56-99b7-09eb22537680@siemens.com> (Jan Kiszka's
	message of "Fri, 31 Oct 2025 18:34:51 +0100")
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
	<20251009151737.0d03b211@wsk>
	<20676160-4572-d92d-4b33-ff4255946345@bela.io>
	<87qzv9sa9c.fsf@xenomai.org> <87ikgls9kh.fsf@xenomai.org>
	<f916d01d-2bd0-cdfd-2e9e-562968a9934f@bela.io>
	<20251020094705.2ac256f2@wsk>
	<9d2bacac-8d70-f083-e926-21beee2207c2@bela.io>
	<87o6q1ad07.fsf@xenomai.org> <20251023155439.0170f987@wsk>
	<87a51djuor.fsf@xenomai.org> <20251027120535.7933c720@wsk>
	<20251027172505.29eecfb2@wsk> <875xbyawx7.fsf@xenomai.org>
	<20251029145125.71debaab@wsk> <20251030132602.2d1ccfcc@wsk>
	<87qzukuzy5.fsf@xenomai.org> <20251031165615.2c9f72f5@wsk>
	<87bjlnc9u5.fsf@xenomai.org>
	<5c69758f-876b-4a56-99b7-09eb22537680@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 31 Oct 2025 19:09:08 +0100
Message-ID: <875xbvc5a3.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedtudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepudejieegtdfffeevjeekieegheduieeuueelhfelfffgtdetvdfhledujeeguedvnecuffhomhgrihhnpehsfihuphgurghtvgdrohhrghenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepgedprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepghhiuhhlihhosegsvghlrgdrihhopdhrtghpthhtoheplhhukhhmrgesnhgrsghlrgguvghvrdgtohhmpdhrtghpthhtohepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgto
 hhm
X-GND-Sasl: rpm@xenomai.org

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 31.10.25 17:30, Philippe Gerum wrote:
>> =C5=81ukasz Majewski <lukma@nabladev.com> writes:
>>=20
>>> Hi Philippe,
>>>
>>>> Hi =C5=81ukasz,
>>>>
>>>> =C5=81ukasz Majewski <lukma@nabladev.com> writes:
>>>>
>>>>>>> Could you get me a trace which goes back up to two secs before
>>>>>>> the time reported by evl about the inband switch of the timer
>>>>>>> responder? e.g.=20=20
>>>>>
>>>>> Why is it 2 seconds? Is it related to latmus "refresh time"? (which
>>>>> is 1s)
>>>>>=20=20
>>>>
>>>> Picking this delay is purely heuristical. Such a long backlog is
>>>> likely going to include the smoking gun, if any.
>>>>
>>>>>>>
>>>>>>> [   75.214527] EVL: timer-responder:743 switching in-band
>>>>>>> [pid=3D745, excpt=3D14, user_pc=3D0x77d08492a5fe]
>>>>>>>
>>>>>>> In the above case, I would need a trace going back to 73.214527
>>>>>>> or so.=20=20=20
>>>>>>
>>>>>> Apparently the ftrace buffer was too small. I will adjust it to
>>>>>> store more data and share results.=20=20
>>>>>
>>>>> It is also interesting, that:
>>>>>
>>>>> bash-5.2# echo 16384 > /sys/kernel/debug/tracing/buffer_size_kb
>>>>> bash-5.2# cat /sys/kernel/debug/tracing/buffer_size_kb
>>>>> 16387
>>>>> bash-5.2# evl trace -eirq -f
>>>>> tracing enabled
>>>>> bash-5.2# cat /sys/kernel/debug/tracing/buffer_size_kb
>>>>> 131
>>>>>
>>>>> Reduces the buffer size...
>>>>>=20=20
>>>>
>>>> Yeah, the evl-trace script is not that smart. I can see the issue
>>>> causing this, will fix.
>>>>
>>>>> Hence, I've used the "normal" ftrace with enabled evl functions -
>>>>> the=20=20
>>>>
>>>> FWIW, EVL relies on the normal ftrace. However, evl-trace fiddles with
>>>> the sysfs entries manually, and may be a bit naive at times. As Jan
>>>> pointed out long ago, relying on the trace-cmd front-end would be a
>>>> better approach than tweaking ftrace's sysfs-based controls manually
>>>> at the very least. evl-trace adds EVL semantics to the tracing
>>>> configuration which is handy, but the way it is done today may
>>>> deserve a revamping, or maybe drop it entirely in favor of trace-cmd
>>>> if we have enough flexibility there in order to introduce some EVL
>>>> specifics.
>>>>
>>>>> detailed information about the ftrace config is with log files:
>>>>> https://nextcloud.swupdate.org/index.php/s/czBd3Ydq9B9noZ7
>>>>>
>>>>>
>>>>> To extract the cpu2 specific data:
>>>>> bash-5.2# grep -rnE '\[002\]' Xenomai4-ISW-trace-6.6-logs.txt >
>>>>> cpu2.txt
>>>>>
>>>>> Here again the ISW happens in the cpu2 execution "hole":
>>>>> [  128.466459] EVL: timer-responder:736 switching in-band [pid=3D738,
>>>>> excpt=3D14, user_pc=3D0x7588e71985fe]
>>>>>
>>>>> Happens for cpu2 between:
>>>>>
>>>>> 11832546:          <idle>-0     [002] *..2.   128.466438:
>>>>> 	sched_idle_set_state <-cpuidle_enter_state
>>>>> 11832547:          <idle>-0     [002] *..2.   128.466468:
>>>>> 	handle_irq_pipelined_prepare <-arch_pipeline_entry
>>>>>
>>>>> However, now the log is large enough to inspect what has happened in
>>>>> the system for ~4s before.
>>>>>
>>>>>
>>>>> With the logs:
>>>>> timer-responder-738     [002] *.~2.   128.466214: evl_timer_shot:
>>>>> [proxy-timer/2] at 128.466467 (delay: 253 us, 66918 cycles)
>>>>>
>>>>> and after ISW:
>>>>>
>>>>> <idle>-0       [002] *.~1.   128.466469: evl_timer_shot:
>>>>> latmus_pulse_handler at 128.467208 (delay: 739 us, 195206 cycles)
>>>>>
>>>>> Why there is such increase in "delay" (253 vs 739 us) ?=20
>>>>>
>>>>> It looks like we have only 2us delay as the timer has fired on
>>>>> 128.466469 vs. expected 128.466467.
>>>>>=20=20
>>>>
>>>> Ok, so the issue is still the same: for some reason, the
>>>> timer-responder thread is taking a (minor) fault when accessing some
>>>> memory, on its way back from the ioctl(EVL_LATIOC_PULSE) syscall, or
>>>> right after. This seems to be valid memory though, just not
>>>> immediately accessible, otherwise we'd have received SEGV, which we
>>>> did not.
>>>
>>> Yes, I also think so - like some "deferred allocation" despite of
>>> mlockall.
>>>
>>> Please find the logs with the below patch applied:
>>> https://nextcloud.swupdate.org/index.php/s/JXNW5bJrB3fQo5E
>>>
>>=20
>> Thanks. I need to analyze the fault flags next week to see if I can make
>> something of these, but I just stumbled on an obviously significant fact
>> when looking at the multi-CPU view: the memory compaction daemon is
>> running asynchronously on other cores while the responder is taking the
>> fault. Compaction is all about moving memory around to free larger
>> physical regions, so updating PTEs will happen as a result.
>>=20
>> Moreover, I could not reproduce the issue at hand, but I did not have
>> CONFIG_COMPACTION enabled. In the meantime, could you try disabling this
>> on your end, to see if the fault still appears?
>
> CONFIG_COMPACTION selects CONFIG_MIGRATION, and that is well-known to be
> incompatible with RT. Xenomai 3 is warning about that that, EVL does not?
>

Dovetail should do that when CONFIG_DOVETAIL is set, this is by
definition common to any rt core.

--=20
Philippe.
