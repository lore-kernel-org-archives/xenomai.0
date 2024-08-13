Received: from sonic312-25.consmr.mail.ir2.yahoo.com (sonic312-25.consmr.mail.ir2.yahoo.com [77.238.178.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D4E19B3ED
	for <xenomai@lists.linux.dev>; Tue, 13 Aug 2024 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.178.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723558619; cv=none; b=PHYo9Z2/lzZRSXptqmnpyiZh/mPnFrKRH/+LkqAVOjiWP+9q1L/4E+Lwic/+Qv6hNZ7xsWzGcyhW8Ne0CMi1GYjqqqYELvdqvIF2htuNSebi9JcBUdzxtZ3WXI2Ro6Lp6IGDEJFT9wYlKwdyLim9KEqST+Fw/TGW/6Wo3jxFpz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723558619; c=relaxed/simple;
	bh=KKH688j5XNwoYD4yV/OpfQFWe4K+kxBQKRszlRPk0YU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=nml4WoU6KvRMy6hJyZ6NhMKZEBTsCZd9bjLDcS9IvVVY+Mlv5oXmvTw5/MChbz8L0qktvRJkCqlsYYwDRcOEkxBUOTOGmQRtBvs1MmZpcIkjE7g7PHNIOx5cPbI+TmoTDzzxtey56LaLEhLjKmWhc2GTMoFnXNccEbsg/OJYLt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Cs2iQ6qa; arc=none smtp.client-ip=77.238.178.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Cs2iQ6qa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723558609; bh=nNy4o9zvMAQSTwKtVs8z5agi1h00AKoMhr3FuiQFUnY=; h=Date:Subject:To:References:From:Cc:In-Reply-To:From:Subject:Reply-To; b=Cs2iQ6qak3hlExL8j6/+Sc2l3UJPKa0z462CJmsZ5tc6knHGUa1Y4tF8GKV6/Ug0JWijaca4BmSr1fbm0BFx9NQuPI06VjmtdqG8Bfw5WzBkqJMFPKqtQJCp4Uh+WhZwknmb4EGzHKlyTl6ekuUHXsXrR6IgK/rlsPfjQYe2hQ+Ayx6hzz9nF0hlacziB7ttZvh5dOp6PX7peqXTneVHCw/j1O5oFsjeGmjJmFZmojpP6uCxkNHycGzoyB6fP8PAcRdo6LMT+M17ZtLDxQDsfoaWdJGzu+ZrilxcS/OM+6NaT6aMY58syJygWvMaG90biZiXXPJfPkPvzGWgP7ZVwg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723558609; bh=11rFr1TxuKNEnk/m9vJPX6TTD2WQzB+3PyZJ4OmYpmj=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=BmjLX2WclloXD6wsEJxPC977JtugG3TPDoCbxbEXic0cAwNSbn2QZdAAFgI7z+6xeYkILR8TPAIVFfmsvnZfUE7wQmKBnfZWaNJ03MOXV6Sxg3cXePy6sszXp6n1JoOZQcqcabtIRvwyTGGAlPZdnO5wn2OkIJGgQsCg3FKibskeZIuXJZVaZuf/thz+n0YEa4MCxhHiTLGY0NzygEYB9ZE2zmjBsQTswa/rNleC2Ngykb7jb35i99UQelD7dqWpRt8znJRJmQJrVCX2Dcjb3/5X2WZflWRX7Xc341uL+ev7xuRaItrm8EMJvY4Vypcg8zEZixwJX4YTA69bjDvMHw==
X-YMail-OSG: g3szRwsVM1lySuOQmy73si_8LEIH0sRJn8eko_6nUUwX38buE.R5uF41CsV3vDL
 2FIPGz_MzCLMS74BVP_CaH8TD6Zlnfu0IVtXfAb.vYRX0hxj7jY3FDCRyKPs2IkVMlWfMKUdLkt4
 NoGvC52mZhFELqzJo4lwDnbqdOS_cAerdi.MS8C1ABcrygw80VbFjbP1PCdm4cTUrjfBGEVGCf7V
 c.4YeajfvNpT1wE7zbR5EzJi5Q8QYIcijWxI4yTXNb9vXyQxszAQLq63f7LmVT0ayHGVFF84ikJV
 XGQWF2vEosTxZhmlRNN4I1zcJFqZRX2YjxLfT67n_zDYAdY_9JmBlHNjfd4VtspGK2qSKF5T8owt
 Kr3rXYgvgoGBkRNoemBNwI16nGPTnIqSevzW1ybhAFWRae3DswICV5FaSSrqBVEQsl27baCx0eGA
 hjALBheFFOq9OZr0tMH08MVhRuLK6BYDbEVLeLSRBglrTYYS76StO5z77QUVn_kjiEYGgVV3AvVa
 NeTLOktMrYjCbILjF_fFdT6SW0AyFT_moBBA7he7.PZYCruhWdfy19LBKwo6Qs6CqodXt_ENPjuR
 UbugIUBikJuTeWGaovPrgQP8oaCANf8TOr6kFXZnPluno_O_laOYVPTo3LY1QVhEpAe141mFx1l.
 dQhhNbbCKB7fDfnY60w90yhkseqhRD9SmmwtTH5dyTHAxqbDcLp4XE19s.ZCz4SQkvwDk9miqaY3
 PCY2.4K0ZT3V7RKmywqcNdFR7_phKYkMhhy5DxOJJ5spdlaDYVOs77xDDTRU1zg4jW.KDMEM4r0J
 AG2qfg9zZr5RAw0TAtPm2FcqthGO8uJVyIvJ2cItChr2MpJMv8t0TAI_cOcns_PgHxPCSuV67l3d
 by_QeMYpj2hKnUPCAk.PMzazt5li_Mi6Tag8QtqmW2yJzbpwQ5xKg1tXQBalMbegzGB8Rfh6fgBJ
 IbXl4KptaPkwDqZxDE0hmxzOP0K7rapcYZ4Ep5lNpJVi2icTguusj9b3HwKQIyav7P6C2pbgjBUE
 JuCF5M1z7LVXEaoJWVh0Uz.VdbR3fvpazzOMM9_uZK6bierDC5mx1gAUh8tiPwaAeCEREGOPNJEN
 byNr4WSkdMRlw2Ba8gSoCdSgg5jzNQjejSWCtAkkNOD5MlXafVM_4Z9sAyPqDzp7Wn8LiAQaSW1q
 PPLHVclsSX9JKdPsQNTiubAP8fLn0lKoSkYKn284JxzCyPDJDGk9q8hRUWfVAM_CMwaxsK9i2xIH
 EBS1vG03td_Lp_O4XPORSds9QVP4Kv9zRgEuvGqw2zRGeen7Diw2Gv_G__dCwDdxll8m__fCemQI
 DjU73_wntn1kGB4a4WexJSRatAvZjh6IL6GFIsiZpMCtbm8hQXAvYNY2AeP8Fdv_d9j797JTSMXs
 oEOCaI1Xbtnp2pLOreg2PdF7cLwEkf35AnyMkpSBR4DVO.QxNPkc3bJ4TdY50PsW0HvQ8J3aD6rx
 CLipPVuTNpJz8NaYAMHehgzGhMm4LAhJNC1E_upMOhoJKuWoOZd5NuPj36HEtZhHEELKut0PGMdi
 _xhCBUOQr6l4nqomRaRbuGyLtSRRusTpFmHMtlPW1QR.w4B8dy2YGvmmccd9ekXjLUK0TidCqQ2H
 3xe9sAqnYVY3gVMdCq0I3.ZcauLbCS_JMLusWs2HcOjRK.10JmQt3sYoX5YSO.SQsuMhIA.oj92O
 TXehPUdSPYcCv.m0L3NTU1hgnM5wn8LRVV9OZm9nJA_GQ.436wUdV3ICxZ_l6kqBJ6FyijcV4J_n
 0YNaEehtB4EpQp1aurxOE64FsmpqRj7FpZHK4uXbJI5SME5X0mi3M1c3tUV5ZITTofvcVpU9cH73
 gEfo7j3s2xUVGZGjHsTqX38eMSJOhXMpAws.A3oIZP6Kfldh3WazUuHG3nlUhrGQai3tnNQqFFht
 DXoen4J5yGHa10Hz7YyC0tm_ZFEK7J.zbGlufaxz6.pPaTBqmwRUEtuz3O8gobgh7IPogyoF7F_A
 T6EE8rC9CUoxar8RJEkJTRb.AvfQrQHfgaIxbqcOl2C_7Gpmf1JjI7R5JIQK6vYa49lWL9D0nbNB
 GxBsMBFl.1tH7jbuEuHwrsd9MrcGqHU6kU.H1nJzGYWNvFQb6ja.WGEz4E7Yf6X3Ge75wYUvSkcK
 naRgbb7B.0yrefdn9KJEGwopv7n__JgwaFW5AMmnDMRzqd3KjzXx7O1UmiNb9M4dTDC.Y1lWaqkN
 7nJt6ucAjFOHL6Lp3lJCjpVAMgS5Sjp_ysw--
X-Sonic-MF: <mau.salvi@yahoo.com>
X-Sonic-ID: ba62e976-02d4-4cc1-b4cb-3d83f93eb709
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Tue, 13 Aug 2024 14:16:49 +0000
Received: by hermes--production-ir2-6664f499fc-fnmws (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4e74d0fd74a293089a52c248040f0e27;
          Tue, 13 Aug 2024 14:06:39 +0000 (UTC)
Message-ID: <0363a40f-ac3a-4024-a9bb-e37841625cb8@yahoo.com>
Date: Tue, 13 Aug 2024 16:06:37 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Process stuck in cobalt_monitor_enter
To: Xenomai <xenomai@lists.linux.dev>
References: <9d5bb262-0646-451e-a5af-82c0473a3003.ref@yahoo.com>
 <4572a391-4c06-4aa9-b92e-66e9da6c23ed@yahoo.com>
 <44ffbd9c-fc28-40fd-849f-a77fee15866b@siemens.com>
 <CADBp9x=310edtayP3nEeDSc2D318E=qA1a=5ceG0krd3r2VN8w@mail.gmail.com>
 <87e3bc23-4eba-43c4-bb5e-ffce9139c075@siemens.com>
 <CADBp9xnL46vC0KiYt2MSv+XxYcgb675S5X6geQWSv8KsKG9+xg@mail.gmail.com>
 <CADBp9xn_Gcu9TCaiZHZvo3hwT4JzzTxE4ueMH3dt81KJWF8qOA@mail.gmail.com>
 <67ce5b0a-1013-4ab2-9617-0723c0dc0809@siemens.com>
 <d1b99e9a-5bc6-414c-9f5d-972134f60c31@yahoo.com>
 <bea3518e-5d72-4a86-a5b9-ac71a59c235b@siemens.com>
 <e5efbf9d-9054-46d3-8deb-aa321146068e@yahoo.com>
 <1b8ec985-8ae2-4bd2-8964-23f97cac7ba4@siemens.com>
 <CADBp9xn4OGi99e57phnv58NtCbxzO62bhrkJhSns-FUbbt4_pg@mail.gmail.com>
 <6fb4564d-3d39-4be1-838c-423a865638b9@siemens.com>
 <2d41fc43-db7d-4070-a769-bb37083cb414@siemens.com>
 <2e779a4e-ce60-4487-9dbd-7d40726b2d9e@yahoo.com>
 <0d9b6cd5-4b95-4b28-bf06-9e98d7d6310d@yahoo.com>
 <46a1ceb0-0684-4bb8-bcd3-5f71456c2d10@siemens.com>
Content-Language: en-US, it
From: "Mauro S." <mau.salvi@yahoo.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <46a1ceb0-0684-4bb8-bcd3-5f71456c2d10@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22544 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/08/24 15:59, Jan Kiszka wrote:
> On 12.08.24 15:41, Mauro S. wrote:
>> On 06/08/24 09:33, Mauro S. wrote:
>>> On 05/08/24 23:41, Jan Kiszka wrote:
>>>> On 05.08.24 16:40, Jan Kiszka wrote:
>>>>> On 05.08.24 16:28, Mauro Salvini wrote:
>>>>>> Il giorno lun 5 ago 2024 alle ore 14:10 Jan Kiszka
>>>>>> <jan.kiszka@siemens.com> ha scritto:
>>>>>>>
>>>>>>> On 14.03.24 15:22, Mauro S. wrote:
>>>>>>>> Hi Jan,
>>>>>>>>
>>>>>>>> finally I managed to have a piece of code that makes the issue
>>>>>>>> reproducible. It's not exactly small, but not too big either.
>>>>>>>> I hope that this makes the issue reproducible also on your test
>>>>>>>> system.
>>>>>>>>
>>>>>>>> The zip contains:
>>>>>>>> - a little main program (test.c)
>>>>>>>> - a little library (in mylib dir). Some pieces of code are never
>>>>>>>> reached, but leaved to avoid potential compiler optimizations
>>>>>>>> that could
>>>>>>>> remove other relevant parts (maybe cycles?)
>>>>>>>> - a script (build.sh) to build the two components above
>>>>>>>> - a script to launch the test (start-test.sh)
>>>>>>>> - the configuration of the kernel in use
>>>>>>>>
>>>>>>>> After building the program and the library with build.sh, you can
>>>>>>>> copy
>>>>>>>> on the target:
>>>>>>>> - the start-test.sh script
>>>>>>>> - the built program xeno-test-session-hang-on-exit
>>>>>>>> - the built library libmylib.so.2.0.0
>>>>>>>> and create the library link /usr/lib/libmylib.so.2
>>>>>>>>
>>>>>>>> Start the test with "./start-test.sh &" and follow what happening
>>>>>>>> with
>>>>>>>> "tail -f log.txt": after a time that varies from a couple of
>>>>>>>> minutes to
>>>>>>>> 25-30 minutes, the log should stop on "~~~~~~ RECEIVED SIGINT
>>>>>>>> ~~~~~~"
>>>>>>>> line: the hang is happened.
>>>>>>>>
>>>>>>>> A small recap:
>>>>>>>> Atom x5-E8000 CPU, Linux 5.4.255 with Ipipe 15, Xenomai 3.2.3.
>>>>>>>> GCC compiler used: 9.5.0 from Yocto Dunfell 3.1.22
>>>>>>>
>>>>>>> Can you only reproduce with this setup, specifically with this
>>>>>>> compiler
>>>>>>> version and only on real hardware? If you rather use
>>>>>>> xenomai-images and
>>>>>>> qemu/kvm target but still the same kernel and xenomai version, the
>>>>>>> issue
>>>>>>> does not occur?
>>>>>>>
>>>>>>> I'm trying in kvm right now, also with different compiler. Iit
>>>>>>> would be
>>>>>>> good to align / rule out variables if my first setup turns out to be
>>>>>>> unhelpful.
>>>>>>>
>>>>>>
>>>>>> Hi Jan,
>>>>>>
>>>>>> Sorry, I never tried on an emulated system like qemu, I did the tests
>>>>>
>>>>> qemu/kvm - that is CPU-wise not emulated, virtualized. It generally
>>>>> gives similar execution patterns as on real hardware.
>>>>>
>>>>>> only on real hardware (using different samples of the same hardware,
>>>>>> just to exclude hardware problems).
>>>>>> I can do a test with Xenomai images on real hardware if it would be
>>>>>> useful.
>>>>>
>>>>> That would already be useful to rule out the toolchain as contributor,
>>>>> yes. When at it, testing in qemu-kvm would also be nice.
>>>>>
>>>>
>>>> FWIW, I've pushed ipipe-core-5.4.281-x86-16. It's not that I expect
>>>> positive impact on your issue, but you never know (until you understood
>>>> the actual root cause).
>>>>
>>>> Jan
>>>
>>> Hi Jan,
>>>
>>> I've seen, thank you.
>>>
>>> I will try xenomai images on real hardware and I will back to you with
>>> results.
>>>
>>> Thanks again, regards
>>>
>>
>> Hi,
>>
>> first results after some tests on real hardware:
>>
>> - xenomai-image does not show the problem
>> - xenomai-image started with my custom kernel instead of the
>> xenomai-image one does not show the problem
> 
> How did you build that custom kernel? Is it the same binary that failed
> before?
> 

Yes, exactly the same: I took the binary from my image and copied into 
xenomai-image bootfs, changing the grub.cfg (because I use a bzImage 
instead of vmlinuz).
On my custom image the problem shows up, on xenomai-image with my custom 
kernel no. My custom kernel is built by Yocto.

>> - I didn't manage to run the xenomai-image kernel with my rootfs yet (it
>> does not start, but at the moment I have a headless system and I'm not
>> able to debug it)
> 
> The kernel we build in xenomai-images may lack some config switches
> needed for you rootfs.

Yes, I have to discover which ones.

> 
>>
>> While waiting the verification with xenomai-image kernel with my rootfs,
>> could we conclude that the problem lies in userspace then? Could be the
>> Xenomai config flags? Or the compiler version? Do you have suggestions
>> about other tests to run?
> 
> Until we understood the reason, we do not know where the problem lies.
> Your userspace may trigger something that the Debian image we build does
> not.
> 

Ok, understood.

>>
>> Note that the test binary is always the same in all scenarios, built
>> with my toolchain (that is built by Yocto), and my rootfs and
>> xenomai-image have both Xenomai v3.2.3.
>>
>> Side note: xenomai-image still has 5.4.228 kernel, maybe you didn't push
>> the upgrade patch to 5.4.281? Anyway, it seems that does not matter.
> 
> Only the next branch of xenomai-images contains the update of the
> released versions so far. But when you build "head of tree" kernel, you
> should also get that latest version.
> 
 > Jan
 >

Ok, I used the master branch to build the image.

I will keep on doing my tests, reporting further results.

Thanks

-- 
Mauro S.

