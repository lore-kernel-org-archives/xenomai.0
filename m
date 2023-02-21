Received: from sonic304-48.consmr.mail.ir2.yahoo.com (sonic304-48.consmr.mail.ir2.yahoo.com [77.238.179.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799391C3A
	for <xenomai@lists.linux.dev>; Tue, 21 Feb 2023 10:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1676976136; bh=UkYRrrSVs9YBSbFHYDL+lkRug5QfLZpkW0Kg97jzGQ4=; h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=sbJBwtTs99ocRK8b8U9HJ8hJY72c+D3K0CIO9jtyjZp7pvGP/JlPnT6t+CdQOTyRtIv3m5D+4mkaJPukL9C2hBul6cjeVoGWhGsz9l6XDA9+IPTgrjkCSohRufaPdzVAF0wRUEWaKnEuNkazUx5BBupINs8OsEzeKKs9pFpl1r6J9BZfTZJAWDFfvs1pF0eYJ6bn6kLSLAXRNf4saCTkqxQFKYzGNK4odao4u4wv5sR3J/DgMClanT2nVRBvKg0M1lHF3njcGk2W1DCZFbjFSuKNB+TENlIg93UocdwOnC6yecMSHjhhQa2ObGoQRr0vc15VhbSVOsUo0A6wI0Er+A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1676976136; bh=1xzDzWjBU1cPIl3k/wdAj4bVIS9Af08na3qxJ0AO+Lu=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=TXSBg5/tvc4YrPMHWB6m/D5S5bVq6A+6cboZLogM2BdGpufH35m/qVHFq9p+tST54HohcHuomSgb3XXEWYimFhszQdwDdGxIKOX0XIxSMrjrZc1vhx3vlEWgnhWjoD5wg0s8bnSzAduAMQqb0uKLEPiOoA24tOQSUbL8DRe8CphVoJNrJf1iaebWl4oEkkpCYh/GtPsJtJjgLrJxT7wV5cHJ/ZNt0msIJno+k5TMJouRWXXMS6NvWvDg3ktKmvFilFYepxKNKZKuKMS+dYMZzzamsisYAEm9Sb5ZsvlyidiC35kAZGk5zyF9P+atZdMMfuvKBD+TXYyE7ht8yyvuZg==
X-YMail-OSG: 8VpE78kVM1l0CIF3_aN3p8pYil.bfLT1pbmQITe5Ue5OSNW0eMpEFl9uow3.u4G
 _rAl6kGRb_UtKRJLaS.O5UmAo_l6TUsnwpJhROKu3kn7yvX7h37N.L3P8pN3ReGROGs29BSoSsY9
 Mcqh2QQXMHp8xHIwCPxnXWRhQZir9l8W05dFWbRFY9Kq46nrKkLb7vspiT33KSkRJlRLStuCPtyq
 zQrkuPoLR5NssGYOLSMBS20WLUlSH.XXRisMkkq5JsD9cYngkKQ02Dg7P14EwDexpCAu6RNVI4PE
 syw0gqI6NYuvBt4A0iUYPPveL1YtoyhjbG8MJDgDTbSKdCeqNK_t6nvJzcm6.uzd5OYqF0V1fPWA
 NDr2b43ek82sk9a2F7h_Gr1ZP3PvnWPyrAltLNdAB6kBU6MsHnXBkIJ7EZr7r5PS5kDyLN1WmmFK
 ht_O8SALtdKIrHugWhqzfI665Gu4hUUZpFxXBo0fR7.oV2HwNxHVdfD6eefEnfCZXagNNWytX0KP
 uoCmPbbxq89QgP1xf_KUMo7LixBXxxuvQbS1yTBLONFDuRk40psimcAAPJ8BoMLJoqxVCtI_qIRU
 azK0uB6UtDX_q.SyOOPl1cQicnum3ePS6vLkjeB.SGBk6TZ7cbcTk22nFTtbYM7pqCHaDJilY9Tr
 27wJJlgLHrwkQAp_GsAMsGa5do_HnqNZ0inGeffo2FBFEUCgh7NTnrj5XOjkEJa93lVmE.gr433.
 KsjHFj6oUCIA_cHvf162t90ZW4mmXxzFhd.kWTuwbXneDPuLveRI3uvYx_04wTiHgNY045CRKusl
 hePjI1zjo0x57r8HqvoP6OShBKMpoqJHDq527DqapEx7meRF.BAXGph._NJ6M_8Ao48GXAu09_Tj
 yXi_.iZFfCM_U6Gx.zd_KYCHQNqpXP_j9mM90pD9quP1eL0_56Kp97rPDdoqPaJJIyotd73ttDA0
 iY6a8rVNatVyqjROKCmvOPhvM3x7gAxnHTU2WXaDRCnR.oo8vVbcuZTUdsjmayMtlmjEiOLADiya
 60aiiCLqHk4rh8j1N2Uvw2lGUmAqF7qS_jZcZd6DWtcKg2KS8CCpHZ3nSLpCwn6qLenXzfYhUEca
 dFHF6_.Txb_yTlqE_6WQ3v_q3SJvpYa5XA7BtWrjb8.sxXGefKi0pkysr053B3Q5MB2WKGvJNmST
 IgVFg3wQdSzyLbcYiNYuQvv9TYxVEg3NK4kyH85UCgmMVjk_xPEBZyn4OZjl3_Fy2dAFlANi0Wg8
 bhMRyiGz8V3vq0AtYrhBMNSVR.VloFzG6IB2juiaKXK8RFZsWkSDTYyUuEzagabODdDw3Ex1JKuv
 ylP1v8CB53rnVIF5G8piuIZtxkgiF__VnkcltEjnNngARkd1Fn0mLqls2i461A7zbguLAPoUoOpF
 Dxz6Ljiff9vfQpOZzveybkGkXN5iICvwoRM0.JFczb_C5ZrRX7dLfIax0ojt7d1VPZVw5jVMJIIh
 Zfj1icwxwJeXDi1lhrDs4Dl3hmJezefxjkeKA0kPFKNFJ9DA5p0TW17QPHPr_OhHoeqLWR2HoBYo
 OGlj6UCFm8uEdRd2L4GGuZTR9Q6LOr0FB6lAwJIPU1AXTqAXbYoEMH343O.V09Gza_YSna7LIv9l
 68y4LN4waNS2OK0qRhKOwDuOo5zKFErU2bvkbIWnEm2Vv68RBhvXxmXHNFj1vmtC7VE0ZjfyTotX
 xihR1JVDLVAWwpZyny30jVGLAbaIHjyb6UPQKgtNbjTabhD8U02w8s_am3aGtT2yWsowdJcDcw6M
 sl_GmxPPcvlnXCzThqd58gRcvzVAT0Dv3Urmfay7hPS0FkSx5hMxWgQr.z9w5VRLhz.tQRYIBHPv
 VMsS3m6ofkehx5W_s22PIlFHbDp4td86kYNY87a3Z2alpPPPpN6b.n4UXOArZIfxKAVic1_va5hd
 iA9OwTHlAXEY.fFKAdDgoXlV3eMpakTpvp9tAyEEYLrS5O3l44tY1lhxhs_Vw6ZTK_U6elTtfhmT
 b5jSTT4z.Ixp65mFzUK3e4.xRPVtt1PkTGPId8FwlfIXzYPqDTfkH58w0dgr1XK4YWnvRcxpBjN3
 cN7.rTBeXy6Xp3pN48C9B_vV39g0fpMEw5L128WgGd3FzF_kATLuJ4MhA0ZNHT8AVO0V8ZVZmKe4
 XxcD2xYBwZIEwHPinJOEIIzImVV1RhrhQ9mY4I9GgKvWt1d1K8TjjE3B6WvEM2UwcEeSBsA.o9UF
 SHtwjOIDSPG3w_bnDEyA-
X-Sonic-MF: <mau.salvi@yahoo.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ir2.yahoo.com with HTTP; Tue, 21 Feb 2023 10:42:16 +0000
Received: by hermes--production-ir2-65c64dfd66-hwhd6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9f183a554ffa4253bf97dd9aef6b6f0d;
          Tue, 21 Feb 2023 10:40:15 +0000 (UTC)
Message-ID: <02c53276-6a36-8377-4792-575274793c66@yahoo.com>
Date: Tue, 21 Feb 2023 11:40:13 +0100
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
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Cc: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
References: <fc2f8e65-dce5-452d-3789-70ebc838abf2.ref@yahoo.com>
 <fc2f8e65-dce5-452d-3789-70ebc838abf2@yahoo.com>
 <MN2PR11MB4285DF9642B16AE3F170431FF2D89@MN2PR11MB4285.namprd11.prod.outlook.com>
 <b953b20d-f866-5bec-faf3-f8560354bf59@siemens.com>
 <04a817d8-5792-c00b-8533-488cbc24cb4d@yahoo.com>
In-Reply-To: <04a817d8-5792-c00b-8533-488cbc24cb4d@yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21183 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Il 21/02/23 11:24, Mauro S. ha scritto:
> Il 08/02/23 09:21, Jan Kiszka ha scritto:
>> On 08.02.23 03:27, Chen, Hongzhan wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Mauro S. <mau.salvi@yahoo.com>
>>>> Sent: Tuesday, February 7, 2023 9:46 PM
>>>> To: xenomai@lists.linux.dev
>>>> Subject: undefined reference to `fuse_main_real_compat25' when build 
>>>> with -
>>>> -enable-registry
>>>>
>>>> Hi all,
>>>>
>>>> I'm bulding Xenomai 3.2.2 for x86_64.
>>>>
>>>> When I configure the library with --enable-registry, I get the error
>>>>
>>>>    ..
>>>>      CCLD     rtcanrecv
>>>>    libcopperplate.so: undefined reference to `fuse_main_real_compat25'
>>>>    collect2: error: ld returned 1 exit status
>>>>    ..
>>>>
>>>> libfuse-dev package is installed (the configure script finds fuse), and
>>>> it has the function fuse_main_real_compat25 exported
>>>>
>>>>    readelf -Ws /usr/lib/x86_64-linux-gnu/libfuse.so | grep
>>>> fuse_main_real_compat25
>>>>     318: 000000000001a500    14 FUNC    GLOBAL DEFAULT   12
>>>> fuse_main_real_compat25@@FUSE_2.6
>>>
>>> I do not know if it might be related to fuse version. In configure.ac 
>>> , it selects fuse version 25 but you are using 26?
>>>
>>> if test x$use_registry = xy; then
>>>          PKG_CHECK_MODULES(FUSE, fuse)
>>>          FUSE_CFLAGS="$FUSE_CFLAGS -DFUSE_USE_VERSION=25"
>>>          AC_DEFINE(CONFIG_XENO_REGISTRY,1,[config])
>>>          
>>> AC_DEFINE_UNQUOTED(CONFIG_XENO_REGISTRY_ROOT,"$registry_root",[config])
>>> Fi
>>
>> That's a good hint. I vaguely recall similar issues when building
>> against a newer version and trying to run that against an older one on
>> the target.
>>
>> Jan
>>
> 
> Hi all,
> 
> Yes, I'm using libfuse compiled with FUSE_USE_VERSION=26.
> I'm building in Yocto.
> 
> I tried to
> - change FUSE_USE_VERSION=26 in Xenomai: does not work
> - change FUSE_USE_VERSION=25 in fuse and rebuild it: does not work
> 
> I finally removed the can utils from the Xenomai build (I don't need it) 
> and the build completes correctly.
> 
> Seems that the fuse symbols are not found only for can utils (don't know 
> why).
> 
> Thanks, regards
> 

Replying to myself: Xenomai does build but does not work:

/usr/lib/libcopperplate.so.0: undefined symbol: fuse_main_real_compat25

Strange thing is that /usr/lib/libcopperplate.so.0 does not depend by 
libfuse2 (that have the fuse_main_real_compat25 symbol exported)

LD_TRACE_LOADED_OBJECTS=1 /lib/ld-linux-x86-64.so.2 
/usr/lib/libcopperplate.so.0
	linux-vdso.so.1 (0x00007ffe6ed14000)
	libcobalt.so.2 => /usr/lib/libcobalt.so.2 (0x00007f21fc308000)
	libmodechk.so.0 => /usr/lib/libmodechk.so.0 (0x00007f21fc303000)
	librt.so.1 => /lib/librt.so.1 (0x00007f21fc2f8000)
	libpthread.so.0 => /lib/libpthread.so.0 (0x00007f21fc2d7000)
	libc.so.6 => /lib/libc.so.6 (0x00007f21fc10a000)
	/lib/ld-linux-x86-64.so.2 (0x00007f21fc355000)

Other hints? Thanks in advance, regards

-- 
Mauro S.

