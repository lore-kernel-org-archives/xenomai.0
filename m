Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0DD1A6817
	for <xenomai@lists.linux.dev>; Sat, 13 Jun 2026 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781370232; cv=none; b=W/haVsZ70DKj5iiJQhzAAiOz6M5FBxxBNEyq92Rs7Bw53B+awCC/HYqH6FLe0mSb0wRuxgvcOUHHQlvdgW5twds7oXMevIRFbjTxo+gB+2QloRxADUqVzeQU6BLmQAMMhUzTQVos3jdq6ODAKQr+siFmFLV9e9c6FOS8mh4nGXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781370232; c=relaxed/simple;
	bh=JqQYH2y0QmX7QdbBzMf0wQwpumDwWQAXK9UiAeOUr+w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P1W9ASAlC6UDZvvxe18jPoaHhQhd0h89p5rUtEbB2GUhpKVBn6ml3Pg4Pl8dTzLvMM0h1Un2faxsJD29/VTTOyaCY/tTLAW+bJPL8ue4ruLcykQo2KmK1QirV0lmxrS7tTdM5zMXoOBzs+yhui3dLXcV84eLLifFs718UfMMhi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=a+4S1G0C; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="a+4S1G0C"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 55C683EE29;
	Sat, 13 Jun 2026 17:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781370219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YK18zPZx9Sq0fdJonjK1jDPR/LNAEUAdQQvMMLL1Bx0=;
	b=a+4S1G0CFUR2QNwN/4+tYs9Tgca+lG9c1iwRQUabzwpsvO5QH2UVAFPLs8nCct+ybp9D0/
	WYDaLq3uxo51ufEqUmFVWubH/vtH2M/hJLXIWiSWd6qXUX9lXv4ko+/gzDlTp5r7DmQ45y
	ookGzG+NJgcpw1cec8rhcbPBlC2TpeD30C3QYZgD7jal7bdIbcmuLqaSX/1+fbVVcl9LYk
	e8Kp93yc9tpAxD0YMLZeany+Jd/hGC2tN2YmDRVFmlRtw+l5s/YWPDau3m4JetmPFfO/Ym
	AW8eWdL1wS//MwjIy+3ftlus3Ql6oEhrIfRFkOKJIfHRt5jAzsYxiez/hO0zVw==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [PATCH linux-evl] evl/trace: Fix crash of evl_sleep_on tracepoint
In-Reply-To: <49aaf291-83f8-4943-970f-8d4699970bc0@siemens.com> (Jan Kiszka's
	message of "Sat, 13 Jun 2026 08:24:20 +0200")
References: <49aaf291-83f8-4943-970f-8d4699970bc0@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 13 Jun 2026 19:03:37 +0200
Message-ID: <87a4sytlsm.fsf@2a02-842b-4100-f601-1469-181b-22db-b4d0.rev.sfr.net>
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
X-GND-Cause: dmFkZTF/wW7jgINTLwWtMJprd19JnQ03Ci2+AREjfktKyX2kok0B2ner5+y+VyQwIj2ulEngVzQImc8hKFXGllIhPsIVOPvVNvQTHAQxHoHRsW1Qc7ONyKrky6MZu71RsiPXh1IHmByNQQDm+GLwghHyDLXfRYKcrddzHK6+hVc7/DKo9DLs3jKJ1FzkWbaztCeIbrP750KCrR6q/caaw016/kkDJbOrVYSQc+bmeNIykj9aaQUCHVAhmE3Q60mGojL2qTIZYDEezVmGT7vEGfO6zMrvzMUT72iO/N5Rn+3/N6VVfcNP2buOWowN6RHCunsn7dDz7KRIU+eyrG/roCbqVe+UqtXXqMMjMcjuylfTXC9ScHlOOl4RDtk4Ue/eLpwllAlAKVE5Giji0dB/fbTzSv8Xk8vFVWlJuwD2Xpk9jaN6XkbMH1kXVannN7vOnQK0XuQHBVy8lL5PiDYufaN3g6uH3X45xUcxozydlPAr24mKsvilPVl6YTVYQZAMmxzS9F+EAfBaNVybj1NdJhnOnkNP6qKPvXfM7zsUWn6o64r1TfEgPXhz+I160weoE2ZdWp4Hx/4SHNKCkklmZw3Z8pSkqQOg5PLjhEI5scqv74yjHpxQnjL4Q5Vp0HSuX8z9g2WiB4QWasTUxm85S4uxrAudwjmi4ZsKgZ3DoSTPs1BJsg

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> wchan can be NULL, and that will crash with tracing enabled.
>
> In contrast, clock cannot be NULL, thus does not need this guard.
>

Merged, thanks.

-- 
Philippe.
