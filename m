Received: from sonic313-20.consmr.mail.ir2.yahoo.com (sonic313-20.consmr.mail.ir2.yahoo.com [77.238.179.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8827719F135
	for <xenomai@lists.linux.dev>; Wed, 17 Dec 2025 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.179.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765989415; cv=none; b=R5AgWp/Z9XEJ1UywsS11BFl9xbcopsgJnhPJESE/UdXhcKHEJBjxQMLFNVlxPvK/LKKR96h/Z64S76xREyuppD0Hy/X4vcnPWM7+BZJ/HeHrJMOtCfKBuqF4k1BLZheTI+UMmcOpwSL2ypBTWLqBitwTgqmU0Idg7bhNyVApQlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765989415; c=relaxed/simple;
	bh=BUNkHTmXGqeRE3XcFNkZuFvjffLELaIf7ZK9lV6pD0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IYJNmN761vzQKNLWAypRVKO86Aiwi1i8aNJWtYHLF6NIRlkw0/qacfo72qMeeN77ss7nTn3ShrOMg5rdCoYKO3LDzBNHI7+sZSVnZyVwPMIiRifuieSWB9hZrWgvY/iQ9icxbAz32AJ8T7HgM0+nFwPJStaDGsDmSCUXhyWL6qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=QjGpz3qr; arc=none smtp.client-ip=77.238.179.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QjGpz3qr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1765989410; bh=m9gh9czFqpezQcNW4K7NucgFh+VfejywACPbll+WeDw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=QjGpz3qr3tW8Q0VB4TSYho/gHB9Jc7Y2ePX5T6EETI3IkYgU4xtFre8mGONGeYBWxLgOoMT0iAJhPpGdDtdTfhh2Gp3fRmBTmXFADPwtXdaDuaX40wel5+l8fQc6uikWSdAE0YcLCI269tastbgIn50VFV5xbiqkE65CnQ6AgPvosv9q71yhLiWqhdXfG/hfFIpFahmsCZNcmRlnnmT8uZwsC4FvZIxLfRqR9q4kdt1qKid420/thMRTnIgkOTZTeDFHn0wxvr04MqpKeHnTF5tUuj3yeODFOwEliXXN/Fp4X5agR5ijUADSTjN9KiI61jCKU/eWMOR7B6gf6SrnIw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1765989410; bh=qOf6kL3qTCqqZGQb65csC/bOXR2pSn2+cAUG+hVj9V/=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=cHOnj5ViQqYYj+cgM+1SEuuUYm0UuMNK2WcmZqQJ9V950SjfY0wg9DJMO0+nuh5LSrmBbss4UDeeonNG3Xgce5+9ZyoNaWQRjKgIzE8cs8S12p/ddGCQjh41/cprta82QNfM5U4FNUFkSJI6NJzU4eqypN4PWxbPl/YfvbhoigTKyd2BlCrPRAUzwkn7u9SEQQ8XrFSVWjn7tWLEzH1HZ5wCjKaMI+vikeFIfNYOQzRyZM+J1gsIMmuI89cRDd60RDcm5DDmLdSvBK/VRgmD/HC9Qg6G/pU+KbNcz+DM/ltzn1NUgrQsVakr5cVjwBr+VeUmTdAMxgXkfErHCId8yg==
X-YMail-OSG: NwOp.8gVM1nk_xuqSAJEBJS3lxSEFeDK8cQlXiJIV8zcaOp71Bb8cgKsTOIY9QY
 ZVbB3XgtB97Bmh7MGT10LUNAO.Eag0RGzpU2ztay2tOC2EHRS1lUiI2lu7RKn.T0.oopEQPWHrZ6
 oPyuE62_Ef7xCxuqr9Vk6UWezf2m_XdNsf1ziqk.v17Vw0rxVo9pWl5HV3KqQe..qWJ8K0vtRgs.
 bP8GOJdNHEIfj8ED1T.B3RsTsSodI0Jbx3iTW6hucEPVDPIOzpTcqyfkDKX8kBEvvwGjWGWgsGv4
 NGhhwu2mX7Tkn6lqIh1zSonldA85L_.jlYNe6flb9dZZf_a89_gWtv6_xdDZ0ja3fADuIvsoOztS
 SEqEmSuYD_9iS1GbQG_XMTCH8_18311KNBUaQfPQTY5LUUJSFoj1wQHilrqxCrTcAlQhRXss807p
 pxN7l99ehd69TYcH3_z3.2umSslxcBYv1Vqbo7MifdswEKklAzQptr2wGuoz91hZMJJ8s6K64HqI
 gTGxo2u.hbAVXJqCHdunM1u3RtIotS65mTLB9skYpNtd8zrjldbakrMO1bGfnTFBXYpG2Zl5A2Oy
 TIUAm.w47sZZSVQnIbM1ZEXhMffkIZnLtptown52LRLwRo2wpWV9qBjd94c5bgHJEKHSm.2TM6bG
 TL_39HlOguEzgC5nkYfauzDq_1nS_qx7T.qLjdynXLP0kZm5Y2_Dsim7Y.uOgSggTf32sXQqtFte
 qOVH4I9JpTlHrwY9U5yLSgLK5rykl.wxM2Ryt5XJl7Vkq5_jcqsQHVlBlG37dLwUjn1RTnkAMoQR
 Fox5kCmq_.Fufj_r6yf_fJ9to3SwBZhfkvzupllyrxk5JcCAjG7ADiAcAW3ykuWPJareh2tKJlto
 uweeUwoaSXeU5a9b7.11Egl9.9oFlhwOt5pWLac.jtCK0rnE6lRNRGP4q_FACKzAaNp4awV8RkUQ
 RRyLoz1kIyEpImGCmz9Ggg5aPWeBjmrE.P_Bj_v5NH.nt7J8FXJRJq8FWB_vRbuh3y2JdwSEbgQi
 QFYZ6ULFa_5gujviGCMYvKor7agBS5qeJD8G.mL0kq6_AlDHYolngkjubh0UKR6li44EjddGHD3e
 qQXvd4VWdvIByHfMK7usvgL37RMQ.7zkBda0t7VH3jahb33nLL7ha3UWbG71VDw5462gZOXaSKiA
 Bu1QZY.gwsCTT7Igv1I18QFl43dKgZavz5GQ9EtDgDyhRzR_pGeTnC_N39bqv5hUUxeeLVw7tXrC
 PCspCWupJnJSsPrMhln07AInwrbnaqGPABrNlZquR8_TfMQ3ZtGfvBmdxjP8y_5.vreclmWTGXlS
 z2GPzaUdEa1ClSNBOkvIPjQl0tXLwFBa7zcSkeAvp7TaG9n7c0xUHltQfumbPZVV.FB1XvPKUZpx
 B7d.pitdtdndexwVodH_NTqDL_ihjKLy7jwT07QDrXVyRTI7tTDdqKiGWtNgNAOREkM5eVSPKGQJ
 gH3OoDVZAVDR9qkG9CURuiWEnLyT9UHX_Rsb1hYhCu35MyKUWxe1iBz_5qY5EThWSQI0g30R0KmV
 7QF4hEwyBJS0jyiQd.XUdiAfV1I0c1KIONg5WNeVm0or8hCewxhBDvqVqoIn37QdF_z3lOoiyyVK
 kOu7H4IShMrb0EWFoW4Dy_9iiMYn.ICH732dGYQtNHHonYrZr2J_tOLeiH7An9cJYmqPYyb477s3
 I6QLWgK5UMDHcfILED_iVwMwMhyQR5GAE.9Ur8dq1P0CtTrn3FolfPwFbv4SI4Zc5stPm6xtNcQP
 frl.OZp8ylxxXpEqUTBigLankGtAgWL_0B8h_lTtQ3wnDJDqkkWHnUl.ellwQENDdY1bZso7gNfe
 18Ryn0Icu2zU_3v1O0JbGwnWhXCxySDcTliVMiIW_Fld1pIxry.8jx.SwcEWo4QCY.upwKvMaNFx
 f2S5rizZi62WShrwAbVicYt2uLdBU12fagEM.giW6Kxx7KK7OZt4YX9BjH2nipf5Q9_WU5kf0IrB
 06zxMvkQhQBPigsHs3nko4uVAY79VMRfMqemXUmPca_UEsBUIN0NSR1xD9t3sutVsqqT_nGUXYPP
 g0pEBEr1kv4b8a4Xc60NSWYmwX3hgkDEnKrpbwncgWTovKZTrX8F785REY5RR5yVnuqk1sa_TKO2
 KcrOvUEW.HWZlzi4ttPZX7GAK7VAn1YaF0q8PqtXP1qb5bLzQp1hEvlOBBRKTKPMnCfv3uDFKaWD
 WatYzOzScMsCmonOvaNqNSK.WjV8Cxgqdr7BSjQj5otiHn9QZQOmg6Uzt5Q--
X-Sonic-MF: <mau.salvi@yahoo.com>
X-Sonic-ID: 6bf999d3-6e68-4d59-9eb1-8365f6ba803c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ir2.yahoo.com with HTTP; Wed, 17 Dec 2025 16:36:50 +0000
Received: by hermes--production-ir2-7679c5bc-vfsc7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d0f9ebade4583343f8b29bf7b398a6c7;
          Wed, 17 Dec 2025 16:16:31 +0000 (UTC)
Message-ID: <d8dd9ec4-1f98-48b5-b877-39a1de243081@yahoo.com>
Date: Wed, 17 Dec 2025 17:16:13 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rt_task_resume() resumes a wrong task
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev
References: <144fcdcd-0944-4971-80fb-80ee7e72cb83.ref@yahoo.com>
 <144fcdcd-0944-4971-80fb-80ee7e72cb83@yahoo.com>
 <348b1bfc-8f0b-4e97-a100-999928f67ab5@siemens.com>
 <172ca47c-acb1-45cc-8e2c-3282c17354f5@yahoo.com>
 <90450dcc-6293-4835-8f75-788090a867ba@siemens.com>
 <348cb4d0-b82a-49e0-881d-fe75ee134964@yahoo.com>
 <d2569de3-405f-4305-a05a-be104160d1a8@yahoo.com>
 <75ab33ce-0a98-4154-add6-9e8fa989b4eb@siemens.com>
 <651094df-88c8-4998-b389-28a6086704e9@yahoo.com>
 <e9573efd-0e55-43fe-a341-da42acf06bf8@siemens.com>
Content-Language: en-US
From: Mauro S <mau.salvi@yahoo.com>
In-Reply-To: <e9573efd-0e55-43fe-a341-da42acf06bf8@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24866 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo



On 12/17/25 13:31, Jan Kiszka wrote:
> On 17.12.25 09:42, Mauro S wrote:
>> On 12/17/25 07:59, Jan Kiszka wrote:
>>> On 02.12.25 09:56, Mauro S wrote:
>>>>
>>>>
>>>> On 11/26/25 12:50, Mauro S wrote:
>>>>> On 11/25/25 17:51, Jan Kiszka wrote:
>>>>>> On 25.11.25 16:10, Mauro S wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 11/25/25 15:33, Jan Kiszka wrote:
>>>>>>>> On 25.11.25 13:23, Mauro S wrote:
>>>>>>>>> Hi all,
>>>>>>>>>
>>>>>>>>> Not sure if I found an obscure corner case or I'm doing something
>>>>>>>>> nasty.
>>>>>>>>>
>>>>>>>>> I'm using Xenomai 3.2.8 on an Intel Atom system with Linux 5.4.299.
>>>>>>>>> Target image and toolchain generated by Yocto.
>>>>>>>>>
>>>>>>>>> Please find attached test case code.
>>>>>>>>> Program is very simple: the main task starts a bunch of joinable
>>>>>>>>> tasks
>>>>>>>>> that immediately suspend theirselves. After starting tasks, the
>>>>>>>>> main
>>>>>>>>> task resumes all tasks. They do a small sleep and then terminates.
>>>>>>>>> Terminated tasks are joined by another task, that was launched
>>>>>>>>> at the
>>>>>>>>> beginning of the program execution.
>>>>>>>>> Subsequently, main task continues to recreate, restart and resume
>>>>>>>>> joined
>>>>>>>>> tasks, on and on, until a CTRL+C is issued.
>>>>>>>>>
>>>>>>>>> What I observe is that, when calling rt_task_resume(), the wrong
>>>>>>>>> task is
>>>>>>>>> resumed.
>>>>>>>>> Please see the attached log. In this log I'm printing the .handle
>>>>>>>>> and .thread data in RT_TASK function as hexadecimal.
>>>>>>>>> At row 19 you can see that Task1 (that has .handle value fc1c9,
>>>>>>>>> the same
>>>>>>>>> of the terminated but not yet joined task 0) has been resumed when
>>>>>>>>> the
>>>>>>>>> rt_task_resume() was called on Task0. Task0 has been terminated its
>>>>>>>>> execution, but has NOT been joined yet: if I'm not wrong its
>>>>>>>>> resources
>>>>>>>>> should not be usable until join is done (at least this is what I
>>>>>>>>> understand by documentation). I expect that calling
>>>>>>>>> rt_task_resume() on
>>>>>>>>> a terminated-but-not-yet-joined joinable task should return an
>>>>>>>>> error,
>>>>>>>>> not resume another task. Am I wrong?
>>>>>>>>>
>>>>>>>>> I know that is some of a stressful test: in fact if I call the
>>>>>>>>> rt_task_resume() only if task is not terminated (checking also the
>>>>>>>>> executed flag adding "&& TaskList[i].executed == 0" into the if)
>>>>>>>>> the
>>>>>>>>> problem obviously does not happen, but as I said I expect an error
>>>>>>>>> instead of a wrong resume.
>>>>>>>>>
>>>>>>>>> Launching the attached code, you should be able to reproduce the
>>>>>>>>> problem
>>>>>>>>> on your side. When the test detects a wrong resume, program
>>>>>>>>> terminates
>>>>>>>>> automatically.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Can you rule out data races on the shared TaskList structure? Seems
>>>>>>>> both
>>>>>>>> your sub-tasks and the main one are accessing it, and that possibly
>>>>>>>> concurrently and/or unordered. Or does this also trigger in a
>>>>>>>> uni-core
>>>>>>>> setup?
>>>>>>>>
>>>>>>>> Jan
>>>>>>>>
>>>>>>>
>>>>>>> Hi Jan,
>>>>>>>
>>>>>>> attached the modified code: each access to a TaskList element is now
>>>>>>> protected with a semaphore (one semaphore each element).
>>>>>>> Strange behavior happens anyway.
>>>>>>>
>>>>>>
>>>>>> ...would have been too easy. Ok, will try the other day if I can
>>>>>> reproduce and maybe even understand.
>>>>>>
>>>>>
>>>>> Hi Jan,
>>>>>
>>>>> sorry, I should me more verbose in my response.
>>>>> First of all: no pressure, take your time.
>>>>>
>>>>> Then, a more deep explanation.
>>>>> I added semaphores to avoid possible concurrent access on TaskList
>>>>> elements, but I already verified that code should access them in an
>>>>> ordered way without concurrency, thanks to "joined", "started" and
>>>>> "exited" flags.
>>>>> In detail, TaskList elements are accessed:
>>>>>
>>>>> - by main task
>>>>>      - under task creation, writing task handler and "joined" flag: this
>>>>> happens only if task was joined before
>>>>>      - to resume task, reading some elements ("started", "joined" and
>>>>> task handler) and writing "resumed" flag before resuming the task.
>>>>> Here, "started" must be 1 and "joined" must be 0, this can happen only
>>>>> after task creation and start
>>>>>
>>>>> - by sub-tasks ourselves: during their execution. Variables written:
>>>>> "started" (at the beginning of the task) and "exited" (just before
>>>>> termination, after task is resumed and did its sleep). Also, verifies
>>>>> "resumed" flag when got resumed, to check if resume request was for it
>>>>>
>>>>> - by join task: this happens only if task is "started", "exited" and
>>>>> not "joined". This can happen only after a complete subtask execution
>>>>> task resets all flags and sets "joined" to 1
>>>>>
>>>>> Printf sequence seems to confirm that execution order is OK.
>>>>>
>>>>>
>>>>>> If you would like to understand a bit more already, you could catch an
>>>>>> event trace (trace-cmd record -e "cobalt*" -e "sched*" -e
>>>>>> "signal*") and
>>>>>> study the task interaction (trace-cmd report / kernelshark).
>>>>>>
>>>>>
>>>>> I'll do the setup to trace events (I don't have trace-cmd on target, I
>>>>> need to setup a qemu image with it).
>>>>>
>>>>> Thanks in advance, regards
>>>>>
>>>>> Mauro
>>>>>
>>>>>> Jan
>>>>>>
>>>>>
>>>> Hi Jan,
>>>>
>>>> I made a sequential version of the test application: instead of having a
>>>> join task, join call was done by the main task, one subtask at time.
>>>> With this code, tasks does not access concurrently to variables.
>>>> Problem happens also with this code.
>>>>
>>>
>>> Starting to look into this:
>>>
>>
>> Great, thank you!
>>
>>>> STARTED TASK Task0 (82a9eab0-829636c0)
>>>> TASK Task0 RUNNING (self: 82a9eab0-829636c0  ext: 82a9eab0-829636c0)
>>>> STARTED TASK Task1 (82a9e2b0-829526c0)
>>>> TASK Task1 RUNNING (self: 82a9e2b0-829526c0  ext: 82a9e2b0-829526c0)
>>>> RESUMING TASK Task0 (82a9eab0-829636c0)
>>>> RESUMED TASK Task0 (self: 82a9eab0-829636c0  ext: 82a9eab0-829636c0)
>>>> RESUMING TASK Task1 (82a9e2b0-829526c0)
>>>> RESUMED TASK Task1 (self: 82a9e2b0-829526c0  ext: 82a9e2b0-829526c0)
>>>> TASK Task1 EXITED (self: 82a9e2b0-829526c0  ext: 82a9e2b0-829526c0)
>>>> TASK Task0 EXITED (self: 82a9eab0-829636c0  ext: 82a9eab0-829636c0)
>>>> JOINED TASK Task1 (82a9e2b0-829526c0)
>>>> STARTED TASK Task1 (82a9eab0-829526c0)
>>>> TASK Task1 RUNNING (self: 82a9eab0-829526c0  ext: 82a9eab0-829526c0)
>>>
>>> So far so good.
>>>
>>>> RESUMING TASK Task0 (82a9eab0-829636c0)
>>>
>>> And here you are resuming a task that is in waiting-to-be-joined state,
>>> right? That is an application bug, but one may expect it to be either
>>> ignored, only affect that Task0 negatively, or even throwing an error
>>> back to the caller.
>>>
>>
>> Yes, exactly: task is ended yet, then should be joined and not resumed,
>> but I would expect that the resume command was ignored and/or an error
>> was returned.
>>
>>>> RESUMED TASK Task1 (self: 82a9eab0-829526c0  ext: 82a9eab0-829526c0)
>>>> ERROR: RESUMED TASK Task1 (self: 82a9eab0-829526c0  ext:
>>>> 82a9eab0-829526c0) HAS NOT BEEN ASKED TO RESUME
>>>
>>> Instead, we see that spurious wakeup of task1. Let me debug into this...
>>>
>>
>> Thumbs up!
> 
> Ok, here is the catch: The task handle that was used for task0 is freed,
> even before someone joined that task. And task1 handle was freed as well
> before you call CreateAndStartFn(1) again. Now your task1 will get the
> handle of previous task0, and when you try to use that stale handle for
> resuming task0, alchemy looks up the new task1 instead - and resumes that.
> 
> I looked a bit into whether we could delay the handle deregistration
> after the joining, but that would be a hairy operation, likely also
> affecting libcopperplate. Given all that, I think we are safer off
> living with this "specialty", rather than risking instability in the
> cleanup path to handle the application error a bit nicer.
> 
> Jan
> 

Ok, got it.
IMO this behavior should be documented somewhere because it's not what a 
user would expect.

Just throwing out an idea (that could be completely wrong): to 
workaround the deregistration issue, should the resume function use both 
the two RT_TASK fields to decide if resume or not a task, resuming it 
only if both the two IDs matching? From the log seems that the second 
field (pthread ID?) stills occupied until the join happens.

Thanks in advance, regards

Mauro


