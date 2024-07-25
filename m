Received: from sonic306-19.consmr.mail.ir2.yahoo.com (sonic306-19.consmr.mail.ir2.yahoo.com [77.238.176.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F191339A0
	for <xenomai@lists.linux.dev>; Thu, 25 Jul 2024 10:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.176.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721902238; cv=none; b=EQxkGk47YjZkUCN1zGzcgwx0Hc2pAEFNtyYTganCfprKe9nRE+5Bxw96FH1LKe+MXWtpPSwE0Mn/fmmOCaEDc+T4tjufhZiHjE155Mnb+bdKvIrAkEBwIuBAH0bc1es1GelmJEC3GPCHkFGUXPDJBeEW13nzdSrVxvABIaW0Qjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721902238; c=relaxed/simple;
	bh=6GED3XYHzPVwt1d4cd94MUj4B/7p3oRDbTkhn/557qA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UzPpvfg/SMHXyWst93pnHjxmjykA84ZuG026nLnJkl61aR4/+unGfTSzNAuIJ4MDYuzd0xROS2Wzrc388pj45RimG67vN7txPjFqLfm9pTznFfAvNSij44aGmslcQdPN0NpOxS0iJ0IDY0R9h+oUQT8Ie0fhuXqAIO9K7JL5RLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=olJW9I8E; arc=none smtp.client-ip=77.238.176.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="olJW9I8E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1721902234; bh=E8X7iZo2K9dH+kaWC/88jUyeUQ/izkbmiHY/X+Eg0WQ=; h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=olJW9I8EWfvOCfKknuS0vbWG73X6JXclJNSZwOv2c/6g+PFPYObjWpeJlkLg7HBkAKA8M1tu0FYzAyO1idCLhNKZne/mtJ98VF3c7NSmHIUYmzFv0AfS1//OHg7qrXYy/yHBiQEPFg6OHJH281sFF3Tr9eN75WWuZJySc7sIWY20Lngmf1nZOWDXBG+jabKMjtlMaTQGnnnKhE08fO2EJWCDY9d5J/LXM9MfCJOmZgBjY2s4j6TOQY6UP46AgcE30nK91OgO97wv522Ryoqpwnhg4UTrahEanGzjSAorcJvP6hdRzXsgziElogEqoXAVAtu9PC+sxis2xUIYeKxmcQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1721902234; bh=IMKlzAB0yksU1MlCnAtsuzj6l41jZnRsii3fYfUTgK7=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=eEgErIMo1075NLsdRNH0xxkPNQddqhbeNymvRTUvvcjMU2JDZz8Uc6uak7ESFU3Lcci6ENvzruToVDq+NqscqlJY1mmKqF/CasWuUZtmH0RhTyr97IG9P5p6ZUOPft8M+r6xgxjSIJH3oPiAT7ZweOO6MGLN+gcLlqXRELFvEbI2+f03OhTAl1tVtSaCxHeB9+cpMnTh1eWNEhVzYq1ZWUgTaC/nYBauqUP3coZD6B2Uh1ztuSxE4ax0h/z51nK96cNDDVK4Xlw6B8dHJ/Kp3s6syjSSJ7hRIzBtCPR8l+yeWDrUFUVg6z9BGwPtaUg3hN2Tk2JeCygGJwAgkRseLw==
X-YMail-OSG: 7_cE2lYVM1lT5XUO6ERR4lOGjZLIONSlVQVJZ1YL.4lIwEj8qvtxWWXXIdpSCr4
 9ymokb.Rt7bX1S45hjWlYgQ4fOSzhdIycwe8HkPWFxwgUjh4mPBHN5WTyiFlCgjMzDvXLGSJ4D3C
 A0ecje2o2b_NqZKWGdhlIARem6yu9Pkd2bw3l_Xg6cNSOBZ13ssyp0E7rOjbvHlNhzsLXsBnZdft
 D5fimo75QS_UvAFreiH41NT3ENPzD17Hzui6rWTBpkjGTukmRpR3kc_UppYB_adQhbaLQr.uTerP
 ET0ZCDtb2bDtba9n5CegOlzZ3Sb.VKLXtn2dsat8HNr0EHZzNx3N9EvLbKtFxqQ0oHYJlqQkOhZw
 fz1.6bRJs5BbXoJfhSAhJSxoc2onr6_ZtufdhmpvWsndtIWf3mgIL.ofnr45TjX1GM8Rfqg0ZJ21
 UKFMjOSVWe3Zz_kd1Wi8Own2dPknoMh0yJqjZs6qC8kUGzlI.y05JCoVlFnzhK8Aopc5J.G9bYlh
 rgSMMDggV0FI22LMr5iZKZpfPhtOEovEaWWjrdgIQX4qPtVAftg_lBDJnTovPgFGIJGAwXqMFvtE
 8cQaRS8mcVr7Sk3eK4ghtZ8G3IqeP80NZYWr0K7kxNObouq0GZojn_TAhlj3MVo0tOb9XwRdwK4f
 AP.VSLwWP4TBBgF_tVA.Y2flcDuIBkw4PGdlOYppAc0bGLM7nGjqVgNp5M0rtp7mPObxIM3xXt46
 T9rWjFwSo6Jiwhvj5Rho0SFNTCmXtgXEOLTY2oehWROQSwj67kiKVlULNd._soO9gjo9d049_LW8
 EZByLNMzLfXN7KBA8LSbDkoX2wdF1_VPcKFyuTS1ZbkWuhxPOq3OH9N6gtJIKz.iRN417AB33mwg
 5jj.toYrAZkK610woI_Vlwojm_SWJUdejtXNx0DboAnCt_z4xccBrCM32pHSpUxmlo1nu4NHma26
 ggeH5R4Zg0A_Bw8uEtP.QyaAxqoWkbq90Xe_DzzgPSgO_oPberCkjamtJe9eBUARibpB1nblYnWB
 8YoyuzmHO_VZ8FoF4o21rdMKk.v3TpquZUYiHaeplzUFxHYHWn.reKG.UdUx4bJT5rJJg9OPsGDQ
 fQ4Ca.xK8OThEZqQg0sBEEYFlUTsnOFHXKzvulYWArnUxymjTEfqcC2l700y9dzQJUtFuOb8rETq
 a_pHcsjKDSIQAKaFKd3jYRPqHk8uiFJW7EMlA0k7vuubni53.UKPtIz2ZoMXClZCjVv4PJnGIwYG
 D38jxMvmxOHh6CLB2kmN7tMb5slSSw6UXA7cNZWevnx78XYz1rYragUyT3PR4hHuAE70ZflPuXVc
 Sn9.7rZYd1Gdh0X5dkY_vOgCYoxKxWGYog_uNHzvb89wvPUJhD.IFuQxvJoN50bu_4EBwXRVr1qY
 V5hv6QVCZnrkCw_IpLOGOsV_7AUB4A0SVP837.hcaHrjhHtGi6vx9ZXsH1t83ACt2QhKQWwPe6QJ
 YQnINrt41netsWsUxu4PDOK2fjAn_9b7Y3nYNF523t7T1Ag7HFXMhx7xolUNzcD2n0xCKzr3BL5h
 ntq34O5Zkym_GjDxGf.MJOjlObRd43kWUH_l2hXaw6ziVE0UAJv7lllEqbmR1UTNY6C8tYmw_aOj
 73qNpz4cdkPADDtag.rhGRcNBEVZGoBmNQ_suSknYfexFjCIoliYDwWURz405tgHWXu37G5Z9F_u
 olrlZHWUR4XoyNXVT6TLfwS4uod_L7eXQ.A13UbTdMAe2BV9DFA4LFRH5vOPjS6UupiUJuXauoOA
 s_yHfw7qM7FZ8MVrLLiTDMHgNotA9Lm_Q0G8QwdDdSqwLUCv_4We4juo4nKoGWlTNjrQ6cd3xMfJ
 dECzuLji2zEJxyvkXvlUbhLOm1yvV1fzublOGBLWMfRziprM5Wcrl87d3rQ9s5fjQs3WZIFW9NVn
 5htiOWV.fu0MFYwMzwXNrhNOttcn7HAZ_pjkxviW7pFYewZXRpAZqfjmAs_kcOuPiZhyIWWPabLe
 WTIa0Z1QlzKuq1XRj3pYyH9XdN9KVvMPdgX6cFsVq._onv5kfFhGcssrpYzp5F4hnnAzh5xRlCdj
 h2AwW2eDCH.npkareyk_eNASUA1bUGw.fkJObjhOzz176hcsXWEzQIiMw3fq.lp5jRMeMZH2G1wj
 ad1LQeRfJ6nGFCsE4pWf4QA1IBVgfU_xb5zHR5DtVRZ1BsbmRJIzgmkK2meJnH2VBIzwm6Rplj.4
 -
X-Sonic-MF: <mau.salvi@yahoo.com>
X-Sonic-ID: 516ee580-b60a-4af6-9f48-ec4885190c60
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ir2.yahoo.com with HTTP; Thu, 25 Jul 2024 10:10:34 +0000
Received: by hermes--production-ir2-57d49df6b5-64vl7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fa6e852aaf506a60a896d49ca61cbb00;
          Thu, 25 Jul 2024 09:40:09 +0000 (UTC)
Message-ID: <5bf13cc0-0236-44f7-b48b-c5b972180633@yahoo.com>
Date: Thu, 25 Jul 2024 11:40:06 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Process stuck in cobalt_monitor_enter
From: "Mauro S." <mau.salvi@yahoo.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
References: <9d5bb262-0646-451e-a5af-82c0473a3003.ref@yahoo.com>
 <9d5bb262-0646-451e-a5af-82c0473a3003@yahoo.com>
 <035a65bc-c064-40c2-9fcc-b3fd6104a233@siemens.com>
 <4572a391-4c06-4aa9-b92e-66e9da6c23ed@yahoo.com>
 <44ffbd9c-fc28-40fd-849f-a77fee15866b@siemens.com>
 <CADBp9x=310edtayP3nEeDSc2D318E=qA1a=5ceG0krd3r2VN8w@mail.gmail.com>
 <87e3bc23-4eba-43c4-bb5e-ffce9139c075@siemens.com>
 <CADBp9xnL46vC0KiYt2MSv+XxYcgb675S5X6geQWSv8KsKG9+xg@mail.gmail.com>
 <CADBp9xn_Gcu9TCaiZHZvo3hwT4JzzTxE4ueMH3dt81KJWF8qOA@mail.gmail.com>
 <67ce5b0a-1013-4ab2-9617-0723c0dc0809@siemens.com>
 <d1b99e9a-5bc6-414c-9f5d-972134f60c31@yahoo.com>
 <bea3518e-5d72-4a86-a5b9-ac71a59c235b@siemens.com>
 <e5efbf9d-9054-46d3-8deb-aa321146068e@yahoo.com>
 <89ad3b15-7fe7-44b2-8719-02dc8425ecfe@yahoo.com>
 <3d312b9673593f87ca2cfe6d86d3c9a1a791ab8d.camel@siemens.com>
 <3a545b7c-f6d4-41bb-a7b5-60cca32cffef@yahoo.com>
Content-Language: en-US, it
In-Reply-To: <3a545b7c-f6d4-41bb-a7b5-60cca32cffef@yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22501 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 03/04/24 13:03, Mauro S. wrote:
> On 02/04/24 15:41, Florian Bezdeka wrote:
>> On Fri, 2024-03-29 at 17:06 +0100, Mauro S. wrote:
>>> Hi,
>>>
>>> kind ping about that.
>>>
>>> Not to put0 pressure on, just to know if the problem is worth
>>> considering and will be examined or if I have to make my workarounds
>>> definitive.
>>>
>>> Thanks in advance, regards
>>> -- 
>>> Mauro S.
>>
>> Hi,
>>
>> we had a short discussion about that issue in the last Xenomai
>> community call and agreed that we have to dig deeper. If you got more
>> information in the meantime, please let us know.
>>
> 
> Hi Florian,
> 
> thank you for the update, good to hear that.
> Feel free to ask any additional information you may need in your analysis.
> Unfortunately I have no further information. If I will have, I will let 
> you know.
> 
>> How does your workaround currently look like?
>>
> 
> Nothing useful, I suspect: simply the external process that kindly ask 
> the main process to terminate with SIGTERM also monitors the main 
> process exit duration: if the main process does not exit in some amount 
> of time, the monitor process kills the main process with SIGKILL. The 
> side effect is that I brutally interrupt some operations that, in a 
> normal exit, would be finished in a clean way.
> 
>> I think Jan will answer once he's back at work.
>>
>> Best regards,
>> Florian
>>
> 
> Thanks in advance, regards
> 

Hi all,

I don't want to bother you, and I don't want to put pressure.
Just wondering if this issue would be analyzable/fixable, or not fixable 
at all, to decide whether or not to make the workarounds "official" in 
final code.


Thank you, regards
-- 
Mauro S.

