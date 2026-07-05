Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0B137F002
	for <xenomai@lists.linux.dev>; Sun,  5 Jul 2026 15:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783265007; cv=none; b=qrnUAzliUQ/Jay+oDK3aCBw368M9YwaiZesbZlF6m6qfZP9XN16gB9tCmeOtuwYhekSfan0e7RepRiVMzNKfMtXa+JIqvO+zoVowEg9/x1aAeHN0qtXZOLOjOcl6WNM1xTT5uQk0jzvk3JKzO4zKvfeH6oqxs59V23V6bUVOVsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783265007; c=relaxed/simple;
	bh=MiaLz7VgX07KuLYqsKwyCkIebC6ErPUid3+82OXVpv0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GGHN4Brfty2tZPDYcvJ7Paw+sLZGNPvyNYJxhtgbI4xYm3dStk89JmVjukfmY6pCSsnn+dVfBTKxz3dqKtGc/VTndl+w9Gi+xXU3Pj0g3e+Ps928BHwVd6NjQaiKgj06XD5TQGgg3XG2pxyCDHsTCPJFjNsMGpuPw+vj7uwgHiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=P5T9S6gj; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="P5T9S6gj"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 3CC4D5805DB
	for <xenomai@lists.linux.dev>; Sun,  5 Jul 2026 15:06:24 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8E0131F416;
	Sun,  5 Jul 2026 15:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783263976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GSodneQvUhJoQWYdgdtYHbH+I7PJ8iMi6D8ikQhMnIs=;
	b=P5T9S6gjRuPBw4nQmSqrTxlf/JpoEKiWkWJ8XeX4o7ADvSBDekDP2slwWS4WqjljPx6Ahg
	HcNDE76I8uSlFHt86vb2TORUaP3KV/E9uPYK/G7XUZXQFAA+qJ0XZd1t7/eHsZynpU086w
	m4rQxi3JKeOYgnAMiQJ4psQRhcOQouvwAJ9vXRrT5K3aL7+0EgbMGa6FAW8L2/fL1EWs/q
	0n4wvTAfEwNx+fx2f1YWnk/x42WADmaXSZDupjAgdag7iWffuiTCDJ3/GFDR5KNVSROmsk
	I8Tn5iVZXONDi279XIP6LPwC9sQ/NoK0eYHfILzcr18Nr2T7JWgC/mGhdzqWaA==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: EVL: Kernel WARNING
In-Reply-To: <b5821b4e-cfd9-4255-ac8f-3de55a788d1c@gmail.com> (Hannes
	Diethelm's message of "Sun, 5 Jul 2026 14:00:41 +0200")
References: <c88ccba0-23fd-4f4c-a182-0967e79adefb@gmail.com>
	<b5821b4e-cfd9-4255-ac8f-3de55a788d1c@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 05 Jul 2026 17:06:15 +0200
Message-ID: <87h5mdmq6w.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTF2XSMSrSgCpRaYEvqL82fCMLW4EZY9v3lp6+UDpptikKGnbnnGjAe7d2b7jOl6E6w98lhUZG0Ti27DDdqlOlbXWHk6NRjgCpx7XChJDPuVAVc0YBK/hV/XWcyGIJYBhxst7HpcKHRIl18whIYZUlzLOF5hxEAR1Hf58VkX76WkikOhQ44ApslDTcWOdiiSYnim3jRS6S7dr3mlbqthNBGixZWFSRSlJRb886ZfMvsoHGsOV6YE0X+jel8MZAfpdamy6tVqI4LJOgD2lZpH6x/K6C7EwJ8hQozUC7pF+v2vHNK40xSSCrcC42gdHxqsL7AcoH9x3/xCb5vyNz3W400CIR6SKB8E5/FNoiRMnqZwTsWdg0nHACHc7jb8y3tRA4brsy6jJlLi5YGjUv2YirZaMWakP9vD195MrJ4O4ciPBX8/4Mmo3uFSk6kHSYjjOvg5aXBZMynLdroAWaU23XfzdP1pdhTHrQ6gPqaMAK5UifUqC2zjlj3A4pkIwp1NBDqP1ENd16V0P97J9DNZL3oUNer3lnxOf87TAEfzSYL3heFHddOv5uhzCLFp/urL0hpX/7aIuiBpIC44t1MI2L3wCp3dU/M+SZwg909LC9x/eVwzXo6tYwFrxgKWNK8TT5ewKAw1BrYNRjHT0Vt4LlT9DUya0CCym5KycdsZAo/RqA

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> - With the good version, I tested ~1M packages, all fine, max 60 us
> response time on the real PC

You mean 60us for the overall round-trip time between two evl-enabled
targets in full/end-to-end oob mode?

-- 
Philippe.
