Received: from sonic307-53.consmr.mail.ir2.yahoo.com (sonic307-53.consmr.mail.ir2.yahoo.com [87.248.110.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BAE30C344
	for <xenomai@lists.linux.dev>; Tue,  2 Dec 2025 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.248.110.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764667664; cv=none; b=taINg/TlexC8lqZ2mYGQ+KO3SBggiDNRQ5B6CEUzANF/CBQ+tPfML5ugXN2x1bHy97UgWrVCfQvNTbPVuflXtGggpJ/yKF9A/RHGJpCcpwoDIrA7b2e/ILyR6Fvargz2HWpsa86is7EcQSOQ7kQcH13UAERlZGl9fvyrlHKILdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764667664; c=relaxed/simple;
	bh=+go/msOCWdJX6wVUh+e9A5CFWiO/Ab3ZopYplpGBzbQ=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=sjeIkzlvat6YJ7o8Myef0ZkBLwNXSoZQSUl23fUrhli0PhODmrwhS9Q7JCsHkce47eJOwAr4Yn3BM0P0gqCK843AmZnBNbTPl/VFkkg17zubKTEYUzZrV9xrRajvP/tQIiDAynu4IK2bndjGkxMGG0COQWWTITKWSNgnlBVcWTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=n3TXeoCY; arc=none smtp.client-ip=87.248.110.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="n3TXeoCY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1764667655; bh=4tksdQGi+/XAvjhZAO1QMq+POeuJacmMTWO1rrshpNc=; h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=n3TXeoCYdfyc/ZcShpulL1Z2tGyBH3IOFyFFvl/ZzXJZSeagChmoVQDZZZQUgXYgRvyIr1HZRPniYoQhgvPviFUYMpL8iLfI/bwkrGpfFIKtkhG+5rOft/inkuzVay/DKNkcdBnM/k7u0pzQbjKKAxI57LIrFMElV+CUenqtEqg3/mA84vqEQ6EzaLgP/s4a6MI30edshoaqK7qroacpPDkMu/ylTSmkRX7C/Y6h5Q9QzM1pBhmKmj9qXaLRh5iKrxRwYd9eYpX0gP4vsNOsivRpUsXPY7swkWdRZLNe7B6cr0CQAO3EG8t4US8L1dPw3VqugKciq07ZfJFdqkuBXg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1764667655; bh=UaByEQ2vgXqUaQ3s2HB2pKu5E+geUMO8VKi5Wp6PBHi=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=X/UsaaLyIaxq6YSD0IzxxtrbGtPm0YG578hIgL0jMeGM96QT5HU0pcpH7cfOaE4Lba7HgXVkNf61C7WyV+c8t8g/qIT/mhrmFd4NfE/+FUvu/6spes5nf04SB7F3AwTgpx7eAajTrJUS2+Yh8acljx+hKDfm4xXFtUS+PO66D23rB0DsgVu8Nmut6DyP5+ASiFX5w55CrB+Jw9BIciirtlpMHlR4GaFXb+a1pfhA4wAQb00+1ooMN0rhgSHHDakVOn7kiTy7BdtpLCoznexp9uLyrdBa6wLJm+R0H3jY7ioIF/GYLixawcWI4+z3IFcUI6TjrYREwuPVtv5iLHJe3w==
X-YMail-OSG: Q1juBkMVM1lU_t7.BZfwkJ3Hopf9IRodk8vkitJ1l.r_dXK3_T8Tdta1y4Zd6yG
 7HVKCPrraAtJdvOsdFW9Hg5cEpOGZjEe3jQB6n9VYg56gouqTMbh8VOMVA3aV1RUzeMuzcMVEFO3
 bxWEXrlhIr9vinoOFFDC43kEn0McYC92hshMZs07CIcuUeIuU6OvU93UV016IrqWD24GGm8ev.DS
 .WgBPXjX2e2wZxY.5aAhjviIGjaRdvIftxbn8YQduLwamaDVXTARFuGI7Jqr8E4pfDkbt6RQv0Jv
 SMCTRerlQ4zBotDLgvVI.tUQqHUit3lBG9DJehnD139VOuhxnd5GPaqsIDJr7eKGKY8dWyup.bcX
 uSE.OOl54fHIAhG0tHJ0Zm7r7TFGAL8uUVNnymVIOfuvWe8AYQw2yre2lyaOewHf0zxmCo3RpJDI
 McE3QSO_hjOWvYRNGEa0tmRDIm0EFGpQx9KccMOqmdwOoAC4XGOhys_YmTBqaVJcojTUYNjZUV7M
 Y4DzvwF3DBD0UOYMf2WEMTWGcU.Rm2QjmUg1EfyDzluTQYa1YzfpzdmLZ05V6AtF6LI.GJRog87m
 TVMACGBCs.EPQgUdSQp_hixqxa17DVNVU.cSbmlrGAb23Kuir5hBSO3t3S8FIo..XiGLV2rfo7ue
 6g.B8T3hx41da4mpa0wxOd9.taZIsRDrE602uepuxww.GI7SD.qBV0BukN2.3Krd.RLuZqf7Qvaq
 2182V0TCbI5baegFGHrFpnj89jfN7Osh5ArQ6OXpLk7HEhTV2KnJafDj6tmX6Eiqa6rwZeJ61FXv
 ZvuEtV5eSqYojUT5ilPthiYP1OEdrf78sh4bio2.GNY697Xq6LBqtcm8F8jnl9IfbhvSIENsc8__
 RAeh_hGixXjqwUBaIE4z843p_fvzXRENA3iHgdrFFcJ9lf5Ddd0dwd3PXqQSCpmrKcjISzhWmYnJ
 Xiq3tx_Rt8wGnj4norgb1no.hLh0PrvzlQnHAb7km08rDpi._E.mBAKKOnX3Lr1ZkG7ky43UlKWi
 h8nQl7JNrhU1dG5XHIWaF3m7ELPhpOqQ42FA6gYWWtGnx0ZCQl9HxnMr90ud.362yB7mf7Rzx6BX
 dxYQSVtvGBl52k.li7If07B2Ocz3nPcsPpVpxn6wDYKXj5VbLMn_hHaIbQynCSmTkM3VwfTLIA06
 rF2L9KDoNu.PwjbccSyYvwJDSxo9x9gXUnqCylwrC5KJ5hfSrd.hUQVpp_DKchO7eoh9D6Fdzc79
 GIRLC4sub1Rm7vjNTWQe3dNslRcEQh4gaTcPUWj4wSLhsd2fhHMBlbol3ouRjV3Bf8s67KwcpD6w
 Tm3VkCSPLmj8FL1vKcK7Ct7WvFOT2YHj9TXRKxhAO7a7s.Iq85K9chLbn5_l.v9cB3oLSdUD_PVa
 zV2YOvSmNnPpa1nF1A6d.nlq.d2QM_UNi1jjnJsVB12KR9CrId8pccPxCedBKfS1soIEU9DB2eLi
 gohMxjdUVm8o35KptjmiaoFAG9EM.ChfMahqAdSlgmG2fHmW4xaSpH.mbfJd0lKy.Wt3oYR1i.Y2
 vRP79GM5pAX0glrN0fs_6NyzGsK1k52RDyHbvxpA6nIqtVXskMVBWjKy7AsoUCuHGLUqbyqZulCs
 SS2vIYXIoaKeKQCmINpsy8ZoiW9D25zUU.yXI1mxZf5FnU3fHFIGmNzy2WFYMtm5f3agXA8eHQom
 CqnMWa.Y4tiJ.JdF049rKshmxkZ55i4qtqQ3mGTJYdBXoalIWNvsyOvbBW8EfEVMbtuW7Z8Bz9Qy
 hC1RDceOiquE4pOFb6KmEXX8UpzKO71B_Aw75_MfRzHk7H49E1b28tKQdlAhi1O5AzsrGqj.XfKp
 keoHr.wMM6xK.3ghcvjUvdMOCU6GyQKYGv7LPuSq7zLS38xTwyLchcuMsqvDc1YiyWwm1a3_pC4o
 jpA45ql9nNN5QEhUzcz4_89_IZoCCMjSFjqdN9ERpHM7NiQhdtoPU7wNl9SjvCCyVUoUkT9euG0T
 Ia.cmBdG.irSvAzeDJsZmahA4ZwFOS0IkM6yxsKGBmttZzBv2RpehQQck3IC_h9Uiko2EBG56ooQ
 kA_YvF.s1DnMS1C1lvitiwqAdg6bMBN0pq_VY33NE_8GdlVGXKkuW94HSHt9_duAn9qMQndBy3GS
 H1HaWJSgAaFliTG6ubQug1fF.eHY4TTy5iw6vHMcN0ScQgYbuGueVYMQMN9saaKVrwv1tbX0a24Q
 R4gHPjxqNmYEaQPkKS9eHV9cX65g_aP0QyTcfC.2QOfRbfVkbgNbUfA--
X-Sonic-MF: <mau.salvi@yahoo.com>
X-Sonic-ID: 96af8a49-271c-4448-b26f-8e51a23c5fbc
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Tue, 2 Dec 2025 09:27:35 +0000
Received: by hermes--production-ir2-76fb978d99-bk4gk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 92da6572ad10db8075340d01696b622a;
          Tue, 02 Dec 2025 08:57:06 +0000 (UTC)
Content-Type: multipart/mixed; boundary="------------0qV9phgdwnJ2d9E3pJYe4Ssu"
Message-ID: <d2569de3-405f-4305-a05a-be104160d1a8@yahoo.com>
Date: Tue, 2 Dec 2025 09:56:58 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rt_task_resume() resumes a wrong task
From: Mauro S <mau.salvi@yahoo.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev
References: <144fcdcd-0944-4971-80fb-80ee7e72cb83.ref@yahoo.com>
 <144fcdcd-0944-4971-80fb-80ee7e72cb83@yahoo.com>
 <348b1bfc-8f0b-4e97-a100-999928f67ab5@siemens.com>
 <172ca47c-acb1-45cc-8e2c-3282c17354f5@yahoo.com>
 <90450dcc-6293-4835-8f75-788090a867ba@siemens.com>
 <348cb4d0-b82a-49e0-881d-fe75ee134964@yahoo.com>
Content-Language: en-US
In-Reply-To: <348cb4d0-b82a-49e0-881d-fe75ee134964@yahoo.com>
X-Mailer: WebService/1.1.24794 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

This is a multi-part message in MIME format.
--------------0qV9phgdwnJ2d9E3pJYe4Ssu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/26/25 12:50, Mauro S wrote:
> On 11/25/25 17:51, Jan Kiszka wrote:
>> On 25.11.25 16:10, Mauro S wrote:
>>>
>>>
>>> On 11/25/25 15:33, Jan Kiszka wrote:
>>>> On 25.11.25 13:23, Mauro S wrote:
>>>>> Hi all,
>>>>>
>>>>> Not sure if I found an obscure corner case or I'm doing something 
>>>>> nasty.
>>>>>
>>>>> I'm using Xenomai 3.2.8 on an Intel Atom system with Linux 5.4.299.
>>>>> Target image and toolchain generated by Yocto.
>>>>>
>>>>> Please find attached test case code.
>>>>> Program is very simple: the main task starts a bunch of joinable tasks
>>>>> that immediately suspend theirselves. After starting tasks, the main
>>>>> task resumes all tasks. They do a small sleep and then terminates.
>>>>> Terminated tasks are joined by another task, that was launched at the
>>>>> beginning of the program execution.
>>>>> Subsequently, main task continues to recreate, restart and resume 
>>>>> joined
>>>>> tasks, on and on, until a CTRL+C is issued.
>>>>>
>>>>> What I observe is that, when calling rt_task_resume(), the wrong 
>>>>> task is
>>>>> resumed.
>>>>> Please see the attached log. In this log I'm printing the .handle
>>>>> and .thread data in RT_TASK function as hexadecimal.
>>>>> At row 19 you can see that Task1 (that has .handle value fc1c9, the 
>>>>> same
>>>>> of the terminated but not yet joined task 0) has been resumed when the
>>>>> rt_task_resume() was called on Task0. Task0 has been terminated its
>>>>> execution, but has NOT been joined yet: if I'm not wrong its resources
>>>>> should not be usable until join is done (at least this is what I
>>>>> understand by documentation). I expect that calling 
>>>>> rt_task_resume() on
>>>>> a terminated-but-not-yet-joined joinable task should return an error,
>>>>> not resume another task. Am I wrong?
>>>>>
>>>>> I know that is some of a stressful test: in fact if I call the
>>>>> rt_task_resume() only if task is not terminated (checking also the
>>>>> executed flag adding "&& TaskList[i].executed == 0" into the if) the
>>>>> problem obviously does not happen, but as I said I expect an error
>>>>> instead of a wrong resume.
>>>>>
>>>>> Launching the attached code, you should be able to reproduce the 
>>>>> problem
>>>>> on your side. When the test detects a wrong resume, program terminates
>>>>> automatically.
>>>>>
>>>>
>>>> Can you rule out data races on the shared TaskList structure? Seems 
>>>> both
>>>> your sub-tasks and the main one are accessing it, and that possibly
>>>> concurrently and/or unordered. Or does this also trigger in a uni-core
>>>> setup?
>>>>
>>>> Jan
>>>>
>>>
>>> Hi Jan,
>>>
>>> attached the modified code: each access to a TaskList element is now
>>> protected with a semaphore (one semaphore each element).
>>> Strange behavior happens anyway.
>>>
>>
>> ...would have been too easy. Ok, will try the other day if I can
>> reproduce and maybe even understand.
>>
> 
> Hi Jan,
> 
> sorry, I should me more verbose in my response.
> First of all: no pressure, take your time.
> 
> Then, a more deep explanation.
> I added semaphores to avoid possible concurrent access on TaskList 
> elements, but I already verified that code should access them in an 
> ordered way without concurrency, thanks to "joined", "started" and 
> "exited" flags.
> In detail, TaskList elements are accessed:
> 
> - by main task
>    - under task creation, writing task handler and "joined" flag: this 
> happens only if task was joined before
>    - to resume task, reading some elements ("started", "joined" and task 
> handler) and writing "resumed" flag before resuming the task. Here, 
> "started" must be 1 and "joined" must be 0, this can happen only after 
> task creation and start
> 
> - by sub-tasks ourselves: during their execution. Variables written: 
> "started" (at the beginning of the task) and "exited" (just before 
> termination, after task is resumed and did its sleep). Also, verifies 
> "resumed" flag when got resumed, to check if resume request was for it
> 
> - by join task: this happens only if task is "started", "exited" and not 
> "joined". This can happen only after a complete subtask execution task 
> resets all flags and sets "joined" to 1
> 
> Printf sequence seems to confirm that execution order is OK.
> 
> 
>> If you would like to understand a bit more already, you could catch an
>> event trace (trace-cmd record -e "cobalt*" -e "sched*" -e "signal*") and
>> study the task interaction (trace-cmd report / kernelshark).
>>
> 
> I'll do the setup to trace events (I don't have trace-cmd on target, I 
> need to setup a qemu image with it).
> 
> Thanks in advance, regards
> 
> Mauro
> 
>> Jan
>>
>
Hi Jan,

I made a sequential version of the test application: instead of having a 
join task, join call was done by the main task, one subtask at time. 
With this code, tasks does not access concurrently to variables.
Problem happens also with this code.

Thanks in advance, regards

Mauro

--------------0qV9phgdwnJ2d9E3pJYe4Ssu
Content-Type: application/gzip; name="xeno-test-resume-seq.tar.gz"
Content-Disposition: attachment; filename="xeno-test-resume-seq.tar.gz"
Content-Transfer-Encoding: base64

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
g8FgMBgMBsP/hL9e8zrDAPAAAA==

--------------0qV9phgdwnJ2d9E3pJYe4Ssu--
