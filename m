Received: from sonic312-25.consmr.mail.ir2.yahoo.com (sonic312-25.consmr.mail.ir2.yahoo.com [77.238.178.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D08717C9E7
	for <xenomai@lists.linux.dev>; Mon, 12 Aug 2024 14:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.178.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723471903; cv=none; b=UrqGQzG1dnCHRO5kY6y8XCk5k8eyHBn0Ei9FcY9mMaSLfSJS8pJZEmqMBG+HrCJLJRxC+O46ZxDGrk+g1AIrk6tXPoLM66tlFGQEd0L6tn+76F+yCmBj7l5zeNnTkw88y0pOOOuQOdtGRifxw7y0te6cMABV2bfGyUtKLCh6j74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723471903; c=relaxed/simple;
	bh=XKraPiR42fpMbYy6FUWRCS0HhP9djwktlW8pqhA9l4Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tBIVdp93904gLHjQiGA9lIaTOKyFTkrAwXEUmKRT4UqOgXMk9Zc8yClr7veh0acXTmaA+TzeZapf4PMwhV/kBfanhGYhPxEhtmJvuQu5B39i4oVS1wX4vsSySMeVX/bi7TLlOS5uGrMIfWvGtJaQx63fkDkBorDB0NzJWAGRMHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=rRT0cU9e; arc=none smtp.client-ip=77.238.178.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="rRT0cU9e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723471899; bh=QNws4/OZ0vNTQEiOCJ7abuS8Sm0P60azrDT90oAGB5k=; h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=rRT0cU9e4C6XKgpasz/LfUDpTcGrTqNn9dbp3oJhwuVUElgTW+xIIc00KgHhRlm+v6PXDIOhiY0NO29xXHrqTeN/TS71/9lFOVfUOB4ZNkGd69rLAtWOjG8k5EnBdRUDCEbRGacrSIcrsFd59GthxDktZPDfMWt4FMI4i9iQEK7Py2mMlcQ2qqvBk8meliiVvtxgE4ORXm4nWmLOKWaqilGOkCViKBPYwqRrjUFKnTsOUiQtKm3qUCfGTPrtk1ERnRbfKau0pQmvU008DibJULKn1m7cxfpKr7//lAlcUfvvao64SSqrrLHYkPsFbAzpBUAMQLzdqYYK7oWJsP65uA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723471899; bh=sIDWsM22aw+59tskCmH5/gV972fyKWa4DRNkAyooeCj=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=cY15Fip8KeTqTmn3Urbfi5uG02RXiiUzf2m8IU6xKjQS2qd4dteZOHayhiN+Hs6EdojDVOQ95E6FAUj5fv1ywao8ibXq2/t1PA6I1JmuyETnOiDFBj+Cw9EL1kQKTToyatRBJyMujBgyO20sHV+CHMZEHZT3xdwBAHYiYFmagaKuB7RDjkDchjTaXhTPgfnuSBtjo7zbT6V9APfj+o1dKiO8gob0Gya0fB8rMkHINdXBNLFYmR2IeRgNRr4nYFJhquawpwAnvZOswXjB0rUhKlXUM6a0dLKHcfRoLDWQjl3p5pdiMsVCGMMutdYL3CmeCxPJmFZ/hI/yuGaYFwG2vw==
X-YMail-OSG: ZeOBoOMVM1mlapVKkl6VcMzcRFzdOPEh7.3SqgL3IMIFg6iy_1_1SKME8nDYmVn
 GPobULB1.3g70.DeB_Nj7Fa2jRj4YYUZPH8K4i2hJDruCdyTYPyNJO9ifGJOqThQlIsZ8aRIhIxN
 9hymVMMAv5pMczpJDopplNJ28vFlt43fgQnOw56WDbJjDROz_jgR3JNpFOE1oKHh0nyvRmqVm6Tq
 H8PGcLSSm599bScukxQjKMhySK0NEgrWSimxnGQz1nJpdhA.qjr.Yv8OIfZ7Hi7Ox2i_lYpibCGA
 jzXGIFMIB4rwWkKSpeU1DB6c_izaVxFwxD6_ieeW11GNb5ioGvWUbLlNTzuYluaQ3fnHPjwfX8bm
 UcIBqMroDUJhhIe6.Fqm2x2GR0kscYN2kXU_uli3ACFOqFGV4UTdD8vPfJVKRX3vAgqco0pWVhtd
 1wdh6BOaRQFZVmE3gaugizrV4bWiwLJvAPwmokMfTI9j0lDpPv5Y3kk4jM3adhKbhBrTZsqkOrXk
 GaxQRhd7NgPnIOPTlurG_71CRqh5AkXWa5R.kmO3H9VjqqeLqiXZ86LDPhNTW3RBCnlmvpddYFQd
 vL3mQMoYb3XyIR35O4nWiqeMf93tLpS5RxJZ_Mm1MywrKTc1e1Cs6Y9tkDiGpTw6SL9dav6WLqPY
 nWCNaPBGjP8KlEotVHymI7y7R7ozB_JAPRKClg6QnV30nD345dBnhGiu9OX4w.j48NletMF2Bf6k
 Bf3.drBzXq7wHf211SLlaQzFzRgSYnibbCI4iMLeNhRZHv6BMLO81Rh1OSPF1tU3.81kGdQf10nh
 gAUom9.yQJbw98XGwLHGWcVDjqZN8Zz6RKwuAjROiCpRthtEJXo3XxJU0M.M0M0n9C8ni_aYj3pa
 G4Y21_VOFXG.VbjIGu6XGdyFWT8DoWFdyGLDOMkHtONI8w51akXVcvwbMlN_q_xOvIPJ.I8rabC7
 RhiIo2xn4NpqA5PxPPy481QIxkRzssMKksIMOdjO2qbN7Fjr1Fz_cT5N.011QTxQsGdRw3ZNbrlj
 aTfPAmfas3Ca66nyXodTFyKvCB0PYpKgWl2gj9HbgLtQynZeCsY7hyjQq_aO74mG63RU304PF7Nc
 O7a5XisL9Q23mSPp7iEB0mqTWN9PpPgxjm.n4On_lNByUY9HjCmcUNSi83nmGdJ__SM2oSsQQ4RM
 QgaN8ZKBpstjXOsz6zw_Neuogw4jt8EbzMo2qSb6zz502V.EGdLw2FC5EdMsmm2HfD2pgX_PPfAQ
 i6fXnjyH3XMS1mNiu1mgXimXiJ5R_1hfn6BOQVeisi1Bgrn4T.FQ_OTmE2Pl1A6ynlHd6dEI2PRb
 Rwqu7vv9e0mq5FDGTeP1IRM4ceBxPKGFqw.AwnLkcOu3hwVE3TsPks213D9gNT6PK5NAVhCNXko4
 fqcffcbKAgp9a4ARZ9W4AYVLj1sWTx3LsEukkodAL1LIIZKXfUl9_7dIew7SlvUM5Gd.BdLmEWB1
 hI5O1o.VJM5nCwWlwQgpXagTgjOxluJ0LwsLcqd9U1Rrt5quNvQg9BQCdNJitTsOXMzX2XZj3J2X
 KG6lkayCgyNB37Iw.BS82V6LN8vQC66FsYK85i.rITonWG0ofKSDFy1Hun6MbTId9ZJ436Xqot_n
 I1Id_dR8Rc0y3K.wq4vtPr9dAtuKScXajoQOMA9_mB0Hp1rO0o9sHQdwFMrfFwKovNVz_MEKJ_8_
 lunAee3Qdd08Iz4BGh02bj9AOKoF_ol3Br8qEdrY9ozr_pzQgaGVpkeVfeggP.YEvvvbMyHq_P62
 ffj9QURGZkP2Ce68lQ1QG6scNzc0TnKh0hB6HzZ6HO5iA_JcMs0KyfAJRRMk0kDQ5Q5TzUJeEmz_
 fcD8SW9jFOASBpW.ETvyQvLBlF7EfB0GMkdQBZjxDIkvkN8U_5dFczQ9vOpmlMcYruyZ3YwOaiBk
 If33YvyIol7xCyjBaDyYLWwQs7_kqvc.M1eN8kXFDF.IHDne43V5.dvOwGr__98uUcXK_M6S2dUS
 mBGrj2SjLzI1ZsJ2RCgtp_CJHPrDfY9.lto.PgaVzPeY6rlyYyLagDS4mC6NeSLBxoqWo4U9b.S9
 G0TFKsmzfPwrYJCqi10r8c.5pT2I1fICR1V87AUABIQWuzrIgY6k8.I1G40KkXkdXAcHyKFHZkCX
 S0sIwRSYM_eXvi29PG_cO1eBKnQPl9A9PlZ.2q3OA0tKDr2kOT3zPEJRJG5Wp7AdcupOMLsKbEtz
 o1TjO_.3mENyaSPWvEXgyrw--
X-Sonic-MF: <mau.salvi@yahoo.com>
X-Sonic-ID: 4556c3af-61b6-47b8-a221-46c882bfe07b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Mon, 12 Aug 2024 14:11:39 +0000
Received: by hermes--production-ir2-6664f499fc-fnmws (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 32a0ebc1666f761499bb74caed7ace5e;
          Mon, 12 Aug 2024 13:41:10 +0000 (UTC)
Message-ID: <0d9b6cd5-4b95-4b28-bf06-9e98d7d6310d@yahoo.com>
Date: Mon, 12 Aug 2024 15:41:09 +0200
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
 <9d5bb262-0646-451e-a5af-82c0473a3003@yahoo.com>
 <035a65bc-c064-40c2-9fcc-b3fd6104a233@siemens.com>
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
Content-Language: en-US, it
In-Reply-To: <2e779a4e-ce60-4487-9dbd-7d40726b2d9e@yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22544 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 06/08/24 09:33, Mauro S. wrote:
> On 05/08/24 23:41, Jan Kiszka wrote:
>> On 05.08.24 16:40, Jan Kiszka wrote:
>>> On 05.08.24 16:28, Mauro Salvini wrote:
>>>> Il giorno lun 5 ago 2024 alle ore 14:10 Jan Kiszka
>>>> <jan.kiszka@siemens.com> ha scritto:
>>>>>
>>>>> On 14.03.24 15:22, Mauro S. wrote:
>>>>>> Hi Jan,
>>>>>>
>>>>>> finally I managed to have a piece of code that makes the issue
>>>>>> reproducible. It's not exactly small, but not too big either.
>>>>>> I hope that this makes the issue reproducible also on your test 
>>>>>> system.
>>>>>>
>>>>>> The zip contains:
>>>>>> - a little main program (test.c)
>>>>>> - a little library (in mylib dir). Some pieces of code are never
>>>>>> reached, but leaved to avoid potential compiler optimizations that 
>>>>>> could
>>>>>> remove other relevant parts (maybe cycles?)
>>>>>> - a script (build.sh) to build the two components above
>>>>>> - a script to launch the test (start-test.sh)
>>>>>> - the configuration of the kernel in use
>>>>>>
>>>>>> After building the program and the library with build.sh, you can 
>>>>>> copy
>>>>>> on the target:
>>>>>> - the start-test.sh script
>>>>>> - the built program xeno-test-session-hang-on-exit
>>>>>> - the built library libmylib.so.2.0.0
>>>>>> and create the library link /usr/lib/libmylib.so.2
>>>>>>
>>>>>> Start the test with "./start-test.sh &" and follow what happening 
>>>>>> with
>>>>>> "tail -f log.txt": after a time that varies from a couple of 
>>>>>> minutes to
>>>>>> 25-30 minutes, the log should stop on "~~~~~~ RECEIVED SIGINT ~~~~~~"
>>>>>> line: the hang is happened.
>>>>>>
>>>>>> A small recap:
>>>>>> Atom x5-E8000 CPU, Linux 5.4.255 with Ipipe 15, Xenomai 3.2.3.
>>>>>> GCC compiler used: 9.5.0 from Yocto Dunfell 3.1.22
>>>>>
>>>>> Can you only reproduce with this setup, specifically with this 
>>>>> compiler
>>>>> version and only on real hardware? If you rather use xenomai-images 
>>>>> and
>>>>> qemu/kvm target but still the same kernel and xenomai version, the 
>>>>> issue
>>>>> does not occur?
>>>>>
>>>>> I'm trying in kvm right now, also with different compiler. Iit 
>>>>> would be
>>>>> good to align / rule out variables if my first setup turns out to be
>>>>> unhelpful.
>>>>>
>>>>
>>>> Hi Jan,
>>>>
>>>> Sorry, I never tried on an emulated system like qemu, I did the tests
>>>
>>> qemu/kvm - that is CPU-wise not emulated, virtualized. It generally
>>> gives similar execution patterns as on real hardware.
>>>
>>>> only on real hardware (using different samples of the same hardware,
>>>> just to exclude hardware problems).
>>>> I can do a test with Xenomai images on real hardware if it would be 
>>>> useful.
>>>
>>> That would already be useful to rule out the toolchain as contributor,
>>> yes. When at it, testing in qemu-kvm would also be nice.
>>>
>>
>> FWIW, I've pushed ipipe-core-5.4.281-x86-16. It's not that I expect
>> positive impact on your issue, but you never know (until you understood
>> the actual root cause).
>>
>> Jan
> 
> Hi Jan,
> 
> I've seen, thank you.
> 
> I will try xenomai images on real hardware and I will back to you with 
> results.
> 
> Thanks again, regards
> 

Hi,

first results after some tests on real hardware:

- xenomai-image does not show the problem
- xenomai-image started with my custom kernel instead of the 
xenomai-image one does not show the problem
- I didn't manage to run the xenomai-image kernel with my rootfs yet (it 
does not start, but at the moment I have a headless system and I'm not 
able to debug it)

While waiting the verification with xenomai-image kernel with my rootfs, 
could we conclude that the problem lies in userspace then? Could be the 
Xenomai config flags? Or the compiler version? Do you have suggestions 
about other tests to run?

Note that the test binary is always the same in all scenarios, built 
with my toolchain (that is built by Yocto), and my rootfs and 
xenomai-image have both Xenomai v3.2.3.

Side note: xenomai-image still has 5.4.228 kernel, maybe you didn't push 
the upgrade patch to 5.4.281? Anyway, it seems that does not matter.

Thanks in advance, regards

-- 
Mauro S.

