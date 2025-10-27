Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0162031326B
	for <xenomai@lists.linux.dev>; Mon, 27 Oct 2025 16:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582313; cv=none; b=kpPzyBOCRyBMUKODj415pvb7XxqdfG20rxksxcRaaNhD0Vxg0hzPVd9UcRPCBL0odtq2F1AO1+SIMzx1NJce3TbDyAlS8nhLV015s9HgQCe/4l9C0IwxhoPLzbLmhpc4WNUsm5fnmu0D1oIx3rFiNkV5gavovp2teA7Hs51Tgao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582313; c=relaxed/simple;
	bh=/x9tR0vnfsJ4pYvHksMUuhtUGlyQEnL5Q2xTNngU7Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OqnVLO1YUXTG1zpbAInHU1QssImhnIkSvl3xghP+tQhhK7Uc5Hy/vk57O03fHrS+C7vtvKLsl4zi774VV2UIDd6edyNdtewVXittUDIv18pdnALQj8SBBvnYEvH7D8bBSGUYMsgDikAxmuZP+gDrL5zK2977aRFECHinWyzeCFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=KzNta/yZ; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="KzNta/yZ"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9DCDA1015A9;
	Mon, 27 Oct 2025 17:25:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1761582308;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=szosOMkljtsX3D1NjsEUbI/o+nWWaA3M9Y93lE6D+ik=;
	b=KzNta/yZkjGLBef6692Yq5xQuRDavzQ3EfD4c1rD1qYTLiIENRzjaV4c/Y0UGu//oCab5T
	DQvkLajCn4Js5yT7JchmKwxpXsRA+3hZmm5gq0g9MsPw1QjXIyigtAIuhAakbo9D7T6tYO
	utKqET3Z+C1al1/uonXSFnS4pEdB8YqgkePv51aHENyJ4eMKUzv7I/4wut0eSKlbG7D5ME
	iQK4vJkAdPljeWkb0eZfWBkaSM8sEDnbMVAiPtp804z8MC1EaeDm06k5fQ6Ut3eyrCaynL
	y138jwDSA3sRc9TSBZ/OiBSK7TNo35aooC8kmLFFBkC0272ldaAZiugglBzaQg==
Date: Mon, 27 Oct 2025 17:25:05 +0100
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Giulio Moro <giulio@bela.io>, Xenomai <xenomai@lists.linux.dev>
Subject: Re: Unexpected switches to in-band
Message-ID: <20251027172505.29eecfb2@wsk>
In-Reply-To: <20251027120535.7933c720@wsk>
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
	<20251009151737.0d03b211@wsk>
	<20676160-4572-d92d-4b33-ff4255946345@bela.io>
	<87qzv9sa9c.fsf@xenomai.org>
	<87ikgls9kh.fsf@xenomai.org>
	<f916d01d-2bd0-cdfd-2e9e-562968a9934f@bela.io>
	<20251020094705.2ac256f2@wsk>
	<9d2bacac-8d70-f083-e926-21beee2207c2@bela.io>
	<87o6q1ad07.fsf@xenomai.org>
	<20251023155439.0170f987@wsk>
	<87a51djuor.fsf@xenomai.org>
	<20251027120535.7933c720@wsk>
Organization: Nabla
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Philippe,

> > so either some
> > traces are missing,  
> 
> I will check if I can add more tracing.

On one console:
---------------
evl trace -eirq -f; sleep 1; latmus -c 2 -p 1000 -P 99


On the second one:
------------------
test_prog/stress_prog_NO_IO &
sleep 5
test_prog/stress_prog_NO_IO &

echo 0 > /sys/kernel/tracing/tracing_on
evl trace -p > Xenomai4-ISW-trace-6.6-logs.txt

First trace:
############

The relevant dmesg output:

[   75.214527] EVL: timer-responder:743 switching in-band [pid=745,
excpt=14, user_pc=0x77d08492a5fe]

When I do look into logs - there is also a "hole" when the ISW is
reported by dmesg.


However, there are some hints when we look around evl_latmus:

timer-responder-745     [002] d.~2.    75.868139: evl_latspot: **
latency peak: 18843.649 us **

On CPU 20:
stress_prog_NO_-752     [020] ...2.    75.868139: folio_add_lru_vma
<-__handle_mm_fault

Which ends with folio_add_lru()...
And after that we do have the ~18ms latency peak.

And the "folio_*" is a relatively new feature added to Linux kernel [1].

The logs can be fetched from:
https://nextcloud.swupdate.org/index.php/s/EjHo5EAwMTeY5ya


Second trace [*]:
#################


[ 1610.086961] EVL: timer-responder:768 switching in-band [pid=770,
excpt=14, user_pc=0x72e9d35af5fe]

<idle>-0 [008] *..1.  1610.076068: rcu_dyntick: Start 1 0 0x2ec
<idle>-0 [003] *.~1.  1610.102242: rcu_dyntick: Endirq 0 1 0x404
<idle>-0 [003] *.~2.  1610.102242: arch_handle_irq <-arch_pipeline_entry
<idle>-0 [003] *.~2.  1610.102242: irq_to_desc <-arch_handle_irq
<idle>-0 [003] *.~1.  1610.102242: ma_read: mtree_load  
	Node: 00000000c4071949 (0 18446744073709551615) range: 4355-4355
<idle>-0 [003] *.~2.  1610.102242: rcu_oob_prepare_lock <-mtree_load
<idle>-0 [003] *.~2.  1610.102242: __rcu_read_lock <-mtree_load
<idle>-0 [003] *.~2.  1610.102242: __rcu_read_unlock <-mtree_load


Now some questions:
1. Why '~' (i.e. oob stage) is on CPU=3 as we pinpointed execution
   of the 'latmus' to CPU=2 (and the command line has isolcpu=2) ?

2. The mtree_load() is called in the OOB context... IMHO, this shall be
done before we do start the latmus?

3. In this case - there is also a "hole" between the ISW time
(1610.086961) and the ones between rcu_dyntick: Start / Endirq


Link to the full log:
https://nextcloud.swupdate.org/index.php/s/nPRAnqCLFDibX6r


Note:
[*] - All ftrace options enabled in the kernel


Links:
[1] -
https://github.com/torvalds/linux/commit/49f8275c7d92?spm=a2c65.11461447.0.0.68003853Pbec3R

-- 
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschftsfhrer : Stefano Babic
