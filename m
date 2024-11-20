Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB9E2F2A
	for <xenomai@lists.linux.dev>; Wed, 20 Nov 2024 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=217.70.178.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732131335; cv=pass; b=QcUufosMDFydmjq8UhedqU6943u0shuonJKiBslNwE8tKEDPJ4oUObFxwboqdUdBI+Ys7ZjvpaKzGAyzInnbwCzZHxlEBRGcARZzFkdEAlkPeGJzoXVo2fAwW+k0xJtnTs0m0DjHrU1MFSvraui4wtPkungdwokWW5M92AQNF7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732131335; c=relaxed/simple;
	bh=Da1ZGDmGqwABivtKDg99Q5Tnh9HChSP7W3BaaGJhUt0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kI8kxLKBOT/ASTmthnXieCa5Yptzn/Jv09JCnrHDaHgA8YgEGLV4UFAHhIhoBCk7VnAJ8oxYRm8Ts9gb53QPyyukoyTxwoL6RrHPYJN6v+VMJP0r2rpM/RTNJQYNPOsFa9DNhTKSUUHG0UZj/9Xe0DJTHm8NH9SuBM5csqfL2rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b=pfTIoRt6; arc=pass smtp.client-ip=217.70.178.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b="pfTIoRt6"
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id 19B7E1A0002;
	Wed, 20 Nov 2024 19:35:25 +0000 (UTC)
Received: from dog.elm.relay.mailchannels.net (dog.elm.relay.mailchannels.net [23.83.212.48])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 31490D806BF;
	Wed, 20 Nov 2024 19:35:22 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 731361C18A2;
	Wed, 20 Nov 2024 19:35:17 +0000 (UTC)
Received: from pdx1-sub0-mail-a308.dreamhost.com (100-112-138-111.trex-nlb.outbound.svc.cluster.local [100.112.138.111])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id D51CE1C1A30;
	Wed, 20 Nov 2024 19:35:02 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1732131305; a=rsa-sha256;
	cv=none;
	b=0SjXuY40mK0u+Lfa2Kv/ekN3LIeTBQ+96lfwiFuFduqgzx60+YSpKkQWk7AUUHnLYqAI3k
	RltUhJ1q53MyPA8Cfir0hd//jYny9TS/sel3KdN1Vm2mwIXQpQoznaf+og9oLWfThfyNHO
	tW6tw8K0N3w296taS+weUQAHrh/JUIKx+wsLlPzuk8cRjrgW5YiwqbGTGvxC4ZDydXbnDb
	Ui4fK1WaTm2oicFEr5W4Gh43XYtAuW4owCUbPEzEfHMB0gYvz2AC3/EfKYCxB3jEy3HYWM
	z0jautLA04KiiBb+Im9RKmZTnPryMxOomekWNMMC3bXe1UOELglJE+Q9LjXzrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1732131305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Da1ZGDmGqwABivtKDg99Q5Tnh9HChSP7W3BaaGJhUt0=;
	b=9mmpSOA7NO1DneNqWbLUSDZEtAucPZGan/bqOkkf9xrMcuDYJityEsPtIqcfxNx81n401S
	wvsnGLWxwxNeKK1oqX1Uv6sQIhmSOgzEc2q0/csWm1agy8DNT8OmMTdNbFmkWcN7teIB84
	U72ngEnPfuQQrxpIdm4S7/DVFh83FVe6WAXXaiFcSbktELVuGfdL7jAJRYTPBCjJ+E19NS
	GZ3IRG2GFL7QLlwE7iVsRJA/EtBkB7ywZjQDSgdoPBlqMXgNg/1IDlmKr/O1sDjcYBskK6
	KjMup7DQOQw8OB7ooHtlZeyGT1Xx+CuJG5ZlfYUIKRlGruO8NBW5m9+2YqcL1w==
ARC-Authentication-Results: i=1;
	rspamd-dcc6979f6-hsjts;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Share-Illegal: 3f28e7c415648492_1732131305980_4218722580
X-MC-Loop-Signature: 1732131305972:1428122800
X-MC-Ingress-Time: 1732131305972
Received: from pdx1-sub0-mail-a308.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.112.138.111 (trex/7.0.2);
	Wed, 20 Nov 2024 19:35:05 +0000
Received: from giulios-MacBook-Pro.local (unknown [186.112.187.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a308.dreamhost.com (Postfix) with ESMTPSA id 4Xts5G1cCVz7G;
	Wed, 20 Nov 2024 11:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1732131298;
	bh=Da1ZGDmGqwABivtKDg99Q5Tnh9HChSP7W3BaaGJhUt0=;
	h=Subject:To:Cc:From:Date:Content-Type:Content-Transfer-Encoding;
	b=pfTIoRt6tfXPUnLwVenMUoB+MMUSZDKRD/1FurGyxq8/hLpe87dryoGHv7mxtyyQ/
	 lv/C5xsRlDIp4tjguKlDLbbtlIbgRcjS7U9udyTySafjDDKkxgUNfpP4spFALVLn/K
	 VOeOe7EzJW/Q63skEcHvNW3Me3ov8hu7MEz7ObbyW5D4WwMSXO3MdthOIjC5ZiWWQR
	 y2XBdr2tAhzDIiQ0hnKfhM4as4/ZkPUW5RRJj769H3lS8xx5i6uxH2MoV2aFYiVFYe
	 ZdM4bnFOdEGFKMcew6DsVwdiGdirLB2Cp/JQBh5CFpb038/TRa9YWIx7wPLH/1wBta
	 nKFRogNFF2MhQ==
Subject: Re: [xenomai4] POSIX API
To: Philippe Gerum <rpm@xenomai.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org
References: <87ses62bi5.fsf@xenomai.org>
 <d28b8d0200ef0e3ff63e833b64c2ad00c554e351.camel@siemens.com>
 <878qthiw8i.fsf@xenomai.org>
 <afea1670c26d61ccbd18b6a7b609498bb1dfb020.camel@siemens.com>
 <8734jm3try.fsf@xenomai.org>
From: Giulio Moro <giulio@bela.io>
Message-ID: <d276fea7-2873-6014-aea3-acced9943f7a@bela.io>
Date: Wed, 20 Nov 2024 14:34:56 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 14.3; rv:91.0)
 Gecko/20100101 Firefox/91.0 SeaMonkey/2.53.18
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <8734jm3try.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=bela.io header.s=dreamhost header.b=pfTIoRt6;
	spf=pass (spool.mail.gandi.net: domain of giulio@bela.io designates 23.83.212.48 as permitted sender) smtp.mailfrom=giulio@bela.io;
	dmarc=pass (policy=none) header.from=bela.io;
	arc=pass ("mailchannels.net:s=arc-2022:i=1")

Thanks for sharing this with the list.

>>> __real_frob() would require explicit call via some macro trick like
>>> __STD() with libcobalt. Others would be invoked under the hood via a
>>> plain call to frob(), depending on the insertion of liboverride.so
>>> _before_ libposix.so on the linker command line.

I am not sure I have a full grasp of the suggested approach, but I'll share a request for clarification/feature. On Xenomai 3 it is currently possible to avoid link-time wrapping and explicitly calling the `__wrap_func()` version, while regular `func()` calls result in the stock version (equivalent to `__real_func()`). I find this behaviour useful and would like it to be preserved in Xenomai 4. I hope this will still be possible for at least some combination of build flags.

Best,
Giulio
