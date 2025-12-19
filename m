Received: from sonic301-21.consmr.mail.ir2.yahoo.com (sonic301-21.consmr.mail.ir2.yahoo.com [77.238.176.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E8832A3CF
	for <xenomai@lists.linux.dev>; Fri, 19 Dec 2025 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.176.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766153536; cv=none; b=j6BLvcPmCj3oYYlYJl716Y1EXnVZcwdW/LMT+/68arwY/0O7SwEauLx+tR3jDe/iA8gPX8jh9mdNfdBppi961WZG7+ojZFAkenX2LGy40fZZPG2RtFchDmhJUazyxWZ5C7Ouoo0jyfT8oodQyGoT+RjTz3/lLUyNHjNc400YvgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766153536; c=relaxed/simple;
	bh=PBQbf95JMac6/+OrRbUuanU83GBETrUgH/+qooV8k4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XvoLpQGKWgS6OHdzCpnN9WN2zBYRcbWaEnUkX4iRdMkXV05zk4M46rKcbZsqxtgSeJZ9WjPIqrfRoTiQ9B9w+3KsPy/aK8UKd23AhKlpZT9jmNaniyJdrO/q9JxUkyTIhCq7ynfL4qp20mXDrFM+iO/170rkPvUEIYvHB9dagMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=NHB5auY4; arc=none smtp.client-ip=77.238.176.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NHB5auY4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1766153527; bh=gfiOQhBgen2TJgaEewbbWQtYg0zCuGTaNdQo6JxyCAA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=NHB5auY46937cjmCS0RBKnfiGW6VvJMYlXWgHWR3cuE7rCsgZ/PSvoO5JWWzN2zyFlZDFFRZSGdnjIffwpxPEqc3vtbSX9czu8HHuB8GKePCSRPmaqwOzXXpU2xmOAqM4LkPVhm0atgQR4Dl/nhV050czkmItgueBhDR1AVyvfUDPrpdehMg6+Xvuj01rFCzu9uccCihiU6vCNuClTINhdguSgD+uNjLjEbE4os5fssXDAATIAchsjDdna7GIcR8nYoyOWSsFWV8X8hdZtObYeMFcpt4Ly3JXze97M4nZ9n4v7c+BMIOd3JMKk7PlilkfmHWM3d+Xj31WTIgPdL3BA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1766153527; bh=PT977OKsnhvR/UG+uYQHDpD5DkKG6JhMgm+/TBtf1Kf=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=tocP6oFwfHOOkd9dtu4hARWSfMMpra833/mRzFfjv9SV0MPS9q/46mUwecDxqkJ9vlmaIx91+kXN2ngzEmk2uoA1fQGRtOBhNXu8FHzE93aVKjqIiE2b7Cv67lx6/xWA1KoQYZzKJIUS+q6sgjrECFgM0CTMFN4EL9ogTZj/+eQ909bepLLcH0jIk0Ti4t8hVtsdk4HYGc7VDkO+YKLULEVgW5Dd+vmyrvsDJ1WsQJ9IpmTODw0qrrkz8rxbh0HFfsT3l/C7fZD929cgMlf+ZgeyLHjTep3WuIrEe7fhhxCZszLrToWKwLxO14PC/q0QymayoNUGNY2Vc8HkmTBWmw==
X-YMail-OSG: ZNKYhOUVM1kqGoMCoZnqGb.9ekncJli5AwUGSoh8AT7liHWOYFoTPJ89d0l8RjK
 kTWhQFWOjl0rirFOA28v4n9cJviy0KxljutEP5jUEea48GILVcFaYUHd2DETwOzwtwNotN3LpY8R
 bxfhbS_8iBkQSBfG8p_ErB2nZPuhyfkHWC7V5wEFM3zOznDwS_XNW7Fg5R.EbiuncnKjDFXQeVF0
 .e5fAawxP6NooBY6o3bfVtHUEbXcBzrP6QUT6UA_3HiRFyi4DTHnlj0iFL5qfojgMOBt5U6jCI1y
 ERuDFcpYt3hFNN.3na7Ig1vsDnLcBbimWm7a711RFBfAC76gqfjJoQoMI8cBqprTi6en2K5mXOQz
 ahHNoTElhJN_5z7wgYROfnKs44Dvb0qp6KEE2UCFWcgXi56pRZBziPn_cPuXU7CAm2nGKYyPn7ox
 MCPao.XZ0juTqCCzH5gzwP26CYys9lmL5PFinqEnq84WuMny5.ZjUCBwPjB7iGkvskIFRD8guWYk
 7VR.cu5SAQUZ_p8WPCDL4i_miQo_uwOdrBM7o.iVjNz4zXX.83NnTYZj0Qfd31vnoEg9YbwDNjJh
 RJS8UdOVyIxIwQuGn66NKo1sB88FRnzB4wj4T6fIgjQbeNQuXL3kWDqr0I9Z41iJXajMOBx0rx9r
 _jt1S6dA2AsrSATsYFjhmb.7l35dl8wVHCikOCwDQy3AN4y7z2mUluzqVFiAWjk7WqC8EUyRJlkE
 SamQtuQcEqDqtytOaNUkenbzFJa.fYnBjZnOEX02C3bI54J_ak45XXljbvZh89xRKkaW1MO7wmn2
 SV1txYG21XWJPe1vAOX0PLJ3HWHKvVRFesSh0trEyu3u42n9z6Wo7xajDanzQR1h6YroYwydRvfC
 .gV.dFxGMDJLvWDO20QjTAN8hiImedGCd34Zz1_6elWK1Izlq.HtGdSmJ0QFD_10CXbOXau_guF7
 Ccz.3fhAYbRWRJn6C.wxeiguzMCRZwQPw_gNyAAyBF7RDgr.zQXiQvMpRxIlctVwaHuaeR0cfyMU
 zysrXrU1mJ919E7sYH2dHsLoDDGgcy5ZwYP8uLN09C5SJUeXGp22cAq_0CMuc3PkOzWm5PmbbPLw
 koO9FjRm6GbijqpvldsOjVYuQLxe_LeaduIswFem7VRavZqO73io56d54rkrmiuKob8WLOwQcnB3
 MnFg7IIf4_pf2YTvEUNf9TiAycsYRuWmUsFXKRXMG3ImYEUlOgxubHRVPuzckgo5VTsRccgy1A.5
 58V_8_sJxwXFs2a4_Z19hRxSvl.HTL6qROCvlBJkfBoVa9sKv8POxbSFNhqquQUe0Q2.85xVQheL
 Zomp1W9bej3M1UYII.QvM3aT68haEC0oe7cOxfeoxbdWToB7GAiToJ1JmLc6z00w_gQnbY2MPcIi
 26J4q.o7__Qhd9ztsRpLW0hNs4vJxAL2ADWHYbvst.bRHdGY8JvkzhUA1a4q_wOxAlXoYRyGufFx
 DP1qVzEjLeJIcJ1Li8jMqoZdZhIdGO5mbsUy5ORSUWF_Df1gejjlblyrzZvKvZ1Lp1Z8C9MVD6fy
 S83FiCWDg64JX3jFN0v_4ixmK.DuMzNgZxxuscqIJzllrEaQ_FkWaS3.ssGDSIMGCcF.gBKxM.Za
 MTy.C0S5nLaRd6xKdCHdx4HPvkGE0bOoGutxn8AUZ7169Lvpmnl2o3zQu6hkTkbjq9.mbUuEm7Lx
 TQrUG83RFyT8ud8Y3UTuNDFF9juXUnfIDwRAywkb7mvuSE.5_u1DCz4Y9XMydN0WkGXP4C5.X5DV
 HYntJaLOwZKxBg8zvTLvCZS99OXICsrWdIEp6a_z7cMJybQ2SDt9ewENpFMez661CgWdreGw7R7U
 fUwOqODi4w9y.4OfnhS4F36WDB_Kklr.uK_e9Miyxbh3QsWwc.x7fb_rbokS7tmEwqzFmT68GK5M
 wYiQjbFapllklFT6atfNAw2fMprZ1RRdj4ijGPUGM.MDuF9ex1gYWwcg5Ks1qe5eScq6V_wyVKSt
 K3umGawOyPO2wqkZAKzUQbL04pUbxM6R4wvgeEzOe2XMXG3t0DB8VWdC.EXPaRmI.3YrzhFM8n_X
 xtRWjgMNYIOCRzRnyA1TIf3XBx04lAaL8dAdhVpgYyxYgBjtKKA9YZvEzY2pao51JJalFevXGViP
 yuAkJB74OPWFR_3qKUieYjEljvUTohU1Hm.RyZgmNlPZd1wsMvPdGvmzHvhZXAFtglZCDzqjJpuc
 3C3NUYozkqoqlY9RHbizdsCQh65C3DuTodjEhuHGK0jsOxsN.GciMy.VAPmbgvm59fbYiABV6eAp
 aGcxZgWkOeQRERKk-
X-Sonic-MF: <mau.salvi@yahoo.com>
X-Sonic-ID: 582932e2-3b61-4695-846f-32ae49019c31
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Fri, 19 Dec 2025 14:12:07 +0000
Received: by hermes--production-ir2-7679c5bc-h9fxd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5b0be7ebf09fd01b5f492b3bdc599bf6;
          Fri, 19 Dec 2025 14:12:04 +0000 (UTC)
Message-ID: <f9116b18-0aa2-4b32-bce1-98913cf0c721@yahoo.com>
Date: Fri, 19 Dec 2025 15:12:03 +0100
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
 <d8dd9ec4-1f98-48b5-b877-39a1de243081@yahoo.com>
 <badbf3d2-4ff7-4d72-ae3e-24898f84c015@siemens.com>
Content-Language: en-US, it
From: "Mauro S." <mau.salvi@yahoo.com>
In-Reply-To: <badbf3d2-4ff7-4d72-ae3e-24898f84c015@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24866 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/19/25 07:50, Jan Kiszka wrote:
> On 17.12.25 17:16, Mauro S wrote:
>>
>>
>> On 12/17/25 13:31, Jan Kiszka wrote:
>>> On 17.12.25 09:42, Mauro S wrote:
>>>> On 12/17/25 07:59, Jan Kiszka wrote:
>>>>> On 02.12.25 09:56, Mauro S wrote:
>>>>>>
>>>>>>
>>>>>> On 11/26/25 12:50, Mauro S wrote:
>>>>>>> On 11/25/25 17:51, Jan Kiszka wrote:
>>>>>>>> On 25.11.25 16:10, Mauro S wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 11/25/25 15:33, Jan Kiszka wrote:
>>>>>>>>>> On 25.11.25 13:23, Mauro S wrote:
>>>>>>>>>>> Hi all,
>>>>>>>>>>>
>>>>>>>>>>> Not sure if I found an obscure corner case or I'm doing something
>>>>>>>>>>> nasty.
>>>>>>>>>>>
>>>>>>>>>>> I'm using Xenomai 3.2.8 on an Intel Atom system with Linux
>>>>>>>>>>> 5.4.299.
>>>>>>>>>>> Target image and toolchain generated by Yocto.
>>>>>>>>>>>
>>>>>>>>>>> Please find attached test case code.
>>>>>>>>>>> Program is very simple: the main task starts a bunch of joinable
>>>>>>>>>>> tasks
>>>>>>>>>>> that immediately suspend theirselves. After starting tasks, the
>>>>>>>>>>> main
>>>>>>>>>>> task resumes all tasks. They do a small sleep and then
>>>>>>>>>>> terminates.
>>>>>>>>>>> Terminated tasks are joined by another task, that was launched
>>>>>>>>>>> at the
>>>>>>>>>>> beginning of the program execution.
>>>>>>>>>>> Subsequently, main task continues to recreate, restart and resume
>>>>>>>>>>> joined
>>>>>>>>>>> tasks, on and on, until a CTRL+C is issued.
>>>>>>>>>>>
>>>>>>>>>>> What I observe is that, when calling rt_task_resume(), the wrong
>>>>>>>>>>> task is
>>>>>>>>>>> resumed.
>>>>>>>>>>> Please see the attached log. In this log I'm printing the .handle
>>>>>>>>>>> and .thread data in RT_TASK function as hexadecimal.
>>>>>>>>>>> At row 19 you can see that Task1 (that has .handle value fc1c9,
>>>>>>>>>>> the same
>>>>>>>>>>> of the terminated but not yet joined task 0) has been resumed
>>>>>>>>>>> when
>>>>>>>>>>> the
>>>>>>>>>>> rt_task_resume() was called on Task0. Task0 has been
>>>>>>>>>>> terminated its
>>>>>>>>>>> execution, but has NOT been joined yet: if I'm not wrong its
>>>>>>>>>>> resources
>>>>>>>>>>> should not be usable until join is done (at least this is what I
>>>>>>>>>>> understand by documentation). I expect that calling
>>>>>>>>>>> rt_task_resume() on
>>>>>>>>>>> a terminated-but-not-yet-joined joinable task should return an
>>>>>>>>>>> error,
>>>>>>>>>>> not resume another task. Am I wrong?
>>>>>>>>>>>
>>>>>>>>>>> I know that is some of a stressful test: in fact if I call the
>>>>>>>>>>> rt_task_resume() only if task is not terminated (checking also
>>>>>>>>>>> the
>>>>>>>>>>> executed flag adding "&& TaskList[i].executed == 0" into the if)
>>>>>>>>>>> the
>>>>>>>>>>> problem obviously does not happen, but as I said I expect an
>>>>>>>>>>> error
>>>>>>>>>>> instead of a wrong resume.
>>>>>>>>>>>
>>>>>>>>>>> Launching the attached code, you should be able to reproduce the
>>>>>>>>>>> problem
>>>>>>>>>>> on your side. When the test detects a wrong resume, program
>>>>>>>>>>> terminates
>>>>>>>>>>> automatically.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Can you rule out data races on the shared TaskList structure?
>>>>>>>>>> Seems
>>>>>>>>>> both
>>>>>>>>>> your sub-tasks and the main one are accessing it, and that
>>>>>>>>>> possibly
>>>>>>>>>> concurrently and/or unordered. Or does this also trigger in a
>>>>>>>>>> uni-core
>>>>>>>>>> setup?
>>>>>>>>>>
>>>>>>>>>> Jan
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Hi Jan,
>>>>>>>>>
>>>>>>>>> attached the modified code: each access to a TaskList element is
>>>>>>>>> now
>>>>>>>>> protected with a semaphore (one semaphore each element).
>>>>>>>>> Strange behavior happens anyway.
>>>>>>>>>
>>>>>>>>
>>>>>>>> ...would have been too easy. Ok, will try the other day if I can
>>>>>>>> reproduce and maybe even understand.
>>>>>>>>
>>>>>>>
>>>>>>> Hi Jan,
>>>>>>>
>>>>>>> sorry, I should me more verbose in my response.
>>>>>>> First of all: no pressure, take your time.
>>>>>>>
>>>>>>> Then, a more deep explanation.
>>>>>>> I added semaphores to avoid possible concurrent access on TaskList
>>>>>>> elements, but I already verified that code should access them in an
>>>>>>> ordered way without concurrency, thanks to "joined", "started" and
>>>>>>> "exited" flags.
>>>>>>> In detail, TaskList elements are accessed:
>>>>>>>
>>>>>>> - by main task
>>>>>>>       - under task creation, writing task handler and "joined"
>>>>>>> flag: this
>>>>>>> happens only if task was joined before
>>>>>>>       - to resume task, reading some elements ("started", "joined" and
>>>>>>> task handler) and writing "resumed" flag before resuming the task.
>>>>>>> Here, "started" must be 1 and "joined" must be 0, this can happen
>>>>>>> only
>>>>>>> after task creation and start
>>>>>>>
>>>>>>> - by sub-tasks ourselves: during their execution. Variables written:
>>>>>>> "started" (at the beginning of the task) and "exited" (just before
>>>>>>> termination, after task is resumed and did its sleep). Also, verifies
>>>>>>> "resumed" flag when got resumed, to check if resume request was
>>>>>>> for it
>>>>>>>
>>>>>>> - by join task: this happens only if task is "started", "exited" and
>>>>>>> not "joined". This can happen only after a complete subtask execution
>>>>>>> task resets all flags and sets "joined" to 1
>>>>>>>
>>>>>>> Printf sequence seems to confirm that execution order is OK.
>>>>>>>
>>>>>>>
>>>>>>>> If you would like to understand a bit more already, you could
>>>>>>>> catch an
>>>>>>>> event trace (trace-cmd record -e "cobalt*" -e "sched*" -e
>>>>>>>> "signal*") and
>>>>>>>> study the task interaction (trace-cmd report / kernelshark).
>>>>>>>>
>>>>>>>
>>>>>>> I'll do the setup to trace events (I don't have trace-cmd on
>>>>>>> target, I
>>>>>>> need to setup a qemu image with it).
>>>>>>>
>>>>>>> Thanks in advance, regards
>>>>>>>
>>>>>>> Mauro
>>>>>>>
>>>>>>>> Jan
>>>>>>>>
>>>>>>>
>>>>>> Hi Jan,
>>>>>>
>>>>>> I made a sequential version of the test application: instead of
>>>>>> having a
>>>>>> join task, join call was done by the main task, one subtask at time.
>>>>>> With this code, tasks does not access concurrently to variables.
>>>>>> Problem happens also with this code.
>>>>>>
>>>>>
>>>>> Starting to look into this:
>>>>>
>>>>
>>>> Great, thank you!
>>>>
>>>>>> STARTED TASK Task0 (82a9eab0-829636c0)
>>>>>> TASK Task0 RUNNING (self: 82a9eab0-829636c0  ext: 82a9eab0-829636c0)
>>>>>> STARTED TASK Task1 (82a9e2b0-829526c0)
>>>>>> TASK Task1 RUNNING (self: 82a9e2b0-829526c0  ext: 82a9e2b0-829526c0)
>>>>>> RESUMING TASK Task0 (82a9eab0-829636c0)
>>>>>> RESUMED TASK Task0 (self: 82a9eab0-829636c0  ext: 82a9eab0-829636c0)
>>>>>> RESUMING TASK Task1 (82a9e2b0-829526c0)
>>>>>> RESUMED TASK Task1 (self: 82a9e2b0-829526c0  ext: 82a9e2b0-829526c0)
>>>>>> TASK Task1 EXITED (self: 82a9e2b0-829526c0  ext: 82a9e2b0-829526c0)
>>>>>> TASK Task0 EXITED (self: 82a9eab0-829636c0  ext: 82a9eab0-829636c0)
>>>>>> JOINED TASK Task1 (82a9e2b0-829526c0)
>>>>>> STARTED TASK Task1 (82a9eab0-829526c0)
>>>>>> TASK Task1 RUNNING (self: 82a9eab0-829526c0  ext: 82a9eab0-829526c0)
>>>>>
>>>>> So far so good.
>>>>>
>>>>>> RESUMING TASK Task0 (82a9eab0-829636c0)
>>>>>
>>>>> And here you are resuming a task that is in waiting-to-be-joined state,
>>>>> right? That is an application bug, but one may expect it to be either
>>>>> ignored, only affect that Task0 negatively, or even throwing an error
>>>>> back to the caller.
>>>>>
>>>>
>>>> Yes, exactly: task is ended yet, then should be joined and not resumed,
>>>> but I would expect that the resume command was ignored and/or an error
>>>> was returned.
>>>>
>>>>>> RESUMED TASK Task1 (self: 82a9eab0-829526c0  ext: 82a9eab0-829526c0)
>>>>>> ERROR: RESUMED TASK Task1 (self: 82a9eab0-829526c0  ext:
>>>>>> 82a9eab0-829526c0) HAS NOT BEEN ASKED TO RESUME
>>>>>
>>>>> Instead, we see that spurious wakeup of task1. Let me debug into
>>>>> this...
>>>>>
>>>>
>>>> Thumbs up!
>>>
>>> Ok, here is the catch: The task handle that was used for task0 is freed,
>>> even before someone joined that task. And task1 handle was freed as well
>>> before you call CreateAndStartFn(1) again. Now your task1 will get the
>>> handle of previous task0, and when you try to use that stale handle for
>>> resuming task0, alchemy looks up the new task1 instead - and resumes
>>> that.
>>>
>>> I looked a bit into whether we could delay the handle deregistration
>>> after the joining, but that would be a hairy operation, likely also
>>> affecting libcopperplate. Given all that, I think we are safer off
>>> living with this "specialty", rather than risking instability in the
>>> cleanup path to handle the application error a bit nicer.
>>>
>>> Jan
>>>
>>
>> Ok, got it.
>> IMO this behavior should be documented somewhere because it's not what a
>> user would expect.
>>
>> Just throwing out an idea (that could be completely wrong): to
>> workaround the deregistration issue, should the resume function use both
>> the two RT_TASK fields to decide if resume or not a task, resuming it
>> only if both the two IDs matching? From the log seems that the second
>> field (pthread ID?) stills occupied until the join happens.
>>
> 
> I played with that idea. It initially looked simple, then reveal a
> catch, but I think I was able to address that as well. Please have a
> look at the patches I just shared.
> 
> Jan
> 

Hi Jan,

I've seen patches, thanks a lot!
Unfortunately I'm not able to test them on the final system, but a quick 
test in a QEMU machine works properly (no doubts about it).

As soon as I'll test on the final system, I'll be back with a feedback.

Thanks again, regards


-- 
Mauro S.
