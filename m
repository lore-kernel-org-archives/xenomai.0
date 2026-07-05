Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B6E2F7F11
	for <xenomai@lists.linux.dev>; Sun,  5 Jul 2026 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783270006; cv=none; b=IcjLF58Zq/45/1LfDv/177g27etYLDjV5mO0B7ZBu/ACahXs5yuqGFXoN93PPeLRRYO+3PDvV+9x2FJH2hWLD5dTpOvWISNY0qbNRKqYk3CAHsngUJdHNzMxI5RfIVvBlWTQms+DUPP6+NcsVwJ1hwXrqoU5P1ZFb5OAVLmAuo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783270006; c=relaxed/simple;
	bh=81+UbEnTlYLaUPzcEVwO7gY+vXw4f9HC0vnmk1cWO4E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NvPBUa2tsYRVugUOWOeZBTvOPkoaETDBClxpsEls7J5jhhBtrKAw/ESQlzfuMhzOvhKM/aCnggUGoJ8zYe6j8OZIpOmosdAQKccwvOj8F2iuPqbqL7SxbVXO8Xmeg+el0qcIj/3D7V/RD58ACSzebUQgOUrJcTCOkoPUEPLZiKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=D18cWrPU; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="D18cWrPU"
Received: by mail.gandi.net (Postfix) with ESMTPSA id A416C3EDA1;
	Sun,  5 Jul 2026 16:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783270001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CsvOBEYiu3rFsjwU5Lpx5jod1Pcwbjp87egBFYs0WcA=;
	b=D18cWrPUMmnfI94hDLmRIku3WcrIeQ3ajEzeNUqUAunujAf7IAGgChiTUKo+YgiEn0k779
	NgT9Pnw/VH30stbIY3B+SVmA0NCvQWd9LiVeUDV0jwmY2W8EPVleGE7wOgly4QS4MDHUe+
	PfL2Hmh4EZFjWQHwbtz/yoYQaY3i7xjtLdjUqCYnNseikeLiPZIEc1C2N+DSkIdYxtcJMi
	bBMo+OKHcx+VyYyQKQ1YOpJNViaewMxhoT61+yeJe6lNAFcDnCy3bJmMqPM0DYT2R8xdx7
	GAvwOZh6b/LOFES+UHMW+NfCNSVKfwivX3K8pRJDJywpcDhXB9xpEjdG8g9JgQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: EVL: Kernel WARNING
In-Reply-To: <593465e6-53c2-4f54-8d4f-745b028ff289@gmail.com> (Hannes
	Diethelm's message of "Sun, 5 Jul 2026 17:17:37 +0200")
References: <c88ccba0-23fd-4f4c-a182-0967e79adefb@gmail.com>
	<b5821b4e-cfd9-4255-ac8f-3de55a788d1c@gmail.com>
	<87h5mdmq6w.fsf@xenomai.org>
	<593465e6-53c2-4f54-8d4f-745b028ff289@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 05 Jul 2026 18:46:36 +0200
Message-ID: <871pdhs7tf.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTGKFkUWszyPij413g+2LoExTrMERvdPSfu4ExBhWLhPblREczAi+4SGPNDWTXTaQ9UZXWg5rGbwcTwp3DYYlKRgbczA/2dpZVTgDWtSjgALes8DiEPs7971YD7MfB5NVZbUModdASyraf+TG51XNOzL2o27qu2h3ldZ+GUJSckRZNKRxv1M6rzF1KKAqlTOsNDmbs1uB2DVKQ9OhNgupvba1z1bkd6hd9KpUeXUZfKaWz32RsgdKilqSRQN62Erzk07fxNb7yW0j20DK7JNerEMrRk0tDZyDqdcbsfzourlP203H4/QqfVIfNQrbJAdhGKkik8Wxk4CrfgcHAzHPr9UP/+/hcjGMoBGvb9jtnestX14DbCEYXbOa6oM0BQad/LgIUc6zjO3RBZ8MhM5DwUHZaLvIsP6tM/42Mj9QGiME2ZqIkVZYjtF+G56y2DMRPSR1NesT9qbpocmgGj/YWsoC3y3qw4COYhMEo9WIJOLB/oHOqoyFG2yvB4TVfngr96MDTwAMIBWArFMlH/qLshOcCspieTWcZFLr/zbiE56TieF+M0I20qr81Z2Y4L7W47IRk64AU1N96ROrzrL7o0v9vZeS2TTm4wooHdO8OKANaK8I6fGSYjE4A3j4wCGydkQWRAkE+2cvzldoh5c884AIuhqozEJ5epW6hEeGQ+3+A
X-GND-State: clean
X-GND-Score: -100

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> Am 05.07.26 um 17:06 schrieb Philippe Gerum:
>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>> 
>>> - With the good version, I tested ~1M packages, all fine, max 60 us
>>> response time on the real PC
>> You mean 60us for the overall round-trip time between two
>> evl-enabled
>> targets in full/end-to-end oob mode?
>> 
>
> That's between an evl-enabled host and an FPGA board as a target[1]
> directly connected with 100M Ethernet and an Intel I350 after some
> heavy tuning. Most tuning was done for PREEMT_RT. I have to test what
> is really needed for Xenomai4 and what can be dropped.
>
> I don't have two PC's to test (yet).
>
> https://store.mesanet.com/index.php?route=product/product&product_id=374

Ok, thanks for the information. Meanwhile, I found the culprit. Now I
have to figure out why I did that. Oh, well..

commit a793acf3cab9a608d70a39d740f04c6a6a1ec77c
Author: Philippe Gerum <rpm@xenomai.org>
Date:   Tue May 26 10:16:44 2026 +0200

    evl/net: packet: forward status of ETH_P_ALL delivery

-- 
Philippe.
