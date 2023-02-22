Received: from sonic314-48.consmr.mail.ir2.yahoo.com (sonic314-48.consmr.mail.ir2.yahoo.com [77.238.177.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6630623A5
	for <xenomai@lists.linux.dev>; Wed, 22 Feb 2023 09:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677059696; bh=NIHBw16QiVXUJEQq3eOZXm30wt6VTmY2Y4wTv8Edc2E=; h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=hVqKgpxC8r9foi1RlLXTeRjmwFo3p2rPwGntqbkoxrs8n6okbIRtoeRCZ+4eI42CWOx0CTMWbenYDyUjExrgDENutpIv1udRU7VscDOhJMtuxhFUvfuLncA+++yHuKcd+nQzCWiYmNlrO/JlszEPiE1vzCEPOUzZk/zTQwIeT/qMX4iUFhV2yUlD07I4An9V4hjc0TH4WYhdP63yCWwYvpJWZZggtOAfNlkVeg7FRMrj+QDpdmj4CfbkiS/6TR654UN+sCrTY8LgCTjuDKVYfNUFCyCDB81EImIirREaowyG3DFKUnLJ9MplJed78b11RcjwrPe1FE+k23uiogOlsg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677059696; bh=4AyOQdXkIaFOowBsMBzRO1dOVOEg9hX12c5L0pE7FPN=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=g3ETzC/hGifOlI3heS9hyYe25duiZ60YsC2/ScU2YG9tRKS2e2JZBJP7hlCdg7fAaQu+h1uzj/Dup9wSEFEWx8hzA1mJ0M9j+YjQejYS6WHdy5Gu8jzE/bPJsu58OitOCd3MBM3JPFvBO7RRb09i3k1i0OV3TmSShdhg9XDgTEPT60XGQy6rUxdCtmqXVQIGN4g8/0jjVcKDp08UEZq79cicB8QDjQx4GbYLKctgq7VKhO/njpTzFq/2dSqIVwzcoBQ6Ui085JOBlaGyYh97ZuM+F2F2LXbahZ8NAVCpwtPX4zcE9CEh3EFF2bPKEK3QcgDxQcLkv3QmsyrOxEtT3Q==
X-YMail-OSG: d0CcCo8VM1nV2v8H5vU6DEtKLcX2sRTqNcv9F8j5JskZKTZjOaf2We29IUVeqMl
 vVdi96DxLo93CiY2ZRhcNIhNZPi7V1csT11C1tT85Gvcjx1KgngKe8H7SQZSXUPWmMQl97f2EAZs
 O0G7E9EmsVv517clwOB..4ncm30NFoD922K4Opg3BhQ9BUCYJJ3h1ro000pj8DXV9lPNcYA.kHLR
 LRzWGbBEQ9IBXEYp2n.aJ9Fp90zx9QP3BSJaPftWlv5vI6wixHS78iEAswHDypDv5Wg6j7KEinGM
 Ydr0RkooSW8bacjIrKz5nMIVsX05dlRjDKXJ47bzsufoP2psQUAe0U_Q4ZHzK27tXdjs3SRlRWNX
 uN493sOUDJVEe6F8U3fE7Sloh_aRzvuZu0gsYSBO_Ld8BwvRJbcItk7TqB8nMjz1nMMIDYmrgI0x
 buQRqHBZ9Ed0WrOr9j7.fyQX.idELeh0kWbH5bmg1P9r47x1rM7zZF7ENhBDfMAhz5CmgnCsxKSL
 Y4DKryl3xRwXH.3o6u75F0iizQzxWYNQW7MZl_cf6t9tXuw8zEU_Fb9lX.r82gEE.A6b.swlb.XI
 2XSesoBBxH9vKSE4oDdlSO.HPJxQ_RhykNwB5SgCej9VUAa.v137T83mAoavPJspo7WfoWHxUMbW
 4IUkgS72Q_QyrVKTIVQqH3HePpNgoy0QiQAXWERk_Yn5vQ_WVtMFxxRRwOxbtXWc8QCfQSBGTACZ
 p_9MtyvCnbpO2Z9atNNB0.3O1qHi1vsZ07N.VOLjHWsEEuXP7VYTADVIp_aNuVc6WAQGHIynRk8w
 gEAZTtcke0vS7m5dpahTEHr_npn3ifI0Ex1Nad5WSco7szBfwUc13zre5A1m.mT8T.Dv_sEyvO8p
 5uUw8RV6.FyEbp8nI1p4m.YnDXhSmRQDblCPpJFwBPkPdANnnqoE9kKhp1wqF0tEVLYUXNtMuXgT
 5dCdZpCK4zA5clIgLE88cSxY8e4HP1dA86K.kcF.FkWLL15VVCc0uVwyMc_sM7hA55p1epV1X8dw
 RSbD.tqwL86iWgxm1W2JCekXWghfDgjuS8Tv_o6TfoUjb6_0R6BmMBDu1ispvcSNDSS8qDon8sqT
 qmt7NCPwgkBq.I1myq8P1asFodCGhQG0hNaZL_0FKPOgsSftAtsLp72lqQzW.wyS34SUNMvD3yjl
 .AaszWeSZZmdNi5Xf_19TPHUries98mVCmjhB8xo2vkrxv0WT_eq5TWXG.jVMjKyqYLQ1HoU7D4T
 gA.JF.e3ngW1WLG8Tzonk9HjUA_qiyPbjM39913cvQ7_L.wtwzXSCNVUa.gEXR0s5yyAAhT8Zc.p
 Q2PUCYwO1u2UpM9Q99mExOlguQ8uqQyQkdulEDXC4aTnRj_CPZ409xE.FL_srp4213pmTFtV7pMW
 IfjqonJSE_oifM5pIM4n_.LBSsj01ml1mnGGR_zKc10p5xHnRfQTIOOnX5UckCTfgAXx52Dcz6zq
 FkEjeixE6vntPDjvHQpGlIAAi8nmb3aNTWowbl_bKv2QB.crvr2_FA4Tkj4dMjU2X2ZxnTjkAIfQ
 9DjDeEEoGeLRBhgEBrTQZAteerPQyz_nNQzhq.aTy6WeEDATMEO1EXYPP3bA90DmrL8RLbuB1xAM
 Pk.JFAPQ6QpwXCgnLo08Du85ZxOcsTTL2We_Ud4.490.oX20dNV29iwm1Fs1Lph7blphmBVniZit
 Y14afqsO3tvUqbSW6A_MuVGprtBnTIwPZEph.cqYBTOYIDb3auQnbC1zDG9Br8yjtpQOu4Wdfv88
 lKPITiqv_TJiZHZndQFvfTLivc5qykYwuERXSRwy6IaepZPBwWt9F8uCAbMdZuAS9c_yN1E52sWu
 53UkSTFqKReMMVYLFtmU853VQ.6qmJOVy.CLo3lXKxgNAdkx71dAGbSHRah0bLJg3ZZ.XQIM6_jw
 bt2HW9drurVtEMsgxLhj35K8evQOh6DrU86KdnIvckFIvhMiIQPx4MIoz__TqmDuvejMtMNV2kpm
 T8N8HQMG2VUfI_VK3UpC_Xrr0anunlic2oM0W8hMgQc3SDnJykRgWSn88lJiKPKJ5Xhu5zXPiz4W
 zyEQAAigjreK5QyoZKZGIKb9fM18pc13RB.JyFjMc5JyNBynebqyfwf4ukJlOMBc_4YYiYDJje5b
 _YQdgcqsWOM4EPogPOVPNAEUHtxVDhBujDlvCoVjEHoUEE5m_1kuaRhyaPVuY5MlP2XHf8eBhdi8
 tWHe1KKIENmWRUrJhcWLF7E4-
X-Sonic-MF: <mau.salvi@yahoo.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ir2.yahoo.com with HTTP; Wed, 22 Feb 2023 09:54:56 +0000
Received: by hermes--production-ir2-65c64dfd66-fhq4t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID cfe24862fe3a22f4dd0c7d7ec65fe1e4;
          Wed, 22 Feb 2023 09:52:55 +0000 (UTC)
Message-ID: <a9c9fbbf-9278-141f-8b73-04c9e5217a48@yahoo.com>
Date: Wed, 22 Feb 2023 10:52:54 +0100
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
From: "Mauro S." <mau.salvi@yahoo.com>
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
In-Reply-To: <bfea17eb-684d-40ba-8325-ef3b45bfc226@yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21183 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Il 22/02/23 08:19, Mauro S. ha scritto:
> Il 21/02/23 17:57, Jan Kiszka ha scritto:
>> On 21.02.23 11:40, Mauro S. wrote:
>>> Il 21/02/23 11:24, Mauro S. ha scritto:
>>>> Il 08/02/23 09:21, Jan Kiszka ha scritto:
>>>>> On 08.02.23 03:27, Chen, Hongzhan wrote:
>>>>>>
>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Mauro S. <mau.salvi@yahoo.com>
>>>>>>> Sent: Tuesday, February 7, 2023 9:46 PM
>>>>>>> To: xenomai@lists.linux.dev
>>>>>>> Subject: undefined reference to `fuse_main_real_compat25' when
>>>>>>> build with -
>>>>>>> -enable-registry
>>>>>>>
>>>>>>> Hi all,
>>>>>>>
>>>>>>> I'm bulding Xenomai 3.2.2 for x86_64.
>>>>>>>
>>>>>>> When I configure the library with --enable-registry, I get the error
>>>>>>>
>>>>>>>     ..
>>>>>>>       CCLD     rtcanrecv
>>>>>>>     libcopperplate.so: undefined reference to 
>>>>>>> `fuse_main_real_compat25'
>>>>>>>     collect2: error: ld returned 1 exit status
>>>>>>>     ..
>>>>>>>
>>>>>>> libfuse-dev package is installed (the configure script finds fuse),
>>>>>>> and
>>>>>>> it has the function fuse_main_real_compat25 exported
>>>>>>>
>>>>>>>     readelf -Ws /usr/lib/x86_64-linux-gnu/libfuse.so | grep
>>>>>>> fuse_main_real_compat25
>>>>>>>      318: 000000000001a500    14 FUNC    GLOBAL DEFAULT   12
>>>>>>> fuse_main_real_compat25@@FUSE_2.6
>>>>>>
>>>>>> I do not know if it might be related to fuse version. In
>>>>>> configure.ac , it selects fuse version 25 but you are using 26?
>>>>>>
>>>>>> if test x$use_registry = xy; then
>>>>>>           PKG_CHECK_MODULES(FUSE, fuse)
>>>>>>           FUSE_CFLAGS="$FUSE_CFLAGS -DFUSE_USE_VERSION=25"
>>>>>>           AC_DEFINE(CONFIG_XENO_REGISTRY,1,[config])
>>>>>> AC_DEFINE_UNQUOTED(CONFIG_XENO_REGISTRY_ROOT,"$registry_root",[config])
>>>>>> Fi
>>>>>
>>>>> That's a good hint. I vaguely recall similar issues when building
>>>>> against a newer version and trying to run that against an older one on
>>>>> the target.
>>>>>
>>>>> Jan
>>>>>
>>>>
>>>> Hi all,
>>>>
>>>> Yes, I'm using libfuse compiled with FUSE_USE_VERSION=26.
>>>> I'm building in Yocto.
>>>>
>>>> I tried to
>>>> - change FUSE_USE_VERSION=26 in Xenomai: does not work
>>>> - change FUSE_USE_VERSION=25 in fuse and rebuild it: does not work
>>>>
>>>> I finally removed the can utils from the Xenomai build (I don't need
>>>> it) and the build completes correctly.
>>>>
>>>> Seems that the fuse symbols are not found only for can utils (don't
>>>> know why).
>>>>
>>>> Thanks, regards
>>>>
>>>
>>> Replying to myself: Xenomai does build but does not work:
>>>
>>> /usr/lib/libcopperplate.so.0: undefined symbol: fuse_main_real_compat25
>>>
>>> Strange thing is that /usr/lib/libcopperplate.so.0 does not depend by
>>> libfuse2 (that have the fuse_main_real_compat25 symbol exported)
>>>
>>> LD_TRACE_LOADED_OBJECTS=1 /lib/ld-linux-x86-64.so.2
>>> /usr/lib/libcopperplate.so.0
>>>      linux-vdso.so.1 (0x00007ffe6ed14000)
>>>      libcobalt.so.2 => /usr/lib/libcobalt.so.2 (0x00007f21fc308000)
>>>      libmodechk.so.0 => /usr/lib/libmodechk.so.0 (0x00007f21fc303000)
>>>      librt.so.1 => /lib/librt.so.1 (0x00007f21fc2f8000)
>>>      libpthread.so.0 => /lib/libpthread.so.0 (0x00007f21fc2d7000)
>>>      libc.so.6 => /lib/libc.so.6 (0x00007f21fc10a000)
>>>      /lib/ld-linux-x86-64.so.2 (0x00007f21fc355000)
>>>
>>> Other hints? Thanks in advance, regards
>>
>> If only can-utils are affected, it should be possible to spot some delta
>> in the Makefiles, the build logs or also the generated binaries of other
>> tools. There are many more tools, and the can-utils do not reference
>> fuse or the registry service explicitly.
>>
> 
> Yes, I will go in this direction doing diffs between build logs, ldflags 
> order etc.
> 
>> And: Where does version 25 come from? Do you have it on the host, and
>> something actually leaks into the yocto build so that the host libs are
>> referenced?
> 
> Version 25 is the libfuse API/ABI version that Xenomai wants to use, and 
> it is indicated in Xenomai's configure.ac, as pointed out by Chen.
> 
> libfuse is built with version 26, but contains backward compatibility 
> API/ABI for version 25, allowing the binaries to use it like Xenomai is 
> doing. In fact, the libfuse2.so library contains the 
> fuse_main_real_compat25, but canutils does not see it during the build, 
> and libcopperplate does not find it at runtime because seems not linked 
> to libfuse2.
> 
> I will do more investigations about it.
> 
> Thanks, regards
> 

Ok, found the problem. First of all, canutils buld fails because 
libcopperplate does not find fuse_main_real_compat25 (as you stated, 
canutils does not need libfuse directly).

libcopperplate does not find fuse_main_real_compat25 because 
libregistry_la lacks the fuse ldflags. This patch solves the issue:

diff --git a/lib/copperplate/Makefile.am b/lib/copperplate/Makefile.am
index 671e87d79..a68f2c80c 100644
--- a/lib/copperplate/Makefile.am
+++ b/lib/copperplate/Makefile.am
@@ -34,6 +34,9 @@ libregistry_la_SOURCES = registry.c
  libregistry_la_CPPFLAGS =              \
         $(libcopperplate@CORE@_la_CPPFLAGS)     \
         @XENO_FUSE_CFLAGS@
+
+libregistry_la_LIBADD =                \
+       @FUSE_LIBS@
  endif

  if XENO_PSHARED

But for me it's strange that this error does happen only to me.
If you are ok with this patch, I can send it in mailong list, or just 
take it from this messsage if you prefer.

I also have another fix for sysregd utility, that I will send in a 
separate thread.

Regards
-- 
Mauro S.

