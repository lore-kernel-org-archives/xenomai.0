Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1572DFF3F
	for <xenomai@lists.linux.dev>; Sun,  5 Jul 2026 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783264246; cv=none; b=d76txA6V+qNY8rsAS6dShkjMWshZYsSxDbgdhUyqT46pMXb1+iZlj6fF0yP2Ksn8/cF3t1P3R4XRqRTOCWRF+4Z80PxCCzAfY4PwgKN8DokjXoyn998JGwXqK2/4krfCvWqSCAJc7ncChHiGZ/pAHuv6BZsdcnwgTh7Cp3JabBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783264246; c=relaxed/simple;
	bh=o85OHqcAaM3oosZrxH74HmJzHDJj8awlq5hiyQJlVvQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AkQoNIIa3gQMdA2G1a5g43qoiCzOusfNznN/rGKO3jO5zv+FD77gGyRX/4EdKM657J4r3uN6dxYH+m8QuEAedJ504DbrfneyFxk25DOh8uU1ycT4wYs6FUqSNGD6UG1VrIyKcVBRvM1fl6QpmceSBEy7isjnAK/VrKjmsB+t7cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=irBAmLIZ; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="irBAmLIZ"
Received: by mail.gandi.net (Postfix) with ESMTPSA id C23463ED92;
	Sun,  5 Jul 2026 15:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783264242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RjBNo7ws1JTMQTlZL6C8RmvHnhEqCj634rPmmQdqa5g=;
	b=irBAmLIZ7czrgd9t4bvk+gPzOPBN7tHnE+qvVIdAUjUvgavaYo1APUNAFE3dfHTip8lEXB
	1ThdMNMo4v0J/8dwxMOhdzLOYAJzmiuNICCE2PUP0ZPt5fY48VnDFBJ+5ZhuXVl/ZH5Ipg
	fV/uSbub9nvWb96zcRHkHl7b0v9Q3FUPrhjRrJF1kPO+PS6MzuYHu4Fk9iskJnGXLGR2bc
	ZF95Oip1xdAvRY5kIP+HcfpnEaf2h7LGy/KbATAjcXyiYNFqljyIn8I+xbq7jkhHad2VfU
	CIYj2g+6IKgPG/Um3MGaEn8XJZBib2IbdewE6NqzyY18KrPnTXcGYtjhuz94IA==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: EVL: Kernel WARNING
In-Reply-To: <87mrw5mqa8.fsf@xenomai.org> (Philippe Gerum's message of "Sun,
	05 Jul 2026 17:04:15 +0200")
References: <c88ccba0-23fd-4f4c-a182-0967e79adefb@gmail.com>
	<b5821b4e-cfd9-4255-ac8f-3de55a788d1c@gmail.com>
	<87mrw5mqa8.fsf@xenomai.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 05 Jul 2026 17:10:42 +0200
Message-ID: <87bjclmpzh.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTF2XSMSrSgCpRaYEvqL82fCMLW4EZY9v3lp6+UDpptikKGnbnnGjAe7d2b7jOl6E6w98lhUZG0Ti27DDdqlOlbXWHk6NRjgCpx7XChJDPuVAVc0YBK/hV/XWcyGIJYBhxst7HpcKHRIl18whIYZUlzLOF5hxEAR1Hf58VkX76WkikOhQ44ApslDTcWOdiiSYnim3jRS6S7dr3mlbqthNBGixZWFSRSlJRb886ZfMvsoHGsOV6YE0X+jel8MZAfpdamy6tVqI4LJOgD2lZpH6x/K6C7EwJ8hQozUC7pF+v2vHNK40xSSCrcC42gdHxqsL7AcoH9x3/xCb5vyNz3W400CTYqC9gHS6destyxQLp4T7uUYS0v5TjAXrOb10q7Gv2pmEnYhCjRrbeKav03fmrhETssOve4QkJez8qPlyPmWjCZmC/LqAGAqSjPoIAcmHqmPdZ+OQnZEh+NT/BF3zYZPDiFz1W/5Xm4UltsmjeEJpSUxCKODAHLJsBDmd0lzDKHGLUrioeDCy1APaA2fL9YhZfushRXQszsuJFVn2LUg3AFMJqupSQgNPp13Bwe8QMq7u07fqZLfuT/e9DC3s8IbbqhCji+sFmnjj5/7xBmilIsCDlDGJmaGp8IblV4HVgRgIRWGxsJf7Q2LW6T8oH/DmDU3QWbpVM6WEvDYXSsz9A
X-GND-State: clean
X-GND-Score: -100

Philippe Gerum <rpm@xenomai.org> writes:

> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>
>> Am 04.07.26 um 20:05 schrieb Hannes Diethelm:
>>> Hi
>>> After updating to the lastest v6.12.y-cip-evl-rebase, I have a
>>> kernel WARNING in the igb driver if I use my oob-net-icmp.c (Patch
>>> submitted)
>>> Exact commits good...bad:
>>> linux-evl efed612...55591d4
>>> libevl 3e5577d..f7b7df4
>>> Regards
>>> Hannes
>>> ...
>>
>> Update:
>>
>> - It fails after ~240...253 packages. After that, no ping response is received any more
>> - I use "sudo ./oob-net-ping -i enp7s0 -a 192.168.122.1 -w 1000" so it fails faster
>> - Also without -w 1000, it fails, you just have to wait longer
>> - With an I350 card, I get the kernel WARNING
>> - In a VM with an e1000e, I don't get a warning but still after ~250 packages, no response is
>>   received any more
>> - After evl net -di / evl net -ei, it works for another ~250 packages until it fails again
>> - With the good version, I tested ~1M packages, all fine, max 60 us response time on the real PC
>
> Ok, I can reproduce this easily with oob-net-ping as you described. This
> also happens with an (arm-based) FEC driver, which confirms that this is
> a generic issue - maybe in the packet protocol module? - not a driver
> specific bug. Working on it.

I forgot to mention that this issue boils down to a shortage of buffers
to convey ingress packets, which explains the behavior once
triggered. Some memory leakage in the packet layer seems to be at work,
because it does not trigger when spraying the receiving target with
ICMP/UDP requests.

-- 
Philippe.
