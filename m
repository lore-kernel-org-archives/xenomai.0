Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2AB12DDAE
	for <xenomai@lists.linux.dev>; Tue,  9 Jul 2024 19:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.254
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720554404; cv=pass; b=hLbfe6o4brj4vvvdExw/SkghDQT1KQMXgbldG8ywy0y2pHKG3uiCaKepRp84LruNyW7aTccqDRqrKZnkw6lCfj7zLQxplUr+mVGW/NR/7AGE+zRndMp14u3wKkSLeIZSc+Jdq6D9fiLX15gw9WFU6EdtTAByP00cqat3sE3N8XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720554404; c=relaxed/simple;
	bh=gz9D4T7EL0eQUEO+VMaoEGks/PkoD0WjPXMV2um+jwg=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HNVPiuQUfz41rR1bhNluzsQlYclzHPKL0bwamk86DrazCoEvXZUwnkg2g1Na72OY9PAeqoQ9nVDhXzSmxXUNb1DwvNr8Z4eG2lVbuPvnKo2mKSE12/l+k+D1rg1hsBFOeIBo2NmHIrWnbUSLIoCSw9R1VVnxFa+RnB16N6qzQrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bela.io; spf=pass smtp.mailfrom=bela.io; dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b=Zf1eGMSM; arc=pass smtp.client-ip=23.83.218.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bela.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bela.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b="Zf1eGMSM"
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id B79D62C30E7;
	Tue,  9 Jul 2024 19:38:26 +0000 (UTC)
Received: from pdx1-sub0-mail-a209.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 50F9A2C3F88;
	Tue,  9 Jul 2024 19:38:25 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1720553905; a=rsa-sha256;
	cv=none;
	b=IHik2g3euvumpSobTYFSaOLH98RqddcSHfMK8pV5nYE47OYAXcOWgUojSRMC9aOeOwVxIh
	lb9yW7U0wy98kqxp3IuQaZAI1cYGeRHoA63LMr4+/zuCvZ/3rUJ0q2Om3bs0mmNTR9U4oR
	iUbt9OMKKPIUw+tRj3ER3jHE4lLIImrllydeBKkGT8jQe7xUbijlQ97cKgI2MexkW5UkFI
	8+3cGVqnvD2oqyosoDE88fdyYi/qD5/o/5WUvojptvDcNFSFkKKlTf0+CvBJViz7vrWvzY
	TC84HnYhkDfphXK9ZdAdmYbDgMYGXilWZeY0iDh5EqJ7GKHUG8YaAS7vGC8HAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1720553905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=3SofecoZpua/J9bBPDmyIuLp3d8lDB5T6jDT1gmEQMQ=;
	b=Nxi2Y3iXCBYLYtcA6wsCdFCHnTZr+qisvoKq99aOs2k3nAU+iC3aD6/5Leuqf4M0Fgm1k6
	Vh7P+qLBiP1Coi/BoJ9NzyaLLKMC+D48a2zkM8kD6xNADCISX66+xkJIy2K8njcTWcEVDR
	qPE4yNvZfmCfdFIwjHGXwShOrtXgu0k2Eu6NXyL+JDL2Cgd+pKPwE3FzbInj8OVYYgWD2a
	K8I5LukIJUTvFM3UU3zT56XpidCHfjEYICZytyB5sywGP5KhNaDHKTrTwhHzOnbpV1Qgih
	toqZF8fgsGVNKYCuxsb4gTBCzkdiqnuntuzMu7a60rsBjYOGyxg4dSOhWPyZDg==
ARC-Authentication-Results: i=1;
	rspamd-6db77b4858-7wjsr;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Invention-Stupid: 1e20a85d3f3bcdfd_1720553905711_1624072568
X-MC-Loop-Signature: 1720553905711:3291949727
X-MC-Ingress-Time: 1720553905710
Received: from pdx1-sub0-mail-a209.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.117.230.9 (trex/6.9.2);
	Tue, 09 Jul 2024 19:38:25 +0000
Received: from giulios-MacBook-Pro.local (unknown [186.99.138.208])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a209.dreamhost.com (Postfix) with ESMTPSA id 4WJWW45nvLzRG;
	Tue,  9 Jul 2024 12:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1720553905;
	bh=3SofecoZpua/J9bBPDmyIuLp3d8lDB5T6jDT1gmEQMQ=;
	h=Subject:To:From:Date:Content-Type:Content-Transfer-Encoding;
	b=Zf1eGMSMUAcrkLd6xzKAewC5GPWUzyo+uujBGaTpQdJfAki4l7rQtZe7BghDBjicL
	 nrPk55MzfQ3FAeV+BbLugPBuQh3HrtzGryI0UUDCdvtdqCAQwuwxAWEZ9PZG02dTKs
	 VxMYjKdkp8wcmgS70riWFwho+L7MJTvzOrjE/1DO+Qeid3+epDAXT21lREObV5Ernh
	 YnHrOZTLs1V1Xa0YHscDchBUq663IilC/hG5OXUdWGAzsYLHi0uY8u/f36RDpU1bgH
	 N5u8juVRi4Uj1xXahJZpcONjvivJ+TiQQvSReCqoXyPuypmwVHt+4nO43lmRoy50Bx
	 bUjOy6UR4raKw==
Subject: Re: [EVL] xbuf preserving message boundaries
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
References: <63f65db0-f9e9-c720-940a-dd6276f93076@bela.io>
 <87plrmgybk.fsf@xenomai.org>
From: Giulio Moro <giulio@bela.io>
Message-ID: <b6fca6a9-8d69-9445-03a3-0b3ca6afa82c@bela.io>
Date: Tue, 9 Jul 2024 14:38:23 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 14.3; rv:91.0)
 Gecko/20100101 Firefox/91.0 SeaMonkey/2.53.18
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <87plrmgybk.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> Philippe Gerum wrote on 09/07/2024 14:27:
> Unlike the XDDP protocol, keeping message boundaries with the cross
> buffer - which is a circular FIFO buffer - requires to either use a
> fixed message size, or have the application code implement some variable
> length management at buffer level using some fixed header.

Thanks for clarifying that.

Another place where the idea that datagram-based communication on xbufs is available is advertised is at https://evlproject.org/core/user-api/proxy/index.htm :

> you could also use a cross-buffer for sending some wakeup datagram from the out-of-band caller to the in-band waiter. This is best if you actually have more data to pass on to the in-band thread than a discrete notification event.

This text and the one I reported earlier should probably be amended to reflect the reality of things and avoid confusion.

Best,
Giulio


Philippe Gerum wrote on 09/07/2024 14:27:
> Giulio Moro <giulio@bela.io> writes:
> 
>> (is this the right list? or should xenomai@lists.linux.dev be used instead?)
>>
> 
> xenomai@xenomai.org is redirected to xenomai@lists.linux.dev.
> 
>> This page https://evlproject.org/core/user-api/xbuf/index.html states
>>> A cross-buffer can be used for transferring fixed-size or variable-size data, supports message-based and byte-oriented streams.
>>
>> However further down it says:
>>> If you plan to send fixed-size messages through a cross-buffer and keeping the message boundaries intact matters, you should pick a buffer size which is a multiple of the basic message size, reading and writing complete messages at each transfer.
>>
>> Is keeping message boundaries possible only with messages of a known size (i.e.: it is not actually implemented and it's down to the user to do that)? Or is it possible to preserve message boundaries for arbitrary sizes? I am interested in achieving a behaviour similar to what was available on Xenomai3 via the  socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_XDDP) call.
>>
> 
> Unlike the XDDP protocol, keeping message boundaries with the cross
> buffer - which is a circular FIFO buffer - requires to either use a
> fixed message size, or have the application code implement some variable
> length management at buffer level using some fixed header.
> 
