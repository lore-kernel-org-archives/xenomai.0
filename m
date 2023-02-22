Received: from sonic312-45.consmr.mail.ir2.yahoo.com (sonic312-45.consmr.mail.ir2.yahoo.com [77.238.178.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686145392
	for <xenomai@lists.linux.dev>; Wed, 22 Feb 2023 13:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677070981; bh=dhWUJNWUbturntUmfcOTp3gdXMuZnVfUDZ/qvQBeIlg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=UtS5QcShoyzj96z0aYjRXAG3jpbxTMtw2dzmn1U6xC2C8gzh8qEaaJRl1itqRRyVIxPCHk6x8hYaxg6TEptx/y4D3f5qGDbcy9EY55d6+OSY0E3J69k1kUAQuuP29fP9qL05XvdNZgDR616m+2FfBDCJMnYwGVYFop6BWW1fT3UkYH+sxK3qBuTt9CuHwfXcIBmvaegyOlV3oQAzMbaz6oFS8z0gccFx61InjpuhAojMmfjEpEbR/NELfoPG3LGPhb4m6B/nEnxtEJxQPPL9+NZphKk1XqVec18u9VMW6C9zV9Wy8XUc7q9ITBcREfSGzOr2ijR59Xd/rbTcW6a43w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677070981; bh=6k21J8rfBFRGAWuR9cBmViJmSVFS17wYE+vI3vXS0t3=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=b36cV61jR2YsvM1Ste62Ri31gfTaJx+O3cCVUx9fOGt5Utr+mcpr2wm8HmUDSDAvmgi14uQh+n5vmOJfkb+gwhKBvEX6/waFNlNLye+5MOmRrE5Uo2m7Xz6R/yJ/C6m4DHj6SD/b3vfLarEHl3dWHQtWPrkijN6+gNFJ6U2daPEXbApH1p2IqTU16Y5QtqeNW1avQW1DdmZQXWuGcf5qGavsYN8spqUCA8WNK3XoTp0kHct7yph7j4YemNDPiZYKN3Ig1wryHtd8mJWYwySyziE2ETZFAmGGrKxTXzYyVGI3oivq6k+fBv2GhmUhvaYTG9MmbRcIGrOvhZNcMgmz6A==
X-YMail-OSG: UUf6zSwVM1l4k8.xdxx79Yidwcw2FQpNcwkpHd9yZpJ15W8mFBTgRVh4Yu0LkNR
 tNy2WqnzaXiFfCLSIzEWNMXXkKyx2V2y67MG3wiUjxi6BF9re__pZWtVpT7CJC2zvg_J8wG7BmY9
 V5Q6t_LG01tzT63yGwcKLb2OkjgyZ_HK.8NUQ4V5vEyq8C4VVGj.qtcYtuLTOfLQhn6Y3Tng2HQS
 5GdvM1NTVtguQWnzh57z6Gxc4aqW3rg8K3EMojZF4kdTFT5514KnlwYy42Aa0n2JEn.1DpC205Rp
 ixi.1qTvjS4d6jyhCj.miX1emsS3lLinlaY6HXsALtLYwKnIMsmw3CCYcEgGiVffJXpPaWcUUSks
 KcSIyjhqt8dT.nyRESNCjcHxux3Un0PhRjm86g0sUID4htVQ2RCaTkUNlR0E2xH01J7UAizM.GGK
 4W9EdPRoayIhYzPAo6xbUU.mM1ENOvUKFb158L4mXcQ5xMMu5aJyu.d2F3m2vxAK4H9hhWQzF7Sd
 z1GdDzMw11QTZWmQdGD7PnwbcbjZq75kIrSFoPkxwfRCYCsiIhunvxNrMsr1Pc3N9BMp5hdK0sZ7
 lfMLrfr0nv4BRdDJhTcMixuPwLBGSZn8WkyvJ4zpbtWnedX2gu8o2K4dbmXgLi3k3uQ5RhaoPbN0
 2ttsZNUJwOOOk.t8Zx39U0rx2guHnRJZYR7.mgMhdruN5Kvp0DPvhejktX74YblRKA2IR9FS56F4
 QJ6Ynk0_8BAEGL6VKe1mkqiNxbdQTq8eEbhOha2NgZGTV1CRROvkF6_jFBY6e6SVEjrkq43_FdUE
 ykeokeadbrU_B.R6OLL34vzJYLaH8t6rUbrgO.NkqBlzc0dNFmOfzcYNRT14mVPMQQu50zgHSrPL
 DzDf5gAHkYnyM9atOl8sear7GQh35xVR0VfooUoGv7N.Har8284P3yIPlEcanb7sYASc1DjNnFfm
 ViPyYeAQOkcQ1ED2WPgGEHpuskcbbdJIk24I9NVUlRhzb0M1WPLci4Y1uCdDZprCHWncRvfxw6s4
 .aymbxw502yOjKScbqdHgYpBIWWsBQQ4dCfiFr8ll.f6twPSjikhbd.iPV2sIYoZ070ZPf2_PUc5
 hWNMaEqxjDyT3pnmyLlyTWJ1QuZgwv_B925LUNTATyzMXriJ2RMxe5Fyf_3LT2HuLuNVDrbySRZ6
 ABGJaQfqHbqiBO85vm9SCrd7QL5D7W606jmG7.VBLxC1Cf4p57hDz54YQOWfZKHuc4ZKuLFCdBZs
 DQh_HWhXICbLYcoPGrmlRoOG6hrTInbbehp8YnoB_bMbOoK7ddilwq4Pm3CzUkHoYEFESpUxXajM
 ZF_fShfQ_hBmQj.jqR_qgQd.4j1wkpx.__i7eUPtIRLXU94oFxVRg1G5vuUeX9iIHUABiC3g1WvF
 qJ_QFSAon8c.ayJdLfCfM7zCbUcq4zQ25QB86mqoruj497JrAHw9mMLYDWMthLeOEybci6WitLsw
 0_G9Oz6lTbcd4IGxkdl8_4Ohy9TF7DxBKuYc05ui.ILgKqy1wKv5iMAdM7PAzbjWvnE4jK9jFyv7
 6TtwUpVLwanJUJTOgHeA0KxwgbDT0ryPY8e9bQhmoHY_YqLmocZ5barVOSg0iZtpnKczuXAErEuG
 ZhrBQkD8ET1O2prUZG5WARO3ycKRwXSjSHDzZvYvp9ylVxWXmEj4SZlUbQP3NXJiKxXZJ3S7bZLB
 t8nEKGt2m0EuL.HGibz37LwgAvGB4sk.bXPLzdxfDT.s_hU0cMVvQ_GYV1UDNMI3DVyFxkZ_4HGL
 xfU0oNJ9KQwPHfCQGjjnap0mrcqkSWy1rd4Qf6.DwkboRor8BCMhnHdfyKr0HLhM88bjzUehNt31
 AiGmLf.Qzk7KSwF9zaGOyha0TGqafRqMhHQLK4rw29T1l.A48Y2Mud5AbxJY.3uwK2Tssp8akkan
 QqkQVRzOjlYEDQXS1bi3Zga.1fx4pk4qcaSRpagFxr99wfglj7bYjeSUW9iNm7RAIpdejBWY8oev
 .PLVo6JPFbZz7LG3QylaSEETMSZJL5hHuJ8Z7jG3CJIq4__CMzAs4wZTnoHsMMvCBI0218sBfbHH
 oAqcqrglpEwCD9DRWAsvdMD_q_SH9ra1NONARnb_DLZYfcNeuj1IdOgwQGvuzZxLNo5ZcraGizzb
 EmLywYHLViL8BPw1prC4JXDQH3n5gJ8.4e05guIp7UMl3872UXDB3nMBQGn7jppgxqnmBdlmy9Yp
 UElHi389lB65xNTBQLAOO
X-Sonic-MF: <mau.salvi@yahoo.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Wed, 22 Feb 2023 13:03:01 +0000
Received: by hermes--production-ir2-65c64dfd66-wgvcl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 66a707e10b6b10c89888b9268b8228a6;
          Wed, 22 Feb 2023 13:01:00 +0000 (UTC)
Message-ID: <1b7b54e5-2087-1d4d-3820-705332699cb0@yahoo.com>
Date: Wed, 22 Feb 2023 14:00:57 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: undefined reference to `fuse_main_real_compat25' when build with
 --enable-registry
Content-Language: it-IT
To: Jan Kiszka <jan.kiszka@siemens.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Cc: "Chen, Hongzhan" <hongzhan.chen@intel.com>
References: <fc2f8e65-dce5-452d-3789-70ebc838abf2.ref@yahoo.com>
 <fc2f8e65-dce5-452d-3789-70ebc838abf2@yahoo.com>
 <MN2PR11MB4285DF9642B16AE3F170431FF2D89@MN2PR11MB4285.namprd11.prod.outlook.com>
 <b953b20d-f866-5bec-faf3-f8560354bf59@siemens.com>
 <04a817d8-5792-c00b-8533-488cbc24cb4d@yahoo.com>
 <02c53276-6a36-8377-4792-575274793c66@yahoo.com>
 <023a8783-e78e-94e2-fd2a-0bf959b886de@siemens.com>
 <bfea17eb-684d-40ba-8325-ef3b45bfc226@yahoo.com>
 <a9c9fbbf-9278-141f-8b73-04c9e5217a48@yahoo.com>
 <08355553-db9b-cf6f-1470-20384a91d401@siemens.com>
From: "Mauro S." <mau.salvi@yahoo.com>
In-Reply-To: <08355553-db9b-cf6f-1470-20384a91d401@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21183 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Il 22/02/23 12:55, Jan Kiszka ha scritto:
> On 22.02.23 10:52, Mauro S. wrote:
>> Il 22/02/23 08:19, Mauro S. ha scritto:
>>> Il 21/02/23 17:57, Jan Kiszka ha scritto:
>>>> On 21.02.23 11:40, Mauro S. wrote:
>>>>> Il 21/02/23 11:24, Mauro S. ha scritto:
>>>>>> Il 08/02/23 09:21, Jan Kiszka ha scritto:
>>>>>>> On 08.02.23 03:27, Chen, Hongzhan wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>> -----Original Message-----
>>>>>>>>> From: Mauro S. <mau.salvi@yahoo.com>
>>>>>>>>> Sent: Tuesday, February 7, 2023 9:46 PM
>>>>>>>>> To: xenomai@lists.linux.dev
>>>>>>>>> Subject: undefined reference to `fuse_main_real_compat25' when
>>>>>>>>> build with -
>>>>>>>>> -enable-registry
>>>>>>>>>
>>>>>>>>> Hi all,
>>>>>>>>>
>>>>>>>>> I'm bulding Xenomai 3.2.2 for x86_64.
>>>>>>>>>
>>>>>>>>> When I configure the library with --enable-registry, I get the
>>>>>>>>> error
>>>>>>>>>
>>>>>>>>>      ..
>>>>>>>>>        CCLD     rtcanrecv
>>>>>>>>>      libcopperplate.so: undefined reference to
>>>>>>>>> `fuse_main_real_compat25'
>>>>>>>>>      collect2: error: ld returned 1 exit status
>>>>>>>>>      ..
>>>>>>>>>
>>>>>>>>> libfuse-dev package is installed (the configure script finds fuse),
>>>>>>>>> and
>>>>>>>>> it has the function fuse_main_real_compat25 exported
>>>>>>>>>
>>>>>>>>>      readelf -Ws /usr/lib/x86_64-linux-gnu/libfuse.so | grep
>>>>>>>>> fuse_main_real_compat25
>>>>>>>>>       318: 000000000001a500    14 FUNC    GLOBAL DEFAULT   12
>>>>>>>>> fuse_main_real_compat25@@FUSE_2.6
>>>>>>>>
>>>>>>>> I do not know if it might be related to fuse version. In
>>>>>>>> configure.ac , it selects fuse version 25 but you are using 26?
>>>>>>>>
>>>>>>>> if test x$use_registry = xy; then
>>>>>>>>            PKG_CHECK_MODULES(FUSE, fuse)
>>>>>>>>            FUSE_CFLAGS="$FUSE_CFLAGS -DFUSE_USE_VERSION=25"
>>>>>>>>            AC_DEFINE(CONFIG_XENO_REGISTRY,1,[config])
>>>>>>>> AC_DEFINE_UNQUOTED(CONFIG_XENO_REGISTRY_ROOT,"$registry_root",[config])
>>>>>>>> Fi
>>>>>>>
>>>>>>> That's a good hint. I vaguely recall similar issues when building
>>>>>>> against a newer version and trying to run that against an older
>>>>>>> one on
>>>>>>> the target.
>>>>>>>
>>>>>>> Jan
>>>>>>>
>>>>>>
>>>>>> Hi all,
>>>>>>
>>>>>> Yes, I'm using libfuse compiled with FUSE_USE_VERSION=26.
>>>>>> I'm building in Yocto.
>>>>>>
>>>>>> I tried to
>>>>>> - change FUSE_USE_VERSION=26 in Xenomai: does not work
>>>>>> - change FUSE_USE_VERSION=25 in fuse and rebuild it: does not work
>>>>>>
>>>>>> I finally removed the can utils from the Xenomai build (I don't need
>>>>>> it) and the build completes correctly.
>>>>>>
>>>>>> Seems that the fuse symbols are not found only for can utils (don't
>>>>>> know why).
>>>>>>
>>>>>> Thanks, regards
>>>>>>
>>>>>
>>>>> Replying to myself: Xenomai does build but does not work:
>>>>>
>>>>> /usr/lib/libcopperplate.so.0: undefined symbol: fuse_main_real_compat25
>>>>>
>>>>> Strange thing is that /usr/lib/libcopperplate.so.0 does not depend by
>>>>> libfuse2 (that have the fuse_main_real_compat25 symbol exported)
>>>>>
>>>>> LD_TRACE_LOADED_OBJECTS=1 /lib/ld-linux-x86-64.so.2
>>>>> /usr/lib/libcopperplate.so.0
>>>>>       linux-vdso.so.1 (0x00007ffe6ed14000)
>>>>>       libcobalt.so.2 => /usr/lib/libcobalt.so.2 (0x00007f21fc308000)
>>>>>       libmodechk.so.0 => /usr/lib/libmodechk.so.0 (0x00007f21fc303000)
>>>>>       librt.so.1 => /lib/librt.so.1 (0x00007f21fc2f8000)
>>>>>       libpthread.so.0 => /lib/libpthread.so.0 (0x00007f21fc2d7000)
>>>>>       libc.so.6 => /lib/libc.so.6 (0x00007f21fc10a000)
>>>>>       /lib/ld-linux-x86-64.so.2 (0x00007f21fc355000)
>>>>>
>>>>> Other hints? Thanks in advance, regards
>>>>
>>>> If only can-utils are affected, it should be possible to spot some delta
>>>> in the Makefiles, the build logs or also the generated binaries of other
>>>> tools. There are many more tools, and the can-utils do not reference
>>>> fuse or the registry service explicitly.
>>>>
>>>
>>> Yes, I will go in this direction doing diffs between build logs,
>>> ldflags order etc.
>>>
>>>> And: Where does version 25 come from? Do you have it on the host, and
>>>> something actually leaks into the yocto build so that the host libs are
>>>> referenced?
>>>
>>> Version 25 is the libfuse API/ABI version that Xenomai wants to use,
>>> and it is indicated in Xenomai's configure.ac, as pointed out by Chen.
>>>
>>> libfuse is built with version 26, but contains backward compatibility
>>> API/ABI for version 25, allowing the binaries to use it like Xenomai
>>> is doing. In fact, the libfuse2.so library contains the
>>> fuse_main_real_compat25, but canutils does not see it during the
>>> build, and libcopperplate does not find it at runtime because seems
>>> not linked to libfuse2.
>>>
>>> I will do more investigations about it.
>>>
>>> Thanks, regards
>>>
>>
>> Ok, found the problem. First of all, canutils buld fails because
>> libcopperplate does not find fuse_main_real_compat25 (as you stated,
>> canutils does not need libfuse directly).
>>
>> libcopperplate does not find fuse_main_real_compat25 because
>> libregistry_la lacks the fuse ldflags. This patch solves the issue:
>>
>> diff --git a/lib/copperplate/Makefile.am b/lib/copperplate/Makefile.am
>> index 671e87d79..a68f2c80c 100644
>> --- a/lib/copperplate/Makefile.am
>> +++ b/lib/copperplate/Makefile.am
>> @@ -34,6 +34,9 @@ libregistry_la_SOURCES = registry.c
>>   libregistry_la_CPPFLAGS =              \
>>          $(libcopperplate@CORE@_la_CPPFLAGS)     \
>>          @XENO_FUSE_CFLAGS@
>> +
>> +libregistry_la_LIBADD =                \
>> +       @FUSE_LIBS@
>>   endif
>>
>>   if XENO_PSHARED
>>
>> But for me it's strange that this error does happen only to me.
>> If you are ok with this patch, I can send it in mailong list, or just
>> take it from this messsage if you prefer.
>>
> 
> I don't recall all details, but I did recall something similar from the
> past:
> https://source.denx.de/Xenomai/xenomai/-/commit/9287a691412ac1da0d611606499eb0201c2e0247
> 
> Reading "optimization", I could imagine that different compiler/linker
> versions have an impact here. Are you on gcc-12 or something similarly
> recent?

No, I'm using gcc 9.5.0 (Yocto Dunfell)

> 
>> I also have another fix for sysregd utility, that I will send in a
>> separate thread.
>>
> 
> Yes, please.

Sent it

> 
> Thanks for resolving this!
> 
> Jan
> 
-- 
Mauro S.

