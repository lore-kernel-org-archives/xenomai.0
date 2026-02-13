Received: from lavender.cherry.relay.mailchannels.net (lavender.cherry.relay.mailchannels.net [23.83.223.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6ED350298
	for <xenomai@lists.linux.dev>; Fri, 13 Feb 2026 10:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770977597; cv=pass; b=SWU96ys7c/PxbozdOSOtE8evw/6cAq7Tdy94/0eX1a578xTMti49FJ3JRC0JeB4FhUGJ6VAZ0bn955IS1kkaAMss/CYhkGO1ZvUIRyFjzwLduZkE8HashgxUdtBpDZIiU0PAHqU60yY6o3dL35AsbSKgE3zkVlgNG3SkF7wY/Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770977597; c=relaxed/simple;
	bh=pC3idtSj2Z7SFpk5DS8YyCEO6lHPS0uchP8ksIC9XOs=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=O9ToMxo2eZl7sm7nL1KTE1w26EtYiPxE1tprK2rLbfGMEnEO5V3aW/lve5SjrgwJl7neTyyNWb3cL0A3aJoo1vChhqYxz19naNYxm8QasEsA02882nJWGEDz6PMsRm+9t2NRyXDKq6TdYJBdmwVPH2KrLeSvJA1UTwIfg4PWv6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io; spf=pass smtp.mailfrom=bela.io; dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b=Hl4zVH+e; arc=pass smtp.client-ip=23.83.223.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bela.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b="Hl4zVH+e"
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 278FB222201
	for <xenomai@lists.linux.dev>; Fri, 13 Feb 2026 03:33:05 +0000 (UTC)
Received: from pdx1-sub0-mail-a246.dreamhost.com (100-98-114-77.trex-nlb.outbound.svc.cluster.local [100.98.114.77])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 87BE02222B5
	for <xenomai@lists.linux.dev>; Fri, 13 Feb 2026 03:33:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1770953584;
	b=ukMdhot3wQ5g2VGlgUgjKz38pNUumLowIwKsfAi/JI5T3Kgm6pN8CkHzHN70o3uRAn2GcS
	mkbJPJQ+8V6ULGJvLMbaXfzH0LjzPCh1dtphzBOVS1PaMFHwMiG9ASegrCAQapQqbEhu6O
	mvqL7wKslJe/lnowZeZlKrJk7J8bXL2k5ekksu5TUmNh1Kh2jTaJaqmh0YkxBtceBqNQES
	Sp/4KPjts6TfKKxoUpgHO6Rhva1zKDBglqIjqhUOE7AtMayFC57sDpkvKDLt6xQ1pUJ6dg
	cKOBS4NHwV4yd4VpuRDALpQb2Zz/uXt7U4rDtsx5iCgdbXMVv+1ICEXsQSi7gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1770953584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=pC3idtSj2Z7SFpk5DS8YyCEO6lHPS0uchP8ksIC9XOs=;
	b=v5LnJThuoLQJJYFae8EeHom8GvQvvEkoQd4RWiNSREgEorRDN78Vy4tSC63jyXGafTG8hX
	y3n+22Ark5MZxZXkMNVSi8fe6z8XY+P2JYS6xSADeilXtKT62nHGbCEhPsNCOZDb6j437B
	YnWQ5LWqTXrkXILwNKOMGGx8EtWrsrsj5Rt3sNB+vogVEKXvKRHx5Q9lgk4soK0PMYI8J9
	6wvb3LyfSN2WD24BLhlS5XkWA/oRVwNIgl7zu9huHzFnve7IzJXBQv0EpVNcDYoNhEiNa2
	IVA2E45HiB0yU48kBBF6ISJlgm8ntmUQjsfbefo48hDumeYJ9vg6523a2gjmcA==
ARC-Authentication-Results: i=1;
	rspamd-79bdc9947c-bb5v2;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Quick-Trouble: 55a3b09650d1634d_1770953584833_2211416555
X-MC-Loop-Signature: 1770953584833:2812404813
X-MC-Ingress-Time: 1770953584833
Received: from pdx1-sub0-mail-a246.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.114.77 (trex/7.1.3);
	Fri, 13 Feb 2026 03:33:04 +0000
Received: from giulios-MacBook-Pro.local (unknown [186.112.184.216])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a246.dreamhost.com (Postfix) with ESMTPSA id 4fByRh0xbLz107R
	for <xenomai@lists.linux.dev>; Thu, 12 Feb 2026 19:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1770953584;
	bh=pC3idtSj2Z7SFpk5DS8YyCEO6lHPS0uchP8ksIC9XOs=;
	h=To:From:Subject:Date:Content-Type:Content-Transfer-Encoding;
	b=Hl4zVH+ex11US7RRGfUZOeqm2Y/D/YIXIZZdPUUSbr3DB1iwpCF+LObPncd6d96SF
	 1mM4HZB8NZCIVeYmX0/PDdzLfq6/gTI3jbzXJDzah7ehv1rpvtAMjs/nAesvxLc98d
	 anJ8eIdBsjsDVCu/IHtWaKeZ9PKsZDXBX6R8i9fW9WVXs0VgVeKfO+MbVjF6SlaVGd
	 1FjAQyYX8Bwy8gTSsvkHe98jcT4lvmc2Oe4Sg4vXtqDQ/UEOJWPxWPtElg4GNLlD+r
	 pAY3N1X6gpMH9EHw5vrOegf+6eN6Z9CJSRcjcUmHaURo9a8YBpzJOpIroKDTH8zT85
	 kKPVTBom2ho+A==
To: Xenomai <xenomai@lists.linux.dev>
From: Giulio Moro <giulio@bela.io>
Subject: cobalt-like pthread wrappers for evl
Message-ID: <8c539987-12ba-912d-f50a-cdaccc2cb7e6@bela.io>
Date: Thu, 12 Feb 2026 22:33:02 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 14.8; rv:128.0)
 Gecko/20100101 Firefox/128.0 SeaMonkey/2.53.23
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi there,
I have to port a large-ish C application to EVL. The application uses pthread_mutex, pthread_cond etc. Porting it to Xenomai-3 was straightforward, thanks to libcobalt and linker wrapping.

Is there anything similar to that currently available for EVL? Maybe someone's half-tested branch stashed somewhere? Much appreciate any pointers that will save me from starting from scratch.

Thanks,
Giulio
