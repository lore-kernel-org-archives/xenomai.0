Received: from sonic310-11.consmr.mail.ir2.yahoo.com (sonic310-11.consmr.mail.ir2.yahoo.com [77.238.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC0E5D8E1
	for <xenomai@lists.linux.dev>; Thu, 14 Mar 2024 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710427393; cv=none; b=knFHZspJ112F3UQbUaAja0dNpcn8e352Bxr2Hcar/LT/J0gwj7WecnH94aYcKcIx1lLWv38pla2+o9GFknGneX3CS7bty93lwG4/GLforvYM9ckxoqgvnouuTVxB65su6WWRc3ffQlWzEhsH5e0BY968fyfY0P3lunEbRcEErbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710427393; c=relaxed/simple;
	bh=tf0X5nrhWvCYElrK5zBgnfuOrdHC/BpsBllGXJDhvus=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:References:
	 Cc:From:In-Reply-To; b=h9dVzvhO3U4Q/EBC7sem46yvQ/tnlmQqiwVAq42jLVuXCLxyz5jwxX7gaWMvkxbMIat0cZ/cjuebwdf6AyQQ+v8r5Kf639aYp7OTuS4dLZWOUdLBNprFcB9f+JWpr6QJdF5i48UEztQUHskFGqE2e/GwuvjJfvXRyE+vmOb7xhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Bwe7JYXz; arc=none smtp.client-ip=77.238.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Bwe7JYXz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710427388; bh=yPa7iD44XChMEY6b7pHeN+8ExE8kuQ5mGT/52TZPZXk=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=Bwe7JYXzCTRVtAWpkSqTTsQDroh2PCgG3nwWZhjbdpCInkY+KY3YjGOcZYi2IlZgVPWwBn9Z9KEwshHa3YFKLRrd4T1IDeNR6x2vloraZ8Hks+oqhhZKFYxAbAds+J2iWf+Xdh06ftDXFKIheRBssHTOzNsIXKh7QMbMIi/S5uPlps6aIT3Utclhozz5ENiCbGlXaJ7jyEOrcGW10rVxrDO9cVipjt8I1XsKYuQrFSNJitA0zVfbSkXLxUdevbf2CFjq23xcGrnivfXRxSEuZCTu8+FSi6+pLZpZGJ5gfEoLeOI9Yy+8UgRpanez43VemEbhh96BnrLkchQmzBWB1w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710427388; bh=ghfloldlsc8pqBrGiuVrXDYuqaUmKwJQ4hnWV9Hu+so=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=EOuE24oJDswOGCf5YYKEa4uk4IODP7XQsJJqjr+b2qHDoxgWGqAAqd8Jy31L94f7JSjAYMuCN4ZBI48dxAEXm0BGSCMIK4FdN8bmUJ6hQnd/V8waEvE4eXWRLJ8m+utkii2zJ8AwYXUaB4JNZ/a/sEKqoN663HhWpFEgq9rB8dSt85zbBjzGpGqxk4Ikk+Mi8XSl2ii3dyzyB+Dm8BMrdSEZ2Fy4szrqWiWJV0WTwxomWL4yXJh6OUZ1n79QUusC7L/YYaORB9PFiLA8fbEIgBny0rPstASN6fZzx4HSzrr21Lm0CelL2NeEXv877bq9Dd7H57KPUZKhSI+JOodzmg==
X-YMail-OSG: 5LtIOScVM1kTpKjmsLZMQ.SB07NapS3_mfOKkD4fopcDqMLtxp7UCaBHbTWtbs_
 M1D0JtnTDkwnO_sWYa9yaV5VEA7mGbfgZ0oewokTgUhfd7AJQ3tfPaVSDelIVDF.d_8EeEUUeje9
 LzXMcHGMsH1h_iQgiFccejgAWWQ5epVSpppQxXmVLK6j.jq1iWzIN3cMrLtyJsJ230Pi2.EbuR5u
 FNM0_02lxKWYkMvdcNLTt8yyUzHmtmFODryDkmOAj0QB.eJZTn_6kZtQi7LL6HgawKcwIVtE_n1u
 glNqO1Lm5LzRpb1i2w_z8lbPSg9qituAz.XEYWf.yYQSwvHmk1mbhc9WPQMPEjQgpq3Y6tzdd9y0
 6uFo1UZvhccia.G77jYUa7_amNerXkr9Rw8.07j4eo1YUasg7bQNZ5FKi2r_g8rQXCRTC.nQn2AZ
 IBquZBSysBYP2iUK1f8fQG0UtpQrdH6.MOr_2PEGXwTyK4NORiX2qqiy6QIDMSCjYO5nRZEWBWt8
 Z87_VB7LIuEdMTgITCgU2Q3WmR8BQCfMkeU.CAXiqN_8Jb2VZOIB_n0gDTKbKbjzVy5x74QNhgVV
 nvLv9H_55njULnXremsK26K2lTnTV2TzFroHJ_ugeqzYaz1ycHbsADrZ52FmGDlU8XsFYHPQfsb0
 yWKUQoFlRYSmUI3vhinJGrLBd6q9XVxsUrdaBW3dStPaTyyeVOc0ODyGTvxSeAyKSDy1Dbbe._gB
 h4O1Ak32_ZkL7Gmo2rZb.QxIRPXabUy9l4pqAYnk2xEotWYZjApvl1Q42GPGAgzHXEqe05UpsXJJ
 CqkJiyZzcCXiJiteqxKd80Vb.wYRX8NSk1Wt4fC61LxYgQ8I3fxO1UutP7z.RRbPBYByOcG3W4cl
 z4gajuH_pJ7dpbF0q4.lCQSYTMiBT49a8PODCPijKtjC5IThE5_Kgl9wppYohLqjFgEO5eEOg5MP
 AWFw4DsTt.r1547cCXXOuazKSU_S6P24.wl.aVRvnvzha6eSf_TprL_TF0M6YJ6FFdq8yVeG4u7F
 Vl7ZtmhyvoFcv9fodVPx35Cd0pgCgjrkyxSTmKPl5N96CrImvq6tQAP6Zqt6d4XLd5IJI4F634zg
 vpJqk8moaazom1sBxF5W50tV8f8tkR55arE6C_doK4jBIEz8FLoWuuaRP4mhoPRFS6JHNsiGsM9N
 .76z87o7oPnVkEoHjHGSfGknG.vxyYbi95U1puDnyGUl5LAAIct.BIPHpNlGhtjB_Ygk9oeUstVZ
 pEbmziC8dekLJfirshm8obAdI8emD2.R9wJRvpxqhzC3lQmTI_h6ZIhLxTueRAQm3tGcM03NuCWQ
 T5pm_UHvBlB2cjYGrVXBIXSm6mzpg4y3vMrsY5mD8ogyOzqMe3JQUyTkeJanQL1q_udg1ufUo_g4
 iankR83iiHJBIlG1UYoTDD2vGqoddlXWtAxvEpN82ZZZeoD2g99F9bbx8X7WbL_MORB_2StTsGN8
 TIdkIatOvQMK79f5bTc6bBVVl08JVyo1qA.oI3q4CKBRiFIOKFXb1BeFKCQJIdDriIeFAY9.Vcxs
 tzhju4SHuRIonazEZS7iDjj5DvBJkvk3EfMvzRyQq0EbOnhHLO2kf.ZMVBGqW.lF1azvxlo696zG
 U3yu.pFnBgiL8Ht9bAlXGbGfBvl6l6BV8w_fvIMWP_.YaaCubsIVhAHa2lNDXXwZatwFfYadLl12
 _71mj2QvbHgaw7tMALC.0_9xIUEtYs8pcDnb5oTCuylRVJirJjsH_qXo8MxwnO44IHjT2gJTO5t0
 tBX5fK75G7oGBZq4e8ss7Kqgl5LVwMCX5eNVu9GueLJH1z9ckXpNc9MHSH1to1RrJhyhET3FfctY
 ymNkS_KNqYjZpt8ismwoH8t7vRyrcZtc846OibTIDuYFjtkWavn_YprBS_DrsQHEzaP.YcRXyj8N
 _os2oZJa90zMXwbKd8nUJloay2PDWVnxobKhA46gwJ4c4tN3jtpM7HSgCaXkZ_YBpGO51R2OaC.S
 xSL3pjhOc_ETJW5bza87p7mbEFqawsxO5LPUafZHmYLENndbfaxSj.R2WdwWkE5pOex7p5FyqylG
 JOvQGTUVshjqCGLSfn9MfBiczXA_NKg2OxTjWj2NmHLWGCGoTNaEgHAGaafQq8Lav2A_cy5bjrOY
 jqP3uRLEzkncYfIDQcEO5mPa.8LQLnGVetdtuW3cy7uXUIvaiki_l0B6DZiJpx5qCndAdTv0BakJ
 q0Y3IthI-
X-Sonic-MF: <mau.salvi@yahoo.com>
X-Sonic-ID: 3e9d7d81-2a23-4db1-9f1b-d6af9d598828
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ir2.yahoo.com with HTTP; Thu, 14 Mar 2024 14:43:08 +0000
Received: by hermes--production-ir2-7bc88bfc75-fzfp2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 199452506f0177c74d5ac73412ecc1e6;
          Thu, 14 Mar 2024 14:22:50 +0000 (UTC)
Content-Type: multipart/mixed; boundary="------------NBdcYoS4qblyY3pn8EDsqIg8"
Message-ID: <e5efbf9d-9054-46d3-8deb-aa321146068e@yahoo.com>
Date: Thu, 14 Mar 2024 15:22:49 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Process stuck in cobalt_monitor_enter
Content-Language: en-US, it
To: Jan Kiszka <jan.kiszka@siemens.com>
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
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
From: "Mauro S." <mau.salvi@yahoo.com>
In-Reply-To: <bea3518e-5d72-4a86-a5b9-ac71a59c235b@siemens.com>
X-Mailer: WebService/1.1.22129 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

This is a multi-part message in MIME format.
--------------NBdcYoS4qblyY3pn8EDsqIg8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/12/23 01:37, Jan Kiszka wrote:
> On 02.12.23 01:31, Mauro S. wrote:
>> On 01/12/23 02:31, Jan Kiszka wrote:
>>> On 30.11.23 00:24, Mauro Salvini wrote:
>>>> Il giorno mar 28 nov 2023 alle ore 09:39 Mauro Salvini
>>>> <mau.salvi@yahoo.com> ha scritto:
>>>>>
>>>>> Il giorno mar 28 nov 2023 alle ore 00:15 Jan Kiszka
>>>>> <jan.kiszka@siemens.com> ha scritto:
>>>>>>
>>>>>> On 27.11.23 22:02, Mauro Salvini wrote:
>>>>>>> Il giorno mar 21 nov 2023 alle ore 01:06 Jan Kiszka
>>>>>>> <jan.kiszka@siemens.com> ha scritto:
>>>>>>>>
>>>>>>>> On 20.11.23 22:23, Mauro S. wrote:
>>>>>>>>> On 13/11/23 18:54, Jan Kiszka wrote:
>>>>>>>>>> On 11.11.23 16:03, Mauro S. wrote:
>>>>>>>>>>> Hi all,
>>>>>>>>>>>
>>>>>>>>>>> I'm using Xenomai 3.2.3 on an Atom x84_64 with a 5.4.255 ipipe
>>>>>>>>>>> kernel.
>>>>>>>>>>>
>>>>>>>>>>> The application I'm running (a complex application, with about
>>>>>>>>>>> 60-70 RT
>>>>>>>>>>> threads) has a simple loop in the main function, something
>>>>>>>>>>> like that:
>>>>>>>>>>>
>>>>>>>>>>> while (stay_in) {
>>>>>>>>>>>        ret = rt_buffer_read(...);  // with 50ms timeout
>>>>>>>>>>>        if(ret) do_something
>>>>>>>>>>> }
>>>>>>>>>>>
>>>>>>>>>>> The main loop reads the buffer to receive some commands from
>>>>>>>>>>> outside,
>>>>>>>>>>> and when the application gets a SIGINT, the custom signal
>>>>>>>>>>> handler simply
>>>>>>>>>>> does "stay_in = false" breaking the main loop, and then the
>>>>>>>>>>> program
>>>>>>>>>>> closes.
>>>>>>>>>>> During normal running, I can see the timer associated to the
>>>>>>>>>>> rt_buffer_read() timeout get fired and reprogrammed, calling
>>>>>>>>>>> multiple
>>>>>>>>>>> times "cat /proc/xenomai/timer/coreclk" e.g.:
>>>>>>>>>>>
>>>>>>>>>>> 0    291/290         2ms970us           -           myapp
>>>>>>>>>>> ...
>>>>>>>>>>> 0    609/608         34ms860us           -           myapp
>>>>>>>>>>>
>>>>>>>>>>> I also see the thread in "w" state (waiting for a resource
>>>>>>>>>>> with timeout)
>>>>>>>>>>> doing "cat cat /proc/xenomai/sched/threads":
>>>>>>>>>>>
>>>>>>>>>>>      0  16328  rt     cobalt     50   21ms279us
>>>>>>>>>>> w          myapp
>>>>>>>>>>>
>>>>>>>>>>> Sometimes, in a non reproducible way (at least for the
>>>>>>>>>>> moment), when the
>>>>>>>>>>> process get the SIGINT it never exits, remaining in this status:
>>>>>>>>>>>
>>>>>>>>>>> /proc/xenomai/sched/threads:
>>>>>>>>>>>      0  16328  rt     cobalt     50   -             W
>>>>>>>>>>> flxcore
>>>>>>>>>>>
>>>>>>>>>>> The state becomed "W" (waiting for a resource without timeout)
>>>>>>>>>>> and in
>>>>>>>>>>> fact the remaining timeout is not present in the row, also in
>>>>>>>>>>> /proc/xenomai/timer/coreclk:
>>>>>>>>>>>
>>>>>>>>>>> 0    291609/291362         -           -           myapp
>>>>>>>>>>>
>>>>>>>>>>> (BTW, seems that some timeouts got lost, because scheds are
>>>>>>>>>>> many that
>>>>>>>>>>> shots, and this happens also on other timers in coreclk)
>>>>>>>>>>>
>>>>>>>>>>> This is the backtrace in gdb:
>>>>>>>>>>>
>>>>>>>>>>> #0  0x00007f5b15bb05f7 in cobalt_monitor_enter () from
>>>>>>>>>>> /usr/lib/libcobalt.so.2
>>>>>>>>>>
>>>>>>>>>> This relates to lib/cobalt/internal.c, cobalt_monitor_wait():
>>>>>>>>>>
>>>>>>>>>>            /*
>>>>>>>>>>             * If we got interrupted while trying to re-enter the
>>>>>>>>>> monitor,
>>>>>>>>>>             * we need to redo. In the meantime, any pending
>>>>>>>>>> linux signal
>>>>>>>>>>             * has been processed.
>>>>>>>>>>             */
>>>>>>>>>>            if (ret == -EINTR)
>>>>>>>>>>                    ret = cobalt_monitor_enter(mon);
>>>>>>>>>>
>>>>>>>>>> But the problem is that the lock (monitor) is no free. Someone
>>>>>>>>>> else
>>>>>>>>>> holds it, and your interrupted reader does not proceed.
>>>>>>>>>>
>>>>>>>>>> If you dive into mon at this point via gdb, you may find the owner
>>>>>>>>>> (according to libcobalt's view) when you resolve manually what
>>>>>>>>>> get_monitor_state() does.
>>>>>>>>>>
>>>>>>>>>> Jan
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Thank you Jan.
>>>>>>>>>
>>>>>>>>> I rebuilt the Xenomai libraries with debugging symbols enabled.
>>>>>>>>> But when I try to print the mon variable, I get
>>>>>>>>>
>>>>>>>>> (gdb) print mon
>>>>>>>>> $1 = (cobalt_monitor_t *) 0x7f3cb524e62c
>>>>>>>>> (gdb) print *mon
>>>>>>>>> Cannot access memory at address 0x7f3cb524e62c
>>>>>>>>>
>>>>>>>>> Seems that the memory address is not in the core dump, but I'm
>>>>>>>>> wondering
>>>>>>>>> why
>>>>>>>>
>>>>>>>> Did you create a core dump or tried to attach live the hung process?
>>>>>>>> Maybe the former was incomplete - for whatever reason.
>>>>>>>>
>>>>>>>> Jan
>>>>>>>
>>>>>>> Sorry for the delay, but every time I modify something I need to wait
>>>>>>> for the issue to arise.
>>>>>>>
>>>>>>> I'm working on core dumps. The previous core was incomplete, as
>>>>>>> you said.
>>>>>>> I needed to set the coredump_filter kernel cmdline argument to
>>>>>>> 0x7f to
>>>>>>> have the complete coredump.
>>>>>>>
>>>>>>> Now, I can see also the values into the Xenomai lib memory space:
>>>>>>>
>>>>>>> (gdb) print *mon
>>>>>>> $8 = {state_offset = 1047984, flags = 1, handle = 44}
>>>>>>> (gdb) print *(struct cobalt_monitor_state *)(cobalt_umm_shared +
>>>>>>> mon->state_offset)
>>>>>>> $9 = {owner = {v = -2147483638}, flags = 0}
>>>>>>
>>>>>> This is 0x8000000a, XNSYNCH_FLCLAIM | 10 (see also xnhandle_get_id),
>>>>>> thus 10 is the owner. Unintended recursion?
>>>>>>
>>>>>> Jan
>>>>>
>>>>> Oh, yes, my bad: I have seen the xnhandle_get_id, but not considered
>>>>> that atomic_t is treated as a 2-complement number.
>>>>> Then, the owner is the caller ID. I'm wondering how it could be a
>>>>> recursion: the main thread is a simple while(..) rt_buffer_read(..);
>>>>> I will investigate a bit more on it.
>>>>>
>>>>> Thanks.
>>>>
>>>> Maybe I found something: in the backtrace of every core (cores are
>>>> generated with SIGABRT) the first two frames are referring both to
>>>> cobalt_monitor_enter(): frame #0 is at the source line where the
>>>> program is stuck (syscall), frame #1 is at the cobalt_monitor_enter()
>>>> function declaration source line:
>>>>
>>>> Program terminated with signal SIGABRT, Aborted.
>>>> #0  cobalt_monitor_enter (mon=0x7f0d7583862c)
>>>>       at
>>>> ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/cobalt/internal.c:218
>>>> [Current thread is 1 (Thread 0x7f0d7628c400 (LWP 2751))]
>>>> #0  cobalt_monitor_enter (mon=0x7f0d7583862c)
>>>>       at
>>>> ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/cobalt/internal.c:218
>>>> #1  cobalt_monitor_enter (mon=0x7f0d7583862c)
>>>>       at
>>>> ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/cobalt/internal.c:186
>>>> #2  0x00007f0d76612748 in cobalt_monitor_wait
>>>> (mon=mon@entry=0x7f0d7583862c, event=event@entry=0,
>>>> ts=ts@entry=0x7ffe7d7380f0)
>>>>       at
>>>> ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/cobalt/internal.c:276
>>>> #3  0x00007f0d76639497 in monitor_wait_grant (current=0x7f0d75842bc8,
>>>> timeout=0x7ffe7d7380f0, sobj=0x7f0d758385f0)
>>>>       at
>>>> ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/copperplate/syncobj.c:553
>>>> #4  syncobj_wait_grant (sobj=sobj@entry=0x7f0d758385f0,
>>>> timeout=timeout@entry=0x7ffe7d7380f0, syns=syns@entry=0x7ffe7d738074)
>>>>       at
>>>> ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/copperplate/syncobj.c:553
>>>> #5  0x00007f0d7664c691 in rt_buffer_read_timed (bf=<optimized out>,
>>>> ptr=<optimized out>, size=<optimized out>,
>>>>       abs_timeout=0x7ffe7d7380f0) at
>>>> ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/alchemy/buffer.c:555
>>>> #6  0x000055b104840601 in rt_buffer_read (timeout=50000000,
>>>> size=19216, ptr=0x55b104844180 <Request>,
>>>>       bf=0x55b104844168 <ReqBuf>)
>>>>       at
>>>> /opt/sdk/3.1.22-2.0/sysroots/corei7-64-poky-linux/usr/include/xenomai/alchemy/buffer.h:129
>>>> #7  main (argc=<optimized out>, argv=<optimized out>) at main.c:410
>>>>
>>>> Could that be a clue?
>>>
>>> That alone does not tell a story. We know now that - at least according
>>> to the monitor data structure - thread with ID 10 is holding the lock.
>>> If the very same thread is trying to re-aquire it, this will cause a
>>> deadlock. And if that is true, we need to find out, how that could have
>>> happened. I have no idea about that so far.
>>>
>>> Would you be able to factor out a simpler, sharable reproduction case? >
>>> It also looks like as if the reader is receiving some signal while
>>> blocking. Is that expected based on your workload? It may destroy timing
>>> constraints, even without the deadlock.
>>
>> Yes, I think it is expected, the workflow is the following:
>>
>> - a daemon starts the program
>> - upon an external request, the daemon terminates the program sending to
>> it a SIGTERM. I think this is the signal received while blocking
>> - when the SIGTERM is received (a sighandler is installed by the main
>> thread), the main loop (where the rt_buffer_read() is) breaks, and the
>> program performs some cleanups and then exits
>> - in 95% cases, the program terminates well. In the remaining 5% cases
>> the program hangs on rt_buffer_read()
>> - if the daemon detects that the program is not terminated after 30
>> seconds from the SIGTERM sending, the daemon send a SIGABRT to generate
>> the core we are analyzing
>>
> 
> OK, makes sense. Based on this description, we may indeed have an issue
> around Linux signal processing here. Now it's about making it reproducible.
> 
>> I'm trying to reproduce the issue with simpler programs, but without
>> success for the moment.
>>
>> I will update you (hope with better news).
>>
> 
> Thanks in advance!
> Jan
> 

Hi Jan,

finally I managed to have a piece of code that makes the issue 
reproducible. It's not exactly small, but not too big either.
I hope that this makes the issue reproducible also on your test system.

The zip contains:
- a little main program (test.c)
- a little library (in mylib dir). Some pieces of code are never 
reached, but leaved to avoid potential compiler optimizations that could 
remove other relevant parts (maybe cycles?)
- a script (build.sh) to build the two components above
- a script to launch the test (start-test.sh)
- the configuration of the kernel in use

After building the program and the library with build.sh, you can copy 
on the target:
- the start-test.sh script
- the built program xeno-test-session-hang-on-exit
- the built library libmylib.so.2.0.0
and create the library link /usr/lib/libmylib.so.2

Start the test with "./start-test.sh &" and follow what happening with 
"tail -f log.txt": after a time that varies from a couple of minutes to 
25-30 minutes, the log should stop on "~~~~~~ RECEIVED SIGINT ~~~~~~" 
line: the hang is happened.

A small recap:
Atom x5-E8000 CPU, Linux 5.4.255 with Ipipe 15, Xenomai 3.2.3.
GCC compiler used: 9.5.0 from Yocto Dunfell 3.1.22

Some potential interesting things:
- seems that application arguments "--session" and "--cpu-affinity" matters
- seems that compilation flags matters
- seems that splitting the code in an application and a library matters

Thanks in advance, regards

-- 
Mauro S.

--------------NBdcYoS4qblyY3pn8EDsqIg8
Content-Type: application/zip; name="test-code.zip"
Content-Disposition: attachment; filename="test-code.zip"
Content-Transfer-Encoding: base64

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
BQYAAAAACQAJABwDAAC8vgAAAAA=

--------------NBdcYoS4qblyY3pn8EDsqIg8--
