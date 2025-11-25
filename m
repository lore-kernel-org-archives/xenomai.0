Received: from sonic309-24.consmr.mail.ir2.yahoo.com (sonic309-24.consmr.mail.ir2.yahoo.com [77.238.179.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF435328266
	for <xenomai@lists.linux.dev>; Tue, 25 Nov 2025 15:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.179.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764084626; cv=none; b=b3R1To4hB26gBCP/N410jYs27VtPJXp04Oge2JAeuiFIyuOEGhPMDNy3ppczDrLRe/Wcr6byQh7lYElZD5o35KnLXQD1YkVG8zLWuWoSMJ+dIo6X6FddktBlM6JQK+ZM7gMZTSc3j4YE2FeM61eQh06gMrlAP83jNtim9Z4jn/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764084626; c=relaxed/simple;
	bh=RGsvxTg/gjV3KNp4D2HXTO0vDc9XGyrH9O8x9McvqPs=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:References:
	 Cc:From:In-Reply-To; b=cPFsvpfllVx3raGn34jicBi7xvztfSz0G9UPimq5E60KAuFmucwphkB3oBbMp4qI2hDQTDEyPIeHReutYg9FgiSR67egjs+ktFhDl7C9kQpdQNezk97SlHMKEx+S4zQ6ENvwBpe/y608kKS/SKrcr6bgf2Ch5a4Xsuqk1HfGGyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=nUMZ+h5g; arc=none smtp.client-ip=77.238.179.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="nUMZ+h5g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1764084622; bh=xvEGsl5rKXpCAWq+/WuZqJL8sfy54G8kFUnNvLQ7XAU=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=nUMZ+h5gBteZi5yp7YJScdMtxKBgC4VDlcJEqxKBjRzrQ2zFHcUHLGqc39QRBF43NwNao1Os56jarV9u91+xv/r1T5ZxLe0h9QlV0jH6cH0i045Ygo8L+V8jfCxX71bqvvUKY+qPyi215ByRgMYXHjZzc+bYHJJwD80mnceXxu3hWuMHU6ik6fA0g9b/g6rhmy3AhIxN+BQS0D6H1fkC4PGZM4b42uQMLsjJGnOdqwHU9G4VLiMte/Ozd6709edxmGEENNrGi3oGsXYoaOQg/b4ZDl7TyEBtHPmErHAiDpGPBiXdBsKCrcxMOibEkMOb2CUCzHJYBvW7kP5zvHZVSg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1764084622; bh=RY0X7Jk7ypvg0m27vF8ERIubOWnYmkcyxR0S/MKif+l=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=lj0ZidIoe6NZUCYbKsAJz0IHgB+PnanNWdX4lvfnVsIftvR5YCBGWWOJE8DGP7BAiMqyzttHck3pZa20toDZFg8dX+j32CaidYTetoQI6dp28rv1V+mCI9JVC2wQvgmFajG9wltC67ajYfQfvQ5/ELftkGXKeYl+aOsngWnMq8/jrJie+ij9VuGy4hzbnP0aOeVOTPJDa89GP+ZJqt1Q4fHmuiaQzU3fMXTDiKfTFrSn5d34iMNw2GZPnOH1HcdTOOkn+W5A9rBThvGjoqOFB6h381UdrUtk/mSpDXklTPdBDLh8kK/7iqg9V4IOCeWMRzF7DsCw9sj34OfMaZynOg==
X-YMail-OSG: e6KcUhQVM1mLMfd3SLPTLlCoIk_iLEMu1ycujMwv1jDrELioLTSVlJ_88Cit1xI
 cNA1TMnBlgdreBUlpxVacwt5A2zPL8Z8X1Plsay5EWFv8Fy8sAlisSebTt5hGgFS16A.s2w0p1_8
 P.iswQoFbWfl0YRZSevNPOQNqGI3PJYkTBNKh5_Rg2RKfvhtjmjImsLwbp48K._s4IP5zL7_RAn0
 n.B5l4nA115ECoxyetBi4lDkF1kuooVFpqgd9rm3qasTsQBdWl23DoqBQ3W.sZd9ZCrn2R9PDEfX
 M90VycGphNLBbVoOyzrIgaY08Yr0QhXQd.HfYEXqCEtPaCqhKw3zJZMOoI8EcOvGWMDRxA7JaCog
 dQFxk4SelW17vIzF8qHgMa.A6gujzM.hFXC4dQIOYD0l.NCP7_1D.WtfBGP3glmrpsclFM4g2k4V
 p9paBfny0TpZrFmIqNAbu.adn2UT7i4WVbngiGXwzWJdyPCw_CAh1KB3DwHVw5pCcsXVptcaKzdL
 UBIf.3xM43_JgZXq4lWhqa5dZDjAOwHCZZUzuCL3GjwAThQg4rYz2hgKkGpbjQS2GsPn4wxOeasX
 JepyvuYEwx2ERLrm0mGTqfC_E7pW6dDagrdG6.scUcT5jlwBCQglo7OA7rZwBoqxXJiMVGCcxNtv
 zm1tzqPH_.kajfvakylQBgSstpcNEX.VJ7nRRUqZlgAZc6H..K0EA2MjM7HHRCs3kwpu_FeghlcZ
 vhpnFzbf3wSDUb7KdV_Ifzbl1V9jmd.VsH2BN3kodNL6bMIlO6jSDtPAdrSS1ctu6ICXkylDS7El
 realqmPeZKDNDLVRiZbgZMrGNF_Wk_isiKgtgQLcnjKQ7wO2KuEtg_xwFQCXKxHeePaPiyc.I_N9
 qVNEk2kvynXx.ijFavRWthXlomwfqr.bIqd61QHgeUBeAC08XxvGulbs7p_f4T8v0DNw9dcKMu5T
 4d.SJrc5HMuvMzOPl0L286nvEFuti0O18Qzgw1Ku6xCZnpTd.rnuNfQ3uam5yekl5OU_rueQPXU0
 OEGnWKYEjgva7d.9XvNOjAEBJYW.lHBIrfcBO6_8UqRiM5oZtUVIJL_xB4hWU0zmSRKfx7mDKPHF
 G1uUeJsF9ZR4VhjI5AVABWmBAWUdH.aSLgKR61y7kGbKNlmoQGtVR9qGXUwTbmRcrbbofKft62im
 uqJOYO1d_G3C3Mf196u.Fkys.dMdVRu6i7v8uEUSIRn7_mLC4GFctvoAkI5lwWuZPbLvNH0HtTA5
 AFgjQ795zR0f8rIZmiy.B9xcK9PRyzmUeqwFD4bQ3tl2BkT5P3aXnnmHYdmcjriV2u__X9f7Z96C
 Ez629BOyHZyMp5q1pzxQ3WIEgk_HJI1yAeRCTt6dTEd62RDL9GKM_YnlIt4JIAPNIMc335lW_QYz
 olAStk.ZTgXUFXuJGlwZHCro8Xg3s3TFD4iAWD25iGArr92Xy2XZm6nuH5q.VwGRe0qNMA91AeB9
 PLW9iffpzQr6YR.2VC7m0jc8c4myIJhC_aj.R2W31CyHu9PR18yjvH9GGfFd9DukjWS4shDNwuvl
 duEn2ENuGc808yr_59zHkmhwPexfdZ0T4mHMzs1QxdFW8ofHr_YcNi7c9DBq7J3HWc4GcBhIo7Lw
 ZBFoBUigAarn1iPmh0KOhFAH6cgpAIYdHvBaLfPvRYwP1avQ8bEiVyOUYWhJODv6EL6e9pVMSjC5
 72WSc2noEsc7n4xbpVQI6vxhmkOx_ej.Wqn3Y0w2DecgQYBYm6H5FmTXekRgVL2LLEuTYWowj5WW
 J_mh.IncwL1Ocv3BxvM39mwuxv60npPauOar0XvISiS_e_geNPDM0iMOUpWJ4m8FxSjHNB1lxrpp
 Xsi68gQ6LrQU_565EKSmpd81ylRygIimjVhq.NrQ1pK.EK4OGCg4CXgOmDGx2e2PFvRj.4.X7yS0
 8H58UEGM7TV93TiTQae9DRHBXdQ_tgsqwt03ttzNDbEARu3i4.ZQwO2GfDdQqo1taowCJQOJcbv4
 x4J3sbCWSNxtq0QD8O_A8e0YW_4tMmczHw8EYmlbhmJrinYIeOxLL4JNlopSwG0qhr40qNC0B5te
 p3W3yIOM5WZgCBY1GnRWXwLnxRyq65d5D61Nm.beS_pP69WDyNfrJabTzu7t.UpSp4og0PZxziJO
 w4hzn6OV8RNG2oLh31GsWe9qFfsQml_ecoD8M8K3FGbGI1FTXuSuTypTkEESrUV19p6NntIAX.is
 jmgRdPEzZKCF8sHX.eYEMHmMtqeo8zbHo
X-Sonic-MF: <mau.salvi@yahoo.com>
X-Sonic-ID: c0cd101f-93cd-49e5-88ba-8fa7afef0981
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ir2.yahoo.com with HTTP; Tue, 25 Nov 2025 15:30:22 +0000
Received: by hermes--production-ir2-76fb978d99-fx5fk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2251d36d8ef3016a69de15cdfb9f570b;
          Tue, 25 Nov 2025 15:10:03 +0000 (UTC)
Content-Type: multipart/mixed; boundary="------------OYu97WgZ90VE6Ozm5zoLi07U"
Message-ID: <172ca47c-acb1-45cc-8e2c-3282c17354f5@yahoo.com>
Date: Tue, 25 Nov 2025 16:10:07 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rt_task_resume() resumes a wrong task
To: xenomai@lists.linux.dev
References: <144fcdcd-0944-4971-80fb-80ee7e72cb83.ref@yahoo.com>
 <144fcdcd-0944-4971-80fb-80ee7e72cb83@yahoo.com>
 <348b1bfc-8f0b-4e97-a100-999928f67ab5@siemens.com>
Content-Language: en-US
Cc: Jan Kiszka <jan.kiszka@siemens.com>
From: Mauro S <mau.salvi@yahoo.com>
In-Reply-To: <348b1bfc-8f0b-4e97-a100-999928f67ab5@siemens.com>
X-Mailer: WebService/1.1.24794 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

This is a multi-part message in MIME format.
--------------OYu97WgZ90VE6Ozm5zoLi07U
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/25/25 15:33, Jan Kiszka wrote:
> On 25.11.25 13:23, Mauro S wrote:
>> Hi all,
>>
>> Not sure if I found an obscure corner case or I'm doing something nasty.
>>
>> I'm using Xenomai 3.2.8 on an Intel Atom system with Linux 5.4.299.
>> Target image and toolchain generated by Yocto.
>>
>> Please find attached test case code.
>> Program is very simple: the main task starts a bunch of joinable tasks
>> that immediately suspend theirselves. After starting tasks, the main
>> task resumes all tasks. They do a small sleep and then terminates.
>> Terminated tasks are joined by another task, that was launched at the
>> beginning of the program execution.
>> Subsequently, main task continues to recreate, restart and resume joined
>> tasks, on and on, until a CTRL+C is issued.
>>
>> What I observe is that, when calling rt_task_resume(), the wrong task is
>> resumed.
>> Please see the attached log. In this log I'm printing the .handle
>> and .thread data in RT_TASK function as hexadecimal.
>> At row 19 you can see that Task1 (that has .handle value fc1c9, the same
>> of the terminated but not yet joined task 0) has been resumed when the
>> rt_task_resume() was called on Task0. Task0 has been terminated its
>> execution, but has NOT been joined yet: if I'm not wrong its resources
>> should not be usable until join is done (at least this is what I
>> understand by documentation). I expect that calling rt_task_resume() on
>> a terminated-but-not-yet-joined joinable task should return an error,
>> not resume another task. Am I wrong?
>>
>> I know that is some of a stressful test: in fact if I call the
>> rt_task_resume() only if task is not terminated (checking also the
>> executed flag adding "&& TaskList[i].executed == 0" into the if) the
>> problem obviously does not happen, but as I said I expect an error
>> instead of a wrong resume.
>>
>> Launching the attached code, you should be able to reproduce the problem
>> on your side. When the test detects a wrong resume, program terminates
>> automatically.
>>
> 
> Can you rule out data races on the shared TaskList structure? Seems both
> your sub-tasks and the main one are accessing it, and that possibly
> concurrently and/or unordered. Or does this also trigger in a uni-core
> setup?
> 
> Jan
> 

Hi Jan,

attached the modified code: each access to a TaskList element is now 
protected with a semaphore (one semaphore each element).
Strange behavior happens anyway.

Thanks, regards

-- 
Mauro S.

--------------OYu97WgZ90VE6Ozm5zoLi07U
Content-Type: application/gzip; name="xeno-test-resume.tar.gz"
Content-Disposition: attachment; filename="xeno-test-resume.tar.gz"
Content-Transfer-Encoding: base64

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

--------------OYu97WgZ90VE6Ozm5zoLi07U--
