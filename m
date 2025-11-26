Received: from sonic306-46.consmr.mail.ir2.yahoo.com (sonic306-46.consmr.mail.ir2.yahoo.com [77.238.176.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB891EED8
	for <xenomai@lists.linux.dev>; Wed, 26 Nov 2025 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.176.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764159193; cv=none; b=N47Cxsdtoc7LRaZVc7DWeqUnFlvJYt8lisv4FKjiyWIk0pz0fiEaeuLtnUgaU3aOrz9MHeQ5LFi2LUWCOBza1yJn8zZO53UBqXwIu6P0WHAxKsO9tuoZ1DUhzFfVT/7Y88zzmcJf28jkxD1vumqIOWY9ZPBVxsYJ0IlxzwhFvKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764159193; c=relaxed/simple;
	bh=5H2vjJsu2zlutsAwpXfOM/TakW+l9F5Eev18A/Z4dRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Da2BNu1WobaN/0BKBetxaCBqhAF0+S6gMmZuNL+sM0A1Willv9O7STEuAS5lTPTke2xLmkMOnYOP/DCe0wIHWUr5/ItXnxOJ0bKzMw90eZLWFC6TG4HaFQxfGh9OucXmXOpM6UB/GP14EkBNLAtDG/OFmL8ouwvrDrDiw0/WULE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=kbN21O9/; arc=none smtp.client-ip=77.238.176.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kbN21O9/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1764159190; bh=jPaOjN9EcWVBAqUe3lu52+FUUDM65MOHzqYvLals7B4=; h=Date:Subject:To:References:From:Cc:In-Reply-To:From:Subject:Reply-To; b=kbN21O9/lb/Ge5yfqysSGzS4I2c3JUuW4ZHIl1HixQdGnV6TjDO/e4bXPeR0yRHUS4lF5PZ0+o363+XpWNizQCwnzDtJnH1JTPJsW9DBUNkbr66X6ld3BVyFvqQduuCEhZCiY/zqQQpGVcOaiGSPsTyiM5AbDJ2Ae86NJGIuZElDZFmslSoThGq3AbsSKKO+hopp+I2h1tU8vzYzXrGhaOqHl0OK+trj2zY/w7vNTHmq7eiEiNXcxoHAXaVV9mvHOiyX43x02Nk4DTDZJtEgykVdRbtVD8MLl/yxD5uXi8zQsh2SIOhxRiVEdtj236984wNpx85Ifqk2EwX3HzlCbw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1764159190; bh=wAJniumMssC/LgkvUk/gyn6T3ivpVC+isjYKHLpMp7J=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=gbjZRQok0a30tvlCMLuN+eKt5fKBkAdDt0yEjk0X93KYJEPbuuFaYPrMbAwfGOrJzbuGb776e02EbRwI8YMJOZRKj7TLulFVVm0IoNEk8CLAoGN9w+j+XpjFdFuhONRslJMXeVeif9rsbYS5RA2UCExnULsCD0lIRUzJRIHT3L6V+nFwPkAuRzOjjz2iss/YhZ/CSKUGT4zqd+N7jQqLwpx6hDQeJbogcKT8FTGNUQKl5+sqvdFfu/DKgQoqYGcmRThjlMxFXLAJmlvbSQw79DLBMS2xzCHWr6s98tsHlwXr+JIfNTLj5e5H+GalTdgkuT+5WXe3ofjfyWez5MT8Fg==
X-YMail-OSG: U3g1N00VM1lDk0dcSZIRbmC6mswmuh2lz8iJW.ZGvUC_EkPSgctVWLnd7fC9HZW
 JA9Fj8HvdL2MH1Fjw_jY9Ol1jLIEOGvUOVAC.GZKh6TmezVk.UYgOG_X_DXjXB_DIhFpA8JzJOMg
 hunyoAZKr3_3Ga1Di.pM_.cVsxmdedjebzhZYGIKL.gVQSetPYOcGtiwU2JnAF_4lDP2RTdKsmZY
 xQTOa_4f6aM5Ve0SnQjm6eWV3VYOCQlOvDSZRxH.yhZ3OFlz4FZ_zsJlPrtAlWW5Dm37iT.rnFkt
 JjU7zbH7lhTheEJFdfVkPsPlAxEJIouerh4vEek73wd13Zw2TCwTGj7gbu_i.R_VsJa4Ob.EtH3f
 KRSTTqklqCsQLsRE6.y59xcwnHcs7ZTsyCUnzG_A.vITTkmS.GCo1kFGD5joEGc9Ef_AIyg57crJ
 WncTaryHjup9w9XalpcPGGvhU2A1wGLvYnzGEaPMm.VmZKy6S95xc7UbYtWnpZ0aHkgTb3_IgEo6
 HZfxaQ2Zbmgd_gI1g6N73KW.Gv7Y.qUk7q80rxmO8GW_c1dM_VvGN2RQZRs9r4T5MUM251KaEiTN
 yQ3wiY9z4WwhO10C3mVc6PzPLfOeDIF5kbBXrsPnsPHeh_Bo8AVKSSrZbF3N8bC2A.UeXxFnRCOm
 _YwZ_0pes0uL30ixNe7.gCUTHw2yo7QjFEeqnQbg9uUit0NVTYSSOJRoKMRbH0.pzanbKR19xWNH
 NEgsz4uidumiNZRIxbqDTQr74c_.6LcDL3DavC.13DLgEH_JvUDySdGsn.36xvxhK9wQ2PVf_tFY
 RKNE3tX3hFFkzM.4Xec5lIGgCvdDoH4SdLe18BH3ulpXBNCUfT6AoBJvLpZ9ffeROTicb0hk_X9R
 rbhnQ2FZ2MY1YjkiNfPHY7Bqwak9JNYQCCF38RCM9ncnygsLvejpMkYAH87uO88bxNh__s98Q59r
 jPdUuVMhTOUyciXvVffNbfyJpcHrcohVnb3nVdeGmShY3jdKTI5Q0WWubxBxV0qQZ0iWeaqPhW30
 3aLyXRVOJGu1gpqfXEnsCBD16EyJ81e7ZrWw0qzyFZXfCJ.UtKjlmXEy_wajtGQHvlGlat0Ldd6W
 G5VAQa6h0_CDZma_8Hboa79LL8fklqpomdgL4n47lQS3JqAP.6HjsIQir9hbA9IyF2btE_CgJK2E
 KMenow.aSWwiJdZSo.tBNT.bMNjDLNPHfRVQMjft_tZx_rZPffrutYQa4F8t2Lju.NP6vs6uTQBU
 9SdZU3XNGpqTz9A_A9TIsZhfVBUn_xVNxb7qEzLg0.8yNJbt8XFBoo7IVAXwZVjIefPeiW.7k5K7
 XWmsFTd5DbTqQOk77iexnmj9mtTUWfrh6QOuOy15pQGT4op4urOuFq8O7OS4r7izz1QXK9cjbrHo
 9jtXz71ETSjlOAF2jga58OOewwrWMuMOBRc2FSiK1ZYnJBbjr9_5HO1IwdKDZ.eIriQ3niYiuMDH
 WfBVes0nDceEyYbt.2DWYeHSsqsWS7hBzXBmERm8rFJRLDSofveUEtayQ7bM4V0s4Ebtk8rPVtm.
 SJEx9L074x6b8fcufm1hPHGiZLNhWePDzqHeVSp0CbD6QzvKiKP.8f_jUsecK18bSKcG6.tSMUwp
 bbDF.ArA6JR75DbdlqCmSgXrDZ7rYpuh1ZV1HjJnTC2KdnzI3JNRghFPk7gYOLCOW5XX1yLcRVyA
 fZWdD1Nx2M4emicuVSt0cgDLpcSpCFWMcvWLRLFmA3AjNiyh7LTZYpo0.oyycXIJremRWoJulKJZ
 lIVQquyiWF4pJty24Eo1MMfouSekWZO90R6CjiA.HVhfD2zKv5l21spWjI9gmmb7QMTDNuYaFOp2
 TP1lZLSi1CHZJ7Af9uJ5DtNU4txSPRtzxBrM23cLYh0rR9CNzkGFa2Kmu3sX2GrePaMnbsX3bawZ
 NLEtBVHhSCoujstUAG14zqR_jR6S0aNpsPTuy7W0jw5N6EvCXGSvnizRVrHPrx_fbUmHy7K7yync
 lm6QOuQxRiKLEonS71HMMIqjb4Ha4agDuUgsOVXgtk80PPsYQJCLcr6z3TYgP2aVZZlVZC0fLaFy
 zxUwZw3QMelhe8b2MxqpkZkIwpkYYDdsDAxBaVIgA7PbmYKD7kMqdtedCMJBw7YUFCc6kbRPoVDG
 DKb4H79rczsTNOv3FG4tHiqWjJBNOl1dMDImasHSQXA6fCQMIGz4gtN.uquImptT0mepNeAWz_fp
 aCDqkpuGG60rUukY0sBaUu2WKv59djjowZqSc7Gb7lzEVGPV_krl_V_HCdcJfCj0IZq931QdPRZO
 FyRNr6GxI9bGCYp5FwleTFLlmwSlGLAjMn6oITA--
X-Sonic-MF: <mau.salvi@yahoo.com>
X-Sonic-ID: 549d5216-5e55-42f7-a270-42f346d1540f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ir2.yahoo.com with HTTP; Wed, 26 Nov 2025 12:13:10 +0000
Received: by hermes--production-ir2-76fb978d99-v9m7g (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2ea55696839fbbbca8142146e546b920;
          Wed, 26 Nov 2025 11:50:53 +0000 (UTC)
Message-ID: <348cb4d0-b82a-49e0-881d-fe75ee134964@yahoo.com>
Date: Wed, 26 Nov 2025 12:50:48 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rt_task_resume() resumes a wrong task
To: Jan Kiszka <jan.kiszka@siemens.com>
References: <144fcdcd-0944-4971-80fb-80ee7e72cb83.ref@yahoo.com>
 <144fcdcd-0944-4971-80fb-80ee7e72cb83@yahoo.com>
 <348b1bfc-8f0b-4e97-a100-999928f67ab5@siemens.com>
 <172ca47c-acb1-45cc-8e2c-3282c17354f5@yahoo.com>
 <90450dcc-6293-4835-8f75-788090a867ba@siemens.com>
Content-Language: en-US
From: Mauro S <mau.salvi@yahoo.com>
Cc: xenomai@lists.linux.dev
In-Reply-To: <90450dcc-6293-4835-8f75-788090a867ba@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24794 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/25/25 17:51, Jan Kiszka wrote:
> On 25.11.25 16:10, Mauro S wrote:
>>
>>
>> On 11/25/25 15:33, Jan Kiszka wrote:
>>> On 25.11.25 13:23, Mauro S wrote:
>>>> Hi all,
>>>>
>>>> Not sure if I found an obscure corner case or I'm doing something nasty.
>>>>
>>>> I'm using Xenomai 3.2.8 on an Intel Atom system with Linux 5.4.299.
>>>> Target image and toolchain generated by Yocto.
>>>>
>>>> Please find attached test case code.
>>>> Program is very simple: the main task starts a bunch of joinable tasks
>>>> that immediately suspend theirselves. After starting tasks, the main
>>>> task resumes all tasks. They do a small sleep and then terminates.
>>>> Terminated tasks are joined by another task, that was launched at the
>>>> beginning of the program execution.
>>>> Subsequently, main task continues to recreate, restart and resume joined
>>>> tasks, on and on, until a CTRL+C is issued.
>>>>
>>>> What I observe is that, when calling rt_task_resume(), the wrong task is
>>>> resumed.
>>>> Please see the attached log. In this log I'm printing the .handle
>>>> and .thread data in RT_TASK function as hexadecimal.
>>>> At row 19 you can see that Task1 (that has .handle value fc1c9, the same
>>>> of the terminated but not yet joined task 0) has been resumed when the
>>>> rt_task_resume() was called on Task0. Task0 has been terminated its
>>>> execution, but has NOT been joined yet: if I'm not wrong its resources
>>>> should not be usable until join is done (at least this is what I
>>>> understand by documentation). I expect that calling rt_task_resume() on
>>>> a terminated-but-not-yet-joined joinable task should return an error,
>>>> not resume another task. Am I wrong?
>>>>
>>>> I know that is some of a stressful test: in fact if I call the
>>>> rt_task_resume() only if task is not terminated (checking also the
>>>> executed flag adding "&& TaskList[i].executed == 0" into the if) the
>>>> problem obviously does not happen, but as I said I expect an error
>>>> instead of a wrong resume.
>>>>
>>>> Launching the attached code, you should be able to reproduce the problem
>>>> on your side. When the test detects a wrong resume, program terminates
>>>> automatically.
>>>>
>>>
>>> Can you rule out data races on the shared TaskList structure? Seems both
>>> your sub-tasks and the main one are accessing it, and that possibly
>>> concurrently and/or unordered. Or does this also trigger in a uni-core
>>> setup?
>>>
>>> Jan
>>>
>>
>> Hi Jan,
>>
>> attached the modified code: each access to a TaskList element is now
>> protected with a semaphore (one semaphore each element).
>> Strange behavior happens anyway.
>>
> 
> ...would have been too easy. Ok, will try the other day if I can
> reproduce and maybe even understand.
> 

Hi Jan,

sorry, I should me more verbose in my response.
First of all: no pressure, take your time.

Then, a more deep explanation.
I added semaphores to avoid possible concurrent access on TaskList 
elements, but I already verified that code should access them in an 
ordered way without concurrency, thanks to "joined", "started" and 
"exited" flags.
In detail, TaskList elements are accessed:

- by main task
   - under task creation, writing task handler and "joined" flag: this 
happens only if task was joined before
   - to resume task, reading some elements ("started", "joined" and task 
handler) and writing "resumed" flag before resuming the task. Here, 
"started" must be 1 and "joined" must be 0, this can happen only after 
task creation and start

- by sub-tasks ourselves: during their execution. Variables written: 
"started" (at the beginning of the task) and "exited" (just before 
termination, after task is resumed and did its sleep). Also, verifies 
"resumed" flag when got resumed, to check if resume request was for it

- by join task: this happens only if task is "started", "exited" and not 
"joined". This can happen only after a complete subtask execution task 
resets all flags and sets "joined" to 1

Printf sequence seems to confirm that execution order is OK.


> If you would like to understand a bit more already, you could catch an
> event trace (trace-cmd record -e "cobalt*" -e "sched*" -e "signal*") and
> study the task interaction (trace-cmd report / kernelshark).
> 

I'll do the setup to trace events (I don't have trace-cmd on target, I 
need to setup a qemu image with it).

Thanks in advance, regards

Mauro

> Jan
> 

