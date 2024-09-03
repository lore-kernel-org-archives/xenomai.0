Received: from sonic314-21.consmr.mail.ir2.yahoo.com (sonic314-21.consmr.mail.ir2.yahoo.com [77.238.177.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDC11C7669
	for <xenomai@lists.linux.dev>; Tue,  3 Sep 2024 09:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.177.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354697; cv=none; b=LdnS5W1JG9oCAzxFo6g1nrGTWs96U7Ocw4JyZqf4mSGRcXEMoD1Rjx2sPLAlq8BqSxG/dKzSiBFIx72oE7CR6tSzGrJ8lfqYVw/b0lDf0aUHuQpjGtUGS/y9xNemt8LWxTeSVgCL44zKNUiogmjnJ23CpA8S8FF1UxEZ8321toA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354697; c=relaxed/simple;
	bh=a5MpCLLWIzhmyaYlxgN31RQ4q+cPyNZDhHaLbjHTuHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=sRok6RpmE69Z6gevd8IJata+DWHMzPmKveoVtPtsnP/kHb/1UT0ihDcj33yn+w/84vOXtl8C+SLNCCAbIhN44yfIOtsA/B/L8FwHp8PLxUBjDicaoFjfDRTtAFlua/ojzUkYnj2X8f0Xv7YUIO7E1f7tZFdtRI5/D2YNmckVBh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=o6X7qq/5; arc=none smtp.client-ip=77.238.177.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="o6X7qq/5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725354688; bh=T6uZANt/L+Z6byn+MkcD+77P75rJjoqUf1Sd0LsVn+I=; h=Date:Subject:To:References:From:Cc:In-Reply-To:From:Subject:Reply-To; b=o6X7qq/5pRiN+rriRpKsRly9UytD0FilJqiF1DhPSNfp+dX2GTYlafft0+Q99SQhp7lofKmcLNV9udlk3sWyEvuinTyGF70lvtPjPBZq5uNz3I+zlrDEHAVHWRNqgjLSXb/VIRd8YwcLkUSI0Kk9EQI+48gB53HjVaX0zE2LDeHsRzUzq3qznwm8TJml6yQ2Dp966hzU2Ty6qkuaL1zv/WJjD2rS8ZbWev7I1rEJB+Lo6cPXDhiHI8k0j2jx5UISGhK+VhzaaP3V4+jUtt9xeXzWx8ySyyh08y7lUEu2vXlli5uzK36jfjXl7IMydNSvC3kdJf96tzN87aqRjdS3Sg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725354688; bh=ZqmfvBu2YCcq6u61o85Uf35bETInovbxooL0IqD9VPb=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=GT/itclCl+kfkQO0ZyWV+ZiCOjC3rasZFIgUfyefhLVDAzJIxHGGNES/zWuRXR3V/ZE7K+y0YTg+cWTjGSqXYVsKIEfqLiH9IBdZq2Xa06ZO/iIRJqByhA6RbcHPqpCW/AmirZGoCrgawT+Xak2bolzvFNWAUlWJJDc/RqQ6ipePn9LDfSXewP1Gwe5jzYePm2OZaGslW/sCwh2L7nRKXBjsPlYy31l8iCGsUivmaYWQZ787dM+MbEzWbKwLYxKQ4N6HqbgUOYDh1gttWr+O8jv1NS6Pbc7YKwB7vexnIjiHe7NNFZiwmMazVErmgteukGAPy0BamduiTLwp5eqO2A==
X-YMail-OSG: 3BZd5MIVM1nNktRnCggjOn699VSALcVpJKeS72Rn7XzbCsRFgkOBDQVt5UpSivD
 e1mp6QGcCk2tqI.YRYMcZom.7Va5dyc7sop1w8EMY39gEvNhVoLPPxoTmjIUlMIJCg690orEyGYL
 4QHNxYUsIoo5c9LOPqUfJi194GKYWMJb36Xy9_zMgsEitJjwp5S7SgvKjbO7ZY3naUN3ePR9cE.G
 HyqvgAexskDDneRcjsE5l2Xko18OhtoV8gW5i2XCFx4QKULcLXyjByKLVR1ZPeVkiYH800SndDYl
 dHgSdA2zp_i7YduyzT0ANRNykvY2pmOL9HhTsQLi8Xk89nE41I1drMFSSv_RUO2n3zHZnvKSDWZE
 b4p6h0TW1sFdS79YJdhppRjfCU6fVwFw78Go1TZysSd8_7uUfwT8_bpkigj7sW5O_qkfgvGAAJgC
 3vxpFCMewYekAT5m8MGLjEQnS44LDMrRKFsnp2Tw4eVVHgcXicUo5yos6wqclh2ARJwc0RZXXPb3
 Ro2e80ALuGEWiPpmPhfEau1EC.iNs6MdVUOhoGLudUjsN76G2y2FXW._4e4Y6evu3v3rQEdQQRKm
 2nVxWGgiFS_aDRcbBB5XeCg0h3q34XOo.2Zlgr5xCFAJVrHp6xduXAQAgCkJPJ7yMsb5yB9UZkgQ
 ezDnTfkUaXcp9MrqgL7f9uqDj3uajI26ieMH2ch_H6nYa0GYjILxa4Uq92LqGDBzycytyrPUhMox
 k1GEAXopN2C3Abzu4YKeKRTAnD_WRBAYPnUlOvU7ZrnYNnkVyvaVmNoFQcPG7AkGz0yvlUaRYawc
 HZVAlm5aEv4xvOIWui3B.k2CYJnLkaRMbN..0A0.G2vV6ifE0sVH3JwRyDEYdbjyTk0LkmsXUBSw
 fpLGBVh7nprCojfVoIWyy6LSOLKIZ.DrG3_PyXBBDKpVz5lTWgaJUUtcl9c.BKOw3Z0HmbJMpw1R
 QXHHjsYyahi19pQ3a.LFM_LUoMOeJI7LpAwGRCjmDCsSCQfUwuEzSUa.yRbqScVV2_XYFTAbk9En
 I.2GdzM0hthnhnnf_IQKGwO2ZgUJityv4DEdoM1v8nP2eZiSgcVDADK5EzqgCr75Hmo7w9btroDC
 bwAZBeOtnIdKKxhiDU4SuhslwMWq_Jgp_eughMmIxCyemK9d66Bn2t.t_aPI9KQd4yyKLuHH9_4.
 ATKWSpe9jJaek7wwbanlTxIKzY5N1wSPIV_E8mB8jqdj64m5G2KIloCnJW.vmd6M_SPMTrjO4zQu
 t8NYLPhx5IXfPTKxAdxTbazMbSPUDGvYT7klAOK7qt1N91Xx0xIYhJQ3al.np51oipF2esCcSe32
 Udmmh5iPWfgIsiyJh9faKvW6S9FxXXd5vFyGWwxk3GT2a5yR7mhdwrMHG0RY35zZop2C7ygembA8
 JtG8k2yyraSrlmX1CLXc3nJol3V76KMAIumKRycMlPVkVkwcKCLvSk5aPVy0EMg3mTg4R4.HgUoN
 8M8PFRWQv__wWSWwb6k5LzlWAbSq.5.bHLyFC85AJCDTRL19yK.OBVGHgaxK.xkgHRzpvGd1vht5
 Gzqh5TPLHHxEW9AnXocW4rOQete4sNabwYU238AaUu9djsxFV3l.p5PDJ6iF3CUOq_hR7sENZc3l
 ipiSL3GqQQ.sSwj60UkT6FoVODZO5dzhenLsgdRwUfsGlJo1O.l4Ev5EiYhCLDUXJlADUdVTNvwU
 6rgS2moNeCMIZOlTsK_.lyD_wUv30CesQVF965KDKGSmZCRr_zUfijchQP.KWo.Ya1qzE0N1KH_3
 xWBtOLIrAiiuqxU7Tqeg86p1YZd2ivSDAhUVXFmJYNH9KbEzCHjDUHR3G0aHLwRLW4sXVcREIAst
 mHuV_nHrjzkXVPr5suobDHVRcMESLz.3BhaID9IC1mCqtKxMQy9gqprdLysGu3h3eVw8rVvoFt4Q
 c63krc14Z8ksPXwKngudpJPqf0dXSGcFvQZsrzr62ZNnod3QYjHRYPik_NsepM4uBRrZWhthGQXs
 VToQ4pC4VnbRrZA7Fdprog1X9b_r.nf_39cM2I3D9hZCZ4k_kxMI1BO2f8gOJeB5yo9e7W0RJF5u
 QGwSuPPB8ul3mZVkZFhXOGMiuZ2IDWXp2ieHSsDamYUl197e3IpFMVnxRE8QoSG8Ybo.Jf808b5y
 Bc.O.ol8dx3WZ_WTNbfsTvoeik1OlRQh0.QhnFYYTmM3XJSE78w.YV3ATQ7YHAnOIRIifxaPn2Zb
 dLJ.1XL.3
X-Sonic-MF: <mau.salvi@yahoo.com>
X-Sonic-ID: d6d67786-02c1-4ab7-9337-3a3b659932f9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ir2.yahoo.com with HTTP; Tue, 3 Sep 2024 09:11:28 +0000
Received: by hermes--production-ir2-6664f499fc-ggmrm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 87266b5f2c4aa561beb920c3e40483d1;
          Tue, 03 Sep 2024 09:01:17 +0000 (UTC)
Message-ID: <4dbeb5b9-da91-4aa4-9cf2-06d6776effef@yahoo.com>
Date: Tue, 3 Sep 2024 11:01:16 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Process stuck in cobalt_monitor_enter
To: Xenomai <xenomai@lists.linux.dev>
References: <9d5bb262-0646-451e-a5af-82c0473a3003.ref@yahoo.com>
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
 <12e3bbed-a0c8-4995-8320-cc6036efb0d0@yahoo.com>
 <f3493320-9f77-456c-9c57-1b35492ecac6@siemens.com>
Content-Language: en-US, it
From: "Mauro S." <mau.salvi@yahoo.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <f3493320-9f77-456c-9c57-1b35492ecac6@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 02/09/24 12:26, Jan Kiszka wrote:
> On 02.09.24 09:08, Mauro S. wrote:
>> On 30/08/24 14:00, Jan Kiszka wrote:
>>> On 28.08.24 16:32, Mauro S. wrote:
>>>> On 28/08/24 15:40, Jan Kiszka wrote:
>>>>> On 28.08.24 15:05, Mauro S. wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I'm back after doing more tests also on real hardware.
>>>>>>
>>>>>> Here is a summary:
>>>>>> - custom image: kernel 5.4.255 + xenomai 3.2.3, built by Yocto Dunfell
>>>>>> (GCC 9.5.0)
>>>>>> - xenomai-image: kernel 5.4.228 (and its initrd.img) + xenomai 3.2.4,
>>>>>> built by isar in xenomai image (GCC 12.2.0)
>>>>>>
>>>>>> I confirm that the problem shows only with my own kernel + rootfs,
>>>>>> both
>>>>>> on QEMU and on real hardware.
>>>>>> Other combinations:
>>>>>> - xenomai-image kernel (and its initrd.img) + xenomai-image rootfs
>>>>>> - xenomai-image kernel (and its initrd.img) + my rootfs
>>>>>> - my kernel + xenomai-image rootfs
>>>>>> don't show the problem, both on QEMU and on real hardware.
>>>>>>
>>>>>> Furthermore, I compiled the xenomai-image kernel forcing the 5.4.255
>>>>>> version and using my defconfig: the kernel became identical to mine,
>>>>>> then I expected to see the problem using this kernel with my
>>>>>> rootfs. But
>>>>>> -surprise- the problem does NOT show.
>>>>>>
>>>>>> xenomai-image uses xenomai 3.2.4, but I don't see relevant changes
>>>>>> between 3.2.4 and 3.2.3 (mine) in code linked into kernel sources.
>>>>>> Then, could really the problem be triggered by the GCC compiler
>>>>>> version
>>>>>> used to build the kernel OR the rootfs?
>>>>>> Actually, my kernel with the xenomai-image rootfs does not show the
>>>>>> problem, then seems that the problem shows only when using GCC
>>>>>> 9.5.0 on
>>>>>> both sides.
>>>>>>
>>>>>> Or is it a dormant bug that some versions of GCC hide?
>>>>>>
>>>>>
>>>>> One option. Did you already try switching to a different, likely newer
>>>>> toolchain while keeping the rest?
>>>>>
>>>>
>>>> No, for the moment: I should port the whole custom meta layer (that
>>>> contains kernel and xenomai recipes) to a recent Yocto version. This
>>>> means that also other userspace components will change: would that
>>>> influence our testing?
>>>>
>>>>> But it could also be that the compiler brings in some noise to a rather
>>>>> narrow race window, widening it so that it becomes much more likely to
>>>>> be hit.
>>>>>
>>>>>> I can share with you my rootfs and my kernel and the QEMU startup
>>>>>> args,
>>>>>> or other things that could help you, and I'm open to suggestions about
>>>>>> other tests to do.
>>>>>
>>>>> Problem may be that we will have to be able to reproduce variations of
>>>>> both in order to try out instrumentations.
>>>>
>>>> Right, I overlooked this aspect.
>>>>
>>>>>
>>>>> I'm also still puzzled that it takes both your self-built kernel and
>>>>> userland to trigger the issue. We only have similar but not identical
>>>>> code for both when it comes to xnsync_fast_*. Hmm, maybe it is worth to
>>>>> compare the disassembly of lib/cobalt/internal.o...
>>>>
>>>> Yes, this really puzzles me too.
>>>> Attached the disassembly (obtained with objdump -dSlf) of the two
>>>> libcobalt.so.2.0.0, with the two libraries too.
>>>>
>>>
>>> There seems to be a difference between the two toolchains in the
>>> selected TLS models. Could you check for both CONFIG_XENO_TLS_MODEL in
>>> include/xeno_config.h?
>>>
>>
>> Yes sure.
>>
>> GCC 9.5.0:
>> #define CONFIG_XENO_TLS_MODEL "initial-exec"
>>
>> GCC 12.2.0:
>> #define CONFIG_XENO_TLS_MODEL "global-dynamic"
>> (I got this from build/tmp/schroot-overlay/isar-builder-.... in
>> xenomai-images build)
>>
>> For completeness of information, in my Xenomai recipe I have the
>> following configuration flags
>>
>>    --with-core=cobalt --enable-smp --enable-pshared --enable-debug=symbols
>>
> 
> OK, and does the issue disappear with your setup when you add
> --enable-dlopen-libs?
> 

I added --enable-dlopen-libs to the recipe (rebuilding the rootfs and 
the toolcain and recompiling the test application with the new 
toolchain), but the problem still happen. Maybe it takes a bit more time 
(about 30 minutes) but it happens.

> But it still did no make it appear on my setup when I removed it. We
> might be unlucky that there are multiple parameters with the right value
> needed.
> 

Yes, probably we are unlucky.

Anyway, the whole config flags passed by Yocto to Xenomai lib's 
configure is:

--build=x86_64-linux --host=x86_64-smitec2-linux 
--target=x86_64-smitec2-linux --prefix=/usr --exec_prefix=/usr 
--bindir=/usr/bin --sbindir=/usr/sbin --libexecdir=/usr/libexec 
--datadir=/usr/share --sysconfdir=/etc --sharedstatedir=/com 
--localstatedir=/var --libdir=/usr/lib --includedir=/usr/include/xenomai 
--oldincludedir=/usr/include --infodir=/usr/share/info 
--mandir=/usr/share/man --disable-silent-rules 
--with-libtool-sysroot=/opt/yocto/dunfell-x86_64/build-/tmp/work/corei7-64-poky-linux/xenomai/3.2.3-r1/recipe-sysroot 
--with-core=cobalt --enable-smp --enable-pshared --enable-debug=symbols 
--enable-dlopen-libs --disable-static

Thanks, regards

-- 
Mauro S.

