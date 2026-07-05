Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC27B3587DE
	for <xenomai@lists.linux.dev>; Sun,  5 Jul 2026 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783263865; cv=none; b=A//N3ia9dPidzTuSb68dcOqFdK7YpFE8zxuKg+c2uu2ddHysQSlAXbUggGF+vPQK+Po/H59yJ2xTOg6jOZ5vnM9S/uPs24xUS7R9IbpKxLjae5QZQNU6bRiu5tb3xor8ueYKoMbJYsP9vW1dHxGV7tqnsA/0Z3XS6JlyL9Abgmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783263865; c=relaxed/simple;
	bh=MBWUs2RCt3Iq+adF96QQynehSW9aHK2cjaMXm/cqNbQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=krh6wgfIVNlG5Ns2lIaRZwIhvewCcrmFn+NWHEAsYT5f5dKeD+M1vc0+qhJMZrwdJ/lSHeT2vHG2UMHK748W2xPRn5au9SKUmIZFQUkalkVf19ioEK+J57NAm/cPDb1TB87WzDZa8Z0MqWC0rupKxXB64PNadbS+BWKMrz7NQAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=o6U4D2N7; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="o6U4D2N7"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 08C573EC21;
	Sun,  5 Jul 2026 15:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783263856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YUgswGX4qkjZBiT4tqPgx96OW4G8yJvKLnQAhdNPkIE=;
	b=o6U4D2N7Q/Am2NIgCuYvRQchntIzddzRT/CmoFG5DGH3v5OGmsrXwfRr5cAhyOh+J+WsPG
	pyDzeUdVDpwehO5UOmwD9NAvu377yDxSYVN/QT7QWPeZkaOiW+HzLJyTTZ+qC19K5tamFo
	9sph/xkvsWXhJq3tNkDyXXqR8uJMRg+RenGSTeQBbBNWfxX4Zpao50y1Ak4C+/+shMRRc2
	ReCtdjj+5Z0gq6zVHwg7TLYqcEsuVYrsbXXyQDqhUhCWw3fl8F6lrhcVVoJ40dYhzF/Jqi
	MmLKds6JmoyU4t4cKfC4wY+baO8Fnjjho99qnKXlZO853y2eK7JxecbPUL48YA==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: EVL: Kernel WARNING
In-Reply-To: <b5821b4e-cfd9-4255-ac8f-3de55a788d1c@gmail.com> (Hannes
	Diethelm's message of "Sun, 5 Jul 2026 14:00:41 +0200")
References: <c88ccba0-23fd-4f4c-a182-0967e79adefb@gmail.com>
	<b5821b4e-cfd9-4255-ac8f-3de55a788d1c@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 05 Jul 2026 17:04:15 +0200
Message-ID: <87mrw5mqa8.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTF2XSMSrSgCpRaYEvqL82fCMLW4EZY9v3lp6+UDpptikKGnbnnGjAe7d2b7jOl6E6w98lhUZG0Ti27DDdqlOlbXWHk6NRjgCpx7XChJDPuVAVc0YBK/hV/XWcyGIJYBhxst7HpcKHRIl18whIYZUlzLOF5hxEAR1Hf58VkX76WkikOhQ44ApslDTcWOdiiSYnim3jRS6S7dr3mlbqthNBGixZWFSRSlJRb886ZfMvsoHGsOV6YE0X+jel8MZAfpdamy6tVqI4LJOgD2lZpH6x/K6C7EwJ8hQozUC7pF+v2vHNK40xSSCrcC42gdHxqsL7AcoH9x3/xCb5vyNz3W400CeD0A0Xre2SKVr8OebnskzRPxekTtNhvBKUoGaVhuTpP4fRXHQ1DBsxoSF+pTnaoeeYWj7J8oZWanuxx+YGnUtuLWll2gNUiz95gvGXf8cYD8ok1/lyLjtz1gJibELjpKoAMu63eEX+BNMmMCp076UJlSEY7eyau1lNoDr/QO6JlsPtvBnv0TSTUo8WHbeA+6Obez/kr2hB+M3piebJs7GT5crvnPVuIgaVZrlf4D/dzpgC2d5Z6Ckx7HFj5rjbDgePAvlWKrdC+waFCID2wgiunhrjM+evPhgRjCatx8JU64fjJxBngvdqePBri/XMx5NeJrajAZ/U+LcDFKya8UNg
X-GND-State: clean

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> Am 04.07.26 um 20:05 schrieb Hannes Diethelm:
>> Hi
>> After updating to the lastest v6.12.y-cip-evl-rebase, I have a
>> kernel WARNING in the igb driver if I use my oob-net-icmp.c (Patch
>> submitted)
>> Exact commits good...bad:
>> linux-evl efed612...55591d4
>> libevl 3e5577d..f7b7df4
>> Regards
>> Hannes
>> ...
>
> Update:
>
> - It fails after ~240...253 packages. After that, no ping response is received any more
> - I use "sudo ./oob-net-ping -i enp7s0 -a 192.168.122.1 -w 1000" so it fails faster
> - Also without -w 1000, it fails, you just have to wait longer
> - With an I350 card, I get the kernel WARNING
> - In a VM with an e1000e, I don't get a warning but still after ~250 packages, no response is
>   received any more
> - After evl net -di / evl net -ei, it works for another ~250 packages until it fails again
> - With the good version, I tested ~1M packages, all fine, max 60 us response time on the real PC

Ok, I can reproduce this easily with oob-net-ping as you described. This
also happens with an (arm-based) FEC driver, which confirms that this is
a generic issue - maybe in the packet protocol module? - not a driver
specific bug. Working on it.

-- 
Philippe.
