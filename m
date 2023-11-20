Received: from sonic313-21.consmr.mail.ir2.yahoo.com (sonic313-21.consmr.mail.ir2.yahoo.com [77.238.179.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6095F358A9
	for <xenomai@lists.linux.dev>; Mon, 20 Nov 2023 21:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="MQpB+HTI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1700515401; bh=UZqP1LJ6XSd1RDDhfMjFh380H+9EQw/PH58G7EIicLs=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=MQpB+HTIZlt1dtnmoMvPvC1X7M0cDWNIylWK1AkFsTMjSHeTCBePJlMAfvXktOUt21DU1yQPcNNX86Vnxj5UVMwDtWeBqRLqq9emLDay5B968VOmaSpB6gT/c8lFF6WJpfQXa5pcRSlvw4qchQkwOFBOHDaMjaIEB6p0WzBXx9qXsfpNCneR95caOI8tsET7adGOlmPYdaHW6aCcWEP/6VkDWG2QcHlW4upkjswjiqZn1zl+5VoWGgYwgYS5DwE0BcgohuGC+GvoSLT5461fka0M3leyuVTGn3EHuFaVaVC3WudRUrmadXZ1lL1V7EJYBDgSHBZNl+r1IgE6fKlgjw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1700515401; bh=jcvknzJHIvmLTFDlocQiEoaqgGU/p5vhqXLXEPevGks=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=joYsqS7Z4ljR7iwz9sFe+gqL0JN/SscDhwMthCOwuVhikoyleTyMAFTWeudUaXZlqHmIVjaTuZZql3a7tQVOoN9BJ6Uv4sIGucVeZmPvvh7N+fLlcryg47bUqjNFigBTMRWhML/T0ARySTH4qvAibqyt4wKl98DKRNFnc/Y9QUaMykMkMynH68SDYJ2tK6cjTvm6piirv9B1dzKaT9kB3b5CjNbz3usYkmpGa1qW2DoQUA35FGIBpr60xXWGrAYoRN1m/4GhZAJY3EQz0N0K55L07/F3u8nQOOGtQv3arV8soTeeLPDqJceonPeS6UF5a1VHUvsy+cjS2JTbrak9xw==
X-YMail-OSG: uxVdSbsVM1m0UQEMyWN8Kqvrt7lwhk9pEk74f9ttikQetUJKUAH0U3DAI3RanRb
 8jByoKzBSkkq1N2FJ3IxTucRsvr70tC8rzj9opVsJ97mb3.d8rhfojbYbcwiWEJDmXPeMf6MHLhD
 hb2lV85NFTq5N3.8.cGYXdROP9rmlRxL4y1lpuD_s.OKTphKJKP1zXJFg4Y2ah6.q_o7MCVUEm1_
 5XKexkf1gC8.A85eMujW_daUlfV3ds6aXNnCU954GPJ85gAl9kitRi9Rwav9dj8Bk_zlrI62IdBt
 KvtOs0iyL4eLxUYEd46tRLLfhHX36PzJ.IMUKkpGAWIWOJhRAfI1clHXnPA3Sg1LDPHf_h999EE2
 8vO21AOzam9oJY7UTenyLCZCnxkU6PcKrDMVMe5FSS_Oq5yMeHgGOdTfBrOZ7xK9RkEkz8FMLeHT
 zZnopz63om2PiYDinUVmTjnd_cI_wyF3gsYEIRAKFMmLSwFUvdDwYd6CAJdr5vBKBjpFd.jfPUAs
 PRtnm57VvGx5CM0QC58tFIUoP7X3Sf_j4Ez1EOiDgp9MN5nfLR9jeyWf2j5t1E8fARjZYd69hFCN
 tTTtQIOJGvYnSTXYuYywMLXNQSRLiBSMlMa1fKq4NX2iqr88C8fOEQLuDHR31SKjMnDlXavQDHBU
 .Ujd9pQlbihMRGQlZjjADstNJ_I7pGWZhjcoXRF579HpLLyHXNOPZwwZ3ESz__45cxP7QI99TuKf
 bIHHp7FiRuHqDVzTmQMD2uprxiVR1Vxh7o.xZpON6D2OSsiWyqVRESi2to86_WuJVVuae7.vaoN0
 C9Qzs1qzV3tuC8KFSDTj_RfC56m7tSvESZ2QYR7BdLhB3jBqZEV8YNu7Gv9tKOoP.Xe89BFuFS1u
 IlIab5Me5aEPIXkphiAHJdtDXjagfFT0O0so3sUxKpVq21ioX6JyZb8fUoC3.KbrWwbXgWJpedp8
 PkFKHYX_rFNXiAji9zXFb_eOpTyJSHdHONOWVFP_qXL_yJieMb4lk6WKTT4ek6hFIx6sv28kA64g
 qzLxCttnEbZEOqBI33NfVDA30H7wRJLhO4JH3OKm_9_2EYo24Z0T_zYc9r7qbBLjfOMQx_ljRMD1
 E9XHMWlGj.1_A8sPp37ZTUzOG81UBJTRjPaxwvOeSimfN_Ew2qMivaqFYYOMnD1KoCTRXOrqRx9O
 FoSuyY1jXcd9TLtPU.7EnPEOXQ3WIhWOj4IXZ.Dhgt3scINv1SwNnuSgSlGzS0uu.x_mbvbIrW7V
 .zVAx85yetMzDzGNsylJ1Cd_WjTsiA8lDuKRUkA_ggvLsRTJwvQYE.GCHNeB_g895ex0QEV21Xrf
 kgeskSgN2zpL0nz1w4K1EitYOU7jdWlvSKp626hcjDK_0ApAHMs00bkuDCHpfVdWjqMgXZ1NEEUf
 m5TiWU_hfaCP1vF.bGzHVDwoippWyvZg.d1EpAMKnf2dBXkojhwyl70DQHSIcVkYf_.Q85B7LIow
 QK.XANjAqCm1LYg6LL1G9YWfSgyt9G6I2GMK25Z7bvdaclXhIrHNu8ohFO8JjceOmGehjPOw0ezf
 R9NZh1ZCF1T7iRgoPCG_snvDNltGm1zpvC40Ti6Eh6ULfGnNOAl7xvpDR.zoq9KhSf0uStdBRQkv
 W.SnBQtBGWyNpqK9NB.HoCkLC20Wl73rL.hnwL1ib.7umL_.RhnUHmMWXHW1WgYYoEOR1B0zPdXq
 qD2UShN.7Nvf5qZ51U7KOyhb2CZshgebhuRJojSoJgH3Gtg5mUHlgkI93de0u9nC.MsDKDoLiUjF
 2OIoTLBtIwdUMSbP4BvSvq1vwiKKeB_6pqclufoTYDPbT3iNr.yxNB7xoTqdLOS71H7Ii0u7l9Op
 1am6hPSRukmRZdF8nFGlGRS444qmWU89D4k8jdIFjJCXroIEFqYObBPN6pYcsJq44_vN_Af5e_Yl
 778dPW1HQTwYIgS798XUUOHM7P9dH4CBhVMzu8.Kf5EJ2F5ACK0X35FRfQhsoSVnQDZpJIrHjDVp
 0rZmkE9xShDduvEdeax_kBs0yq8VqWFN8V_fUSVxAI63jCRTaPzJdFDDNKIZBlNA2hGmgzHpdCKE
 PBOwL5awvHQabs9PgZtBj9KhmorkrArmNgh0zzmGkMfTNilijFDgIZSCyuIPY9TnStU_V.PY3nKf
 CI35S1znxOTmrm7ky5gzNsly5vm4WiZ_M4U9me3EJIYtcDeMJ65E3vElkunfnivDjkposEtSGfdR
 gKQeO
X-Sonic-MF: <mau.salvi@yahoo.com>
X-Sonic-ID: 9b931957-d045-4da4-be8e-1859556ba63c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ir2.yahoo.com with HTTP; Mon, 20 Nov 2023 21:23:21 +0000
Received: by hermes--production-ir2-6755f9ff7c-ltc4c (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e2d92247e0bd6d3479af5337790747aa;
          Mon, 20 Nov 2023 21:23:16 +0000 (UTC)
Message-ID: <4572a391-4c06-4aa9-b92e-66e9da6c23ed@yahoo.com>
Date: Mon, 20 Nov 2023 22:23:15 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Process stuck in cobalt_monitor_enter
To: Jan Kiszka <jan.kiszka@siemens.com>
References: <9d5bb262-0646-451e-a5af-82c0473a3003.ref@yahoo.com>
 <9d5bb262-0646-451e-a5af-82c0473a3003@yahoo.com>
 <035a65bc-c064-40c2-9fcc-b3fd6104a233@siemens.com>
Content-Language: en-US, it
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
From: "Mauro S." <mau.salvi@yahoo.com>
In-Reply-To: <035a65bc-c064-40c2-9fcc-b3fd6104a233@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 13/11/23 18:54, Jan Kiszka wrote:
> On 11.11.23 16:03, Mauro S. wrote:
>> Hi all,
>>
>> I'm using Xenomai 3.2.3 on an Atom x84_64 with a 5.4.255 ipipe kernel.
>>
>> The application I'm running (a complex application, with about 60-70 RT
>> threads) has a simple loop in the main function, something like that:
>>
>> while (stay_in) {
>>      ret = rt_buffer_read(...);  // with 50ms timeout
>>      if(ret) do_something
>> }
>>
>> The main loop reads the buffer to receive some commands from outside,
>> and when the application gets a SIGINT, the custom signal handler simply
>> does "stay_in = false" breaking the main loop, and then the program closes.
>> During normal running, I can see the timer associated to the
>> rt_buffer_read() timeout get fired and reprogrammed, calling multiple
>> times "cat /proc/xenomai/timer/coreclk" e.g.:
>>
>> 0    291/290         2ms970us           -           myapp
>> ...
>> 0    609/608         34ms860us           -           myapp
>>
>> I also see the thread in "w" state (waiting for a resource with timeout)
>> doing "cat cat /proc/xenomai/sched/threads":
>>
>>    0  16328  rt     cobalt     50   21ms279us         w          myapp
>>
>> Sometimes, in a non reproducible way (at least for the moment), when the
>> process get the SIGINT it never exits, remaining in this status:
>>
>> /proc/xenomai/sched/threads:
>>    0  16328  rt     cobalt     50   -             W          flxcore
>>
>> The state becomed "W" (waiting for a resource without timeout) and in
>> fact the remaining timeout is not present in the row, also in
>> /proc/xenomai/timer/coreclk:
>>
>> 0    291609/291362         -           -           myapp
>>
>> (BTW, seems that some timeouts got lost, because scheds are many that
>> shots, and this happens also on other timers in coreclk)
>>
>> This is the backtrace in gdb:
>>
>> #0  0x00007f5b15bb05f7 in cobalt_monitor_enter () from
>> /usr/lib/libcobalt.so.2
> 
> This relates to lib/cobalt/internal.c, cobalt_monitor_wait():
> 
>          /*
>           * If we got interrupted while trying to re-enter the monitor,
>           * we need to redo. In the meantime, any pending linux signal
>           * has been processed.
>           */
>          if (ret == -EINTR)
>                  ret = cobalt_monitor_enter(mon);
> 
> But the problem is that the lock (monitor) is no free. Someone else
> holds it, and your interrupted reader does not proceed.
> 
> If you dive into mon at this point via gdb, you may find the owner
> (according to libcobalt's view) when you resolve manually what
> get_monitor_state() does.
> 
> Jan
> 

Thank you Jan.

I rebuilt the Xenomai libraries with debugging symbols enabled.
But when I try to print the mon variable, I get

(gdb) print mon
$1 = (cobalt_monitor_t *) 0x7f3cb524e62c
(gdb) print *mon
Cannot access memory at address 0x7f3cb524e62c

Seems that the memory address is not in the core dump, but I'm wondering why

TIA, regards

>> #1  0x00007f5b15bb0748 in cobalt_monitor_wait () from
>> /usr/lib/libcobalt.so.2
>> #2  0x00007f5b15bd7497 in syncobj_wait_grant () from
>> /usr/lib/libcopperplate.so.0
>> #3  0x00007f5b15bea691 in rt_buffer_read_timed () from
>> /usr/lib/libalchemy.so.0
>> #4  0x000055d2d6e7e689 in rt_buffer_read (timeout=50000000, size=19216,
>> ptr=0x55d2d6e82180 <Request>,
>>      bf=0x55d2d6e82168 <Flxcore_ReqBuf>)
>>      at /usr/include/xenomai/alchemy/buffer.h:129
>> #5  main (argc=<optimized out>, argv=<optimized out>) at myapp.c:421
>>
>> Do you have any hints about that?
>>
>> Thanks in advance, best regards
> 
-- 
Mauro S.

