Received: from sonic301-21.consmr.mail.ir2.yahoo.com (sonic301-21.consmr.mail.ir2.yahoo.com [77.238.176.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287693064C
	for <xenomai@lists.linux.dev>; Mon, 27 Nov 2023 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="U1entNM5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701093783; bh=r2F7pjMv2bcgCzVZL06Oc+LIPwZxQ6jJsQyNTKjmEhY=; h=References:In-Reply-To:From:Date:Subject:To:Cc:From:Subject:Reply-To; b=U1entNM583+D9I5428PK+WbNzLuroIWggwUD/zm3mq63trlwDtttY5TE97+3ziIG9g/aZSc4gJoKrsIgSIRqN754bsI6B9JPCM9QSujWXZlECZ/1heWeaD0ZKy1jS3+5rnKjSjDg/mdeudvK+GAnb7qKXLzHvrIEDT6lSiMLI6bpnWDsxOSKMKUQhzkYGXLg8/GGZ0Q2JxpiSFN35mSh3LZDu7i4dUrmCD/EZgzbNwIX5vR7SFlHqrIzaUqkhCfGyWLIIfo0IVdp4cmt361XDRyc6XyDvCo/RVfo8luFy9dKSBenAlTOHoDp6TQchvHguxR+pPcWWtt39lKUfmKf1A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701093783; bh=IBcxWEp20px5WgyWeCPPbecnxmeyDyDQkmCFoDI6pzk=; h=X-Sonic-MF:From:Date:Subject:To:From:Subject; b=n8EzRooZR1UCAQbDXKT7FY2NBjxZ7RFj6w2iBFpKldyF2tzLptU9aCOQa12bBl4AJEOPK2fGEubu0UVGehEOVgu4eUGOi0ShYTFpctg9OMqV8WhqNo9lx2qaCxysWsnGKBgG6ihq2we1LOIoqSDxwgQ6psnNKfAAICN/ESfhcObrf/YP9lykf/uLkCKEK5igaIgDgg7nZVvQNhoSJaRhnvirSxTEL+vT+c5up11dzTiT67/gj48UQnQUo2hNDhjo3sy/fv4XfwdFVpzkwblVgjFGiT1cUvs5JLVASemnAzkAQr2oQGWWU3fWwiqDLfylntJV1tPDsreAMvVxQab0Vg==
X-YMail-OSG: .GTfCloVM1md4WNZDyz7RxazO3StLYNwFdOw1MmssyDhwtrUH5ZjKtt2yvdeY.U
 7DKAG5tt3u4SysyfyDyENtrkogKxdC9qXtIuqkhS3qlKmxKvZ9TY.8Agwlkt6Zegx3dA8_ZC0qRU
 __LzDD9WWsYIxlQss93c7Zu.58zWPtz5g.80AhYBXVWDtRKGVtAtak2lacrDbD.AWIi38tcqxe.D
 YmN.2bPAeko3hus0NhrrQpb_0DZv_jBoOn87wUcpf5IZsSEIMD6uwvkpZhvpOyJ0EBOlRJ8JX_xq
 p_QGRvEvGFm3fDXIyju8DoQq4JyerA1IqrWJtAwYIKus5dPJelqYaWgp6FxP0hLICQpWGjPtH4rc
 9DWBpNrHnPXlHr_2EYcGME9vS_o0ES7PUKnIJWHz74V4hh8j5SlNvGAcDl0Anne5NO2.mYQ6Vosv
 L5v35TpqUuE20yHTxBDiBDL0NBzKyzZLGYnS6ObgRhNZ.PiyAjJAwac.uiqn6DJ5kSuBwXCafdsp
 D0WoYG.t6Gy3H8Df7NUqzN9R7FOZxXZ7_slX.W19ia_EuBmnGlIJuRP7H8bfX1PRrkfdPeDwnil7
 MWm7vnVuARfYt4ABZD8_ZtjBkI_3B6_9CR436Jf6hZVumGTVCeo7bTk2kE6OEupNEpesWpWSg1bX
 GcpTOiSBCjHu0aWQzW_r1cUXrP3i8GvugLZmJL4t7jGz2C3fK8J1U24YwWKIweNdHLx58dGEf3Cl
 kvNrdZIjzBdLkkUlIDDtwRVw0dN7BqUuVwjlLR9suGtAyz8UWOTa9ODed7jKoZLP6Fk_9zqIDDpy
 MCSNmNs6Y5XXSGlqamEw.5tXoXClTYC1nILZcxWLXgIh5qnoldCKN1MdslqUaBeMyefTMfxlQgBw
 JnRwm4mVefU.jqtQ_fvenci9YzzJLRMR9zkYNEHZtsxrR1u1NK5xpFD6k_eMH.HqAi87Ywind9bE
 v4RXcMTSd7wN6xV_lfWwPH9e1RjA3fNhz6sAMWIt_jyklS1EppVqQMbMjcFPP5zguqUW3aKp9tLQ
 vigNdGP.Iyq7NRLYZRVS_DA.dXJdfx0DtxpT.rQ5D9oSmFxhx4NpXFSRuz6fBvgI2qh0RXBAwqCW
 nLcfIH.n3YU8A8..hxoGcOfxB8mP3EAlFdFkl9kv3PnmsCy4wvZyMRjnkibKYeDQH5pj2DYJ0b0j
 lS7byzFs1t_roFrzXgt9F9rxQ1Hf5zQIPlc0Gwikro9dyVN34mFUJ8xuTo5pC.d9JA3ciVbWNatu
 U52RdpHB75Y8AbQmfAHsjU6zleSdL2Pi1Ei6SWgUUSvaLM9NxyaRnptUGze9skuhdq.sQ7XDfwXs
 imCBc847haZu6J1pAYJLB4GBJr.59jfcX6HEF3R2a8NFE9nEH1qDC9IWxo22iTwy09rKMmZHWjS5
 4W8oGYcOYT1M3k527J8W4Ha517Pe7GHVpiMAxwmiKEH4CVPI7bceHrJg48db0VaD5DdaDwzssqfr
 8chq0QXHFDo_QUEBbTdtu0aQFCdzzL0HZqDv7Q4Wb2uv3xe6lJage9RLlC2126Fe0c5vrriwNY6W
 vsKbPkXSlq83x1bxwnRKeycszVCFD7d5FalUvz4Mf2GxEH5Fg34AM4tO24XlMD2SJkYlK_IgSsHZ
 WoeRwzGaCZ6SLyxu0yAGhAbz9odRtahs5njgJPRgtjapiAYoQHqbbNTzRhLZzIPhM9YqXO0U_fKf
 fmUI9DqVRuws_4HHv69sj184_Hki.lK0fgt9qzzimDrvN51R7Z8jwU_H97CfBs5xJYENqyQhxGZA
 TvhmMn4gtIpUwoCF6VLqAzcGO.yNo17MGBqvbf0JRaR0B6F7I28wiUhKHPPSJxNnzce7T4NciDND
 YQTYsCAgXwjE3zq13kwjFntuAgMPDHXomTyHR.McnSev7bbNIF_flJSZ0w06AxD4rApTiWgneGzK
 EzVLP2UGpyiCnzRXSSSFoGLiUXBSs9Vep1ZaVcvmcqtUTUdht2M3oOUH0tsJ92NuPoAZLigutHK_
 4T2tVrTXrAuFCXb58tyOdnEIRBlSJRnccLknLl2lbYt4LYk6mLCiC_ym1zdzep.aCXBPO52l7jeG
 qPtf2Mp69F0vltuuZWrMEqRCi2Lf3Ii71yTGsEmGBCFdA02QBTinrmziHvp61HwNPTfgKiwgNmES
 BU5ZQ9y4mJ2dwnHlWli7nIFqqx4AJe97VjqV89w3ETedq3gNEMFcX_B_28EkWfg--
X-Sonic-MF: <mau.salvi@yahoo.com>
X-Sonic-ID: 82310a87-d739-4e8f-a5d3-7dd3f0842026
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Mon, 27 Nov 2023 14:03:03 +0000
Received: by hermes--production-ne1-fbbbb8f75-tr557 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1ac51722fb9c2a2428926781a7631a83;
          Mon, 27 Nov 2023 14:02:58 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6d81580d696so1130717a34.2
        for <xenomai@lists.linux.dev>; Mon, 27 Nov 2023 06:02:58 -0800 (PST)
X-Gm-Message-State: AOJu0Yx28PwGrUj4XP4H5UxhnNmRMwlGKk5RPnAzeKhIAD2TCKxWsnVA
	K7F0J6exX9CPEq5Y8mXXvIacuyfrLVFtPPTIAPw=
X-Google-Smtp-Source: AGHT+IE9Z9r345mxzc1cgKq29pheaHO86jK/gO07xkyTQsQHqZXwexlTU7GtOfdgIcxv+GuMQpD2ctutmXdXJ2+HJsA=
X-Received: by 2002:a05:6870:5490:b0:1fa:2fbc:59ab with SMTP id
 f16-20020a056870549000b001fa2fbc59abmr7730663oan.51.1701093777401; Mon, 27
 Nov 2023 06:02:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <9d5bb262-0646-451e-a5af-82c0473a3003.ref@yahoo.com>
 <9d5bb262-0646-451e-a5af-82c0473a3003@yahoo.com> <035a65bc-c064-40c2-9fcc-b3fd6104a233@siemens.com>
 <4572a391-4c06-4aa9-b92e-66e9da6c23ed@yahoo.com> <44ffbd9c-fc28-40fd-849f-a77fee15866b@siemens.com>
In-Reply-To: <44ffbd9c-fc28-40fd-849f-a77fee15866b@siemens.com>
From: Mauro Salvini <mau.salvi@yahoo.com>
Date: Mon, 27 Nov 2023 15:02:46 +0100
X-Gmail-Original-Message-ID: <CADBp9x=310edtayP3nEeDSc2D318E=qA1a=5ceG0krd3r2VN8w@mail.gmail.com>
Message-ID: <CADBp9x=310edtayP3nEeDSc2D318E=qA1a=5ceG0krd3r2VN8w@mail.gmail.com>
Subject: Re: Process stuck in cobalt_monitor_enter
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Il giorno mar 21 nov 2023 alle ore 01:06 Jan Kiszka
<jan.kiszka@siemens.com> ha scritto:
>
> On 20.11.23 22:23, Mauro S. wrote:
> > On 13/11/23 18:54, Jan Kiszka wrote:
> >> On 11.11.23 16:03, Mauro S. wrote:
> >>> Hi all,
> >>>
> >>> I'm using Xenomai 3.2.3 on an Atom x84_64 with a 5.4.255 ipipe kernel.
> >>>
> >>> The application I'm running (a complex application, with about 60-70 RT
> >>> threads) has a simple loop in the main function, something like that:
> >>>
> >>> while (stay_in) {
> >>>      ret = rt_buffer_read(...);  // with 50ms timeout
> >>>      if(ret) do_something
> >>> }
> >>>
> >>> The main loop reads the buffer to receive some commands from outside,
> >>> and when the application gets a SIGINT, the custom signal handler simply
> >>> does "stay_in = false" breaking the main loop, and then the program
> >>> closes.
> >>> During normal running, I can see the timer associated to the
> >>> rt_buffer_read() timeout get fired and reprogrammed, calling multiple
> >>> times "cat /proc/xenomai/timer/coreclk" e.g.:
> >>>
> >>> 0    291/290         2ms970us           -           myapp
> >>> ...
> >>> 0    609/608         34ms860us           -           myapp
> >>>
> >>> I also see the thread in "w" state (waiting for a resource with timeout)
> >>> doing "cat cat /proc/xenomai/sched/threads":
> >>>
> >>>    0  16328  rt     cobalt     50   21ms279us         w          myapp
> >>>
> >>> Sometimes, in a non reproducible way (at least for the moment), when the
> >>> process get the SIGINT it never exits, remaining in this status:
> >>>
> >>> /proc/xenomai/sched/threads:
> >>>    0  16328  rt     cobalt     50   -             W          flxcore
> >>>
> >>> The state becomed "W" (waiting for a resource without timeout) and in
> >>> fact the remaining timeout is not present in the row, also in
> >>> /proc/xenomai/timer/coreclk:
> >>>
> >>> 0    291609/291362         -           -           myapp
> >>>
> >>> (BTW, seems that some timeouts got lost, because scheds are many that
> >>> shots, and this happens also on other timers in coreclk)
> >>>
> >>> This is the backtrace in gdb:
> >>>
> >>> #0  0x00007f5b15bb05f7 in cobalt_monitor_enter () from
> >>> /usr/lib/libcobalt.so.2
> >>
> >> This relates to lib/cobalt/internal.c, cobalt_monitor_wait():
> >>
> >>          /*
> >>           * If we got interrupted while trying to re-enter the monitor,
> >>           * we need to redo. In the meantime, any pending linux signal
> >>           * has been processed.
> >>           */
> >>          if (ret == -EINTR)
> >>                  ret = cobalt_monitor_enter(mon);
> >>
> >> But the problem is that the lock (monitor) is no free. Someone else
> >> holds it, and your interrupted reader does not proceed.
> >>
> >> If you dive into mon at this point via gdb, you may find the owner
> >> (according to libcobalt's view) when you resolve manually what
> >> get_monitor_state() does.
> >>
> >> Jan
> >>
> >
> > Thank you Jan.
> >
> > I rebuilt the Xenomai libraries with debugging symbols enabled.
> > But when I try to print the mon variable, I get
> >
> > (gdb) print mon
> > $1 = (cobalt_monitor_t *) 0x7f3cb524e62c
> > (gdb) print *mon
> > Cannot access memory at address 0x7f3cb524e62c
> >
> > Seems that the memory address is not in the core dump, but I'm wondering
> > why
>
> Did you create a core dump or tried to attach live the hung process?
> Maybe the former was incomplete - for whatever reason.
>
> Jan

Sorry for the delay, but every time I modify something I need to wait
for the issue to arise.

I'm working on core dumps. The previous core was incomplete, as you said.
I needed to set the coredump_filter kernel cmdline argument to 0x7f to
have the complete coredump.

Now, I can see also the values into the Xenomai lib memory space:

(gdb) print *mon
$8 = {state_offset = 1047984, flags = 1, handle = 44}
(gdb) print *(struct cobalt_monitor_state *)(cobalt_umm_shared +
mon->state_offset)
$9 = {owner = {v = -2147483638}, flags = 0}
(gdb) print cobalt_current
$10 = 10

Could you please tell me how I can figure out who my owner is starting
from these values?
I tried to find the owner ID with "thread apply all -q print
cobalt_current", but nobody has that owner value.

Thanks in advance, regards

-- 
Mauro
