Received: from sonic307-32.consmr.mail.ir2.yahoo.com (sonic307-32.consmr.mail.ir2.yahoo.com [87.248.110.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2022142E8E
	for <xenomai@lists.linux.dev>; Wed,  3 Apr 2024 11:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.248.110.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712144182; cv=none; b=WYkqzwdE83ZG50Uv2j3I2culxp7C1VvseyJ8mGIyvTLHYoQapu21IN9YLVjkJDHokGYFgk+CZ5pf2NKSxvnyOqcSa2GZJYndo7EokQkUMA4PijhizYPvsO1qc5E6pAvM7ImLKUUY5ZoFLh8i+Q3/C3ZhjSWKYNuthAFhoB3FLNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712144182; c=relaxed/simple;
	bh=geIZq9DpEtoJus3XeEzJFg6TUdYlsoDYo7DD7YcU7Lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=juRyUdaetkgnPJ1+/BHKFdGuZi4PAZ+EMhZxbuYmMyHd6EHYqFJqMr5L8uT+yyzbQOzwuyo78mPVUBhabRhidH1lCX75jVmjcdUDEnV3ij71cMEzf93YB1f1YLNG+EzWTH6ah4oKN0F844UtVDBaFijnPZLkl9iwylau+hBHqYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=SCPTZBgI; arc=none smtp.client-ip=87.248.110.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SCPTZBgI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1712144178; bh=zT4U0Z3AUxZW0xdAZ8onygfRzlXk+Tmc+g9Jzc3lDcw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=SCPTZBgIvU5p0XowXS6XJnBZUMSa38usIIlGnI8bDOdqyxgVTjrLJUsElgSCV5EWhev5CgcMkfAmCixtZyw6zAlqpf/D3/eQpLmLzgZgLurO+wYn3uk/sKhcQdhGMM22qfUHDtHf3LVD3ip3heO4HGk1EvJsCESW7mrr31GoJj6bq/FcOQM2T+qFQEvydG5vaqQt2ZkRZ8qUlk1q3sLH+wVOsLGu64QhSKJTe6r+Ch+knnA6USy6B6znfck9oB0QZT2xc7mYYAo3C8Brsdx4/K/Cwq5pauoMwtoAt3ZcyGWa6Nzc6MyjHge+jx2zTDrxjJ9Z7x9gjuUj0CA6gFm2uQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1712144178; bh=DUJsdTvY2QUdSfJs1nkbBfb5T5StfdOiEi8Lbwo64Hn=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=oeT1GeJkl2rZeh9Ru2/GMIuQFUFYftUj4ZHUMkAWi5IbghsOZxlBkArO+Uu2CXgFJbnBol4J4QJ1LC7Gw26D2mjL2tq34kR5BKlDKektMFudt1nWkUjkI9jq/PCKMkY7khBxwwAspUcJll5JTHu+CFci00JVy06hJPCm54ZHejlrxoOKDY+anMAeW74GNbE2qynt0KXvqPBMIdOMrPZp9dCjWDtI+h5FmWIshu23gFtLsrGRCnoiMq2+TZXT5EDzGuLFk8CyMscdzLnwlw923tnR7wKE1Qa4BA19WlrS3Ch7guO/r/UdDx62J7hQdiHQDdgINnwDoWD43SQkmyfCJg==
X-YMail-OSG: 6OubGgIVM1mixNvDUlvpVQhTr_q2Yhp09eTRIHtDXPXMeH.pd9rBshu_cAXHZL7
 lANWPuLzPfK_YzESp3zCStT0TUeWES2ZG7FG.zlduQd3KBi1zvCW_tAUtZnHqoKUggJsDL8DRYNX
 w6PTYuJ4sptH.g5Rd4mpg8lChpRbDL5zzcNDPgO7zuN2oGzyDvyk154svyduKzC96zpHcawTnhXh
 S5JdDAD8ZvumPyEQVAeE80qxkcoUhlbzLsDGVPNDfaLwtuFgKYmwQsOeIv5KTJEzVxK3kmpXJ.63
 KGurP51hGVUVWK4pzemdvEpyg.QDcA9TUGQ0.Mej.7lOt_cXvjLtbRkWP9J5G9Yt.fRkwNn26BWz
 ZTAL2UINdsOQj3EJjfRro3qJ8Pxr3wOw21N0ZAInZ.KsqK4rabgO5cq9a.pAojz87GOn66kAcbu1
 X84GRF.MKLynYuSdtBm.7c_L60TGC9ZHzBQW9Uqw6ROFpJpwbF1qJwIC_KJ4byN2ok26OSbBTuLH
 P61b1RWPsY0ENffAAK_1xxXdAQZ6DjhqBI9yEXBd6kX1MN0mGmYX503g1YO4KEW7fGEKX9cO2bjP
 pF_fIXCKcfMtEJFwrQL3PSbESHinUNVjpB6q3TksT5tTHMCZdhSrNZT.e7qZyOlfc8tk7DAsbwP.
 2XGGcHDKyv9iLLMjbgRIVh2xAygddgKU7o9OWnB.ajqGgl.z84.yvPf_xg5mxYN_9piOnsjFWWKT
 CqMBkAw_xbUGfwEUQf8qo_nb4SlN9DKTwME2Ct78WqjDdtEbyjwuknqRWLvYMj4G6A2.ks.4s3.f
 2MATP.PosbhsNC2C5fgMZupY.dmUu7oluCZ4mCbfLgDkEFjzdHppEPL_GSXrQnNs08C3OxUtrvdn
 YzIp4KX5Axb_unKLrmn7Z.taA6iIKQxqEtE1xg9V73Z6O1PvlEXPh72v3_huBU.AkhqL3D7CCQwN
 opa_dzA803g7ShneDudzw5JwNATqG5vbab46P3o78QBKmIGYpWO9CUBDHtfouhPXLlYk1kxSKlLi
 SyiMQPKq3V7zBtj.6tc14Pu32YpgtqbTFkyWoM89E61fXFoNva2hLjEmv_YvSFQADR1Ej0el1WDy
 0h9qUdFUwMYdLZLkVI_8R0xvncLje4IY1mpYDGAXmJkrpuQq_GjR4MWV2ynIzb.mkVklgnZfcsX7
 R2Xsr9ESnPubLPRnIQjD3PngBQhl8Q6oavOYiLeTVzpJsaNz2UzXP7Jq6TCwaeb45m_thLyd9V35
 oRjALlplJNrlIrwzsWImneIztsMpCmXcm1SvSJvan89gHCUZBeSoiDpS4O8tKPsVwJNRiE3Yc6az
 0KEJ882Afq3IC6R5dmtC5YYjulQlZ3jB_juZp_.GdqmpGspRrS3yWfkOkdHxd4I7ftyrGm_HlnFn
 fc49eyg4Stbq8B.WX2F_kFlq2V6bSYtzCjqy7m68eA8Z2302x1G_h8ycfCOiAa8GikfgoeJA20St
 DT99fB87edK5FPVgsZWlq7Z6hejWyTlnsgrxy_Z6OnHzXNglJcpn5qFMwaCGRIiT8xxoYPpDhsuZ
 UfI0SWbQx2lR3S0d7SjxwcawixTHqOAPcHxLvDiXcle.F9HoAlkWQ6HtDDRCtzUzcZg4y01mjB3B
 7F0kazanVvMKSZ9emB5SH5t6Vbgt1YskBDtX_Cw5uE28HJqmwh4OMtVJaeLA_y1dg1eb9fBwid5s
 zCQ.zES.H7ktFaE7odyrz0Engk_LpmQEzu.tJ.0YkvHpwaMpebb0ko_Satks5f.hqOfQ4FIo7C5b
 138eo.Z7YVEn8r4rAssk3EuobZ53lhUr0kSq369PwrbQWr4z1YzP_gr_D.m4j2fZaIi3AoAUFLoG
 dH6XuSorPo387RNSDP5Uffk6V3tZO6z5eEwvkngUoP6lDjxH4ZfdXBhf7KwR_Y_NkcZKZl.rTtwy
 lkgYA_ynfD7EIlGeMUoYQTODujwP11Sa.1cJCMIhWG1dmbhvXv0mwVyZXyC5bOdnOhAQVDR3vOay
 qNj7yfuw5sbaf6Snr3pKuvtSTsh9AZ3nqw875sXhgYRrhmtwFVF56WbwcXk5w4V0EfVdG0eblpH9
 DoTC006Bdf.r2rDXZl_XPShjLi8lD8d_O6cfUq3eQfoJVAGPUAa5gjCw_7JWRzXUGQ.dLGDXJo1v
 VQcSHLyFPkuc7Q7oyT0YtJiZdgWi1f17oryoeX1EocOxWq14uFlrWth35TYA5Ho5_EBSceoq3Uxv
 LZdV_D2hYqYrw
X-Sonic-MF: <mau.salvi@yahoo.com>
X-Sonic-ID: 5a4a1333-876f-41cb-9943-6779c2b27661
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Wed, 3 Apr 2024 11:36:18 +0000
Received: by hermes--production-ir2-7bc88bfc75-pxs6z (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f22e520f29db3c1ee14f7960ad99b04c;
          Wed, 03 Apr 2024 11:03:53 +0000 (UTC)
Message-ID: <3a545b7c-f6d4-41bb-a7b5-60cca32cffef@yahoo.com>
Date: Wed, 3 Apr 2024 13:03:52 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Process stuck in cobalt_monitor_enter
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
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
Content-Language: en-US, it
From: "Mauro S." <mau.salvi@yahoo.com>
In-Reply-To: <3d312b9673593f87ca2cfe6d86d3c9a1a791ab8d.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22205 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 02/04/24 15:41, Florian Bezdeka wrote:
> On Fri, 2024-03-29 at 17:06 +0100, Mauro S. wrote:
>> Hi,
>>
>> kind ping about that.
>>
>> Not to put0 pressure on, just to know if the problem is worth
>> considering and will be examined or if I have to make my workarounds
>> definitive.
>>
>> Thanks in advance, regards
>> --
>> Mauro S.
> 
> Hi,
> 
> we had a short discussion about that issue in the last Xenomai
> community call and agreed that we have to dig deeper. If you got more
> information in the meantime, please let us know.
> 

Hi Florian,

thank you for the update, good to hear that.
Feel free to ask any additional information you may need in your analysis.
Unfortunately I have no further information. If I will have, I will let 
you know.

> How does your workaround currently look like?
> 

Nothing useful, I suspect: simply the external process that kindly ask 
the main process to terminate with SIGTERM also monitors the main 
process exit duration: if the main process does not exit in some amount 
of time, the monitor process kills the main process with SIGKILL. The 
side effect is that I brutally interrupt some operations that, in a 
normal exit, would be finished in a clean way.

> I think Jan will answer once he's back at work.
> 
> Best regards,
> Florian
> 

Thanks in advance, regards

-- 
Mauro S.

