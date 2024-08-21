Received: from sonic312-25.consmr.mail.ir2.yahoo.com (sonic312-25.consmr.mail.ir2.yahoo.com [77.238.178.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0EF210957
	for <xenomai@lists.linux.dev>; Wed, 21 Aug 2024 10:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.178.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724235092; cv=none; b=QSpRzvqnK1H50nUQ3NW2PnJLhhwNIQIo0RvDW+FTx3P/l3MXtK+RyDZNyuVAqQ4zRLBskJt5BZO31B58AKC+8AHc+NMbasoQ9/aXEi2THAmrjGi9IVhuCnoDxAAZejYiIk6pAfxVC3o5+6klcIqYmVdmx7Ty+cyKiVFDZA3sBWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724235092; c=relaxed/simple;
	bh=0lbpuRmHA3eKE3slyKqWMVDRc9RHhkg+rfxAcUGySlA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EWulpebGbaqG1DB3L4n4seCCroOMxwXzNAx270UImP8EKiYrfNj25baGE90MyXL0pjBi5FRXbPu7xkaOO8YFvGgXFY642V41TAy8RYra68WwEBfHukdNhOJIiVRSOtOZNlLXDzc+YcQaEsKlbcBpuUEaD7s3/+Lx44ujnFP9H+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=f9b7/wHi; arc=none smtp.client-ip=77.238.178.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="f9b7/wHi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724235082; bh=LaQz20FhS+PJf0MI8k3IGCmeHQc+0y9SvhXr+/Cr+BU=; h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=f9b7/wHi+bLw4bdHAJ2JcshA27rzSd5FaBJXFCC/4hgjpzM3mie9BHjH3yJA4EHB8tgNblc1hXODWxHkDAXPnG/vNri5PugwyrVNVOWxDEjO0CEIa6t+Qpgg836D24jIxmjMwUUSWoNXKg0R7dYEQ0yt8gvql/Ac/zqVG2lB2Cs5RIRYyFSXD25fQsB1+Y6tTkzOB25vQUQpV3yttFmqDCAho+LPG1lCL5o8p7o+3A9/IKHCHRGwvpPyFwvmN2Z39FW9Xxa1C00X4uhJUebvMUrM21SPpZERAqoNBRE7oY45S+FoROyK52d3/GukJ+7aBq4BmzQak3ExuaInwB8SAA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724235082; bh=h2aTZ6h/Ii+iJQx909KRYC/WS76gm+su92z80HT0kQ3=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=ZqyXWAo86MEfJ0hZVZ8ahflgB3ReQjNo0GWvHbpG+vFxQYXEIgE8vYQFt+jTiwqpcrUcBWb3Gydbn2ps1OcxSg4XQtKodN8tM422mg08czoZLcwIDjJzTKmGOQ31ZJUySUENobPselDdmpB3Lyb6s3p0uTAcMmP+tO1vteWz21YZEG1NPOnsWeQqz3HaV9WUQanofnl1FRBtxj75wXc3Jpdy46M1Z9BgX4UbIkzRRFH3NeNcuQGwkRUXu8emfdCVZQmJTvlgc3tFQaP51pnT/8juTDpJHe/OI9mLaDPZ8yF3fgiBFnGW4SEqwZa96CrHmRDxqZsXfZrPTGlTuN3UIw==
X-YMail-OSG: iDUdgI4VM1mqbGYmcuErCBW0kqNtohN_aF.1gfnPDeh8.2_CyG4nVBRfcOJqKT3
 ptJQQdIeCK1bI9V4vCcMqyTkZ3jjYecz9sMOBL3ylOVe6SqVmQN1PuyHgQAj8BAeKSTCYo6i0pTV
 FlYF3XKp97NZ89OvMd_d1qCqCP6fekpPGsheMww9mapYfCE0KSaUXWhnsoAHbcW7xnBNvf_uDPGU
 Qq7NC_VJIywQiEx3B2.If5DVDaOtzokr9cVMb7mLPhTvCNHioqDBUR0agYdHM5ylaPWmVPoa7yz0
 hj7jqPtP0Jlbo9pXVBcJkjctRfbYmrXYyS6YFF1j8GIjCc1rnjberJgb.FAXus4AYu8FYZKpMhT9
 zlfRsZ3EBkYYynaLKwp9IdTa6kVlyrf5cqR5aQ8s0bM4wE4yK9fFuCgxayG19TfUvJ_9MrQj7XMx
 KdA3Jw8TqqWg5_AhWXOfgSDS1FHW9fYi8dk.Vzj2GlzYrcqv0ppBQAavaxqSqx3xmEBIs4K8R.XL
 .1iUIASwOeDy7HI.iABN507c6idmK57o3zxqnNS7WEgINGSJ4ploS2QAEkIezDtZlQj4HfdGl5fR
 XoRtP9faOCtGUIBcvjlTwiYKvGONDylGbIDFToe7hMQ07V93fXluu.cCDzzA_0yyKUNGApUKn7Ni
 D5Ty7pfa_4jGk_rYP5ic.xcZLHBY3igQiwvlOj61XwhlrX01d8INSEN_EhNwEfxkDv_BoJLHK7lJ
 htLryMqQWUzWC6OHuJGP6nZgU2WNcTQv2hvEwSeZa3ELM7uOlropa7yjwQAhCP0ohNbhJd7yBuDD
 7Kl1J9nM5dODZyTg_TKuszxlP1RnkqCFzencaJ954ikDIIVCo2JSPdkfTrEFui_s5q0evKayfw84
 ZgRuKlfcTrDS3n0KhmVBvmDxptdyBgJyfz7xYYYODyI3aR8_2weDo9nGoNxBwqsMYPSSBxy2aAQT
 kUqWID6gQ1FCqxP0rNbP56g7XhtFWT_0bco4S6Nt3uSau8K9q_RQE0UoQF6mwhS0RSuIHmTEH2Gj
 7mzdU.8Yxi9ekx2keMUCzG2eHDtg.ajd4q_l7mp7EvJaqCvmIX5TaHf2fSRxqi7JcEiFl8M5YdDV
 OBsEkS2WU_DapiaSiDfkXvJBYzUYvO5_iGxn88P5PAuPDELYdOw_woTFq8iya3AobpSIBfcwWoUU
 scDHpXCqof1nOd2rJLFLP6uuYYIhgva_nooveGyGLi6d_2RTaNV.vzMAnphet_MyScczzKRVWCXc
 Bv.eP0kSHAISUkuifnnEefbLZQkzoJTHcHaZrBvf50PPIatPOjLWXPHHGX14c7cQrjnHm5TfwIdQ
 2s9YPUHUG3sGBU5qjJn2DeFZU1lDt6H969lzULdYyXoONOoQrT9zt5PCJGVCunyB.TnY37sWomrg
 cLNTFHt.5fT4oqoi4PFNucXN0hJSavmUFkedjrN5zMrPa_.5qoz9g3Mhkm664Hr14Kq81qjENC2L
 P1HooCkvdUJdcoqhDGF_LfvrfzlpMX.j3hQ0r28jjsXBgqZ0BJLkmsXfIAtgVxy_jfYvdeBEeZwh
 9LkVFVrz5UCfEqMJH9aQdaerQWoLaNQbPNcz29mUkgsM1ZELhNxnH9JO3zIdkBdu_w1eOMf5WwQz
 mtC4eunTPuOqt1amzOLyfc7xOl.KYmy.F4cWNopzzUCVnXfEojxXaxXHgfpdVzgO_wk_SOblCIHL
 x1ktoSraVXeYJl2CZ_0YMsAB7mhoGaUdzQJ6zXXNm.054LTHDJ_ElL3fFMwVo6fc0ok8qRdyLpzy
 PXhvAyYBcYUMfX3CyLS1QQwH2GSaNbYdcB4QOGgzd6T6lT1uVuTNSCuoapnef7tM8zIUnFOSaMVR
 jonlvuIbP5kXjE8uL7jt7Ico3orf941mhPlX_irK5eA6z2rSSrcBSoGfm1b9Fy.MIDLkqY3KDl9o
 RMpWt9k1HeIpBDCb4BirT37Cb50OKmKf.wv1xysj6ve7D_HNWjpd5ppvFENKEcutT_wtoCJEgmC3
 Hz_Fi8FKj5qE3Fz3w51Ei1c_b2Htm7XcxIPwg8V8GdirCZH4c9Uplgz4xsxJ_Y9_hagCTnRm9VsJ
 sT3OJluVoL9XB0ilBj7aXFgpPK7kiQVeKltirde3T3eXaMUzelubxBBgXiqiDd1a0wVtdKcdZTD7
 7etGE__.SF.qEjkL7BUeKcM9VYGDdUExV7owV_C4vrlroCeRgVgy1OHiFfG8OnsalnrkDHEO5o3_
 ggHVNEy1t7rulyFySYMtHwTg3xw--
X-Sonic-MF: <mau.salvi@yahoo.com>
X-Sonic-ID: 37db0df3-85b1-4103-8246-ba703445572f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Wed, 21 Aug 2024 10:11:22 +0000
Received: by hermes--production-ir2-6664f499fc-l95lq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 38974ea76db340e2a0c01d74c3b74912;
          Wed, 21 Aug 2024 09:40:58 +0000 (UTC)
Message-ID: <7707fef0-b164-4a79-913d-6ddcce6600d5@yahoo.com>
Date: Wed, 21 Aug 2024 11:40:56 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Process stuck in cobalt_monitor_enter
From: "Mauro S." <mau.salvi@yahoo.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
References: <9d5bb262-0646-451e-a5af-82c0473a3003.ref@yahoo.com>
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
 <0363a40f-ac3a-4024-a9bb-e37841625cb8@yahoo.com>
Content-Language: en-US, it
In-Reply-To: <0363a40f-ac3a-4024-a9bb-e37841625cb8@yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22544 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 13/08/24 16:06, Mauro S. wrote:
> On 12/08/24 15:59, Jan Kiszka wrote:
>> On 12.08.24 15:41, Mauro S. wrote:
>>> On 06/08/24 09:33, Mauro S. wrote:
>>>> On 05/08/24 23:41, Jan Kiszka wrote:
>>>>> On 05.08.24 16:40, Jan Kiszka wrote:
>>>>>> On 05.08.24 16:28, Mauro Salvini wrote:
>>>>>>> Il giorno lun 5 ago 2024 alle ore 14:10 Jan Kiszka
>>>>>>> <jan.kiszka@siemens.com> ha scritto:
>>>>>>>>
>>>>>>>> On 14.03.24 15:22, Mauro S. wrote:
>>>>>>>>> Hi Jan,
>>>>>>>>>
>>>>>>>>> finally I managed to have a piece of code that makes the issue
>>>>>>>>> reproducible. It's not exactly small, but not too big either.
>>>>>>>>> I hope that this makes the issue reproducible also on your test
>>>>>>>>> system.
>>>>>>>>>
>>>>>>>>> The zip contains:
>>>>>>>>> - a little main program (test.c)
>>>>>>>>> - a little library (in mylib dir). Some pieces of code are never
>>>>>>>>> reached, but leaved to avoid potential compiler optimizations
>>>>>>>>> that could
>>>>>>>>> remove other relevant parts (maybe cycles?)
>>>>>>>>> - a script (build.sh) to build the two components above
>>>>>>>>> - a script to launch the test (start-test.sh)
>>>>>>>>> - the configuration of the kernel in use
>>>>>>>>>
>>>>>>>>> After building the program and the library with build.sh, you can
>>>>>>>>> copy
>>>>>>>>> on the target:
>>>>>>>>> - the start-test.sh script
>>>>>>>>> - the built program xeno-test-session-hang-on-exit
>>>>>>>>> - the built library libmylib.so.2.0.0
>>>>>>>>> and create the library link /usr/lib/libmylib.so.2
>>>>>>>>>
>>>>>>>>> Start the test with "./start-test.sh &" and follow what happening
>>>>>>>>> with
>>>>>>>>> "tail -f log.txt": after a time that varies from a couple of
>>>>>>>>> minutes to
>>>>>>>>> 25-30 minutes, the log should stop on "~~~~~~ RECEIVED SIGINT
>>>>>>>>> ~~~~~~"
>>>>>>>>> line: the hang is happened.
>>>>>>>>>
>>>>>>>>> A small recap:
>>>>>>>>> Atom x5-E8000 CPU, Linux 5.4.255 with Ipipe 15, Xenomai 3.2.3.
>>>>>>>>> GCC compiler used: 9.5.0 from Yocto Dunfell 3.1.22
>>>>>>>>
>>>>>>>> Can you only reproduce with this setup, specifically with this
>>>>>>>> compiler
>>>>>>>> version and only on real hardware? If you rather use
>>>>>>>> xenomai-images and
>>>>>>>> qemu/kvm target but still the same kernel and xenomai version, the
>>>>>>>> issue
>>>>>>>> does not occur?
>>>>>>>>
>>>>>>>> I'm trying in kvm right now, also with different compiler. Iit
>>>>>>>> would be
>>>>>>>> good to align / rule out variables if my first setup turns out 
>>>>>>>> to be
>>>>>>>> unhelpful.
>>>>>>>>
>>>>>>>
>>>>>>> Hi Jan,
>>>>>>>
>>>>>>> Sorry, I never tried on an emulated system like qemu, I did the 
>>>>>>> tests
>>>>>>
>>>>>> qemu/kvm - that is CPU-wise not emulated, virtualized. It generally
>>>>>> gives similar execution patterns as on real hardware.
>>>>>>
>>>>>>> only on real hardware (using different samples of the same hardware,
>>>>>>> just to exclude hardware problems).
>>>>>>> I can do a test with Xenomai images on real hardware if it would be
>>>>>>> useful.
>>>>>>
>>>>>> That would already be useful to rule out the toolchain as 
>>>>>> contributor,
>>>>>> yes. When at it, testing in qemu-kvm would also be nice.
>>>>>>
>>>>>
>>>>> FWIW, I've pushed ipipe-core-5.4.281-x86-16. It's not that I expect
>>>>> positive impact on your issue, but you never know (until you 
>>>>> understood
>>>>> the actual root cause).
>>>>>
>>>>> Jan
>>>>
>>>> Hi Jan,
>>>>
>>>> I've seen, thank you.
>>>>
>>>> I will try xenomai images on real hardware and I will back to you with
>>>> results.
>>>>
>>>> Thanks again, regards
>>>>
>>>
>>> Hi,
>>>
>>> first results after some tests on real hardware:
>>>
>>> - xenomai-image does not show the problem
>>> - xenomai-image started with my custom kernel instead of the
>>> xenomai-image one does not show the problem
>>
>> How did you build that custom kernel? Is it the same binary that failed
>> before?
>>
> 
> Yes, exactly the same: I took the binary from my image and copied into 
> xenomai-image bootfs, changing the grub.cfg (because I use a bzImage 
> instead of vmlinuz).
> On my custom image the problem shows up, on xenomai-image with my custom 
> kernel no. My custom kernel is built by Yocto.
> 
>>> - I didn't manage to run the xenomai-image kernel with my rootfs yet (it
>>> does not start, but at the moment I have a headless system and I'm not
>>> able to debug it)
>>
>> The kernel we build in xenomai-images may lack some config switches
>> needed for you rootfs.
> 
> Yes, I have to discover which ones.
> 
>>
>>>
>>> While waiting the verification with xenomai-image kernel with my rootfs,
>>> could we conclude that the problem lies in userspace then? Could be the
>>> Xenomai config flags? Or the compiler version? Do you have suggestions
>>> about other tests to run?
>>
>> Until we understood the reason, we do not know where the problem lies.
>> Your userspace may trigger something that the Debian image we build does
>> not.
>>
> 
> Ok, understood.
> 
>>>
>>> Note that the test binary is always the same in all scenarios, built
>>> with my toolchain (that is built by Yocto), and my rootfs and
>>> xenomai-image have both Xenomai v3.2.3.
>>>
>>> Side note: xenomai-image still has 5.4.228 kernel, maybe you didn't push
>>> the upgrade patch to 5.4.281? Anyway, it seems that does not matter.
>>
>> Only the next branch of xenomai-images contains the update of the
>> released versions so far. But when you build "head of tree" kernel, you
>> should also get that latest version.
>>
>  > Jan
>  >
> 
> Ok, I used the master branch to build the image.
> 
> I will keep on doing my tests, reporting further results.
> 
> Thanks
> 

Hi,

I played a bit with QEMU and my image vs. Xenomai image, here the results:

- xenomai-image does not show the problem, both with 5.4.228 and 5.4.281 
kernel (as already seen on real hardware)
- xenomai-image started with my own kernel does not show the problem (as 
already seen on real hardware)
- my image started with xenomai image kernel and initrd does not show 
the problem, both with 5.4.228 and 5.4.281 kernel (on real hardware this 
kind of image does not boot, I'm waiting for a board that allows me to 
debug why)
- my image shows the problem: the only difference with real hardware is 
that sometimes it takes a bit more to show up (up to 1h instead of 30 
minutes max). I also observed that having some load on the host PC seems 
to delay the problem.

I can share with you my rootfs and my kernel, and the QEMU startup args 
if it would help.

Thanks in advance, regards

-- 
Mauro S.

