Received: from sonic309-25.consmr.mail.ir2.yahoo.com (sonic309-25.consmr.mail.ir2.yahoo.com [77.238.179.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AF01C0DD0
	for <xenomai@lists.linux.dev>; Fri, 29 Mar 2024 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.179.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711729018; cv=none; b=YI/CKmpe8kvH7rsm/nrHbvNbyF0B5dcm2BQ4nhtZMUxHOZxUD/M82umDeaBgR48FR8dis68gDmvGt4h4fzcbr+dqfao+ejOvjKUBf2ghaafsouF+5URbTXbQBzmPzavv5cGfORkwxD0YZbNHmyV+p5/uNc1Ej/nWV822ZpmH/Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711729018; c=relaxed/simple;
	bh=Nw1GZSv0oRWoHvw3rPp9jiiEMr1quXSjz1JTG/fm6HU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jfXrDKVM2RDxoomBtBmsnM0PAd8PR6zvjfPIRqPSSS0+yT6WYNrcPRHUWA+kQEpcEyUTeQuCmwF01JdjncT3/0+kGwMCEHNLyoL52Z3NiMdys/4yVPBgcNEATJe8cz16bIhUpAm3VTJM9XOA4o4uOxrAoDQSwCJu4FViEcb6Poo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=HZJLQCy4; arc=none smtp.client-ip=77.238.179.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="HZJLQCy4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1711729014; bh=DP6kfDfWlbARNuh88g3WvTwC+kqe4Xik9MfwYPD0Dfw=; h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=HZJLQCy4PjLOHPs0S2/PGIs8+9Hyhvo4zrpsyso/ilZGGp72uTtnxVf2rXmTFUkxvvrKwfXwSixirQ/LJXGMviY+0YX2jt61ZpIelpKT6BnLApvABSwhesORgZ7S9e2XTJnhHR6PZEc25OX3TCa7Gq27xjG1T0S8Sf8lb8gwYl9AjjXWQcMbeNMTAUXmu9P2krO/HvPVFQzTTzjbmfC9A2x/UmE+KaTFxKeWTJb7MH9QjayLIBBeYovXp1Hd/e0hbi0j85cUjYUAOOChVjqSrvcd7OG9lguUs3VaSvT3480k0d+a+F1oYrYEKd7XtmZMjZX0PZjTDoBE8zzN+JhlbQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1711729014; bh=dLcy4CCPLs4sVCNCzP9v6WBzV22oG/dpqEjTA/u71Jx=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=C//VpRAWZOZhrZsh8yRXxUFQKNhEFfI5wRBDfDBAdAs3ycPAB/t18T5+fooHaSX+NOIFEUte6NvorjfZJ7rUHGu9I8Qi2wqkdJQ3DV9HINiq2QPDzDtXtxi9zdCDwIIySl1FwddhyWww3yM3TQOva/GYyNWM3rRGu1Qeg22lHUcME2j5YbwB4/dmIU09JO4BITTsgFW034z7z4rxA9dXCZzN3DrWd3/kAhkt65erXWAs4D5Jq1Aaps8q4C6cv5QepZf8khLNERLF2YCma9GpLU4qxBzP8DsP0EuVAlRFgeBpIN4GG6+HwyDHhgxrq6OLaqDriQwQ4O5AGaiYJgjl5g==
X-YMail-OSG: WHqFeZ4VM1kG6M.zxJ_WydIRh2Lcts1hIjtIVq9iM9jguUAqPcOvW5yWoUxyOK_
 KZimfVMmOGr2lBH51M5qrbrnVVvZw8mVv83hPgZW0rrBVM79Si9dqOOCyJmSwEfcss_ExEW9eb75
 TeeIq5ct_Ngo6wTR9JjLwCqARFi48mgeoAatNZMKXiVYNYRMOYeuAu7FmNIdcwo4S5HXkRawZC0J
 b6P9N3NRO464D3DsZjY6yEFMwi2R5dWBHehzKfhf1TZzb65sg7GqKuNnHhEJj9rLu_Vm1RlV8Rwt
 fZuAh_PItcsT0ZEzijheO1bYolBDg9QhKKnrbYx5IjjA6OCJSdwtlHS2MC2lMRiqe_KjUSBx9T43
 Etgp7Y.GjlqwnpcTaw7WwBlkJ1qvK38CDm.kOePn9kaG.blZCcqg5_eE4cVrPvRDGErUWDJcbljl
 4ewhPADzEfJ5SJxPMYoFLwMQjtURmwti8q.jp_OX5Kj_nivDY5CnT67sOkX.Oz62jS1T6Qv1uq4B
 c8ItkeGyuqkcUGaEYCgsqoboeu_CyPCRpEF4i8qNXVSNWE7WYywLoAZuvE8LYVpdkzgjiT.L_njd
 45AJS_GxuG1yHh58rrxEeGCv7oTTx7ddfpqbbIVuv5cPl13q9nhr1rkWzIoeyqcLsDG6PWbOBf1r
 l1cWsG6s9OtBbCN3wFEfPx_qY.9ajkMLipA.Olih3UsgLKz5tk68J.jsli1iSRq2hqiwqB4M_xa6
 kCiWfz3oY2o2q1ahhtMb5sTRGqwmoxKsaA99EKiM5aFyoXU_x2sbJq17HbHoTE.jHLMlLyWxITPI
 C1vt.BF3Gsm2FDXgmawjLeGiIUIAg.eX9D3NuIBSWFJ_Hnbtq8E6OyjTu262t8MrFCJ_8J2mz86s
 dZ6ssg9hPZ1V.daTpPNcDWkRLw4le0usrQFtwE30qdXihCUWSS2_t2_yDSLZRAYZStP63I4JP2lT
 kinL9KPfIInR6n6wqzuJO_6QcHFIHL2hV5EFLLr1sSem42nhvDy2Hw6nMCjwHxOeBCxejH_ZGszJ
 ePC9_9LLqgILbzX2cEZjTl3MUf7KDlC.LdqABYy_3_O1P1gnzG8xtb6TGCypzeF7h6HKKjgCfgBG
 KRbRBGK2QY_R.SVCKRaFNZxMX7xLN90o0G_tqkvUBcCfjlnj0_4ftdFJYZyqoJhrx3_xAH8.hKUT
 Pd0bxdetOommPCWBRQBCLFmogd4popuycWetdpGq9W4Sc0HROiFI8L1Nw.M9E3COQhZ221nh80tk
 4JlPVr7R3LMB3dBv9qS5Yu4jnpxKvJ0lPnV_gbxOMSbOhFfcD4QWHfxFRu6pNwYN.TVqs.NSL2JS
 3Ko.N65di0ZFW4gnL62ufRXl.g9BL6dFTGL.4DtRubAGDWaW2xaNNSEZ7yLjBDL0SGpsRXdurepS
 Yl3LvD7T7nthVSMQ5BV6MoHNFo0OwOv1YXZEd7V6lgp.cAosax_4T8EGodw_xKhtYVaKHBoLM07a
 M_kXGM8YKiiigmP_n6Z4YO6h82TdTkahScKqEpZYekJRmZtamXZGV.jfdMPNBgC.c4q9oqBhQOGK
 uc.Ko86LJnQg9jx2G7SU3QW4WyYNPvGfyDkrDk4BpP_CnFYm2ScYZnXTLkAgWWAg6HS4UAuRUevX
 sRFUHSaby4b87r_IjODqrCLcW9qFpP_DloDb_MraibdbIxbty37WXSCtCYPHHokgExJcReZMRMw7
 jHkZn2e.fkhD1CR.YahatnHpx4HJxSJFugJ6nrKKq_qMjpgZTTiJQZTB3v.rAtLAWw_cUvybFCme
 A_owUYhXP_.rIBGa5Mhd9zl_S8dP3mLxbP6LcoSSdSfxwoIvJhM3YXt8P2ia_lo3IX7v1ftR3MYP
 is56NJ814BfSxRSQ0AP3kWr6LbKKY970Jpf_pVIIi0vp3AnbrZnNTQFSMYx3UmTlF4VoL0ylvPkT
 LuPv2sDhoso_0L0aMh43qpUHd.jKyUQ2AdwkWMs9.NObWjOhE.59MswsEkvOTcoNNtBCr_6AVDME
 3bsAlQ2wG9z8JXpBpJarVrp7CVlqB4Vpuf10JHLKZkx0KKIM4kkgr8zQScpGTiknWoXQCpalEMvj
 Gt3jSA5TxLc.wS5at4ieycx0HJB01b4QQVQPG4jqggcpgSwdaejK.X8BQtkTg892y3dBxpMGedTy
 NGdNJ6irvwS_rY7lH1vAg6lDEJdjfAoUTOXcgCZT.VRTcI4MpmTnEr7UgwCowSbc3q.Qc4YkG.O8
 Mcw6eqVs-
X-Sonic-MF: <mau.salvi@yahoo.com>
X-Sonic-ID: 917043a5-ebd6-4687-b572-36389c97d35f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ir2.yahoo.com with HTTP; Fri, 29 Mar 2024 16:16:54 +0000
Received: by hermes--production-ir2-7bc88bfc75-rtc5j (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID bc4be16a2bfeaaad360dc5ac833afe0e;
          Fri, 29 Mar 2024 16:06:44 +0000 (UTC)
Message-ID: <89ad3b15-7fe7-44b2-8719-02dc8425ecfe@yahoo.com>
Date: Fri, 29 Mar 2024 17:06:43 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Process stuck in cobalt_monitor_enter
From: "Mauro S." <mau.salvi@yahoo.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
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
Content-Language: en-US, it
In-Reply-To: <e5efbf9d-9054-46d3-8deb-aa321146068e@yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22205 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 14/03/24 15:22, Mauro S. wrote:
> On 02/12/23 01:37, Jan Kiszka wrote:
>> On 02.12.23 01:31, Mauro S. wrote:
>>> On 01/12/23 02:31, Jan Kiszka wrote:
>>>> On 30.11.23 00:24, Mauro Salvini wrote:
>>>>> Il giorno mar 28 nov 2023 alle ore 09:39 Mauro Salvini
>>>>> <mau.salvi@yahoo.com> ha scritto:
>>>>>>
>>>>>> Il giorno mar 28 nov 2023 alle ore 00:15 Jan Kiszka
>>>>>> <jan.kiszka@siemens.com> ha scritto:
>>>>>>>
>>>>>>> On 27.11.23 22:02, Mauro Salvini wrote:
>>>>>>>> Il giorno mar 21 nov 2023 alle ore 01:06 Jan Kiszka
>>>>>>>> <jan.kiszka@siemens.com> ha scritto:
>>>>>>>>>
>>>>>>>>> On 20.11.23 22:23, Mauro S. wrote:
>>>>>>>>>> On 13/11/23 18:54, Jan Kiszka wrote:
>>>>>>>>>>> On 11.11.23 16:03, Mauro S. wrote:
>>>>>>>>>>>> Hi all,
>>>>>>>>>>>>
>>>>>>>>>>>> I'm using Xenomai 3.2.3 on an Atom x84_64 with a 5.4.255 ipipe
>>>>>>>>>>>> kernel.
>>>>>>>>>>>>
>>>>>>>>>>>> The application I'm running (a complex application, with about
>>>>>>>>>>>> 60-70 RT
>>>>>>>>>>>> threads) has a simple loop in the main function, something
>>>>>>>>>>>> like that:
>>>>>>>>>>>>
>>>>>>>>>>>> while (stay_in) {
>>>>>>>>>>>>        ret = rt_buffer_read(...);  // with 50ms timeout
>>>>>>>>>>>>        if(ret) do_something
>>>>>>>>>>>> }
>>>>>>>>>>>>
>>>>>>>>>>>> The main loop reads the buffer to receive some commands from
>>>>>>>>>>>> outside,
>>>>>>>>>>>> and when the application gets a SIGINT, the custom signal
>>>>>>>>>>>> handler simply
>>>>>>>>>>>> does "stay_in = false" breaking the main loop, and then the
>>>>>>>>>>>> program
>>>>>>>>>>>> closes.
>>>>>>>>>>>> During normal running, I can see the timer associated to the
>>>>>>>>>>>> rt_buffer_read() timeout get fired and reprogrammed, calling
>>>>>>>>>>>> multiple
>>>>>>>>>>>> times "cat /proc/xenomai/timer/coreclk" e.g.:
>>>>>>>>>>>>
>>>>>>>>>>>> 0    291/290         2ms970us           -           myapp
>>>>>>>>>>>> ...
>>>>>>>>>>>> 0    609/608         34ms860us           -           myapp
>>>>>>>>>>>>
>>>>>>>>>>>> I also see the thread in "w" state (waiting for a resource
>>>>>>>>>>>> with timeout)
>>>>>>>>>>>> doing "cat cat /proc/xenomai/sched/threads":
>>>>>>>>>>>>
>>>>>>>>>>>>      0  16328  rt     cobalt     50   21ms279us
>>>>>>>>>>>> w          myapp
>>>>>>>>>>>>
>>>>>>>>>>>> Sometimes, in a non reproducible way (at least for the
>>>>>>>>>>>> moment), when the
>>>>>>>>>>>> process get the SIGINT it never exits, remaining in this 
>>>>>>>>>>>> status:
>>>>>>>>>>>>
>>>>>>>>>>>> /proc/xenomai/sched/threads:
>>>>>>>>>>>>      0  16328  rt     cobalt     50   -             W
>>>>>>>>>>>> flxcore
>>>>>>>>>>>>
>>>>>>>>>>>> The state becomed "W" (waiting for a resource without timeout)
>>>>>>>>>>>> and in
>>>>>>>>>>>> fact the remaining timeout is not present in the row, also in
>>>>>>>>>>>> /proc/xenomai/timer/coreclk:
>>>>>>>>>>>>
>>>>>>>>>>>> 0    291609/291362         -           -           myapp
>>>>>>>>>>>>
>>>>>>>>>>>> (BTW, seems that some timeouts got lost, because scheds are
>>>>>>>>>>>> many that
>>>>>>>>>>>> shots, and this happens also on other timers in coreclk)
>>>>>>>>>>>>
>>>>>>>>>>>> This is the backtrace in gdb:
>>>>>>>>>>>>
>>>>>>>>>>>> #0  0x00007f5b15bb05f7 in cobalt_monitor_enter () from
>>>>>>>>>>>> /usr/lib/libcobalt.so.2
>>>>>>>>>>>
>>>>>>>>>>> This relates to lib/cobalt/internal.c, cobalt_monitor_wait():
>>>>>>>>>>>
>>>>>>>>>>>            /*
>>>>>>>>>>>             * If we got interrupted while trying to re-enter the
>>>>>>>>>>> monitor,
>>>>>>>>>>>             * we need to redo. In the meantime, any pending
>>>>>>>>>>> linux signal
>>>>>>>>>>>             * has been processed.
>>>>>>>>>>>             */
>>>>>>>>>>>            if (ret == -EINTR)
>>>>>>>>>>>                    ret = cobalt_monitor_enter(mon);
>>>>>>>>>>>
>>>>>>>>>>> But the problem is that the lock (monitor) is no free. Someone
>>>>>>>>>>> else
>>>>>>>>>>> holds it, and your interrupted reader does not proceed.
>>>>>>>>>>>
>>>>>>>>>>> If you dive into mon at this point via gdb, you may find the 
>>>>>>>>>>> owner
>>>>>>>>>>> (according to libcobalt's view) when you resolve manually what
>>>>>>>>>>> get_monitor_state() does.
>>>>>>>>>>>
>>>>>>>>>>> Jan
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Thank you Jan.
>>>>>>>>>>
>>>>>>>>>> I rebuilt the Xenomai libraries with debugging symbols enabled.
>>>>>>>>>> But when I try to print the mon variable, I get
>>>>>>>>>>
>>>>>>>>>> (gdb) print mon
>>>>>>>>>> $1 = (cobalt_monitor_t *) 0x7f3cb524e62c
>>>>>>>>>> (gdb) print *mon
>>>>>>>>>> Cannot access memory at address 0x7f3cb524e62c
>>>>>>>>>>
>>>>>>>>>> Seems that the memory address is not in the core dump, but I'm
>>>>>>>>>> wondering
>>>>>>>>>> why
>>>>>>>>>
>>>>>>>>> Did you create a core dump or tried to attach live the hung 
>>>>>>>>> process?
>>>>>>>>> Maybe the former was incomplete - for whatever reason.
>>>>>>>>>
>>>>>>>>> Jan
>>>>>>>>
>>>>>>>> Sorry for the delay, but every time I modify something I need to 
>>>>>>>> wait
>>>>>>>> for the issue to arise.
>>>>>>>>
>>>>>>>> I'm working on core dumps. The previous core was incomplete, as
>>>>>>>> you said.
>>>>>>>> I needed to set the coredump_filter kernel cmdline argument to
>>>>>>>> 0x7f to
>>>>>>>> have the complete coredump.
>>>>>>>>
>>>>>>>> Now, I can see also the values into the Xenomai lib memory space:
>>>>>>>>
>>>>>>>> (gdb) print *mon
>>>>>>>> $8 = {state_offset = 1047984, flags = 1, handle = 44}
>>>>>>>> (gdb) print *(struct cobalt_monitor_state *)(cobalt_umm_shared +
>>>>>>>> mon->state_offset)
>>>>>>>> $9 = {owner = {v = -2147483638}, flags = 0}
>>>>>>>
>>>>>>> This is 0x8000000a, XNSYNCH_FLCLAIM | 10 (see also xnhandle_get_id),
>>>>>>> thus 10 is the owner. Unintended recursion?
>>>>>>>
>>>>>>> Jan
>>>>>>
>>>>>> Oh, yes, my bad: I have seen the xnhandle_get_id, but not considered
>>>>>> that atomic_t is treated as a 2-complement number.
>>>>>> Then, the owner is the caller ID. I'm wondering how it could be a
>>>>>> recursion: the main thread is a simple while(..) rt_buffer_read(..);
>>>>>> I will investigate a bit more on it.
>>>>>>
>>>>>> Thanks.
>>>>>
>>>>> Maybe I found something: in the backtrace of every core (cores are
>>>>> generated with SIGABRT) the first two frames are referring both to
>>>>> cobalt_monitor_enter(): frame #0 is at the source line where the
>>>>> program is stuck (syscall), frame #1 is at the cobalt_monitor_enter()
>>>>> function declaration source line:
>>>>>
>>>>> Program terminated with signal SIGABRT, Aborted.
>>>>> #0  cobalt_monitor_enter (mon=0x7f0d7583862c)
>>>>>       at
>>>>> ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/cobalt/internal.c:218
>>>>> [Current thread is 1 (Thread 0x7f0d7628c400 (LWP 2751))]
>>>>> #0  cobalt_monitor_enter (mon=0x7f0d7583862c)
>>>>>       at
>>>>> ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/cobalt/internal.c:218
>>>>> #1  cobalt_monitor_enter (mon=0x7f0d7583862c)
>>>>>       at
>>>>> ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/cobalt/internal.c:186
>>>>> #2  0x00007f0d76612748 in cobalt_monitor_wait
>>>>> (mon=mon@entry=0x7f0d7583862c, event=event@entry=0,
>>>>> ts=ts@entry=0x7ffe7d7380f0)
>>>>>       at
>>>>> ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/cobalt/internal.c:276
>>>>> #3  0x00007f0d76639497 in monitor_wait_grant (current=0x7f0d75842bc8,
>>>>> timeout=0x7ffe7d7380f0, sobj=0x7f0d758385f0)
>>>>>       at
>>>>> ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/copperplate/syncobj.c:553
>>>>> #4  syncobj_wait_grant (sobj=sobj@entry=0x7f0d758385f0,
>>>>> timeout=timeout@entry=0x7ffe7d7380f0, syns=syns@entry=0x7ffe7d738074)
>>>>>       at
>>>>> ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/copperplate/syncobj.c:553
>>>>> #5  0x00007f0d7664c691 in rt_buffer_read_timed (bf=<optimized out>,
>>>>> ptr=<optimized out>, size=<optimized out>,
>>>>>       abs_timeout=0x7ffe7d7380f0) at
>>>>> ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/alchemy/buffer.c:555
>>>>> #6  0x000055b104840601 in rt_buffer_read (timeout=50000000,
>>>>> size=19216, ptr=0x55b104844180 <Request>,
>>>>>       bf=0x55b104844168 <ReqBuf>)
>>>>>       at
>>>>> /opt/sdk/3.1.22-2.0/sysroots/corei7-64-poky-linux/usr/include/xenomai/alchemy/buffer.h:129
>>>>> #7  main (argc=<optimized out>, argv=<optimized out>) at main.c:410
>>>>>
>>>>> Could that be a clue?
>>>>
>>>> That alone does not tell a story. We know now that - at least according
>>>> to the monitor data structure - thread with ID 10 is holding the lock.
>>>> If the very same thread is trying to re-aquire it, this will cause a
>>>> deadlock. And if that is true, we need to find out, how that could have
>>>> happened. I have no idea about that so far.
>>>>
>>>> Would you be able to factor out a simpler, sharable reproduction 
>>>> case? >
>>>> It also looks like as if the reader is receiving some signal while
>>>> blocking. Is that expected based on your workload? It may destroy 
>>>> timing
>>>> constraints, even without the deadlock.
>>>
>>> Yes, I think it is expected, the workflow is the following:
>>>
>>> - a daemon starts the program
>>> - upon an external request, the daemon terminates the program sending to
>>> it a SIGTERM. I think this is the signal received while blocking
>>> - when the SIGTERM is received (a sighandler is installed by the main
>>> thread), the main loop (where the rt_buffer_read() is) breaks, and the
>>> program performs some cleanups and then exits
>>> - in 95% cases, the program terminates well. In the remaining 5% cases
>>> the program hangs on rt_buffer_read()
>>> - if the daemon detects that the program is not terminated after 30
>>> seconds from the SIGTERM sending, the daemon send a SIGABRT to generate
>>> the core we are analyzing
>>>
>>
>> OK, makes sense. Based on this description, we may indeed have an issue
>> around Linux signal processing here. Now it's about making it 
>> reproducible.
>>
>>> I'm trying to reproduce the issue with simpler programs, but without
>>> success for the moment.
>>>
>>> I will update you (hope with better news).
>>>
>>
>> Thanks in advance!
>> Jan
>>
> 
> Hi Jan,
> 
> finally I managed to have a piece of code that makes the issue 
> reproducible. It's not exactly small, but not too big either.
> I hope that this makes the issue reproducible also on your test system.
> 
> The zip contains:
> - a little main program (test.c)
> - a little library (in mylib dir). Some pieces of code are never 
> reached, but leaved to avoid potential compiler optimizations that could 
> remove other relevant parts (maybe cycles?)
> - a script (build.sh) to build the two components above
> - a script to launch the test (start-test.sh)
> - the configuration of the kernel in use
> 
> After building the program and the library with build.sh, you can copy 
> on the target:
> - the start-test.sh script
> - the built program xeno-test-session-hang-on-exit
> - the built library libmylib.so.2.0.0
> and create the library link /usr/lib/libmylib.so.2
> 
> Start the test with "./start-test.sh &" and follow what happening with 
> "tail -f log.txt": after a time that varies from a couple of minutes to 
> 25-30 minutes, the log should stop on "~~~~~~ RECEIVED SIGINT ~~~~~~" 
> line: the hang is happened.
> 
> A small recap:
> Atom x5-E8000 CPU, Linux 5.4.255 with Ipipe 15, Xenomai 3.2.3.
> GCC compiler used: 9.5.0 from Yocto Dunfell 3.1.22
> 
> Some potential interesting things:
> - seems that application arguments "--session" and "--cpu-affinity" matters
> - seems that compilation flags matters
> - seems that splitting the code in an application and a library matters
> 
> Thanks in advance, regards
> 

Hi,

kind ping about that.

Not to put0 pressure on, just to know if the problem is worth 
considering and will be examined or if I have to make my workarounds 
definitive.

Thanks in advance, regards
-- 
Mauro S.

