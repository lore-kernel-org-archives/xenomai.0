Received: from buffalo.birch.relay.mailchannels.net (buffalo.birch.relay.mailchannels.net [23.83.209.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D0121516D
	for <xenomai@lists.linux.dev>; Fri, 28 Mar 2025 12:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743163318; cv=pass; b=QkvHnlQ+eFGc537LXKdNYsR5kX7LVbAguq9MN0geCUMTyxDok3JCTCo6qc3OHv4oQDP9J35ht3XkCm+FHvbzZPlyJQsto5WI8dUL3hiTV7wrTN6IIZgTIo1M5+hqxTtll8FemdaFxe/5TR8nHw8qHazzBJaRzI9/+HrCaXmPxq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743163318; c=relaxed/simple;
	bh=eJv6KNkUgr6/vsciYpRZY7ypeEcj3bEcEmihS+YrakM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mymCp5SEgtdxS4elHm2t1alas22HFy6pJVJAGKPcWUPUk7CApB8nPsA0EYcOi/18zeDF7bvym849dKmJ7DxdoNPyTDIAsNrYpkqXLfYe/qiwcWViA7UBWqp+sXDzuqlKmzCCGRv2iK7K/Tu6r6tAdngPul7CfGULpEDY35GDB+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io; spf=pass smtp.mailfrom=bela.io; dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b=d0DUNZ8r; arc=pass smtp.client-ip=23.83.209.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bela.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b="d0DUNZ8r"
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 7A83E239FB;
	Fri, 28 Mar 2025 12:01:50 +0000 (UTC)
Received: from pdx1-sub0-mail-a309.dreamhost.com (100-99-235-2.trex-nlb.outbound.svc.cluster.local [100.99.235.2])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id E82B725325;
	Fri, 28 Mar 2025 12:01:49 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1743163309; a=rsa-sha256;
	cv=none;
	b=hv3+OIMk0QVihe900BG1C9RsYD2OEn4+pwJ8YycQX8QiN0B206fw6IkOwK1gUISKW83Eg5
	FeWjGIHlH+DX19ieE1rpNYRPVlKZchYGN7ZYxOcMeeUQiOpum1QNA4yKkuKUut2Ki+Mkks
	LORzHq9cMl4W9V6IM8nJVmFNuiY+FZ1s8JHJfX1NqWSWsarxKQm8N//tWCZXT74Jp2AZZc
	MDql4sZcaY4s1MmJH8i9EoqE1B85xv53t5bV9kriHV08VIukbrJ4f9S0bv1x+9iizPdifg
	DYmDTncTft2meCsBQ2+xDU6wvaJ4ntrJECVRtLs17Y19+BWZEaz/MiyatfYYQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1743163309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=EtPh68S7/1rqAFuNaq80kjFqIwkoCp1muonYcPqRyqI=;
	b=rhhAgIDoI1dx/p0Oo1wIGAhqmJkX2Y8N2rfyvn7Oomd23qKBTjLyUaFqc4ehNQ9EcOqMB7
	RI+g8nz1cvhwJwy7jXmR8pI3HdMM8OvLveMRo082c+UkpeVnzzVbMQoIPstrcfA+uIJPlq
	arxrFA7kKf6CtaJJyDBJpEAv7ePhPkIsviN2U50nnQL/sonKopD7txvdrYJBcydiA+bfec
	o9TUZY3aHzC+v4uqGmsewoQUW+viZowTrSGsAL+A/1v0Bf6iW3PcfgD6/Z/8e+w1tRxbx8
	iHg0HdxEy8eoB+OuKAd/62ysMhP3NlmLz3mMVo2SpX5AhYOHzhnEnnn9Bubb+g==
ARC-Authentication-Results: i=1;
	rspamd-c6dd9f947-k5btx;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Wide-Eyed-Relation: 1bd49ba1684a6b5a_1743163310249_2418594371
X-MC-Loop-Signature: 1743163310249:1768923173
X-MC-Ingress-Time: 1743163310249
Received: from pdx1-sub0-mail-a309.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.235.2 (trex/7.0.2);
	Fri, 28 Mar 2025 12:01:50 +0000
Received: from giulios-MacBook-Pro.local (unknown [186.99.134.121])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a309.dreamhost.com (Postfix) with ESMTPSA id 4ZPJzK2D7pzK3;
	Fri, 28 Mar 2025 05:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1743163309;
	bh=EtPh68S7/1rqAFuNaq80kjFqIwkoCp1muonYcPqRyqI=;
	h=Subject:To:Cc:From:Date:Content-Type:Content-Transfer-Encoding;
	b=d0DUNZ8rAOmCbh531tTMeIWaItqToVd6fbFJxr30dOgyn0Wl/AOYgNr+gRdSLm8kz
	 Dw6FRPpso5PFTuPfdYiQ5BdheVKcT3qf4sSfSuEQK6L60hlQFNDDWQYQB+5cZG43JE
	 aGEE6G+EswHyEphcBgsJvh9EoMq9W8rFF/1zQvBWCnThkwhqGIQrzYexsONJklciLV
	 fxYYyxxzT+Yptk/tWXkmhrd1khomeuM++YTYYcpL+TWyBjcz6icng6O+SoBMytvIKV
	 9KdajNYg2HfmmIIg+nD2bXw7K9hy2PrH/IC23xHms8pSVaiDwgjGJXkitqOO7Ff9GY
	 LJx7rNJHvAASQ==
Subject: 403 on pages from source.denx.de
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <DB9PR09MB60325FCC7AEFE1880D9698EF81A62@DB9PR09MB6032.eurprd09.prod.outlook.com>
 <DB9PR09MB6032B14E3FA653EB1FD4BDEC81A62@DB9PR09MB6032.eurprd09.prod.outlook.com>
 <582f231a-3e17-4b4a-804e-7f43ebda3c48@siemens.com>
 <CAFc1U0t8cWGpCc-ntsxCm-+obz7fu3w8jMrV1w=XtRyRCMDKqQ@mail.gmail.com>
 <CAFc1U0vf9y98v_iaWdBz1YcdRfJ+6pd_t1Hv+9F3zfmNu3+C1Q@mail.gmail.com>
 <e5426038-8819-48db-959b-e7982d2ba667@siemens.com>
From: Giulio Moro <giulio@bela.io>
Message-ID: <31290680-6e3d-2bd9-293b-f5a41315a8ee@bela.io>
Date: Fri, 28 Mar 2025 07:01:47 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 14.3; rv:91.0)
 Gecko/20100101 Firefox/91.0 SeaMonkey/2.53.18
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <e5426038-8819-48db-959b-e7982d2ba667@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>> Le ven. 28 mars 2025 à 06:57, Pierre FICHEUX <pierre.ficheux@smile.fr> a écrit :
>>>
>>> Hi,
>>>
>>> The xenomai-images link seems to be "forbidden" (error 403).
>>>
>>> regards
>> On 28.03.25 07:00, Pierre FICHEUX wrote:
>> Same for "all" the links (repositories) from xenomai.org !
>>
> Jan Kiszka wrote on 28/03/2025 01:06:
>
> Was either a temporary hick-up or is (still) a local issue on your side.
> Works fine here.
> 
> Jan

FWIW, I noticed yesterday that from Colombia I get 403 on all the pages from https://source.denx.de/ when I visit from the browser. I can still access when cloning git via https, e.g.:
`git clone https://source.denx.de/Xenomai/xenomai4/tinyalsa-evl.git` works.
