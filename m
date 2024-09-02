Received: from sonic314-21.consmr.mail.ir2.yahoo.com (sonic314-21.consmr.mail.ir2.yahoo.com [77.238.177.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435261311AC
	for <xenomai@lists.linux.dev>; Mon,  2 Sep 2024 07:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.177.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725262725; cv=none; b=q7umxzBCe/x+5qdsZ6tx7RgjLcfRbMcSgIhZITDVlWcJMyjjxZ4oi+idp+v5t67QmMcpBJuolNrAFCgBeA0ilhbR3oemDu+nCUHoE1o5AKJdDOxfgqDzZ9M3KTuNE+3+t4W569K9HsRhzu+L7wv9F90hUt64BnKApbeDMxU33kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725262725; c=relaxed/simple;
	bh=lRCSbKPmFR2lmdvqh5EOaA6JTcqI2E/0TYmDFJ7FUpI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Gtjqb6LO7zEjqTOWKAacOr1wpDxD9NpBMmBTgjdOvWw4jZKcEub/0FrJ+CtgI8c7AxPW5SABRnve2YkS52IXOI3mZzqnkrAulRlmMjrBz7zwNoQHIroavCAwmK7nRGDM6dzigPWtCJNwlJr4K3BMuJ0vzNTWzRpTi8/ZT0mji10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=gUBS7ujn; arc=none smtp.client-ip=77.238.177.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gUBS7ujn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725262721; bh=ot+/hEfBko4qj3Fnd002jIGD/BxM8FojGmjwtnw7gpc=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=gUBS7ujntOmlO0IofCfjlmbZV4YNHWosuEMIgeHsZ0Cqlc2FCJxfSz0tLhvsh+cw6TY6MY8EPYuuEQhEndMZPH/Wgz/9mFFf+LpEsRnHfo48G/YGGd/oPTQejSjwNIQgJhEIP7gefnjcKRH1aeyDTPfnZHfwLrR55runWbXu30+lqAu9MkH5+zzS764zMvLX4bABhVZJu69Od0zzDRDFZ3M/ybrxbQDGYuxCjY8sqKi+OsJSomDnuIrRqQnfHnzjMU2hRTvByLybRtFnv7M+VUpShx5gSQQFWoevt8IoOfZyC0o4gcEroc+cqFLXkK9LbSImLsdcdWRhXg1dlmPRXQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725262721; bh=sMZdj82g5oFF6YkMzeFp8h1PBQ8gNDOjkCp/75+8gNZ=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=TmueeO+yuMshMVJOLYjmNKFR8CSMBUNukonpXSvKdsWp85oG1LEw4mQVMNqP/L4pfsHd4bSZR5mUKOwlBtFpJGO9qmbx8iKwRAgwAPbnUTnF5LBbx46HACrN5JOXlRsM8IYOCPS8b2aU9+hjXFAbjK/rfoEC+a5lU/St6fQ3B9p8HC1lsSJA18l/eDf9Ln5aC+eVuOwfKAYg7yFBolNWllpq8EUmZoAp8gjWlOSCE/6nL3XXLEI0/prvUp6WGxkLqd1LBPZVrOOhZZx4kH/0LpbeYZU/nMCp2EiXit8o4c0QZqqXR+3gmoOVG+qrj9/f+fbpeuw/n9Nhh3WAzqh+8g==
X-YMail-OSG: uzq.fagVM1mRkR7kuFtg6B_2dekIr.NJnxB85.fBrMmUA2k.yU3.S7Hjf1PRrQg
 X.HH21tdoYVFQsaZJ2Y76W1YnEPRpknund7w9vYJSXxlGVUWqDZqFMVqhwjSUI5VOtD9RCgaiXVP
 9YPsXAC_Zp28icsFm__17cQLTOyMKZ5EbEvCiSfWIS9V6zZB4h7j6jq5jPuV0QKC1E1Gmt.NSGzA
 NH5dpY5eS6IPfy7ts1CA.ZIHmMqCX2HDk.mPtjjATA9t1ukL33sVUlCXxVmhKmrbmYhyDS7Zm9Eo
 r_sAvGMgFpotVN7lwJnoGhAJMBHXBSD5IppzwMzh05xuMbm0wFVhnY831E4V05SVF_kf4iBrttFZ
 J3WA_SEtWQfgMs5ViFE0tVhUed68TaNAUFfxmQrBwIwxY6a1tZcM4_ZA.98OQtsEPfpejhKcv363
 AjEk39lxJ5QVpgvxn22Ma7hgYMobmIkK6Q3IQE9_MGmi5O.sIfNbEgryUKRXa6mSeFakgEgd0Yo8
 pp82S_hWrRKwtzfUvpYyjhOhbF4rehxdwhirkDenJPAKG.lOOqbaKoDd22CiboYoDRBpwwafPQ1l
 br3PeK.rM.poLcgtdKSA5f2ITcnKdP2FzQ9NhFbCBEvNqPleJhYmYBlYl8MLWH9FV1qorpcfH0yd
 5siJDK514AITsbBbxjBCKHD_qRXTcTpTv8tH8fWdabQUF4eYc23D2W0ZqSbGpt4ZY.Q.1iGdYFhj
 QsM7BWMGrc2STsj_TF_fUbqclU2VV_jrA9ISuVb0PQgKlIOwFm.9YL8FCmOdy4y6JuCDe21o.9By
 VMd1Q39hetQCsOTw.vUp1u.hU7LHtlmGs8WH04CBgDxBaml0ZK8TpNvQ2QbOdUFY3B9i8quFM4lq
 KqO999t4QuDPSOQ6tCB0lcZBF.9l0lS9SToGAy3dvCtAUAzQe.FFRG.67jl7fXl7Uuo5z.VPWT1.
 ObqkT0zAY3LyEFpcl.URllSs9LGL40Bf.EKw5RmbSk5eSn5Or2ggo1nS46RLgOXkGwO3tFP10kvh
 e9Pbl5SSQjEUXaLg5MlUNJvM9.oTKWOA1d.OsLZ.nAt8iT.iyv2yUIhZJ7BHz93KiMe8IMr6rXYy
 cb0zMhiPfpuQ0f2qmsD4pJATQ1GQIWe4Aq34yPrEb4dAHp2n04SxUL8q90SBQc2YxH_cPTyXkPZ5
 3XvvGPYSIv.6rvTE8U7xehveFx7Ksx1wAOuXweMR3p5MrXCTKakrsNvQ7l3XaYWyjhhsRQDEnm0g
 5HGerHsIBI8Q_JKTt.zM83V1mzF1qlzuwJGQgTNCn0z7eLOUIhutKbC32VU12qUuVQLW8y.iy_AW
 6kSY0c1v0QlRy9J9W5GL96haFXfZPw5WIhJ8ewsY2WLoar7iEdTDbGxUPNxF2Sd_rZAMy9NY034z
 Kb8G9yaC8GsQ6oVtkdGJXEGYht1D7ksl0Yp.4cH2g4hqOiDJIEDiWnh4vJv6BiJufwdLg45obZ6b
 XibiWVoKbuImiPmN_SLKIbB5JN3JC14sF1PTltS6SQlZ4HYKB5QEfe9rgJTPJ93WkSg3cCP_pGnG
 2CCuuEIYoU97QaZFTWAOVWNO06ZqcR7MP3epELVWr.hRBOi4Xa1DYtlaMx0j6mgs6e2iPLVYsZJj
 OvLxgbD16W.PTG9rXaVWWgZKrNvdSnwGZWrAmmO8pS_RPRw5Yy5JxvRHyQS5hoyyiQm5_NuHHC3R
 fhuaLbmikr6mn9Up0IOD42hT8PIoW7BFafiGQCxNeRV.Rq582fml.HMJFCOmg8psIINvGt8sm.4f
 CWtWW98nmk4X2.GUoi99ozFkfvmZKqzFMzogIrI4ulcGKMPzGtsGeGaNxeICecHwN6PXMfWKqfty
 Xo58j22oRh2zYINOysqRzOJESj8Kn7HoChfQsIWg0Pl45Lr4gRTX7bS5GHIlE8m.H925OEJf8DBb
 wlPaKHlAaw18Y4_V6bVtmlNee01YB9f8cBI1sFw_Wl323EbB84hAkOgZAYrkcIjNQOx25ryNkU5B
 E6Dqd7RmPN.DuLfl07zXXXHqCDrPEXTi9I4PCDNrcvli0bkPj7mV.VNJHa.DuE2yhjNvGBtWVcg3
 KbPnlDPmaImp88gbr.cWZc7qTz.Dn10c.Jmwtwf_5ba9RarDoXhdGWFk7sLY1UVtEszfEix_2oK_
 mbmNSixQ9HrpPHlLxiuolWnH31HcL3LOskrEAqGYAbqAVrAfnhZgAIWmKolSpSQ3roH4GIUb6HOs
 ZDis3
X-Sonic-MF: <mau.salvi@yahoo.com>
X-Sonic-ID: 2eeb337f-4d0d-40e6-9965-a9436283d89f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ir2.yahoo.com with HTTP; Mon, 2 Sep 2024 07:38:41 +0000
Received: by hermes--production-ir2-6664f499fc-6rh2p (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1a68da43aae90d85ccc1ca630cdbf662;
          Mon, 02 Sep 2024 07:08:16 +0000 (UTC)
Message-ID: <12e3bbed-a0c8-4995-8320-cc6036efb0d0@yahoo.com>
Date: Mon, 2 Sep 2024 09:08:15 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Mauro S." <mau.salvi@yahoo.com>
Subject: Re: Process stuck in cobalt_monitor_enter
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
References: <9d5bb262-0646-451e-a5af-82c0473a3003.ref@yahoo.com>
 <67ce5b0a-1013-4ab2-9617-0723c0dc0809@siemens.com>
 <d1b99e9a-5bc6-414c-9f5d-972134f60c31@yahoo.com>
 <bea3518e-5d72-4a86-a5b9-ac71a59c235b@siemens.com>
 <e5efbf9d-9054-46d3-8deb-aa321146068e@yahoo.com>
 <1b8ec985-8ae2-4bd2-8964-23f97cac7ba4@siemens.com>
 <CADBp9xn4OGi99e57phnv58NtCbxzO62bhrkJhSns-FUbbt4_pg@mail.gmail.com>
 <6fb4564d-3d39-4be1-838c-423a865638b9@siemens.com>
 <2d41fc43-db7d-4070-a769-bb37083cb414@siemens.com>
 <2e779a4e-ce60-4487-9dbd-7d40726b2d9e@yahoo.com>
 <0d9b6cd5-4b95-4b28-bf06-9e98d7d6310d@yahoo.com>
 <46a1ceb0-0684-4bb8-bcd3-5f71456c2d10@siemens.com>
 <0363a40f-ac3a-4024-a9bb-e37841625cb8@yahoo.com>
 <7707fef0-b164-4a79-913d-6ddcce6600d5@yahoo.com>
 <4e5fe5f2-44cb-4578-b47a-89980173eac9@yahoo.com>
 <e48a247d-db37-4c78-ae35-0d1a35646aeb@siemens.com>
 <f8361e27-2fed-4aa4-9348-bdc64760f7e5@yahoo.com>
 <6af7ce37-f6a5-44f1-9f48-18120baa831e@siemens.com>
Content-Language: en-US, it
In-Reply-To: <6af7ce37-f6a5-44f1-9f48-18120baa831e@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 30/08/24 14:00, Jan Kiszka wrote:
> On 28.08.24 16:32, Mauro S. wrote:
>> On 28/08/24 15:40, Jan Kiszka wrote:
>>> On 28.08.24 15:05, Mauro S. wrote:
>>>> Hi,
>>>>
>>>> I'm back after doing more tests also on real hardware.
>>>>
>>>> Here is a summary:
>>>> - custom image: kernel 5.4.255 + xenomai 3.2.3, built by Yocto Dunfell
>>>> (GCC 9.5.0)
>>>> - xenomai-image: kernel 5.4.228 (and its initrd.img) + xenomai 3.2.4,
>>>> built by isar in xenomai image (GCC 12.2.0)
>>>>
>>>> I confirm that the problem shows only with my own kernel + rootfs, both
>>>> on QEMU and on real hardware.
>>>> Other combinations:
>>>> - xenomai-image kernel (and its initrd.img) + xenomai-image rootfs
>>>> - xenomai-image kernel (and its initrd.img) + my rootfs
>>>> - my kernel + xenomai-image rootfs
>>>> don't show the problem, both on QEMU and on real hardware.
>>>>
>>>> Furthermore, I compiled the xenomai-image kernel forcing the 5.4.255
>>>> version and using my defconfig: the kernel became identical to mine,
>>>> then I expected to see the problem using this kernel with my rootfs. But
>>>> -surprise- the problem does NOT show.
>>>>
>>>> xenomai-image uses xenomai 3.2.4, but I don't see relevant changes
>>>> between 3.2.4 and 3.2.3 (mine) in code linked into kernel sources.
>>>> Then, could really the problem be triggered by the GCC compiler version
>>>> used to build the kernel OR the rootfs?
>>>> Actually, my kernel with the xenomai-image rootfs does not show the
>>>> problem, then seems that the problem shows only when using GCC 9.5.0 on
>>>> both sides.
>>>>
>>>> Or is it a dormant bug that some versions of GCC hide?
>>>>
>>>
>>> One option. Did you already try switching to a different, likely newer
>>> toolchain while keeping the rest?
>>>
>>
>> No, for the moment: I should port the whole custom meta layer (that
>> contains kernel and xenomai recipes) to a recent Yocto version. This
>> means that also other userspace components will change: would that
>> influence our testing?
>>
>>> But it could also be that the compiler brings in some noise to a rather
>>> narrow race window, widening it so that it becomes much more likely to
>>> be hit.
>>>
>>>> I can share with you my rootfs and my kernel and the QEMU startup args,
>>>> or other things that could help you, and I'm open to suggestions about
>>>> other tests to do.
>>>
>>> Problem may be that we will have to be able to reproduce variations of
>>> both in order to try out instrumentations.
>>
>> Right, I overlooked this aspect.
>>
>>>
>>> I'm also still puzzled that it takes both your self-built kernel and
>>> userland to trigger the issue. We only have similar but not identical
>>> code for both when it comes to xnsync_fast_*. Hmm, maybe it is worth to
>>> compare the disassembly of lib/cobalt/internal.o...
>>
>> Yes, this really puzzles me too.
>> Attached the disassembly (obtained with objdump -dSlf) of the two
>> libcobalt.so.2.0.0, with the two libraries too.
>>
> 
> There seems to be a difference between the two toolchains in the
> selected TLS models. Could you check for both CONFIG_XENO_TLS_MODEL in
> include/xeno_config.h?
> 

Yes sure.

GCC 9.5.0:
#define CONFIG_XENO_TLS_MODEL "initial-exec"

GCC 12.2.0:
#define CONFIG_XENO_TLS_MODEL "global-dynamic"
(I got this from build/tmp/schroot-overlay/isar-builder-.... in 
xenomai-images build)

For completeness of information, in my Xenomai recipe I have the 
following configuration flags

   --with-core=cobalt --enable-smp --enable-pshared --enable-debug=symbols

Thanks, regards

-- 
Mauro S.

