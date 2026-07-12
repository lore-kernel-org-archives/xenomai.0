Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7776367F2F
	for <xenomai@lists.linux.dev>; Sun, 12 Jul 2026 20:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783887476; cv=none; b=RHxd798RnuyamYnQJhCKI7jT6wvXusQ6sGtujwbpbwDvAL1HKbsWfpqaEJphGzLcyGuKyk0o3FqSuU/0XSzIPV5nQVE12j61IrOam+lhKAA8YZRKUoI1+rlK+/1HEuX9CgeypAPjJxC4UhJSEWTfvnnfcFE3jCyeqRXGXcPjQe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783887476; c=relaxed/simple;
	bh=IDuCvhSJRM7oj8W3M9WvQOQRHR/vjGllpsqZJZ99o/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cns5K3ceUdfymZ4cgP5VnkPDErw8si67RrVqAy3Xbm52AuoTdCSyHGcqeZE3xNuRrTHzLFUIQxhVPnZD1ySJrzlZkJXx1oaJZLkTcj5qcksd96Teg4iiDpxVwQrxx2l3PpZeaPGJtff3fBDuHliC7CyV0QdNhFR5fHiaJeCfOyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZDuTGEt; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZDuTGEt"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47f36a122fdso567207f8f.2
        for <xenomai@lists.linux.dev>; Sun, 12 Jul 2026 13:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783887473; x=1784492273; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yjvQqDJq0jNtGyDKMzQdBephKx7yhbUCHJBfLTnp//Q=;
        b=gZDuTGEtzat5+CcygauAM1jMN1YDeSJdQslByomWAKL8ExWmjUTXNplCLUWC/JZT8e
         FUq55EVxewU6ar0rOi5rcn8AknbK1aHVNgIvbyf5Bo4bXzLxOFHNU/gJa1X2nb78RMvT
         +zylgBxvZrmj7lVUXDRCvNmnjq0J/GEoyqmuv2rX6XTtONMKDyDiZ0b9pR8JDBJx9LYX
         v8RZojh5G7oZjdSj6LnXtN1usGrmhl8+YswaQLtvbsR4+TTHkfewWNUyAQVemayWmgJs
         vaX8x+TcGBpcUAB6KrypGx8j23li3nmuGsNzMaG+e4/Ju5N79Bub+wyvL2obBtbLvhnh
         +W4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783887473; x=1784492273;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yjvQqDJq0jNtGyDKMzQdBephKx7yhbUCHJBfLTnp//Q=;
        b=Q8hrVOzFQP2sEYoJIY5spLMr+cWMcBSbPfrazhcF7xv5KGnMMfuaFPsu+Ce2xtUaS9
         Y1u23D9oFUdrwgDCBJqnbMer2iPCcInaVyeZMxYFVGXo0tA7wI4QZWIBE1YaTaLGqOIq
         OiUTrST3KlKnMUvsnkNHM8T/iR0HbumpMkrxwo0nqghOhv3SvQ8LP30XrEv1BlZZ+aC1
         G8kZxmK5HoK9ARzC0l/DJs2Ov+ZP5DU4WansLitPQCtIDwePc3tIRVz4z2TPn1U0x4fn
         qXuAPhJJstpFbQ2a7cTIkT/ytrAHrYIsWYJG6L09HDCpZACXWTQ/sL6ndhiTHVSmh9GI
         v0yA==
X-Gm-Message-State: AOJu0YzrBJKPN3joOAsFDOpLm1prX7h0jpXerRjavxSDLFVdeNAG7sa5
	vymR8AZIxA84Mp3BUG9YkuYx01lpw2ohM4vcVRroEEi4zNBXxpSN2u1r
X-Gm-Gg: AfdE7cmCGNyqZZ1RkHYLvSWldZ0T1+fU9Zb1XNTZhGsrEPB6yp2J8T5F4TBrVDnnuAb
	GhW2POeRmoE0TL8uD8clQD2D1em99K34IMOchlPENLZsF1RzwV2sNIVKq8h9ZOJIhaOCotMp5Df
	ABWEK8IUpyAJkap4XymAcY+IZ30L0CRnUDW3YInmQpSNCQgSDaiLg25T5kcnQ7VWPDMtJDDFjq0
	Bun9Q+UaTmeihMRbKUWiahijrUiEoUzTTGSiUJrfAnZPq1dgM0U469yVzkXhj4quWDjmJZoxwx4
	48/TqS5EVPytlpbrDKbdPu2mFS7nqsqs313UAVUq+F1VhDMY3dSUxMNzve0LPr1E6T/dTXzuzxZ
	+7LyOXlnwtM29p5FckW8FZacCh4yGiYWb/YmwwIhczwcPb1t/oVH3AiTEFvBO3kMEDCQbyJ9POc
	TmFFbUIoESSUwTBlUGS5iOv30iSH0vYdY1jc+O+PxeAA==
X-Received: by 2002:a05:6000:290f:b0:479:e2ea:3d51 with SMTP id ffacd0b85a97d-47f2dce228amr7505096f8f.17.1783887472843;
        Sun, 12 Jul 2026 13:17:52 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d843csm78469685f8f.14.2026.07.12.13.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 13:17:52 -0700 (PDT)
Message-ID: <8311d15c-e582-4351-8d92-a143a69a8359@gmail.com>
Date: Sun, 12 Jul 2026 22:17:51 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: EVL: hectic test fails when to many CPUs are available
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <2a2e5b00-ef70-4de5-865b-c8d00c87104b@gmail.com>
 <87h5max6sb.fsf@xenomai.org>
Content-Language: de-CH, en-US
From: Hannes Diethelm <hannes.diethelm@gmail.com>
In-Reply-To: <87h5max6sb.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 07.07.26 um 15:34 schrieb Philippe Gerum:
> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
> 
>> Hello
>>
>> This is the reason for the patch for evl-test. I guess a beginners mistake / edge case but
>> if you want to look into it:
>>
>> If I don't set evl.oobcpus in my VM or just use to many OOB CPUs, the hectic test crashes and
>> never exits. I have to use kill -9 to stop it.
>>
>> evl_attach(): Resource temporarily unavailable: This is probably not handled correctly.
>>
>> evl.oobcpus=0-15 -> Freeze
>> evl.oobcpus=1-15 -> Freeze
>> evl.oobcpus=2-15 -> Ok
>>
>> /usr/libexec/evl/tests/hectic -T 5
>>
>> rtus_ufps11-10 rtuo11-11 rtuo11-12 rtuo_ufpp11-13 rtuo_ufpp11-14
>> rtuo_ufps11-15 rtuo_ufps11-16 rtuo_ufpp_ufps11-17 rtuo_ufpp_ufps11-18
>> fpu_stress_ufps11-19 switcher_ufps12-0 rtk12-1 rtk12-2 rtup12-3
>> revl_attach(): Resource temporarily unavailable
>>
> 
> Mm, ok. This one is indeed an old and obscure issue which has never been
> cared of. Increasing CONFIG_EVL_COREMEM_SIZE and CONFIG_EVL_NR_THREADS
> in order to account for the massive amount of threads involved in large
> CPU configurations should fix it.
> 
> At any rate, the test should unwind and exit cleanly when that fails,
> so there is still this issue to solve at some point.
> 

The supplied patch should fix the issue with the forever running hectic
test. It looks like the main thread waited forever for the task_init semaphore.

Probably not a fully clean way of doing it but it exits now with a many error messages
in case there is not enough memory instead of running forever.
