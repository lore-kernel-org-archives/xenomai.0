Received: from sonic305-19.consmr.mail.ir2.yahoo.com (sonic305-19.consmr.mail.ir2.yahoo.com [77.238.177.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E764C293B5F
	for <xenomai@lists.linux.dev>; Wed, 17 Dec 2025 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.177.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765963382; cv=none; b=CSzUYEfcIgDeHGd3dn/TIjSm21CR0f/2dTeG/bg4g640oU7+pircVHJ1eb1QfOSzCi+N42TUcaaIHb2jzuBpkwXmWohdnHaACNRrwKmoTDuRRnbOxox0vfFrYDdIaIrw8WYm3+tRtQF8TqTEjKS+m+BRLkJ2eWFrXpQ6fNO1IwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765963382; c=relaxed/simple;
	bh=dmGjrCt3rSJ6DfE33xK/q8VA0g8wp6SpSu4SPdO8qfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4naaNn7GwQHQgW1W5kuH/3nQ02ruiHmTmI6yXKRu2zpHM2GDzZFy8b2xYSD8xAIJUCO+PBx0bZaZiqRaEHgH/dhj1+ovU4Z2g1VD5lTqUhhWJlVJeDLvS0wym+UcNBbmpgzzJXdQkA0BxnlaMwGiiK316mceyzMkdEXMHVI8HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=QiqP+5ly; arc=none smtp.client-ip=77.238.177.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QiqP+5ly"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1765963379; bh=hPpiIus1bSB5Eo1v+ZA4DmN79lUjETjbefCPpqBe8EA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=QiqP+5lySOmqs7Yon7H6P+r1FpGpXFrXijYPqNrH16ptn+bOESdEXK0kaE9U6wUS26YGdxVpMOP+XZXC76fs5UEeQqV9eMAQw8R86M914kvPdqreHan92TLrScw1+loJTcXpTvyOkHBpIQxdupNjqUsU8mruNZobb8Ub7GxN9HIEKkCfXstGarkCJFYOLTZzk/ZXgnPvMJWmyWDp2iVe7fSuazmA/GvfyJFyqVebh0PL/CYIpoCQhxbVgSLgU0MdguI61ypD6o6o7NHFKvvUbfhQbxiE3lUDjwfnTqJxBo9DYi0t5/7/1jGPFi8S6O7fOJ08MjHs1oVIlHbdS7NM8w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1765963379; bh=3jgvo3mcF/rXxo+r21bU4zJPHbbdyHBO3tU5I3KKIEB=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Moi9Yon48c6x3zil0LeSIMDVPcmixTtpgbL33Ks1v1BGMhgbNWtNTIXCVxE1FN+a2mE4UZSH6PQol0odR0ivczSrD5TNtbTROm37FLjcesoVrwr1f+e2FwHAzbSldMPGN7B2tq5DsTx5SFTpsmk3FrVYR9G36fJuskuwB+x6y3KYGWWMOCtqPyTiYRDJUklN1HlcDe9q/LUm9yenZw6iwsWgnYKdQ29WxmLJxsipmQmRru3BVY2Rhmoz4oi2Yc7a565kGtMjZ22PstxoUZIJd3HoQYNJILlllxsaxRxOwT4asauIyFj4RDhqotobw7z288WnWp8goNkeWuXuILVTng==
X-YMail-OSG: notYcHAVM1noYkgLRe8cNBCoz_0Gofm8hytxHwxZVVA8yrC20s1zQ52xmcR8W4f
 Bmdb4NHY6VOYMvWYsIRv68RMUzz63wkPsKZEQjfkp65w3_6b48ngB7SXb_7mZM7PxzHPCwvrSfVb
 VBtfBMcDR5sJoDCz76IcpnGu73pWD9I9hyeB.9HG_uWgQPvTmqM9uNDX4QBZ7Nqb29L7d91.s7d_
 GktP7dQUGCu14C8sVq8is.WtbX2f9P4wxmfPozSscO2vTFFoMdEVMXmltSbXCxAj7iMzzx43g4mA
 OP1DzB1OXinhpsHwhTBouZ1v9cXvXYDyFTz.31aSsnyzC0Fkc5pjh0skYHMt50fqarkJT5YqBleJ
 8W8p9xypgxNOK0dFDWOJ8X9qJABdCMQQAGCCu1QAxmQH4CrVyA_f5jShFB67UiiEyZD3WtacFSTf
 SiAso5zo2cTHXj4T5B8Fff3_mFPM9.sV592BtRS2dzwC5tMPSTu2GE1.mtAixMi4VR1tJ1uRMAxX
 S2BdcP35NLbqK7B.etSlypT1FUsUaMM_7DrfWwwXmUqnZ0iTBFByjpIqjVFeQETv6sB.r.6DtHLZ
 OInky9_wXHKrOJdykoVx2fnVECe9Wf.Qm_M1uRmpP6s7.6uGZW0gPaBYNdBWKm2pix1QIkhWKPQp
 QfFI1fcnqxn9VuX953POGIWLyeNidnAzhpup9d4Fva1CCCPO9ImK_4Q0XkieSQjG3LXYD7oHwgkA
 xTQ0Nb9OMDKVisTSf_pAZZ6CPneKuE5_XK.9EM7WYVbI6DdGBbRPVOeNVnyXD9mRPqpxKzCgpj0D
 nOdSJvZ4TL4euj8OMFl70w9w5vUHD13AqOPQizCO9UeVuTVaD5cvmUkRdC2oFCfCmtSQH94YK6PV
 BWwtCDIK7Ibbkg_UtTPoK2gE5Sjx.YHhm27hIh6wkkGFZf5czM2PkZnKH1EFM29cd_VVYlINvEQF
 FE8UCDd14Sy30xz65gtf7elyeRguQU0b60n6xHYHsjGLenslHrC.VpdEyFAztixIdCRzbAGewiN7
 7dbcWZ2mYIyr5HyZmlnbo.uKaFzcDYvZllH6GuHQWk4WqGli6Yar9M4lieho4S_VaO.xsArAwpgA
 ITm4K8OwbYY_7NZo0VvR8PCC7QpIfLIsoAgxm81khbFSdECJJB.rbNiG6ANcNa7l5v6uWf.Fo3c3
 gcih1eH.GhH5HNSqBDtE1XkRJlxmNAAnoI2USGe5IKP.m4fPH5HlzKG7YZKeuAu57.dbr4emuRdx
 qEzBb75EBTVokVTD3JQFJojhUqXQhssSX41x.kZA2Ao.eNjQjsCcptCm4jF9_JdsvbMpA9N1czwJ
 b0N35hRChJWJ4ivMfn7MnFJ4gl6txGSe0Kqs9cij3Hp6qjzjKqUX8kWEOdjTClKFZssvYouS9Bnn
 gJtE.vvi7Av7g9DNtOwR85z4ZjXILOaFb7ei695etf5Ke_AxmK6zaKdBA5ApSI.mgfQUAb6r6IYR
 hi7K3VMja1HW6CD90uydpxfIPkxbcFKkbVtpkqaoUX3DJ.Bb7Hu.gDhUrfp1SIBWS0QrdYOXQaH1
 tlyd.4y8RHcz4hM7ZV7JU4JfJsO.wwX215VucQUh00oY8TLa.G._0NU6oyJIknZBdUCPmheWWEIi
 .NTh9Uqqgn8Y9Xj0imaFWI3T1Hj1enemKgnOjcolLXmVMRiOr.Cx2PO3OykL0ICm1xIYKtFjVxwl
 XzmQ7f8tAadkP0yX7349c0psf7abTRnM2rZVGTDsUuYvNfJ01HE35dFSomi20FHTMqQysmI9RjPz
 XHSVdonxP8W36._ok_iMb6p.rWucyJho6OtRkf.yXXojSEJMZGsiu5_vONkHER5myQ649q7gmEoZ
 oYJGUXkl7BRpV3xzPSIoy8ynMN9NMItuR0tNb5VQQqS3h36tvjC0kOpwRsU8U58h9CDQ3FMBI_kI
 xOddTPuV40BKVC0YkPu5D0p3VmNkdBYk8kwkkmwKSzwrR0RE6Irvoiri8hZUuTCLTWtQhjnTutsX
 NiNuclAKlpt3cZxz6CYNc6wPQsG6kD1d74EK9H0L0.46jPfNBPaw6bHRFWr9ffNkbNIF60UJikXC
 y9QtuFuwghkbJRT827DDH5DQ881Km__sTB973ki6SthpjV6jDNW10rD.dC65FErfixLdENpLuY6Z
 NI.2KZYNkofK3MLmGB9621LRWPzuoFMg0NlJ02Cdmo8AnyWHIe1AvYgzC2IEuWyK02iDTRP54vzu
 f5KGF_J.omUIeip3WLQLcrKUOmjlXx8bjED9AWSTj2LQh.fVNpQyAUw--
X-Sonic-MF: <mau.salvi@yahoo.com>
X-Sonic-ID: 44c4ab83-9d37-4531-b25b-28a68d4a945c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ir2.yahoo.com with HTTP; Wed, 17 Dec 2025 09:22:59 +0000
Received: by hermes--production-ir2-7679c5bc-jd2qw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e037658cd60c15cb52c7d223bcb9d51c;
          Wed, 17 Dec 2025 08:42:25 +0000 (UTC)
Message-ID: <651094df-88c8-4998-b389-28a6086704e9@yahoo.com>
Date: Wed, 17 Dec 2025 09:42:14 +0100
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
Content-Language: en-US
From: Mauro S <mau.salvi@yahoo.com>
In-Reply-To: <75ab33ce-0a98-4154-add6-9e8fa989b4eb@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24866 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/17/25 07:59, Jan Kiszka wrote:
> On 02.12.25 09:56, Mauro S wrote:
>>
>>
>> On 11/26/25 12:50, Mauro S wrote:
>>> On 11/25/25 17:51, Jan Kiszka wrote:
>>>> On 25.11.25 16:10, Mauro S wrote:
>>>>>
>>>>>
>>>>> On 11/25/25 15:33, Jan Kiszka wrote:
>>>>>> On 25.11.25 13:23, Mauro S wrote:
>>>>>>> Hi all,
>>>>>>>
>>>>>>> Not sure if I found an obscure corner case or I'm doing something
>>>>>>> nasty.
>>>>>>>
>>>>>>> I'm using Xenomai 3.2.8 on an Intel Atom system with Linux 5.4.299.
>>>>>>> Target image and toolchain generated by Yocto.
>>>>>>>
>>>>>>> Please find attached test case code.
>>>>>>> Program is very simple: the main task starts a bunch of joinable
>>>>>>> tasks
>>>>>>> that immediately suspend theirselves. After starting tasks, the main
>>>>>>> task resumes all tasks. They do a small sleep and then terminates.
>>>>>>> Terminated tasks are joined by another task, that was launched at the
>>>>>>> beginning of the program execution.
>>>>>>> Subsequently, main task continues to recreate, restart and resume
>>>>>>> joined
>>>>>>> tasks, on and on, until a CTRL+C is issued.
>>>>>>>
>>>>>>> What I observe is that, when calling rt_task_resume(), the wrong
>>>>>>> task is
>>>>>>> resumed.
>>>>>>> Please see the attached log. In this log I'm printing the .handle
>>>>>>> and .thread data in RT_TASK function as hexadecimal.
>>>>>>> At row 19 you can see that Task1 (that has .handle value fc1c9,
>>>>>>> the same
>>>>>>> of the terminated but not yet joined task 0) has been resumed when
>>>>>>> the
>>>>>>> rt_task_resume() was called on Task0. Task0 has been terminated its
>>>>>>> execution, but has NOT been joined yet: if I'm not wrong its
>>>>>>> resources
>>>>>>> should not be usable until join is done (at least this is what I
>>>>>>> understand by documentation). I expect that calling
>>>>>>> rt_task_resume() on
>>>>>>> a terminated-but-not-yet-joined joinable task should return an error,
>>>>>>> not resume another task. Am I wrong?
>>>>>>>
>>>>>>> I know that is some of a stressful test: in fact if I call the
>>>>>>> rt_task_resume() only if task is not terminated (checking also the
>>>>>>> executed flag adding "&& TaskList[i].executed == 0" into the if) the
>>>>>>> problem obviously does not happen, but as I said I expect an error
>>>>>>> instead of a wrong resume.
>>>>>>>
>>>>>>> Launching the attached code, you should be able to reproduce the
>>>>>>> problem
>>>>>>> on your side. When the test detects a wrong resume, program
>>>>>>> terminates
>>>>>>> automatically.
>>>>>>>
>>>>>>
>>>>>> Can you rule out data races on the shared TaskList structure? Seems
>>>>>> both
>>>>>> your sub-tasks and the main one are accessing it, and that possibly
>>>>>> concurrently and/or unordered. Or does this also trigger in a uni-core
>>>>>> setup?
>>>>>>
>>>>>> Jan
>>>>>>
>>>>>
>>>>> Hi Jan,
>>>>>
>>>>> attached the modified code: each access to a TaskList element is now
>>>>> protected with a semaphore (one semaphore each element).
>>>>> Strange behavior happens anyway.
>>>>>
>>>>
>>>> ...would have been too easy. Ok, will try the other day if I can
>>>> reproduce and maybe even understand.
>>>>
>>>
>>> Hi Jan,
>>>
>>> sorry, I should me more verbose in my response.
>>> First of all: no pressure, take your time.
>>>
>>> Then, a more deep explanation.
>>> I added semaphores to avoid possible concurrent access on TaskList
>>> elements, but I already verified that code should access them in an
>>> ordered way without concurrency, thanks to "joined", "started" and
>>> "exited" flags.
>>> In detail, TaskList elements are accessed:
>>>
>>> - by main task
>>>     - under task creation, writing task handler and "joined" flag: this
>>> happens only if task was joined before
>>>     - to resume task, reading some elements ("started", "joined" and
>>> task handler) and writing "resumed" flag before resuming the task.
>>> Here, "started" must be 1 and "joined" must be 0, this can happen only
>>> after task creation and start
>>>
>>> - by sub-tasks ourselves: during their execution. Variables written:
>>> "started" (at the beginning of the task) and "exited" (just before
>>> termination, after task is resumed and did its sleep). Also, verifies
>>> "resumed" flag when got resumed, to check if resume request was for it
>>>
>>> - by join task: this happens only if task is "started", "exited" and
>>> not "joined". This can happen only after a complete subtask execution
>>> task resets all flags and sets "joined" to 1
>>>
>>> Printf sequence seems to confirm that execution order is OK.
>>>
>>>
>>>> If you would like to understand a bit more already, you could catch an
>>>> event trace (trace-cmd record -e "cobalt*" -e "sched*" -e "signal*") and
>>>> study the task interaction (trace-cmd report / kernelshark).
>>>>
>>>
>>> I'll do the setup to trace events (I don't have trace-cmd on target, I
>>> need to setup a qemu image with it).
>>>
>>> Thanks in advance, regards
>>>
>>> Mauro
>>>
>>>> Jan
>>>>
>>>
>> Hi Jan,
>>
>> I made a sequential version of the test application: instead of having a
>> join task, join call was done by the main task, one subtask at time.
>> With this code, tasks does not access concurrently to variables.
>> Problem happens also with this code.
>>
> 
> Starting to look into this:
> 

Great, thank you!

>> STARTED TASK Task0 (82a9eab0-829636c0)
>> TASK Task0 RUNNING (self: 82a9eab0-829636c0  ext: 82a9eab0-829636c0)
>> STARTED TASK Task1 (82a9e2b0-829526c0)
>> TASK Task1 RUNNING (self: 82a9e2b0-829526c0  ext: 82a9e2b0-829526c0)
>> RESUMING TASK Task0 (82a9eab0-829636c0)
>> RESUMED TASK Task0 (self: 82a9eab0-829636c0  ext: 82a9eab0-829636c0)
>> RESUMING TASK Task1 (82a9e2b0-829526c0)
>> RESUMED TASK Task1 (self: 82a9e2b0-829526c0  ext: 82a9e2b0-829526c0)
>> TASK Task1 EXITED (self: 82a9e2b0-829526c0  ext: 82a9e2b0-829526c0)
>> TASK Task0 EXITED (self: 82a9eab0-829636c0  ext: 82a9eab0-829636c0)
>> JOINED TASK Task1 (82a9e2b0-829526c0)
>> STARTED TASK Task1 (82a9eab0-829526c0)
>> TASK Task1 RUNNING (self: 82a9eab0-829526c0  ext: 82a9eab0-829526c0)
> 
> So far so good.
> 
>> RESUMING TASK Task0 (82a9eab0-829636c0)
> 
> And here you are resuming a task that is in waiting-to-be-joined state,
> right? That is an application bug, but one may expect it to be either
> ignored, only affect that Task0 negatively, or even throwing an error
> back to the caller.
> 

Yes, exactly: task is ended yet, then should be joined and not resumed, 
but I would expect that the resume command was ignored and/or an error 
was returned.

>> RESUMED TASK Task1 (self: 82a9eab0-829526c0  ext: 82a9eab0-829526c0)
>> ERROR: RESUMED TASK Task1 (self: 82a9eab0-829526c0  ext: 82a9eab0-829526c0) HAS NOT BEEN ASKED TO RESUME
> 
> Instead, we see that spurious wakeup of task1. Let me debug into this...
> 

Thumbs up!

TIA

Mauro
