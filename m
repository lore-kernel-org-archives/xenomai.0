Received: from sonic314-19.consmr.mail.ir2.yahoo.com (sonic314-19.consmr.mail.ir2.yahoo.com [77.238.177.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26F04A9B2
	for <xenomai@lists.linux.dev>; Fri,  1 Dec 2023 17:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="N+spiv5t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701451887; bh=czU7XWAnvs5GB0TkXKuWNQZj8cTwrwjQSQCSl4EkTxI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=N+spiv5tK6+OmpQK+DyA9bIqupnGsDsl+5dhgjcaOIQEnl/iL5bFL30Q0zKjSps+me7/gf0OxGEFngamhtturzVw1GRprWWBQCW6F/HaYt9K+JLbxJy3gsByLneEMElWtEmUr7ocyVtsKS3D0iIL0/HuDncxT/cxQNRLBOiiWbCUpStUnw54kDTshnVhlIzDTzr9Hz5RFUx7WZEMqJrkkwA6u8iXxiNE+fyiW1GoKcLOaWr6uFiKmsqqXxMV9HTyY5kjlcMWQ9QeUxPgUf5HfU2J23yDqO/E3CrVOKeOVPBwdFPP12NhI9etMSF6G5KP2Z1DKNcadysJfyF3xGDMUQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701451887; bh=znul+UKy0cLdBByEkeD8+LXSzraAX4dZy5Fc/h1MJ4l=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=OzS5Zg/6yRIH9UWda2wW2GFvIopbALUjE4s6EHr+wAK+2njAqxIfoVMWHCB69zAKiJoxt5VzOIs3eDXMaFp0/Ny85Gpfdm9bd+BBpltpYJgytfAnLNUCA5BP8nkwgyBhdfh6AAgUkhz1/arPma21InqodWBbHoNFD7FwJIgBCiKb/X25WaQubfAXO/3qVKwXOT1G5eUFQN6O1FZdcPmOaWlTi7jWWDsbL5NoWZDcSRAu54E7VJ0W1BPPiDCIFHxKHFPQJfHsGB6eluJN3NdEYnW9syOa3Z/dzGZChovooTSoBl8JFjvyEHzuwTH1p50REGCiW2ch2mKBPB9C+HAk1A==
X-YMail-OSG: CiPiCmcVM1kw.T6WiDoR63uEFVdkJp27_R5D6GYs4AshCWQn3cMMP4KNLeZjt2K
 fo1pJgxouIELOY0WHxkAjjsRHuHdy0qojtI0jt7A7iqMuD_o4rV9ErQz0AnGM9h0eIU4g4_5iHag
 xutt_NQ_leOAcGKAlZQVnxuzBaJS7MW93ZgtHbOnIJsAou9yZuQiMm5hg06b3x2I53YaZoGg0vnT
 f0FyhugcR2aLvfCq6kSaWRZ71nkgrorSMEe695d__PY.fEe.BvSa2b3UPRFclQhoSlbp1m0tTmUr
 v.MuNtgZi1rvJc7G_0CVBozhPv1FLvzVJFneZzUixFl10W5GQ5qkQmfvYDrVEnWs4cfpgSgWKll8
 UA_P2eASZoQKCmNdNmsGz5isn8YA2JX4mC7bqnq85DUkEZpDtgbljjHoaEcTGOekSSLBKf0_5zbR
 Lnh8rogIx2gNWWusOezci9VtSVK2ppubjdwKHMiRyueUKr7CyleK7tK82laLP0isUxh0BUgxG1cM
 nFZf1zV68BzCehd7tlU.5DKea1jmjrgl9sM8IMkOv8c9A9ZufHU.P7pPuSu9T7AX6rrX62lALec0
 QKCneYC9tt6Tx3UPFD3uebM6WcCBqWMk31TF0o8x_dgFX4og6MGoYvrj606O2nQxKd5JKZSf2CZu
 3RSWWD8TaZtGkkR5fjWxDXFM_j4aTy9Je8ysOIrGDEQMDPH2F1SSZXlGjgzWETHDelR.B6OdM0wH
 t2Gy4iN7BwZfXEUJTey2958jNGPEXdZvP5RiGGPlNqUkDkRoOGr5xe2emnDxzy6QdReBCE_dhPbo
 CB2g3VfQbNZ72lcneJRHg_sy6XXCQSIy99WYg21s8ZRAw1HQgB9nqavhroYx2F581.u6mADeApsF
 A_LcGDztwKhN4leBKOmMHDcmmndvRjnk11eUFz2_2JZ6c75JFsj5gN7S1.PfIVvBC.1fxSdp3bWp
 qAyQuYicGCuDoXH5bZNg4JbBHBdDGb930hYwZBGd0Eud5_N.AG2dLb6fF5W9dHmb7oHCf1wubcPN
 VrP6vb6bEqFWSHsYYJWBinD_WtMjf_owjVbWncIK4625EdqLzEZtS9wgRjXAqWqaUFqX.GsZKzTj
 65lW5TBWiX6.9T6sLhHJUJWQryKO.DlCf4G3d0XfnAfAHk7jiTEAQ4CweuJtTMFK4NS.Dcx5Ez8.
 fxs3LzqaJkXotUKUWhKMuoE.NVpWA_U_Eqyf8te7V2UppgUNpjv4RB3SDAoYUVB6KVHqGT4sAEA9
 nzLQfdVOHzrMRMDCReXLcK.kxtSH6ALuqHDSsI55coJsNEn6M0SpHUleKx0k0CdjxcK2ESdi8jzF
 .go64V_V95c4r5fFSaz2T6hlayIFhuyU7oJFcxhggwG_aDQSVA3UPx10fDlJfD3JPHKBp6FJZUS5
 26CWLX87VU4W7bhBfDzvkLDBOb5BbveXscdS45GIvZHXJF3rkfvXISwhdR17GKWvIq9nIV5R2dMH
 8JV8xgl88h6bVVdglZCEpfV5R049ky.Koca2rWXYZVjY.BCQfJjuJtifBX1k8Qh0a71D30M3etPP
 A2TejtGQemv5Sx7ML58Dm5iNHcVzYvqed0da2vb6y2cZQa6nT5pXimiLk3dsjtcpo4RDT8JidkUG
 FDGD99rnlleRBFkDu0.U6mZXa73aoq.mJO2U4z34XEBjwU8bcsbFWMw6iMO.q0wDZQpummfvyXIC
 uDWoEo6bUx_zFwXTXm5bc6fZXeNpHNolUZKH4xoE34Hb3lFBvWghDRVsG7Fpt_n0XbO5COIRBB5L
 CX1as8ySYlAbicnTDv2TTD_IgICkc.atH9s3mgsUaybnm2SsmoXnK0kMpLVyMb2e9dumyd7y2w7k
 QAB6fiD158D5.yWhnljqYsZOf1Ma7TWeWPgL60KQfIErmQrfkIAnPjD381EklxdjOZe66fJv4kEG
 MMW2_SY5WhxR6yrHUlCf4dl5xEqNtjnoLRpcbn6_firNN0mY33lGTP_6ge8jLVp1h9P..dN8JxoC
 niGIu0NkBSw_b10PeiLpv1XEJqlUnV.ZJqLBOqQEkZ6T6zDSTfPVO8GfHxn9.d_QfU7tVutBV.oc
 QFshcIkEiA5hEAuVAc7iUUqlEYeQPdUgpounSd1QjUcFBBhpNhE3PmCx.VVSt5_Qm5vXVKqf3V1h
 iB20s1PQ69VFY4ixbLqa7fG2wbE03p3hrzOIYoaijNH2LU28JKlK7JhXIDzvjjpTBnHVK0TrOl5l
 .6P6t4gBnsj7TYg--
X-Sonic-MF: <mau.salvi@yahoo.com>
X-Sonic-ID: d470eda1-9729-4ad6-8576-2f917387fa58
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ir2.yahoo.com with HTTP; Fri, 1 Dec 2023 17:31:27 +0000
Received: by hermes--production-ir2-864cfb66d6-wjgq6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ece3f6ad2331b82a43326e9defd75670;
          Fri, 01 Dec 2023 17:31:23 +0000 (UTC)
Message-ID: <d1b99e9a-5bc6-414c-9f5d-972134f60c31@yahoo.com>
Date: Fri, 1 Dec 2023 18:31:22 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Process stuck in cobalt_monitor_enter
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
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
Content-Language: en-US, it
From: "Mauro S." <mau.salvi@yahoo.com>
In-Reply-To: <67ce5b0a-1013-4ab2-9617-0723c0dc0809@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 01/12/23 02:31, Jan Kiszka wrote:
> On 30.11.23 00:24, Mauro Salvini wrote:
>> Il giorno mar 28 nov 2023 alle ore 09:39 Mauro Salvini
>> <mau.salvi@yahoo.com> ha scritto:
>>>
>>> Il giorno mar 28 nov 2023 alle ore 00:15 Jan Kiszka
>>> <jan.kiszka@siemens.com> ha scritto:
>>>>
>>>> On 27.11.23 22:02, Mauro Salvini wrote:
>>>>> Il giorno mar 21 nov 2023 alle ore 01:06 Jan Kiszka
>>>>> <jan.kiszka@siemens.com> ha scritto:
>>>>>>
>>>>>> On 20.11.23 22:23, Mauro S. wrote:
>>>>>>> On 13/11/23 18:54, Jan Kiszka wrote:
>>>>>>>> On 11.11.23 16:03, Mauro S. wrote:
>>>>>>>>> Hi all,
>>>>>>>>>
>>>>>>>>> I'm using Xenomai 3.2.3 on an Atom x84_64 with a 5.4.255 ipipe kernel.
>>>>>>>>>
>>>>>>>>> The application I'm running (a complex application, with about 60-70 RT
>>>>>>>>> threads) has a simple loop in the main function, something like that:
>>>>>>>>>
>>>>>>>>> while (stay_in) {
>>>>>>>>>       ret = rt_buffer_read(...);  // with 50ms timeout
>>>>>>>>>       if(ret) do_something
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> The main loop reads the buffer to receive some commands from outside,
>>>>>>>>> and when the application gets a SIGINT, the custom signal handler simply
>>>>>>>>> does "stay_in = false" breaking the main loop, and then the program
>>>>>>>>> closes.
>>>>>>>>> During normal running, I can see the timer associated to the
>>>>>>>>> rt_buffer_read() timeout get fired and reprogrammed, calling multiple
>>>>>>>>> times "cat /proc/xenomai/timer/coreclk" e.g.:
>>>>>>>>>
>>>>>>>>> 0    291/290         2ms970us           -           myapp
>>>>>>>>> ...
>>>>>>>>> 0    609/608         34ms860us           -           myapp
>>>>>>>>>
>>>>>>>>> I also see the thread in "w" state (waiting for a resource with timeout)
>>>>>>>>> doing "cat cat /proc/xenomai/sched/threads":
>>>>>>>>>
>>>>>>>>>     0  16328  rt     cobalt     50   21ms279us         w          myapp
>>>>>>>>>
>>>>>>>>> Sometimes, in a non reproducible way (at least for the moment), when the
>>>>>>>>> process get the SIGINT it never exits, remaining in this status:
>>>>>>>>>
>>>>>>>>> /proc/xenomai/sched/threads:
>>>>>>>>>     0  16328  rt     cobalt     50   -             W          flxcore
>>>>>>>>>
>>>>>>>>> The state becomed "W" (waiting for a resource without timeout) and in
>>>>>>>>> fact the remaining timeout is not present in the row, also in
>>>>>>>>> /proc/xenomai/timer/coreclk:
>>>>>>>>>
>>>>>>>>> 0    291609/291362         -           -           myapp
>>>>>>>>>
>>>>>>>>> (BTW, seems that some timeouts got lost, because scheds are many that
>>>>>>>>> shots, and this happens also on other timers in coreclk)
>>>>>>>>>
>>>>>>>>> This is the backtrace in gdb:
>>>>>>>>>
>>>>>>>>> #0  0x00007f5b15bb05f7 in cobalt_monitor_enter () from
>>>>>>>>> /usr/lib/libcobalt.so.2
>>>>>>>>
>>>>>>>> This relates to lib/cobalt/internal.c, cobalt_monitor_wait():
>>>>>>>>
>>>>>>>>           /*
>>>>>>>>            * If we got interrupted while trying to re-enter the monitor,
>>>>>>>>            * we need to redo. In the meantime, any pending linux signal
>>>>>>>>            * has been processed.
>>>>>>>>            */
>>>>>>>>           if (ret == -EINTR)
>>>>>>>>                   ret = cobalt_monitor_enter(mon);
>>>>>>>>
>>>>>>>> But the problem is that the lock (monitor) is no free. Someone else
>>>>>>>> holds it, and your interrupted reader does not proceed.
>>>>>>>>
>>>>>>>> If you dive into mon at this point via gdb, you may find the owner
>>>>>>>> (according to libcobalt's view) when you resolve manually what
>>>>>>>> get_monitor_state() does.
>>>>>>>>
>>>>>>>> Jan
>>>>>>>>
>>>>>>>
>>>>>>> Thank you Jan.
>>>>>>>
>>>>>>> I rebuilt the Xenomai libraries with debugging symbols enabled.
>>>>>>> But when I try to print the mon variable, I get
>>>>>>>
>>>>>>> (gdb) print mon
>>>>>>> $1 = (cobalt_monitor_t *) 0x7f3cb524e62c
>>>>>>> (gdb) print *mon
>>>>>>> Cannot access memory at address 0x7f3cb524e62c
>>>>>>>
>>>>>>> Seems that the memory address is not in the core dump, but I'm wondering
>>>>>>> why
>>>>>>
>>>>>> Did you create a core dump or tried to attach live the hung process?
>>>>>> Maybe the former was incomplete - for whatever reason.
>>>>>>
>>>>>> Jan
>>>>>
>>>>> Sorry for the delay, but every time I modify something I need to wait
>>>>> for the issue to arise.
>>>>>
>>>>> I'm working on core dumps. The previous core was incomplete, as you said.
>>>>> I needed to set the coredump_filter kernel cmdline argument to 0x7f to
>>>>> have the complete coredump.
>>>>>
>>>>> Now, I can see also the values into the Xenomai lib memory space:
>>>>>
>>>>> (gdb) print *mon
>>>>> $8 = {state_offset = 1047984, flags = 1, handle = 44}
>>>>> (gdb) print *(struct cobalt_monitor_state *)(cobalt_umm_shared +
>>>>> mon->state_offset)
>>>>> $9 = {owner = {v = -2147483638}, flags = 0}
>>>>
>>>> This is 0x8000000a, XNSYNCH_FLCLAIM | 10 (see also xnhandle_get_id),
>>>> thus 10 is the owner. Unintended recursion?
>>>>
>>>> Jan
>>>
>>> Oh, yes, my bad: I have seen the xnhandle_get_id, but not considered
>>> that atomic_t is treated as a 2-complement number.
>>> Then, the owner is the caller ID. I'm wondering how it could be a
>>> recursion: the main thread is a simple while(..) rt_buffer_read(..);
>>> I will investigate a bit more on it.
>>>
>>> Thanks.
>>
>> Maybe I found something: in the backtrace of every core (cores are
>> generated with SIGABRT) the first two frames are referring both to
>> cobalt_monitor_enter(): frame #0 is at the source line where the
>> program is stuck (syscall), frame #1 is at the cobalt_monitor_enter()
>> function declaration source line:
>>
>> Program terminated with signal SIGABRT, Aborted.
>> #0  cobalt_monitor_enter (mon=0x7f0d7583862c)
>>      at ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/cobalt/internal.c:218
>> [Current thread is 1 (Thread 0x7f0d7628c400 (LWP 2751))]
>> #0  cobalt_monitor_enter (mon=0x7f0d7583862c)
>>      at ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/cobalt/internal.c:218
>> #1  cobalt_monitor_enter (mon=0x7f0d7583862c)
>>      at ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/cobalt/internal.c:186
>> #2  0x00007f0d76612748 in cobalt_monitor_wait
>> (mon=mon@entry=0x7f0d7583862c, event=event@entry=0,
>> ts=ts@entry=0x7ffe7d7380f0)
>>      at ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/cobalt/internal.c:276
>> #3  0x00007f0d76639497 in monitor_wait_grant (current=0x7f0d75842bc8,
>> timeout=0x7ffe7d7380f0, sobj=0x7f0d758385f0)
>>      at ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/copperplate/syncobj.c:553
>> #4  syncobj_wait_grant (sobj=sobj@entry=0x7f0d758385f0,
>> timeout=timeout@entry=0x7ffe7d7380f0, syns=syns@entry=0x7ffe7d738074)
>>      at ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/copperplate/syncobj.c:553
>> #5  0x00007f0d7664c691 in rt_buffer_read_timed (bf=<optimized out>,
>> ptr=<optimized out>, size=<optimized out>,
>>      abs_timeout=0x7ffe7d7380f0) at
>> ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/alchemy/buffer.c:555
>> #6  0x000055b104840601 in rt_buffer_read (timeout=50000000,
>> size=19216, ptr=0x55b104844180 <Request>,
>>      bf=0x55b104844168 <ReqBuf>)
>>      at /opt/sdk/3.1.22-2.0/sysroots/corei7-64-poky-linux/usr/include/xenomai/alchemy/buffer.h:129
>> #7  main (argc=<optimized out>, argv=<optimized out>) at main.c:410
>>
>> Could that be a clue?
> 
> That alone does not tell a story. We know now that - at least according
> to the monitor data structure - thread with ID 10 is holding the lock.
> If the very same thread is trying to re-aquire it, this will cause a
> deadlock. And if that is true, we need to find out, how that could have
> happened. I have no idea about that so far.
> 
> Would you be able to factor out a simpler, sharable reproduction case? >
> It also looks like as if the reader is receiving some signal while
> blocking. Is that expected based on your workload? It may destroy timing
> constraints, even without the deadlock.

Yes, I think it is expected, the workflow is the following:

- a daemon starts the program
- upon an external request, the daemon terminates the program sending to 
it a SIGTERM. I think this is the signal received while blocking
- when the SIGTERM is received (a sighandler is installed by the main 
thread), the main loop (where the rt_buffer_read() is) breaks, and the 
program performs some cleanups and then exits
- in 95% cases, the program terminates well. In the remaining 5% cases 
the program hangs on rt_buffer_read()
- if the daemon detects that the program is not terminated after 30 
seconds from the SIGTERM sending, the daemon send a SIGABRT to generate 
the core we are analyzing

I'm trying to reproduce the issue with simpler programs, but without 
success for the moment.

I will update you (hope with better news).

Thanks

-- 
Mauro S.

