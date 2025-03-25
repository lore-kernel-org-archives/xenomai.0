Received: from sonic309-21.consmr.mail.ne1.yahoo.com (sonic309-21.consmr.mail.ne1.yahoo.com [66.163.184.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B009626657E
	for <xenomai@lists.linux.dev>; Tue, 25 Mar 2025 20:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933414; cv=none; b=JRVLnoqGvZfEwi4flSA3VgFwbgkVaFNWhRwAnol7tBWUQMPDgVZnlUwn+ax9eI2jmfwePqyEz1aj/9+ABlYnpdLjenjhr7DLWYKURogFF4SxpdrDj5k3u1WcUVVRrZ3bViSNWwD6rWW/IY0tCG325L0SQDYcdd+DR6S+dl0HhZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933414; c=relaxed/simple;
	bh=6ACYlUK3t2LZvohXF6HUi4VFef010RU4QtOiEvy8idM=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type:
	 References; b=ZGFVWYo2Vn5wpaIVGNEsz4PPIX3A/vAg8CQE1SPMJTCrPDwn8iYNHv4Kk7uIE2wdNIwmXszbYBvxY4JP/yiqM0iJD91MGOFEhn30colrntgt1kZo0ux41h9Xv8QloI33Y/H+taux+hYXG3XdCAyN73eJTbklg2zIchJw6trC7gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=mFqIbuLi; arc=none smtp.client-ip=66.163.184.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mFqIbuLi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1742933410; bh=6ACYlUK3t2LZvohXF6HUi4VFef010RU4QtOiEvy8idM=; h=Date:From:To:Subject:References:From:Subject:Reply-To; b=mFqIbuLiZ7yyPOhAvxcDiGZwBh3zzZhHDIKMvqD8bLOLlj2kkpg9fFRbslHniPGGyEY31rk0zKN4pjDvqrp+PTsYFLdPATehnQ8ndlP6YVvEmyjNXyM+f6WtVUky4it8oDyCu55ZF5u35/jHhrDlL9fbGsJXtv225CMVE7+pjUXNOEshnVBjW4uMBAQcfWmXodL8WG6/tfT8lv3+AuCFy923/gvMXiiL6Dvww/Wes3eu/R25cGbSvoDZveRtI1z6pgnJLZqDtWQhdtyKKn+K5oyNukqSU9gJRnG9EwmEGrxhCP+YbW9sgrwldtXXwaSKeLUfjxD0lXupv7+Tl0bBrw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1742933410; bh=YtQ/+NCfYNyWDIiaAMQdg9n6fBRsQWD28vN+JC2mn8W=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=XA5KeedWkJzHGBY4nVRaWXa0MEVWTNqcH/anZnwWvRCjwbDFeu3GtfzGGlbnAXCntNqfdQGT8+P1jHCeBt7nYqvnWKdSbU0URjTrHh17Diw5Pd4yGXXe/tNXm9DNfzxgiPUy+oLt+qZ8jFmkso3o8/3ppqEGVbBU4cRnXYLpCDTfhP0EJElhACRGBId/BjzrnlQ0mPfwnjkIUBFwKBHDmyUPjKh9f5QhcPtJ8kWI5C3Wjwzpjdk3Dadx/eUFIo3ui5LGlaJ8Se9AqaAKYOjrmnyg9fQARYCrobl5zHJG4LajzKFfMw3RAe5xkLzQtyWDofzouYVYtdNsaOr4eHWOlA==
X-YMail-OSG: NZWwnxIVM1lX7tfUGKjdk9PkGZq20mboYrO_Ywj7lLHAIAzn7zckEj00wn80xkL
 ZtQbTSiax14ZsQXjyPRTgMzH5WtNdWEYS.yCLcyS7FT5ZsaCAAjTRTQRf.EVeRWKQmGUyV.pZT8I
 UYR86RSlFAZHX8GkkkjgP7xljoRGlnP1raN3OpSuo.S7b_QvNofUZO6ZqsUHYZc899sQ0LeB5DcJ
 XyWdmY6jExYAwi9hxFeyb7klucYaUQXiiw7aAUlMe3iEXSSaB2xOiLPR6Y_frU1_4xB79JcjXcE1
 Ad0IbIOf.bEpzLQWRq3KF7IY8K.GOzk7dJJdsHoT3aJuCTcKwH98VEilPVYjqHmxReZRdN6jcNoK
 mIlmH4OIjj1t7ycA33XGaTEXWW9jb6XmcKxPuWPq42LCPsyR_67RNGvmivAB0JGoMjaefh3qE8M9
 y_jZ3fLjXYAgiSSwWOyN75V.9KNhdBP8fCpeA5MWk.RLlTuChw9LvXNkd_MXRmKM_2XCtAW1vc5m
 44nhdhMtdqK87zTOVf4Z30zN2kSzwyP8voGPgscznZd7AdPQ31mazvh6se0JgxCwLiEwdXA_lI7M
 qWA8ZSDfceEAAWwS_pFNLv1nqBzszuHGRo.AkvF7MeSgGzvotiG3vNh0gbAZ0i0pj0xN11MwSo9U
 e3FLLT3NqiawzTEIv27MCZAYIA0unO3.DgkhY5gCphULBGRKqrsi8_tjtbhmPzRPcyPim8ktVj8o
 dYnKrJS2fWRw72G1FgmiPz3pHIZuyMW145RHVFyJV7b4Rpc86WwPBeMyqIakQxpIZDMEjxesRdyM
 D_2ePFxQrv2wfNYBzPgRGf.gtGDReC8sW8yWEgtrz64NeTPdsNHHr8FdSLjxs5N83IVkwtnpyn3N
 rEv2_g0tabOXkGjRxk0Tzzoayr7fdDMnIvRwQf2_Sw9efDvd_GTNIthXaNyNAdkf9BkXEC_RFxDb
 us7vWvplftwSKLJA_Wa3w3azJdzvgz6ui7RpnlfdqLVcwdlmoMo.jMuDjwMwgYl9kvCe06ZFz0BO
 ROLFUTPbOKNZ750u4q3CxAVTvfn8jTT2eoQZUQ8d3mbDWQGsa2yZO0NfsvM569MMlll0bV3p4ksi
 NDxD3mUsve8hjc4vjNl.eYaHHO3s3Tf6gSpp0J1KNqAD3olKmu6lCCxBKdz1h_J72y1T4AEgz8F4
 JX48Blt8rjxQPlB5pe.ttACg3PERI9XBfgebD5eFS.EOGJUTpvWuWjB7HJcrxuxXVT_K4lb_DS3.
 iGqz.yaEoHuCVWU5tLAOqXy.9nWBAkBS3mksCTGP42MhD4lzgFUbn1Sks2d5OICj3ganoQOJ7fFE
 gsRc3_zrpUv3m_QoOaZhNAQ5.rlU_oIbJqzt2xb9Tf0RI0n7aLKReTVnQIrWmT8fo3rI4q2uYnqE
 sPSbLpK5Nyu0_IhS5RAKC1bhmLYU_WFA.mq2ydvjK9PZxnDjtnueGpg1ss3twLdpI7hjGl2OeIRg
 r6xERyDKhi1t7NakMluqYJxAPVEAS9_cnaoKCdaDcpL1_h8Gn7lLouVyY5OcpAVagSGOppzLpUFj
 JyXyaIzhuboIdruVmxsnzbqY7j_iplA7rtPHSn391tN6AtTmPeSMQZKy.GFbRWu8EUUWU0KZCbfc
 j06OREn3Z.rGYTGKg6WZF_557d8_w9nW0ubQFYZT4rtO0.zrhHBZCk7mvHiQgBZaIAXBBdHUSx2w
 0owbnU0GAHqyVItCiyVkdpLR_wOK1a.5.pYwZn2tKhphzyeNGvO6ppAA4tY43f5TylmW3nKBEFft
 wSoKlGOgpvwfjyZGnpVds9uc2a3IjbpxEbW06CHGFcPVjIBmLM5Kmtem.ycV55pQ4iZuOnoZJvwD
 9JG9EfVdLNzFHPYypFHYaUVeNDZvH4CDzhiqdVDhnYHpXGvG.sfgpX93YuJdJvGVxjo.JuptF.mS
 RgxXIk2cjzAWCyc5uTeNztgrYtfGHlrVFushNvBnnxn9HB6WJAqRH7wk8FH2lfK7SoUuTFxPRP.T
 zAbSgBWTgH_Lrth5dykOWHZeWz5uRrx0pQpQ_pT5ucvN8qXFEuWgdxm6J9laZrIKDt.62xP72TwI
 R7D3XcEaesiodA60uhFL83rAko5fYhzd5UCC.5NMkyegzrsKq.tYylGoiw32hzw0raFYLFSJMr2w
 Cl7IOXbqCc0GQZ4hU2Tam2V4fzvY5_S8_8lkVKokbSjMeMiwQbBpgEyFmnCAIxGVAfX0oHampP5i
 0mH5PcS_rXOXj
X-Sonic-MF: <ionut_n2001@yahoo.com>
X-Sonic-ID: 1bd1ea04-93af-4e14-817e-c21c02a1393c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 25 Mar 2025 20:10:10 +0000
Date: Tue, 25 Mar 2025 20:00:03 +0000 (UTC)
From: Ionut Nechita <ionut_n2001@yahoo.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Message-ID: <1086761396.1811188.1742932803430@mail.yahoo.com>
Subject: [linux-evl 6.14] - RIP: 0010:irq_set_chip+0x92/0xb0 -
 amd_gpio_probe
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1086761396.1811188.1742932803430.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.23533 YMailNorrin

Hello Xenomai Team,


I notice today this:




[ =C2=A0=C2=A0=C2=A00.556966]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] ----=
--------[ cut here ]------------
[ =C2=A0=C2=A0=C2=A00.556968]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] irqc=
hip amd_gpio is not pipeline-safe!
[ =C2=A0=C2=A0=C2=A00.556971]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=
=A0WARNING:=C2=A0CPU: 0 PID: 1 at kernel/irq/chip.c:52 irq_set_chip+0x92/0x=
b0
[ =C2=A0=C2=A0=C2=A00.556976]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] Modu=
les linked in:
[ =C2=A0=C2=A0=C2=A00.556979]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=
=A0CPU:=C2=A00 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc7 #3 PREE=
MPT(full)
[ =C2=A0=C2=A0=C2=A00.556981]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=
=A0Hardware name:=C2=A0ASUSTeK COMPUTER INC. ROG Zephyrus G14 GA401QM_GA401=
QM/GA401QM, BIOS GA401QM.415 08/11/2023
[ =C2=A0=C2=A0=C2=A00.556982]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=
=A0IRQ stage:=C2=A0Linux
[ =C2=A0=C2=A0=C2=A00.556984]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=
=A0RIP:=C2=A00010:irq_set_chip+0x92/0xb0
[ =C2=A0=C2=A0=C2=A00.556986]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=
=A0Code:=C2=A018 5b e9 8c 74 d3 ff 80 3d ee 43 ef 01 00 75 cc 48 8b 33 48 c=
7 c7 18 46 45 a5 48 89 04 24 c6 05 d7 43 ef 01 01 e8 be 0a f5 ff <0f> 0b 48=
 8b 04 24 eb aa 48 c7 40 40 40 10 d5 a5 eb a0 b8 ea ff ff
[ =C2=A0=C2=A0=C2=A00.556987]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=
=A0RSP:=C2=A00018:ffff9fed80087990 EFLAGS: 00010082
[ =C2=A0=C2=A0=C2=A00.556989]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=
=A0RAX:=C2=A00000000000000000 RBX: ffffffffa4f42e40 RCX: 0000000000000027
[ =C2=A0=C2=A0=C2=A00.556990]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=
=A0RDX:=C2=A0ffff944d8da22c08 RSI: 0000000000000001 RDI: ffff944d8da22c00
[ =C2=A0=C2=A0=C2=A00.556991]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=
=A0RBP:=C2=A0ffffffffa3fcd190 R08: 0000000000000831 R09: 00000000ffffffff
[ =C2=A0=C2=A0=C2=A00.556992]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=
=A0R10:=C2=A00000000000000000 R11: 0000000000000004 R12: 0000000000000000
[ =C2=A0=C2=A0=C2=A00.556993]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=
=A0R13:=C2=A00000000000000000 R14: ffff9446c1c3dc00 R15: ffff9fed80087ae0
[ =C2=A0=C2=A0=C2=A00.556994]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=
=A0FS:=C2=A0=C2=A00000000000000000(0000) GS:ffff944d8da00000(0000) knlGS:00=
00000000000000
[ =C2=A0=C2=A0=C2=A00.556995]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=
=A0CS:=C2=A0=C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ =C2=A0=C2=A0=C2=A00.556995]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=
=A0CR2:=C2=A0ffff944c28e01000 CR3: 0000000667c36000 CR4: 0000000000f50ef0
[ =C2=A0=C2=A0=C2=A00.556996]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=
=A0PKRU:=C2=A055555554
[ =C2=A0=C2=A0=C2=A00.556997]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] Call=
 Trace:
[ =C2=A0=C2=A0=C2=A00.556999]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0<TASK>
[ =C2=A0=C2=A0=C2=A00.557000]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0? irq_set_chip+0x92/0xb0
[ =C2=A0=C2=A0=C2=A00.557002]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0? __warn.cold+0x93/0xee
[ =C2=A0=C2=A0=C2=A00.557003]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0? irq_set_chip+0x92/0xb0
[ =C2=A0=C2=A0=C2=A00.557006]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0? report_bug+0xff/0x140
[ =C2=A0=C2=A0=C2=A00.557009]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0? handle_bug+0x65/0xd0
[ =C2=A0=C2=A0=C2=A00.557011]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0? exc_invalid_op+0xb2/0xd0
[ =C2=A0=C2=A0=C2=A00.557013]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0? asm_exc_invalid_op+0x1a/0x20
[ =C2=A0=C2=A0=C2=A00.557016]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0? __pfx_handle_simple_irq+0x10/0x10
[ =C2=A0=C2=A0=C2=A00.557020]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0? irq_set_chip+0x92/0xb0
[ =C2=A0=C2=A0=C2=A00.557022]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0irq_set_chip_and_handler_name+0x2c/0x90
[ =C2=A0=C2=A0=C2=A00.557024]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0? srso_alias_return_thunk+0x5/0xfbef5
[ =C2=A0=C2=A0=C2=A00.557027]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0gpiochip_irq_map+0x55/0xf0
[ =C2=A0=C2=A0=C2=A00.557030]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0irq_domain_associate_locked+0x66/0x150
[ =C2=A0=C2=A0=C2=A00.557033]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0irq_create_mapping_affinity_locked+0x41/0xe0
[ =C2=A0=C2=A0=C2=A00.557035]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0irq_create_mapping_affinity+0x9a/0xf0
[ =C2=A0=C2=A0=C2=A00.557037]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0? gpiod_get_direction+0xca/0x120
[ =C2=A0=C2=A0=C2=A00.557039]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0gpiod_to_irq+0x6b/0xd0
[ =C2=A0=C2=A0=C2=A00.557042]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0acpi_gpiochip_alloc_event+0x15d/0x2b0
[ =C2=A0=C2=A0=C2=A00.557044]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0? __pfx_acpi_gpio_irq_handler_evt+0x10/0x10
[ =C2=A0=C2=A0=C2=A00.557047]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0? __pfx_acpi_gpiochip_alloc_event+0x10/0x10
[ =C2=A0=C2=A0=C2=A00.557049]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0acpi_walk_resource_buffer+0x7f/0x160
[ =C2=A0=C2=A0=C2=A00.557051]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0? acpi_rs_get_method_data+0x93/0xe0
[ =C2=A0=C2=A0=C2=A00.557052]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0? __pfx_acpi_gpiochip_alloc_event+0x10/0x10
[ =C2=A0=C2=A0=C2=A00.557054]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0acpi_walk_resources+0xbe/0x160
[ =C2=A0=C2=A0=C2=A00.557056]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0acpi_gpiochip_request_interrupts+0xa5/0x140
[ =C2=A0=C2=A0=C2=A00.557058]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0gpiochip_add_data_with_key+0xd36/0xeb0
[ =C2=A0=C2=A0=C2=A00.557061]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0? srso_alias_return_thunk+0x5/0xfbef5
[ =C2=A0=C2=A0=C2=A00.557062]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0? debugfs_create_file_full+0x1a/0x20
[ =C2=A0=C2=A0=C2=A00.557064]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0? srso_alias_return_thunk+0x5/0xfbef5
[ =C2=A0=C2=A0=C2=A00.557066]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0? pinctrl_enable+0x1dd/0x2c0
[ =C2=A0=C2=A0=C2=A00.557068]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0? srso_alias_return_thunk+0x5/0xfbef5
[ =C2=A0=C2=A0=C2=A00.557069]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0? _raw_spin_lock_irqsave+0x13/0x60
[ =C2=A0=C2=A0=C2=A00.557071]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0? srso_alias_return_thunk+0x5/0xfbef5
[ =C2=A0=C2=A0=C2=A00.557073]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0? devres_add+0x33/0x50
[ =C2=A0=C2=A0=C2=A00.557076]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0amd_gpio_probe+0x287/0x3d0
[ =C2=A0=C2=A0=C2=A00.557079]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0platform_probe+0x44/0xa0
[ =C2=A0=C2=A0=C2=A00.557081]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0really_probe+0xde/0x340
[ =C2=A0=C2=A0=C2=A00.557083]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0? pm_runtime_barrier+0x54/0x90
[ =C2=A0=C2=A0=C2=A00.557085]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0? __pfx___driver_attach+0x10/0x10
[ =C2=A0=C2=A0=C2=A00.557087]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0__driver_probe_device+0x78/0x110
[ =C2=A0=C2=A0=C2=A00.557089]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0driver_probe_device+0x1f/0xa0
[ =C2=A0=C2=A0=C2=A00.557091]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0__driver_attach+0xba/0x1c0
[ =C2=A0=C2=A0=C2=A00.557094]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0bus_for_each_dev+0x7e/0xd0
[ =C2=A0=C2=A0=C2=A00.557096]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0bus_add_driver+0x142/0x220
[ =C2=A0=C2=A0=C2=A00.557098]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0driver_register+0x72/0xd0
[ =C2=A0=C2=A0=C2=A00.557100]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0? __pfx_amd_gpio_driver_init+0x10/0x10
[ =C2=A0=C2=A0=C2=A00.557103]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0do_one_initcall+0x46/0x2f0
[ =C2=A0=C2=A0=C2=A00.557107]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0kernel_init_freeable+0x22e/0x290
[ =C2=A0=C2=A0=C2=A00.557113]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0? __pfx_kernel_init+0x10/0x10
[ =C2=A0=C2=A0=C2=A00.557116]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0kernel_init+0x1a/0x140
[ =C2=A0=C2=A0=C2=A00.557118]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0ret_from_fork+0x34/0x50
[ =C2=A0=C2=A0=C2=A00.557120]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0? __pfx_kernel_init+0x10/0x10
[ =C2=A0=C2=A0=C2=A00.557122]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0ret_from_fork_asm+0x1a/0x30
[ =C2=A0=C2=A0=C2=A00.557127]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =C2=
=A0</TASK>
[ =C2=A0=C2=A0=C2=A00.557128]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] ---[=
 end trace 0000000000000000 ]---


CPU:=C2=A0AMD Ryzen 9 5900HS with Radeon Graphics

Branch:=C2=A0wip/evl-v6.14
Version: 6.14.0/6.14.0-rc7


A good day.

