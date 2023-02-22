Received: from sonic312-45.consmr.mail.ir2.yahoo.com (sonic312-45.consmr.mail.ir2.yahoo.com [77.238.178.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31815392
	for <xenomai@lists.linux.dev>; Wed, 22 Feb 2023 13:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677073488; bh=GWvxnjCkLZVQ3x3JpL5B90zrpiCcOh1oNE8jBVIqZTc=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=XhkswIKnfx9PdrwgF9Fy/rMWnP9JTsXNdf6YZ6brUtsVWp4AJz7bD5QGreuUhSgu2ul+s9jtG1NTxHaEqIrm7Ch8seE//xtu1FFO/qnYxNHPg6MxbJvRDDLWafZM6XllsVBSu5kxsoSzV6JCf5ZiAr+ce9F0nPLvOEujeveWsiq37FPSFK90XxvmhRG0nyv6T7wAYAqdB5Zb+EJwIf15ayLSD6K2nVki5UqiZRHa8WxAIqrLjoaQa5k31/psJU8t06WNnWukOATVJGrNi1k9FWepiUOTv7dIdDjQa8uQ1dFWAQLm/m7IgHOehD+RfcOepbygdO2gb8nKxREiFeeKdw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677073488; bh=D65qLcdqYIjh2Mj2eMo/ZxvEOuJYzn6EYZx7TujMy0V=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=SWwpZ9Oj3YkP8WutydToP//DXZuJzqLJGBM3rzqtRQV7nlbGGvp6yk2SH/I80/mZnu9JBrR3b7C9vCj3Adj1ldAuFi8q6TTnUbpjFNorjz+q9zWgIhQe0jzbia0/uh1J7lP4+EvoRA1ZEcIuXdRPHqltEw88OZ8Zj4S0+LsvBbsUeBOU7ccqhBwcfUz/kujBWXZrdl0M6yglqwsZyOvDzJN4oY6oJ3KdWhiSh5ohymie/WZi9/5A+2wjTTeOn6nnPNBs0QMJULwudlJmqFENa5WRovUPd6GZ5TA16zXqT9ctKf8xRQgi8ZI4fdZ2niaUk0sGgi5lzC4+IUP++MPFKA==
X-YMail-OSG: FzGWvosVM1nQhdQoMvAuE64d4FF4ba.rFNjyt.gMNApHSvGRhV2O3XTEWTEPjEI
 3Btf4kqRvKwgHMiXUg8MkK2dv_ifbwqfM5OnE29LfvRcHW2BnmqP7mZfqZNJ843la.B8p1c8pBbD
 FZa0A0uCwj245OWZn_J98IpDAVl_DhFooHdyqcg9.6lEvE3MMpf6frKVHl_otg7h7eHeBnDinZky
 217Z2IuN3o8Y65ZGrBu5kZJBC1WuXcRXwG1zT.GyzfdTgncHlDlKqBc3a2tRMdyeri80Qhpii.jV
 d9cLyWvNN6gJdh58T0iscDuPLlV66m_Uz4IXRITFkaQTUrlIfQ5MeNj6JWfvU1MCMvK5c55u73WZ
 Miy2C_.apyyrE43BWsHoEmrebA98ereJBSDKKa8bNp3WgbimG_ulqd5D65Tn.O4tlSHY0HQoRQBV
 rb7bh02_wYDgEE1J43KMhBkIqrBkCdGlkQRAD4C0sL_FzA1sPhzFNXU5J0D.yymheqY4bLl1lphp
 38vMfp3SPAu.3vFIqk8T9XzeEUfOvdKZeEgYDZ8076RoD6iE3zr9s9t6aPRXofQBWv7BvV7Vf2wc
 LfJH4AvJaE0pTr_fXUOIsZIK23XjbDDQSMGYUMjOVNg3r0zIaEXuXGQYrWMrD1rdmnKqDSkFBI8M
 o7NkQ1HsHng9LrRBvkuL7T8_5G5KyuaSdhm_pYvVwx_poiBI2li1uW1CBTexehZhz5Qf9HpD6a3l
 t3yoXbG6ZNFGOck6ux3kfWbLdpdRucuM36OjjKeFyhThSSE8KKCcXtf1v35DdXyxc3OmCeJkNePC
 kKOrBGmo3IyMGpAnAWnH0ZybgKbASChJNn9_CibEWYkRPxEMjur.8YfIYH9IAWdukl3wCCeyC4AY
 WLqz.X24gN0qqEqCnDn21mKVAUYItLvu_kLpgPwn3d9wl3D4KBwhCXfSU0ZLR4muWN.73YgWmd.P
 21NrDlMBIBvG0W9eyT3cBs2kTyTduMqMJlHgZI8XXawamNYZxgdHwn_o5LsolknRtfqDZcEuQmMy
 PC0rAz11HRQoEd9GvoGKv.YzROLlXiKKOtWmUD7_76EyJi5gkh31CnNIxqaVGv1.7yEh7ZGaKiSS
 3C3Q6u8bg3Kig.NEkgOnVZqB.25mX_7_bLIPcDI6jkhgWvt.lkOqje3DibVJTKKaCmoupH7SOCgY
 yukyi8Eoc4zZEk56GJff062htNQXkrO_IiLRXSDd4VHzu3C_Q2fOpIjXoyM3K9onwX41RN51BMYe
 3OzEprBn2AvjU1m.rIZCPmoMfJEfdzBoZVGeL1f3dBqrIhI4aeY8Wjd.DNxy.0sbK0..DYOSMo7c
 ekZ.I5XzwdZa49mkK7VkC2.ykJU_bQAxoyXr5e.myEc0LcUCjAOh19e2.N7PqxQEK5VDfP0ZyJx.
 nzebh94zaQGuzsBbMuNYdF2Nl1z5KktbmAtV4OpOuOsUVhrJYfaNqSI8i1s.1G1CPAQE05Jy.yTQ
 zvX8_BVNmZCkHvWmICAN2UJS_LXpGr5P07PWK1w0cSg6DYC7hengHJ7t5FNinM9pnha_3YhUcuAv
 cMEkEzRpbHf0.jhDAAK.6E_FX79kkR_32g_qsekMu1OfuDCbRXmvJuy.CgglHIRSiMyG1vsWCIid
 Jv3wKwZoDwfbhiNJqtEdTSvQ045pnc9oyqnr5YJ6VL0c3WF.1a_nwO6fKG0kLEjkaaORfMI8Pc4b
 9jlCou4HUxM_1F1AWs5nmPH_DK6balPGaYC0PJ9QHNPuXsh6gx1PT8Q1SKJjUpe15oH7w.k3D2Tv
 gvbNuMFVB7ZCITvBUTglNSZ03UXgnt6Tix6m3avm13lAb1vi6NO3nmhsaB3ekW1nhZV7S_2Xfk.g
 wpL_NoEkvHIIFzLP_R1zUAWp26pBnJgEcPsmhvRT6JMofZqdpUBeIWUPnAFGucI7Wjnp_0bgDckN
 p0m.9qtj4Rx.FRTNSK.aZXtTkf.EN03wnEaKPPzgEGBk6438lBuErYYT5DT6CUtmsswo7RkobjE5
 VUfRDkOKw8cA2Mq9c6E2RAxbg5MASz_1Y65B6aMnPK5RJ.ci1Ea5vRja1k3OIVuFFrOUTDQGa9j.
 xwc_0b7v1vKSv7RTYJOkk70JOazUgrNwiMceHl8Uxk51lAiRO0EJkNAw9UMeQ3q3YKciwpT7nw1s
 ZbPq3jXoxspjOgcP9f7bF4VZ7DhBEsIg8dGAb0I_L8AkjUTQOJUyHCtGW5TcPOOG50iqQklYCTHb
 NhRHoph1M1QM-
X-Sonic-MF: <mau.salvi@yahoo.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Wed, 22 Feb 2023 13:44:48 +0000
Received: by hermes--production-ir2-65c64dfd66-ntl7g (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2ee39e0183a097e2e2135ab023289c5b;
          Wed, 22 Feb 2023 13:42:47 +0000 (UTC)
Message-ID: <70e1512e-6697-4752-117b-ba50a3dc31d0@yahoo.com>
Date: Wed, 22 Feb 2023 14:42:44 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] copperplate: sysregd: fix Makefile.am
Content-Language: it-IT
To: Jan Kiszka <jan.kiszka@siemens.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <fe268669-3bf8-627a-05c3-6231e44cead5.ref@yahoo.com>
 <fe268669-3bf8-627a-05c3-6231e44cead5@yahoo.com>
 <f7897511-3723-4962-dfd6-f25466b50f94@siemens.com>
From: "Mauro S." <mau.salvi@yahoo.com>
In-Reply-To: <f7897511-3723-4962-dfd6-f25466b50f94@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21183 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Il 22/02/23 14:29, Jan Kiszka ha scritto:
> On 22.02.23 13:51, Mauro S. wrote:
>>
>> To avoid following Yocto error:
>>
>>    do_package_qa: QA Issue: File /usr/sbin/sysregd in package xenomai
>>    doesn't have GNU_HASH (didn't pass LDFLAGS?) [ldflags]
>>
>> Signed-off-by: Mauro Salvini <mau.salvi@yahoo.com>
>> ---
>>   lib/copperplate/regd/Makefile.am | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/lib/copperplate/regd/Makefile.am
>> b/lib/copperplate/regd/Makefile.am
>> index 3b14e9863..590a47c2f 100644
>> --- a/lib/copperplate/regd/Makefile.am
>> +++ b/lib/copperplate/regd/Makefile.am
>> @@ -1,14 +1,14 @@
>>   sbin_PROGRAMS = sysregd
>>   -CPPFLAGS =             \
>> +sysregd_CPPFLAGS =             \
>>       @XENO_USER_CFLAGS@    \
>>       @XENO_FUSE_CFLAGS@    \
>>       -I$(top_srcdir)/lib    \
>>       -I$(top_srcdir)/include
>>   -LDFLAGS = $(XENO_POSIX_WRAPPERS)
>> +sysregd_LDFLAGS = $(XENO_POSIX_WRAPPERS)
>>   -LDADD =             \
>> +sysregd_LDADD =             \
>>       ../libcopperplate@CORE@.la    \
>>       @XENO_CORE_LDADD@    \
>>       @XENO_USER_LDADD@    \
> 
> This was heavily mangled. Please check your mail client settings or use
> git send-email.
> 
> Besides that, some explanation why making the same settings
> program-only, rather than global, would be good to see in the commit
> message.
> 

Ok sorry, I will resend it with git send-email (I need some time to 
manage it to work with yahoo/oauth2...)

> Jan
> 
-- 
Mauro S.

