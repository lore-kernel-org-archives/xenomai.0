Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F651F4C96
	for <xenomai@lists.linux.dev>; Sun,  5 Jul 2026 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783263690; cv=none; b=TkghumVDMSXQ2eE3XKdlzQ7UzEXtmaeDM/d8PJMsO1+lb6BHd5fYmL0xxlPA+Sc0ed1nWNAjNrtiksrQw8m8C8jMoQgBlvZm/50dXQ4xzKjrR5NIunfxvy+sQRJW1lcyHKQ/Lm+pQLIzOide9TKKkmjg86EHvWOv6WBu4aqd7V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783263690; c=relaxed/simple;
	bh=popYnmTFabcGotrVWV6+Y+IaHV2BJw1CjOSGBhyDiRs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U9GqY0qS41ILxgrbfYmHWzk63pbYLvCgtCDLTdYTXwwGx0f3ptmo74orssDgO/App11jmPKAlPW2VXesxmungsNciyV/RXDQBlVaB1TGLFYZje1iRCGP3wW03deefBM7pUciruCtDZSLiiQZM9V8Tte0SPJVIVaS8PrDyBigpwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=ciMyEh4L; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="ciMyEh4L"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6B7533E96E;
	Sun,  5 Jul 2026 15:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783263678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nNuZlYC5xftf/3SiUzLM5u3HjQT80ESzoaKu8udYAeE=;
	b=ciMyEh4L5848jf0EVEo0UWS7Tbc/nAKtaGPoXzU3p2ecZwLykWuVv9EbZiCC5c9zgkZBuO
	7KU0odTvIkqfp0wLxl5ISVZBRs+FkeccNdNMQYCX9JE5bHjWqsoKNQSYEExk/3orwr9cCt
	6byKyd7402NrSw1alf6ku5MpJFfBt1tAUZ/nTg2Pdnj2W8wZCN0+CVdshTbhDyK17rwsZF
	x8U7mNDVYwjfa3bLa5c565BEt9d87NuFQZLoMNTwqEkAJNURjtqusy2QhGYP5IfPI+Ti4v
	3Mz8r9nog5uW1hqziGS4C9I54c5uiAqUKPoxZCpihsc0V3bOvxZDCy71hKJcqg==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH 0/1] tidbits: net-ping: add ping tidbit using raw socket
In-Reply-To: <20260628153956.1435330-1-hannes.diethelm@gmail.com> (Hannes
	Diethelm's message of "Sun, 28 Jun 2026 17:39:55 +0200")
References: <20260628153956.1435330-1-hannes.diethelm@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 05 Jul 2026 17:01:17 +0200
Message-ID: <87se5xmqf6.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGga3Km2k4N1TrkgFXHisLexpx4Zdgds5crb0+qkGIxdXvJXVSdeckvYxXTIMKQs3IMCnyAR19z2nh0XvbD+3Jm0gE9+yYzmRMa/6gWi660vg7Z+gpcwjqNZAJ/djbcBowlWKzO+iCMaTUWg3XUoP/VjhS20QnjQEUkvKqzyzsp8YeYp4ccwlyTlWuSwkXPylEFWGry3LwajbeCwEinFnLVyIFQyvH1VY4hbQnFjFOtPrEOAiURBuFQmhfRzUMsETvEFTtHKS/AO6rGcd3SJ67i3yYebP0pQ/QQaRQc+NtmVWF+9KmMDwrIS3q1RXz1CnIPjE14G7KGohuh8ehNlPqQhDIoHlVcsIbOZSOH6RHgXW/7N4iWmYKEYkoFvr9kNg98EwSaUenjXJEJV/ne+WBb6/409q+iy/ilkjLQJEV5qP1SrwbkKHrIOgqIJA/SoNcHL5OZIT1sYnA4opzu6Ls5RToA4yG4GxT4Y1v1CiqpBg3AWUWyV2thseeonC/LVu5vzOpaPUOi5IrtFetVAmyBCXZGoT5QJjmfoN4v6amiqlueV0QjRShR4xYPkn90/2TsvHvOzHn5qM0sUfWUm9jmDtf0EKYhs6eyKaGMK4wKD9/sKJip8eSdsLk7n+kVEqpIn0LmyGV1cRpUnLPhXHEoiTF0/hKrG0MmXHmGzSzHgQ

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> This patch is the result from experimenting with evl networking. I use it to do basic
> connection tests from the out of band network and check the timing.
>
> It is a bit complex due to evl doesn't support IPPROTO_ICMP sockets.
>
> Using the in-band network stack, you can use: sockfd = socket(AF_INET, SOCK_DGRAM, IPPROTO_ICMP);
> and then only send the icmp part of the message. However, such a support is not really needed,
> it works fine without.
>

This said, we have an ICMP protocol module in the evl stack since
recently, which only responds to ICMP_ECHO requests ATM, directly from
kernel space. Extending IPPROTO_ICMP by implementing the oob_sendmsg()
handler for it there has become an option.

-- 
Philippe.
