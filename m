Received: from sonic310-37.consmr.mail.ir2.yahoo.com (sonic310-37.consmr.mail.ir2.yahoo.com [77.238.177.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909C31FB5
	for <xenomai@lists.linux.dev>; Wed, 22 Feb 2023 07:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677050491; bh=OLzvhctcZshVTig50qxus4Hn3g1NEjM6UH/xdAQzje8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=hkqzFDFDYlg0jxWPGToxCfS8pzOKgnbGymXhMzGcsfGYyYbrAKNaALUyeO64e7z0foKld/KNfyCldXhSb3r3LklwX7YitqnUcRdQYnYeYFOa+BFHWxQvo4zt8iWjCufz1thvv66Op3TZk6QB9dIQtdQ9gyMn5fqVuLvys6Srur5Pal9xHGFWPruqsxUEuizyqeXjXVA1DyC8lzxo7+jTEDzrCU4CUsAqIRDF77GRAZFhOjeHmvlTbfSzfe3PoNIKruwWhcDygCJXIg6xJBH5+H3523aemIHX2wnSHsyTufX6gr0gf799xgy5kPbL7GV8Drj4pnj1Hj4N0hrPERdWwA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677050491; bh=xdA/CYCxxsxK8Gi7e7K1CVSbpAivTCiEBVhTCI3F+K2=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=rRfrbDp/hDKc/kYFwn4ZOYEJdgGH2IIED+QGOwrJWZ09zyf9laptILtobnuRlnGEV5G3Qk9TbVvnY+b/k0p6POUu/gCJkcfAncVOahqzSlbbAKTHRc4G2kPhxXXsF1ZkKmRa5NOgxWrOS1a9l9zNos+j3gL0GQAwMb7AYsXJu+LwoERVIaPzZMvcK/q2pN6H/IjB182UUO2aiuMYqJC1t1ZQSBkb96ihspZRZy9ChQHHPJyWZkXvScURZzakb0YZkoqwvYOeUU0iAv/31tOlvLltoiKhqYfBupD5odAEfX6uhVhfVt73zptxtvHuJF9jyJo3dsOE6Ewf32KzwiqhYg==
X-YMail-OSG: nVsGV78VM1lRxpX1cN2FkSdgr4fAkulwJMMBa1iUDIagvkWFLKrlyiB9O9uXekS
 jL_L08FUeYapo8iTfSPUAsUTy0yk6phQqiV8JHtKyMXkXOTBHJEuTZv8Lukl8DNr2ZTlpWxtri.2
 DkIFKQ8lReLOijwAzb1dM.wqGoKd0UtFZl.XSLX5uf_hO4fVMdEK7ckdxD.ozX3v4E.4fdXdps8o
 MBMf27d7hEAvSuPaoRhv_mzqnSmZhj4QNTV6ue2FPcR5U_eAL9_0Fu8X6OGVNiaprxO7fi4XIMnh
 aokCcB.lwMONQCQA0O53aQWOHywvHR.Z7tOIK3NsPSnTYvhDRLb1j._E3bPaXpYrYJyDmWKwJZyZ
 Xx.0bsiPXMWrdMnIixNAfnx3tfmprEVQnaU63Jw3I0s7ppD1RxI7_5t1r9XVqi8QqjFO2TlJ_pv0
 8MEiYfxRSy6xx200XEacgbYBnD1aWeeWGCzFp9alZLYQ_qJZRbllUVU1G5yW5xypz7.Uk2l_0zMz
 jCjslwwouocefddKPbIu_tLnItQUD6mKDdq5E7gk6XlcrWz9wcSRri5zqlHBiQxboymR7iuHQy5n
 Fjn9TNpa9UHtWdir_g1c0MS.4VbBrCmjTQnU6JoZXDv8Gl369RSizJReDXHlxs9GjKfdEhr_LwKC
 Pct13vAU_s60QTHYiG.o50r5ez1uu1TQGxmS4quQSTbpjSLuLk7KvcDo0XBnYvRDHQnglR5UKl3H
 Gbq2rhcrV67Xry9QOsUib4c.xFVVXznAJ1kH9VnQrEhFHEWXO1IYf2M9z3AOjJZxag9rAowCDmPf
 foz8wjFtCayYyQutY.b2Gb6uqwaDQl58OL3anYjFTLMuXcM7V015_LLHBW6D_17OIEa7Dad0uzX5
 Q7NFWSoP4zGe3ZNYWSgxxNbcsqGvbmQvdw16hh.CpWJFEBLu6gB0CGi.C9K5bPpCV8jIU.ROWysO
 qs5CrXOSRw_IqoSIMJJuHoqC9fnt_j5NPRnVsHA1o2F.5CAvOMx24L8l6KQY32GNH_cAuljNMdiG
 1a8N_LA3H5oV_V0nBaj66bsRAJBOS07bp7qr7M5I1pnpLmmpbhw8LwKvkd.K3iFoyFzu5evl6mVH
 h7lAu5iqPwWZU7ObNso8_.WKRIpGfAMXauF0gJ7qzLm6PiFNeu.7Wq0EpyCqzCMvOtgMDKksHNNO
 0N_mZa1NCH7ytJipOse1vPRph7jbsFgFxvXBr1i3zkT_WJF38u12RntnJWpHnHuLQHRrItIqw_So
 EqM4yenRndpsPOkAU9RZTIFTMQOehz4BFQrK5nvN7LdiGBXvsjQgtYemWslwxsqwa3I__afUWGU6
 mtoAH2tmqNZgb5neYC2nJX9v4Ij2ZS9G1c4FcdTyy8l_PSadMT20Rk39wr9Uuco7mg6gWmidl3d3
 kMP1zYjG9Y6I2degs3pHSP98OuATBtwJUT8gVT066CcNb0s4JCumq5yVhqvqeu7wCsjT0qIp1hzg
 kmTnpyyBRDY_OadyEvaoDElqvBrckPgJ6rd5twNToYwv2lxpZYjYt0DDL4aHftIZwWlq.gv_5QnX
 O2suBVxBq8InwM9AELFLdlcu0KvKW_2jVddtEch4Unw8YXokq8hNxqDIA__ZdUm0OyllJu0La8nA
 Itc_7CHvlqxbvI4_yH6qVUWmvH9cexgDAA50MoZujEoThYGFFOWP2HpI95HoLIJop0uCk8ES4EBF
 0enOy6OGB7FJGIo4XCqqB6OczHACq7u_eRByqNdLyx3pJWVUdb6bot7DJSC1j11tS4tQrpf4jrgz
 qU1dfDIN8AqMrblozN1PnsGzV3VaTPVeLfLOwEHN6pgR9PXuMtbeVNJU1hmybFj0tZn3hyWADFuf
 LMlbfq_OA5WpXGxl_YW2a3FINiuTMTXCGaFBoZJV2tgtpczHgFyq14uKpCT5G_86iOFZCrBCyt1_
 hDVNaFW4KwPGT31iG4jh8zn04mTu5Sm3uEyqrdrtlm6FGBMhBawCaLi1MnJv1VAtmmZyfgHbt9Hn
 qkm._VvFRmHbT9V377zo0ooYwghobY7Kv1C6rfmDPv1AZV4uRLoXoTq26wk.WLP_KJk.6T0PtdGF
 vpzcDeKlrjqR5NEvFVeqglhuhU7wXLyeNa8eofqdfTKJ61dxDjDCvOF5zNX8mu_zuOjBAk3_OdLT
 uAIslXg_3ZZRG4Lr4WFpSsqqmKFQmv9hGevD6sCZd41jU3wGa_v4hWGd96CiyVQqQB6z9Sav1luR
 cJu_cXdHTCQU6mlIHh6.W
X-Sonic-MF: <mau.salvi@yahoo.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ir2.yahoo.com with HTTP; Wed, 22 Feb 2023 07:21:31 +0000
Received: by hermes--production-ir2-65c64dfd66-hxbb4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 918bc84f4cebfbf6e2c2de83f0a645d6;
          Wed, 22 Feb 2023 07:19:30 +0000 (UTC)
Message-ID: <bfea17eb-684d-40ba-8325-ef3b45bfc226@yahoo.com>
Date: Wed, 22 Feb 2023 08:19:29 +0100
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
Content-Language: it-IT
From: "Mauro S." <mau.salvi@yahoo.com>
In-Reply-To: <023a8783-e78e-94e2-fd2a-0bf959b886de@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21183 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Il 21/02/23 17:57, Jan Kiszka ha scritto:
> On 21.02.23 11:40, Mauro S. wrote:
>> Il 21/02/23 11:24, Mauro S. ha scritto:
>>> Il 08/02/23 09:21, Jan Kiszka ha scritto:
>>>> On 08.02.23 03:27, Chen, Hongzhan wrote:
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Mauro S. <mau.salvi@yahoo.com>
>>>>>> Sent: Tuesday, February 7, 2023 9:46 PM
>>>>>> To: xenomai@lists.linux.dev
>>>>>> Subject: undefined reference to `fuse_main_real_compat25' when
>>>>>> build with -
>>>>>> -enable-registry
>>>>>>
>>>>>> Hi all,
>>>>>>
>>>>>> I'm bulding Xenomai 3.2.2 for x86_64.
>>>>>>
>>>>>> When I configure the library with --enable-registry, I get the error
>>>>>>
>>>>>>     ..
>>>>>>       CCLD     rtcanrecv
>>>>>>     libcopperplate.so: undefined reference to `fuse_main_real_compat25'
>>>>>>     collect2: error: ld returned 1 exit status
>>>>>>     ..
>>>>>>
>>>>>> libfuse-dev package is installed (the configure script finds fuse),
>>>>>> and
>>>>>> it has the function fuse_main_real_compat25 exported
>>>>>>
>>>>>>     readelf -Ws /usr/lib/x86_64-linux-gnu/libfuse.so | grep
>>>>>> fuse_main_real_compat25
>>>>>>      318: 000000000001a500    14 FUNC    GLOBAL DEFAULT   12
>>>>>> fuse_main_real_compat25@@FUSE_2.6
>>>>>
>>>>> I do not know if it might be related to fuse version. In
>>>>> configure.ac , it selects fuse version 25 but you are using 26?
>>>>>
>>>>> if test x$use_registry = xy; then
>>>>>           PKG_CHECK_MODULES(FUSE, fuse)
>>>>>           FUSE_CFLAGS="$FUSE_CFLAGS -DFUSE_USE_VERSION=25"
>>>>>           AC_DEFINE(CONFIG_XENO_REGISTRY,1,[config])
>>>>>          
>>>>> AC_DEFINE_UNQUOTED(CONFIG_XENO_REGISTRY_ROOT,"$registry_root",[config])
>>>>> Fi
>>>>
>>>> That's a good hint. I vaguely recall similar issues when building
>>>> against a newer version and trying to run that against an older one on
>>>> the target.
>>>>
>>>> Jan
>>>>
>>>
>>> Hi all,
>>>
>>> Yes, I'm using libfuse compiled with FUSE_USE_VERSION=26.
>>> I'm building in Yocto.
>>>
>>> I tried to
>>> - change FUSE_USE_VERSION=26 in Xenomai: does not work
>>> - change FUSE_USE_VERSION=25 in fuse and rebuild it: does not work
>>>
>>> I finally removed the can utils from the Xenomai build (I don't need
>>> it) and the build completes correctly.
>>>
>>> Seems that the fuse symbols are not found only for can utils (don't
>>> know why).
>>>
>>> Thanks, regards
>>>
>>
>> Replying to myself: Xenomai does build but does not work:
>>
>> /usr/lib/libcopperplate.so.0: undefined symbol: fuse_main_real_compat25
>>
>> Strange thing is that /usr/lib/libcopperplate.so.0 does not depend by
>> libfuse2 (that have the fuse_main_real_compat25 symbol exported)
>>
>> LD_TRACE_LOADED_OBJECTS=1 /lib/ld-linux-x86-64.so.2
>> /usr/lib/libcopperplate.so.0
>>      linux-vdso.so.1 (0x00007ffe6ed14000)
>>      libcobalt.so.2 => /usr/lib/libcobalt.so.2 (0x00007f21fc308000)
>>      libmodechk.so.0 => /usr/lib/libmodechk.so.0 (0x00007f21fc303000)
>>      librt.so.1 => /lib/librt.so.1 (0x00007f21fc2f8000)
>>      libpthread.so.0 => /lib/libpthread.so.0 (0x00007f21fc2d7000)
>>      libc.so.6 => /lib/libc.so.6 (0x00007f21fc10a000)
>>      /lib/ld-linux-x86-64.so.2 (0x00007f21fc355000)
>>
>> Other hints? Thanks in advance, regards
> 
> If only can-utils are affected, it should be possible to spot some delta
> in the Makefiles, the build logs or also the generated binaries of other
> tools. There are many more tools, and the can-utils do not reference
> fuse or the registry service explicitly.
> 

Yes, I will go in this direction doing diffs between build logs, ldflags 
order etc.

> And: Where does version 25 come from? Do you have it on the host, and
> something actually leaks into the yocto build so that the host libs are
> referenced?

Version 25 is the libfuse API/ABI version that Xenomai wants to use, and 
it is indicated in Xenomai's configure.ac, as pointed out by Chen.

libfuse is built with version 26, but contains backward compatibility 
API/ABI for version 25, allowing the binaries to use it like Xenomai is 
doing. In fact, the libfuse2.so library contains the 
fuse_main_real_compat25, but canutils does not see it during the build, 
and libcopperplate does not find it at runtime because seems not linked 
to libfuse2.

I will do more investigations about it.

Thanks, regards

> 
> Jan
> 
-- 
Mauro S.

