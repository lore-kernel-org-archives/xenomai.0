Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0581B86D6
	for <xenomai@lists.linux.dev>; Tue,  9 Jul 2024 22:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.253
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720563922; cv=pass; b=nXe9O14h4mECbEnFXhcNMs7fhZ0dCXN39frznkYF5qQsXDN1mBjUkJVUfO/MCx1/7QAuvhfh6KnRO9ME7m4zAwEr79DYUR1J3zTz1Eg/Nixg0kFcG3OwBZl9vsqyG8DliW8x2olZk5KVLQ7mmeTgUmdavkx3HW/CaGq9bnS0qaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720563922; c=relaxed/simple;
	bh=K0YErLjBgEDBL5LdkZlEx+2IKECcL5cZi2fUKiNUc6E=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=acdhU1+3sAv5M3+7Yr2OGg/ojyIQGyR3QaNZCcmxtTNyQdMHLG7jpVkUEAvGOrYX7CKF76gkyq0q1uFAjynV7Mo4oNI0EIoO4QCqQwYDV6D8ySZI7coY6zv8ZQd3beEt6hKKhY2bJ22A2RVKfjHwU9abdG9GH9NQeURLjdqfzPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bela.io; spf=pass smtp.mailfrom=bela.io; dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b=TQFsS+lY; arc=pass smtp.client-ip=23.83.218.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bela.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bela.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b="TQFsS+lY"
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 7D63884685;
	Tue,  9 Jul 2024 22:08:01 +0000 (UTC)
Received: from pdx1-sub0-mail-a209.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 63420846DB;
	Tue,  9 Jul 2024 22:08:00 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1720562880; a=rsa-sha256;
	cv=none;
	b=Zc+mpXb7pg5M8XBRV7Dh92XaQ16ClW8dKAU+P+GVDEMtCMbVcaQmWel0z0AgJRJSITiEtC
	n54+Y2aFz8UXr1V9YDo6XL1es61blHlsEVh4PjmmpPU3ftGnJ99I7HrgIoYGdxMcnnoMjN
	7fqQsCcu/TWtA6fL0w/oIblot7TrKCDOKRPPkZwv1tkZ7VmxUjvhdiUT5vU0SRJwFBKc5H
	tb/haCxal+rdtnrMGjcEnFawUf5EPGp9l5z2PNi2rp86j4J/qc2NxKHK+61DZfd9IFjQa/
	XhlT7B0Kq+DNVmx6torLm/p6X9Ysml6QfjxIQLkSlE58wuBb43segIj7TU6xag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1720562880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=K0YErLjBgEDBL5LdkZlEx+2IKECcL5cZi2fUKiNUc6E=;
	b=x0EvH9+voieoz6aaMB41R7zux3W0UM76XzuS5rTKkdaMh9+knywkQsjQqhqE43xYbHwqgf
	Q+JChkDLXPY/cd0rSs9p/1o0qQ/4ZJrEM0HeYyEKAHJ84BYXNMsm/w/z/PmTCX9cCHFQjJ
	Yp0fMp6qmSfVzVckdg2EU/gSgZ/DcwP0GYDN0boZSxD4aKHuVlCoYIiTR2RcExMCd3DjC1
	nvjBc8R1ln//VP/ZG7NqRMPt6TQHI69krDBDdBlcQGh2FaCKbiDOzIDVdM/vxmcis+DiVF
	CUfYKM8VbdA25H5OLjJAj3m7GyvuLqhB/ZwyBv9Ch/IfcbEx1367Y0b3472xaw==
ARC-Authentication-Results: i=1;
	rspamd-7c4f8cbcf8-sp6m9;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Thread-Blushing: 2ad42e4161f645f0_1720562880626_3552138198
X-MC-Loop-Signature: 1720562880626:332100815
X-MC-Ingress-Time: 1720562880626
Received: from pdx1-sub0-mail-a209.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.123.177.199 (trex/6.9.2);
	Tue, 09 Jul 2024 22:08:00 +0000
Received: from giulios-MacBook-Pro.local (unknown [186.99.138.208])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a209.dreamhost.com (Postfix) with ESMTPSA id 4WJZqg68d6z1Q;
	Tue,  9 Jul 2024 15:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1720562880;
	bh=K0YErLjBgEDBL5LdkZlEx+2IKECcL5cZi2fUKiNUc6E=;
	h=Subject:To:Cc:From:Date:Content-Type:Content-Transfer-Encoding;
	b=TQFsS+lY9yW9fZGjS0X/SFYaYhySxq4lsBstXey+d0ywIE/JLMYmDu/VphCtIvOgq
	 qxqhAkPUyz50DuPfpaWbLXoFrXnBwYON5EeQYPE3WterV3tkHQrTtw6LN+bPsuCqiZ
	 k1C840QnTHVOBjn/fHYunYFe39a3RebBuQfSRfjf0C3+M8VSDV0T6acU4eyftMuJcv
	 8lgaeqmSPa3kiUS6qBkLcLI6cuLkUJ4cFWtv8XJl1KVjBJOmU9/b0ipm1hzb//sy9i
	 aPisgw9aU78RtwoJBUpADvX2TuqJ1Oms2LvZ5Der0ZPUrXBbHSsRYRZxgG2mAZIJAw
	 Q5MoZVll9kw8A==
Subject: Re: EVL documentations issues
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <7e4de8bf-c42c-7592-ee44-022d0e75fb68@bela.io>
 <87wmluff5e.fsf@xenomai.org>
From: Giulio Moro <giulio@bela.io>
Message-ID: <06cf758c-5d93-2304-203b-c4e0a242351d@bela.io>
Date: Tue, 9 Jul 2024 17:07:58 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 14.3; rv:91.0)
 Gecko/20100101 Firefox/91.0 SeaMonkey/2.53.18
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <87wmluff5e.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for getting the fixes in.

This one is still wrong:

> -EINVAL if usecs is invalid, i.e. not in the [1..1000] range.

It should be [1..1000000] ...

I am also wondering whether returning -EINVAL when the argument is 0 is the best choice. FWIW, usleep(0) returns 0. I believe I have seen code use usleep(0) as an equivalent to sched_yield(), which I guess evl_usleep() would be "for free" if it didn't do the early return for usecs < 1 : evl_sleep_until() would return immediately because `next` would be in the past. Similarly glibc (I checked 2.39) goes through with the sleep even if the argument is 0. I guess the rationale would be that no matter of short the sleep, it should always at least cause a reschedule. As this function aims "to match usleep(3)", maybe it's worth considering using the same approach?

Also evl_get_thread_mode() hasn't yet been removed from the function list.
