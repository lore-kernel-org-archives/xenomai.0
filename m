Received: from sonic312-25.consmr.mail.ir2.yahoo.com (sonic312-25.consmr.mail.ir2.yahoo.com [77.238.178.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B3615FCE6
	for <xenomai@lists.linux.dev>; Wed, 28 Aug 2024 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.178.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724850355; cv=none; b=AUh15fJnhUAzM1HcLJXsobxHmOTJekoSoRz1VujQZZvGCv0mi9eUPIzY3/DkdHgNDiBbN02TEZ20GiTgfLa4ZzE+pirUqLA+zQIX9EFxAk/10ba6QPoIqdNhTiwluZBjgmA9sMg55ZZKuFzH79tdgCCj9Tsb90q8T8dDjA3+0IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724850355; c=relaxed/simple;
	bh=3AQvwicpbYkTWZYKMDeP9fPSKmcesgZKEh3VfEPXkTY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mA2d5eQee6GjuchopBdYNBVqxlXbssv663VjDrWTkfNNZ/dh8m8dRmi2e0/I5GMSgId79RQ4m2vkpQiCPNXy5xt+BLCY1aQWAn70bJRREZdVF2UV5DIKEll3m+7/Im8h3naf4zcX2CVXHIqeKFB8mHQWv4mq/6zAmlUTONRs+8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Xi0yx2PS; arc=none smtp.client-ip=77.238.178.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Xi0yx2PS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724850345; bh=J3SzUah7QjvAeV8KMnFdS+/WJCPeJFjZLP5zjBEwQM4=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=Xi0yx2PSNMzK6hzIh7W7ys4zkbcbRKxygXPLL11WkzWzbOQZDgVUh8RXzM+YBM/yrHkR3o7CsxImdO/U2XoRV/vtStOMAXNf3Yi4h7fj21xqdnh6qiCFg2unN8sNCdwT8yxt8K+zimytaUUIwpRq53LPQOrNc66Dx5ZRzjixLFg1vBx3z0hByaJjyIgwKtqMgdtffLygfsS+kHfed0YeGYXRUE6pYrvX39dD8mP9G+JrVp6/8tyVAVF2BrkGOw1zcyzHIZBRr5DSDS9uQaspIdWV/C7W/jSJNfWUnbSMSIOLrgLG/bl+aOrZ1gVhShYsFrseWvPC9ADYuD+9hA0i2Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724850345; bh=dDzOCCZzdFfwSUIbl4kNjVtgTc4b+7+Wq6l2MBFQZih=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=JzufO93XgEjrGQahvyLqKCt7StRgKQnqSh0RasqZA6JmDaQAaN4gcbt9vYjIAdqSlcep5O8TxCHsEIfWPvosOW/40YguT1lBDxxrqSF6t9lQtI5NP9rpTD7OfOupgyNqWvk8D1MUgCSuiWVvIEWShI/EQrEJ+4JiDbFiQeNnvsuMSVSIbH3iNCXr1JBz/utey7QBt8x+8So3EuuszSPXp5b6T9KEBgjxMdg73TxUoYl9kirvbLdrZG+KTkvfto9ngiCDovec7iy0euVGwiuen25Cb3l6D0NxfjVuDGkdAmgKsJDsnWaQKI4DWwAX+miRTS5+4hP6aw7Cb3KnMzwg1w==
X-YMail-OSG: EnFSGqMVM1lKqz9zJoMxqyBHzGDFmdnJWhv8JWgHJp4QeL303bwU1Qh.JnJ4ZDo
 aWLHvKkno61jqLeFZcNdgd5niv4qeOjYQtHLwOFegW9PEZzMyKs91dyIRPbZNOs8H2zy2HPwYL.V
 sMK_gMqX0o93XaXwy8gNdWwX5MG4egQIA5PeAgVJGMFL5r_x8BXAqQ0KFfLEmpB0uPxcFUNMVsJF
 K9dIoFVmW0ejD57b0jxohUj_FoDBfOGsEDSsYviaSvOcHebOTbXRY5_14p2A2t8dbNa96rftLunI
 mPfC9SMZjaSro.Vc_3W0l2635nUQky_IHHfAeTc_f_L56r6gwnH74pe6mYM.YmSj0PWb9526uNwe
 zQOcyR4RTDa3CJMk5Qooa9w8fRW95so.tbGHIfakewgDYIDSPt2D7lTRC4Jra_NAAlFRuhVzYcJ_
 tU.yzl0AREps0Hw2lfUcBof54M_LZ0rkdHOueiS4MWpR4Wr_sZqhdyKJbKcUMUJDe2LIOIw2yXGl
 zH7C2FB774Yg_HCmpVXMx5qS6XW9FMeBv2waUSRVwnAEH2CDkaHC1Yaa9nEizHGv1640bVJy2X6_
 4ODr_Z0DKHQzBoGmVZkEnpnQGyK72wd.IShpL5dV7Zdr1bzsbMKo9zAMyRWGch3ZmlocnLIB6.d5
 SfHNXG_ygiEZuwStVwpSpavNAJk4pn1XgcrLfM7Amo0bLfqQPU0OUeeJaa6JqOmFTy8c5df87dAr
 lH6098f6lY0C5bqxYYQDK2vBlMaWdp1Swjw_nP2__eBe0AK1m5GiXU0tlUSulFFVflIClmn.o3PZ
 SWIIb9p8ZpHQwDTUWn_ullh9kgy4sOAbG6OlbtDay.vOHru6uLVyTslTOEGvA2sFg4FmhFMHYBH.
 fJUYHPddj3U8VARh_ChaXitJZ0zHETWM3MCzm8aU1ANfr_OdIIbUcGgCSwd9jJofqOPzyNEChmGL
 .wEVwNrPAT9rXmWPXj2_a0Q1Qstljaswng6YcCXVcqoHwa3hS1EJtxPn9hT79ihlkiFauzeuZco7
 Cq4.v1b00dLh6.iqrT1ZiGw03WeYevSsglgfDGkAR5LZvM4Mf_3K.fq0ETtG0US2_Ikm3LQdOVxI
 c6_30u_NrjK1xKORy2iZwQT6iDLc5R5u7KoNHhvAdgJyQNM.6mn555dMptunOYMJJNy9NyyEdGTj
 y5WjnpR3pW9K9NsCzTjuGKX6ddAdaGrOWAz9aLQsQBiK4m7JI7fbI70qpVhaPdJqyPfjWslEDUZH
 QCZ6cW7aiBb3fiVUayjKXmW2cyVrDbm.vgStLf5cCB2VYrsYK_sSXFzPQCvomMRmnUmf6hsEzVzb
 35bo9a6sVG7WbV4hVdhhQXFqqz5ZQ5URxqfW.O0bXjEWkNKj6HoSzhXgtK9ItItzwd4k19ZEGjJu
 jve8KjJbC6XqOTH67Sgn7ZeJVTRHEIZn0rsuLBHCostZT24GiusJgvzrr.Afyro1I05vbczjX10W
 QFLgrwhoBIYSzu4SxO1VHRd8Dfkjv_.Grmv93jzWosHIgy83QOlvCBGPYG2nzMcS6FTpW1A1Swk7
 WgoQL2SsISSb4BHjDzttYsY24m9PgzIvnoppm33dwrF7._Lf51Npb.Y20Ypf66gnRSAEYSvDDXBL
 qC7kMDG1nJHkHrq2iENQR3PwYgxCyKTGb_xPgwSjAktfc8_x8AjQ78THpiEt_2yr5SOHMU4vu3Q_
 BFfK_MuU5ApIp5yH5iPnSGginbVke8IKWTaP4PDhFfgrTd9mDGxikLMB7IDyaaepXH0yPxt_6K7q
 t7DLrQIns7TMhSyxdYbrs5d6BPAwdzDSghR9hsb4QAkLWiFrp_JbD19RVuwwytLoi2rPzNddjT_E
 YtsBaQ5RScG5dRIaD2eDaAPad4iFbBWl.CaqbMhowjRiFK3G6gFneoWI54O8OKiiM1UQdq27jcye
 qprKo_.qDleqKnyoSg8vTGv9WD2V3GO6wtkF1OiZSwxkVJ.d_NIZqaAr.YqYYhor8BMLHniuxT6a
 N22nFb8oO87KsbYq6j2QB2VMFHm2usnuCrqCv27rKjJCuUD1VmG7NSdQE.R9IAQHAnDr4dWgL.Ke
 7xBh4M6n9orAuUe5brMOny02b9ALQigPP1l80zxqQLbJMj.vfC4_RoAT.WOhpjG3W5hU5y227UvA
 WkEVZyO7aZnmvRnvQAl23viboMVs58KVz7ztfryjv7peFIrApDxXBrcoy02j9i.9a2k24hkxosqy
 PajUOLWGE4GpowYY.x5lc
X-Sonic-MF: <mau.salvi@yahoo.com>
X-Sonic-ID: 1dea323e-8e85-4a78-a678-0fe74bb567c7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Wed, 28 Aug 2024 13:05:45 +0000
Received: by hermes--production-ir2-6664f499fc-l95lq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID bfc74013aa7f2c75f64187f0202f12dd;
          Wed, 28 Aug 2024 13:05:44 +0000 (UTC)
Message-ID: <4e5fe5f2-44cb-4578-b47a-89980173eac9@yahoo.com>
Date: Wed, 28 Aug 2024 15:05:43 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Mauro S." <mau.salvi@yahoo.com>
Subject: Re: Process stuck in cobalt_monitor_enter
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
References: <9d5bb262-0646-451e-a5af-82c0473a3003.ref@yahoo.com>
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
 <7707fef0-b164-4a79-913d-6ddcce6600d5@yahoo.com>
Content-Language: en-US, it
In-Reply-To: <7707fef0-b164-4a79-913d-6ddcce6600d5@yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 21/08/24 11:40, Mauro S. wrote:
> On 13/08/24 16:06, Mauro S. wrote:
>> On 12/08/24 15:59, Jan Kiszka wrote:
>>> On 12.08.24 15:41, Mauro S. wrote:
>>>> On 06/08/24 09:33, Mauro S. wrote:
>>>>> On 05/08/24 23:41, Jan Kiszka wrote:
>>>>>> On 05.08.24 16:40, Jan Kiszka wrote:
>>>>>>> On 05.08.24 16:28, Mauro Salvini wrote:
>>>>>>>> Il giorno lun 5 ago 2024 alle ore 14:10 Jan Kiszka
>>>>>>>> <jan.kiszka@siemens.com> ha scritto:
>>>>>>>>>
>>>>>>>>> On 14.03.24 15:22, Mauro S. wrote:
>>>>>>>>>> Hi Jan,
>>>>>>>>>>
>>>>>>>>>> finally I managed to have a piece of code that makes the issue
>>>>>>>>>> reproducible. It's not exactly small, but not too big either.
>>>>>>>>>> I hope that this makes the issue reproducible also on your test
>>>>>>>>>> system.
>>>>>>>>>>
>>>>>>>>>> The zip contains:
>>>>>>>>>> - a little main program (test.c)
>>>>>>>>>> - a little library (in mylib dir). Some pieces of code are never
>>>>>>>>>> reached, but leaved to avoid potential compiler optimizations
>>>>>>>>>> that could
>>>>>>>>>> remove other relevant parts (maybe cycles?)
>>>>>>>>>> - a script (build.sh) to build the two components above
>>>>>>>>>> - a script to launch the test (start-test.sh)
>>>>>>>>>> - the configuration of the kernel in use
>>>>>>>>>>
>>>>>>>>>> After building the program and the library with build.sh, you can
>>>>>>>>>> copy
>>>>>>>>>> on the target:
>>>>>>>>>> - the start-test.sh script
>>>>>>>>>> - the built program xeno-test-session-hang-on-exit
>>>>>>>>>> - the built library libmylib.so.2.0.0
>>>>>>>>>> and create the library link /usr/lib/libmylib.so.2
>>>>>>>>>>
>>>>>>>>>> Start the test with "./start-test.sh &" and follow what happening
>>>>>>>>>> with
>>>>>>>>>> "tail -f log.txt": after a time that varies from a couple of
>>>>>>>>>> minutes to
>>>>>>>>>> 25-30 minutes, the log should stop on "~~~~~~ RECEIVED SIGINT
>>>>>>>>>> ~~~~~~"
>>>>>>>>>> line: the hang is happened.
>>>>>>>>>>
>>>>>>>>>> A small recap:
>>>>>>>>>> Atom x5-E8000 CPU, Linux 5.4.255 with Ipipe 15, Xenomai 3.2.3.
>>>>>>>>>> GCC compiler used: 9.5.0 from Yocto Dunfell 3.1.22
>>>>>>>>>
>>>>>>>>> Can you only reproduce with this setup, specifically with this
>>>>>>>>> compiler
>>>>>>>>> version and only on real hardware? If you rather use
>>>>>>>>> xenomai-images and
>>>>>>>>> qemu/kvm target but still the same kernel and xenomai version, the
>>>>>>>>> issue
>>>>>>>>> does not occur?
>>>>>>>>>
>>>>>>>>> I'm trying in kvm right now, also with different compiler. Iit
>>>>>>>>> would be
>>>>>>>>> good to align / rule out variables if my first setup turns out 
>>>>>>>>> to be
>>>>>>>>> unhelpful.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Hi Jan,
>>>>>>>>
>>>>>>>> Sorry, I never tried on an emulated system like qemu, I did the 
>>>>>>>> tests
>>>>>>>
>>>>>>> qemu/kvm - that is CPU-wise not emulated, virtualized. It generally
>>>>>>> gives similar execution patterns as on real hardware.
>>>>>>>
>>>>>>>> only on real hardware (using different samples of the same 
>>>>>>>> hardware,
>>>>>>>> just to exclude hardware problems).
>>>>>>>> I can do a test with Xenomai images on real hardware if it would be
>>>>>>>> useful.
>>>>>>>
>>>>>>> That would already be useful to rule out the toolchain as 
>>>>>>> contributor,
>>>>>>> yes. When at it, testing in qemu-kvm would also be nice.
>>>>>>>
>>>>>>
>>>>>> FWIW, I've pushed ipipe-core-5.4.281-x86-16. It's not that I expect
>>>>>> positive impact on your issue, but you never know (until you 
>>>>>> understood
>>>>>> the actual root cause).
>>>>>>
>>>>>> Jan
>>>>>
>>>>> Hi Jan,
>>>>>
>>>>> I've seen, thank you.
>>>>>
>>>>> I will try xenomai images on real hardware and I will back to you with
>>>>> results.
>>>>>
>>>>> Thanks again, regards
>>>>>
>>>>
>>>> Hi,
>>>>
>>>> first results after some tests on real hardware:
>>>>
>>>> - xenomai-image does not show the problem
>>>> - xenomai-image started with my custom kernel instead of the
>>>> xenomai-image one does not show the problem
>>>
>>> How did you build that custom kernel? Is it the same binary that failed
>>> before?
>>>
>>
>> Yes, exactly the same: I took the binary from my image and copied into 
>> xenomai-image bootfs, changing the grub.cfg (because I use a bzImage 
>> instead of vmlinuz).
>> On my custom image the problem shows up, on xenomai-image with my 
>> custom kernel no. My custom kernel is built by Yocto.
>>
>>>> - I didn't manage to run the xenomai-image kernel with my rootfs yet 
>>>> (it
>>>> does not start, but at the moment I have a headless system and I'm not
>>>> able to debug it)
>>>
>>> The kernel we build in xenomai-images may lack some config switches
>>> needed for you rootfs.
>>
>> Yes, I have to discover which ones.
>>
>>>
>>>>
>>>> While waiting the verification with xenomai-image kernel with my 
>>>> rootfs,
>>>> could we conclude that the problem lies in userspace then? Could be the
>>>> Xenomai config flags? Or the compiler version? Do you have suggestions
>>>> about other tests to run?
>>>
>>> Until we understood the reason, we do not know where the problem lies.
>>> Your userspace may trigger something that the Debian image we build does
>>> not.
>>>
>>
>> Ok, understood.
>>
>>>>
>>>> Note that the test binary is always the same in all scenarios, built
>>>> with my toolchain (that is built by Yocto), and my rootfs and
>>>> xenomai-image have both Xenomai v3.2.3.
>>>>
>>>> Side note: xenomai-image still has 5.4.228 kernel, maybe you didn't 
>>>> push
>>>> the upgrade patch to 5.4.281? Anyway, it seems that does not matter.
>>>
>>> Only the next branch of xenomai-images contains the update of the
>>> released versions so far. But when you build "head of tree" kernel, you
>>> should also get that latest version.
>>>
>>  > Jan
>>  >
>>
>> Ok, I used the master branch to build the image.
>>
>> I will keep on doing my tests, reporting further results.
>>
>> Thanks
>>
> 
> Hi,
> 
> I played a bit with QEMU and my image vs. Xenomai image, here the results:
> 
> - xenomai-image does not show the problem, both with 5.4.228 and 5.4.281 
> kernel (as already seen on real hardware)
> - xenomai-image started with my own kernel does not show the problem (as 
> already seen on real hardware)
> - my image started with xenomai image kernel and initrd does not show 
> the problem, both with 5.4.228 and 5.4.281 kernel (on real hardware this 
> kind of image does not boot, I'm waiting for a board that allows me to 
> debug why)
> - my image shows the problem: the only difference with real hardware is 
> that sometimes it takes a bit more to show up (up to 1h instead of 30 
> minutes max). I also observed that having some load on the host PC seems 
> to delay the problem.
> 
> I can share with you my rootfs and my kernel, and the QEMU startup args 
> if it would help.
> 
> Thanks in advance, regards
> 

Hi,

I'm back after doing more tests also on real hardware.

Here is a summary:
- custom image: kernel 5.4.255 + xenomai 3.2.3, built by Yocto Dunfell 
(GCC 9.5.0)
- xenomai-image: kernel 5.4.228 (and its initrd.img) + xenomai 3.2.4, 
built by isar in xenomai image (GCC 12.2.0)

I confirm that the problem shows only with my own kernel + rootfs, both 
on QEMU and on real hardware.
Other combinations:
- xenomai-image kernel (and its initrd.img) + xenomai-image rootfs
- xenomai-image kernel (and its initrd.img) + my rootfs
- my kernel + xenomai-image rootfs
don't show the problem, both on QEMU and on real hardware.

Furthermore, I compiled the xenomai-image kernel forcing the 5.4.255 
version and using my defconfig: the kernel became identical to mine, 
then I expected to see the problem using this kernel with my rootfs. But 
-surprise- the problem does NOT show.

xenomai-image uses xenomai 3.2.4, but I don't see relevant changes 
between 3.2.4 and 3.2.3 (mine) in code linked into kernel sources.
Then, could really the problem be triggered by the GCC compiler version 
used to build the kernel OR the rootfs?
Actually, my kernel with the xenomai-image rootfs does not show the 
problem, then seems that the problem shows only when using GCC 9.5.0 on 
both sides.

Or is it a dormant bug that some versions of GCC hide?

I can share with you my rootfs and my kernel and the QEMU startup args, 
or other things that could help you, and I'm open to suggestions about 
other tests to do.

Thanks in advance, regards
-- 
Mauro S.

