Received: from sonic303-19.consmr.mail.ir2.yahoo.com (sonic303-19.consmr.mail.ir2.yahoo.com [77.238.178.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582F51BD013
	for <xenomai@lists.linux.dev>; Tue,  6 Aug 2024 08:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.178.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722933842; cv=none; b=HndQfIuuUoTH/o7aYEciXCPoyt8wQYgas51bc8pDASnpeVhUtdK4M//tzbk0Y96OKqa8oepvOiExOU24thIgymxBCh30c877Whw10/uAR2GygTrsqm1IE3wOoPcZrLwN11JMfc2NWO/MW3wLTz/oHHTZ0ssKGtQ08HpnuaKgy+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722933842; c=relaxed/simple;
	bh=83X14yp4idPCfymoBERG+Xtuu+ET4NOj5rEFmYzHMvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8Ch2dW72RDZOh6Jg7D01kbB219/kkLd6dwOkgVwmRx8LqFLqNlPsKzPOB8E2L3CfLbT4BjKIcUVVMUvbBemqD/9eezpfY6ymC2Mdy1tw9LNF0RDJYHw0FFjBlgwAb5DSBqO47em97NODw/n2nP9htGKfhF/N/hXRPgV8MeKp94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Be4szn6T; arc=none smtp.client-ip=77.238.178.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Be4szn6T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1722933838; bh=bYPuISVsVKGGMDbE7msjSGKKT6kSCnMVdxXa+TI0LCM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Be4szn6TJbKpm9ipehrvRpQP8cnysh0JQdaZ3GkWFxIQE5ZrualKe0YZmkNGh6lduuZRHEkm/QFNVrL9X2T4V+uXJUKy3alZ+SYaaq9T0HaVL5hAgSDyGELzXemNDnWQjKYF5Tk1b5fxNbS1IlgHJIpU1iSIb3STW/iBAW0fhgcIU194kZc6pBUDDB/e9gMHTybDIhZpmitpkmmfW1WVEXp0gZboCBrGQ7ljboVyVRkmU90jIWRdRhXqaMOaFQcjZ/7IhVMqDrMGHMIN1HR8uGvALj4dIP1HDRk3RrbtVBcrvOcJnNcYXLmeZk5bJfJhq7a+3tNsdyKMhAxo6Rdd3Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1722933838; bh=uR9wrqYOFvvkuS5Ib0ZMlH3yQb7jlmGHEgRl5fz2mCe=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Z9k4qiYFYZDBv4kZMojR740lCAcSsvZuyOLhsalU/mS6WQgbZfL+TCCBAGSci18eK4qivI8s8XUPrkCJhZEjv5N0/F622hwbc8M3C6dWBoCHa1RZ0m9MZhcd5FYGwmZt1Rd3X2cSLlJiHOVsNiSvugRp4yXK0xYRofQAvd2w1lvX+tHTGgMLzBbTVwPjWNenOHayPO09ZKlMgK0pA3ZeTUtv6+g75ZVihytDikcKuzBbSKO94vpA4giGRZHT7C3R0TFGp2NdukaHlmReOLIpT+k3aGKryUHJ5s+uqgyGngGUWZzfKuh1GRIehY6cDTIBVwrwFeFOP3jdkwrjTUKfow==
X-YMail-OSG: 6xuS4vAVM1kIiJMtoonv9Of36.nzY24_T.C_ODZvCNzreeA3uBbRmbeSZMyPbZo
 O3_WmyeXDlqZ7T1voZQBHHAufnEXqfOjnW1pFRCAbwZbrye0rwwN6reneq_0hSPWFDBd3fnIWV_T
 0FOX3QdhwHFWoHqUeI2APQjiZ3uMTV_wSKzLWaoeRm2H2oF67IAZFBTS5JRrlV_W7mW7VNrgrW_I
 n0cmIL9BO6EoVozzVDRJvSk5Crob0AqJ6L8kbMNzuWDMl0ce4nj7DEye_QPFFImqtHKZg8bFJXSP
 57wW3Z3HYSBpIv61czkNL8JAROFbs8jUOtXK5sDMCbFrWAp_HcvuAxHs13_Af3izxyYr9L57COYR
 feGXr0SRFEFvFR6DMr6jailEvOS9qCz3zF1mjGZg7pT7QK3lNC22hJ6SmD554PoaN54cd1oiGliK
 FrVUgFGsxaHKsMTlWqtG6Haqc6VgeNGqQ9zphAk1pUL.8BhKWAXHQAG8iFTrxZR8MYvoxEJj4Qbe
 ZBWQBxLBhxwdVC5pwj735QLuNP5po0jleBfYbxY.LXGygFgZnEtjwVeYc9_gUc1HiiErQvNrE8I9
 dxRC._MeKNyf4XnG7IWICCSJMC4U.eedmCDyPP3DszDl6twPrOL0mBYVeg3BWNdkHvzeQtxeJpjK
 U4e562SrM_WuDehOl5gwWQIpbmaJ8qIoa2m9T2wJH8P9.qCdw0_bhMJ5qfPDeTXLFZolx_f7Ihe7
 fOJ0D7UntYuMe3oFDvE9APQHwYeCE442gPIi7TWZzsMAttXV3bi3jldWLvJmH29jMw7XB.zWiZQs
 GlS9j79.4jhIY9qdSh54bvfD0uxs.dICkmiY4TveUo9Y5pk0mGeFMR8_VwdOvoxhEXtigSkTCnFg
 myZ63xs8rsRKYC6z5Xi49L4TW0e1l03ZMJi948Y9QqDRnWATbfhhuyDj4pL5UynJUicD1GOSveaX
 .vWIt.POeTYHmubepf4mt.QDJDu9xLVR6n_keBce8WW_eIqnWMifnTQ.6sIzKWImjQHlII1wcx9q
 hp15ICJEKgQddTq3ax2jlBqSUljV_h2tHi5R9zQVEJ_jGg7DSZLbRIrO6hbatIgaNz2HL.WUpCh1
 2JSPE3KGbEZ7EbsEzDLtcdsp96VkTVZg.dLlzuwckflpnc24uipyFJGYiYHZFyJJMdZ_dOcrJUKE
 N5b3AyldnapUkoHBWi4OpKDmvNsja52yyOrQuez7TtaqMSNaYQ8A3STzMBSEdIpj0X20pUE8gO8l
 W13DAoHFjGVB9YxlAlaL_Zb6kLgzfmlnE2ZD6_z1Ly9yOQJlQto0IaehvVAytl0kYOfoFB7zvoCx
 nvV40XolMv5NXjmxCeevbZd_UQdCdO.nPb5dx89PEwZXRouqziPc93SUQDEjVixWK92_PxatjnkP
 .LGuN807wVzd474NIzqjGfsqPrvpJpMV4PaONzLNLFEWiVkZ.SuPdDE5IwpWqj.0u271S0CIUuKn
 Mc35z23NQHlyhStn8PyZkhwuOAZIACMd863rHXcw4yABaND1W4rCSNE9Oxm8ue54rW7I_RU_2Qpq
 B7S5g3xTG8nS28eMuBqclJpQCFB52O.ObglIiJ6.JWZMFVyoW_Ehr_r5KdnGht9vJmAsufZODN7v
 ktrPzHSdpqZVGBxctadDBbaQESfYgn_Bz5O9.A31C9UR7OJ0BNXg_5wlqg12PYAj2yTSqqxvSo..
 Mb8NieQ3gGl2L3INSCaZrBHRsG7E5ZQzx0urCCUlYRslVQujaQJVBSf4tRDXBOipo.Y_bL5LXk61
 iUjXf7i3NuMY_ieXXQOfLqaTZSVlQ3AJvYVK_1_8NmOlQIr8WfTaxUywSMI1QZH4A8e0PsnUJIyR
 GI56t3BsuxYXL.kK78fQdxQN5WWm1jYNrzDqSqYVMgT_QII_TAuZF36I1r.vxgsvB9L4XG03k3SZ
 9cUSJjzFvsbtAfvRKcZ4_zmgzFPaTQ6PvRV2vwIhGw23D755e6Olg1Z3djtOoveDv8FCGZm4jOg4
 hdE82nMzWFG_f.oKjwUzo1jOmMzCmlTNwh76qrteL8KdB4qV8Jxi4qNjjTehnMdNwhsAhW4XZrSF
 ZfZJdLnZTFHV_QYtf4jUfvhh3meMISWXth8N1PmTUMGpSjEOLvFr0j8Od3D1hksAgWVgMq05BBc8
 rvq06f0266epmpNRjDR10PpnbaZyWjNot3zeQlSdhLZ_iLI.HoEiDGMIZ45eCEeX6kxzUVzawejx
 DXYCs2FzvwrK_oKB7fw0iY9g-
X-Sonic-MF: <mau.salvi@yahoo.com>
X-Sonic-ID: db82d80f-4df4-4150-8a2d-a67d72aa512a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ir2.yahoo.com with HTTP; Tue, 6 Aug 2024 08:43:58 +0000
Received: by hermes--production-ir2-6664f499fc-sk6p8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f39a8022e105cc9379af0e2c904d1785;
          Tue, 06 Aug 2024 07:33:01 +0000 (UTC)
Message-ID: <2e779a4e-ce60-4487-9dbd-7d40726b2d9e@yahoo.com>
Date: Tue, 6 Aug 2024 09:33:00 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Process stuck in cobalt_monitor_enter
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
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
Content-Language: en-US, it
From: "Mauro S." <mau.salvi@yahoo.com>
In-Reply-To: <2d41fc43-db7d-4070-a769-bb37083cb414@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22544 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 05/08/24 23:41, Jan Kiszka wrote:
> On 05.08.24 16:40, Jan Kiszka wrote:
>> On 05.08.24 16:28, Mauro Salvini wrote:
>>> Il giorno lun 5 ago 2024 alle ore 14:10 Jan Kiszka
>>> <jan.kiszka@siemens.com> ha scritto:
>>>>
>>>> On 14.03.24 15:22, Mauro S. wrote:
>>>>> Hi Jan,
>>>>>
>>>>> finally I managed to have a piece of code that makes the issue
>>>>> reproducible. It's not exactly small, but not too big either.
>>>>> I hope that this makes the issue reproducible also on your test system.
>>>>>
>>>>> The zip contains:
>>>>> - a little main program (test.c)
>>>>> - a little library (in mylib dir). Some pieces of code are never
>>>>> reached, but leaved to avoid potential compiler optimizations that could
>>>>> remove other relevant parts (maybe cycles?)
>>>>> - a script (build.sh) to build the two components above
>>>>> - a script to launch the test (start-test.sh)
>>>>> - the configuration of the kernel in use
>>>>>
>>>>> After building the program and the library with build.sh, you can copy
>>>>> on the target:
>>>>> - the start-test.sh script
>>>>> - the built program xeno-test-session-hang-on-exit
>>>>> - the built library libmylib.so.2.0.0
>>>>> and create the library link /usr/lib/libmylib.so.2
>>>>>
>>>>> Start the test with "./start-test.sh &" and follow what happening with
>>>>> "tail -f log.txt": after a time that varies from a couple of minutes to
>>>>> 25-30 minutes, the log should stop on "~~~~~~ RECEIVED SIGINT ~~~~~~"
>>>>> line: the hang is happened.
>>>>>
>>>>> A small recap:
>>>>> Atom x5-E8000 CPU, Linux 5.4.255 with Ipipe 15, Xenomai 3.2.3.
>>>>> GCC compiler used: 9.5.0 from Yocto Dunfell 3.1.22
>>>>
>>>> Can you only reproduce with this setup, specifically with this compiler
>>>> version and only on real hardware? If you rather use xenomai-images and
>>>> qemu/kvm target but still the same kernel and xenomai version, the issue
>>>> does not occur?
>>>>
>>>> I'm trying in kvm right now, also with different compiler. Iit would be
>>>> good to align / rule out variables if my first setup turns out to be
>>>> unhelpful.
>>>>
>>>
>>> Hi Jan,
>>>
>>> Sorry, I never tried on an emulated system like qemu, I did the tests
>>
>> qemu/kvm - that is CPU-wise not emulated, virtualized. It generally
>> gives similar execution patterns as on real hardware.
>>
>>> only on real hardware (using different samples of the same hardware,
>>> just to exclude hardware problems).
>>> I can do a test with Xenomai images on real hardware if it would be useful.
>>
>> That would already be useful to rule out the toolchain as contributor,
>> yes. When at it, testing in qemu-kvm would also be nice.
>>
> 
> FWIW, I've pushed ipipe-core-5.4.281-x86-16. It's not that I expect
> positive impact on your issue, but you never know (until you understood
> the actual root cause).
> 
> Jan

Hi Jan,

I've seen, thank you.

I will try xenomai images on real hardware and I will back to you with 
results.

Thanks again, regards

-- 
Mauro S.

