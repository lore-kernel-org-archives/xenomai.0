Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937D3248873
	for <xenomai@lists.linux.dev>; Tue, 24 Feb 2026 14:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771941703; cv=none; b=QTCeZBo1aO006jl9znBPrzIzg9XJXx6GGxiVjUqw+fBbloEjXkyHqVr6VfNEcytv5PHj6UBE5FGPAMOeYjmkWOULXrrqBH8f3RbboMJXe+L8GKyQ96usrs0ouXTdDazeZ4HBdMUx5N4IMWsI3BHR3yM4BpajvOULiF3I6xQDXvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771941703; c=relaxed/simple;
	bh=PYAah/bRF3oaamk3yNjOM291J+QwM2ZlJtk29/RUbso=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qamGkMg/bv27KsQtwNtGkjo0zntm3ph/UWTRDknJO/qzjG+iPnitWkqT7VSLA7STdBmZs9BVb2kHAq35pY4Y9Sl7ygh1dqbpmoAnDW5iO0X7aQtWEuq3Zsbv2SLUIrbRRIALC+v9DTAGS6NAtvDfW5nePElHLTq+IAiJ9uPLOO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=QAaGpxDy; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="QAaGpxDy"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 21BFC205F9;
	Tue, 24 Feb 2026 14:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1771941693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/VaKyb9g9c0y2J4zIPM88kbMVT0DauFPuF1UlpVtE0c=;
	b=QAaGpxDyDhdGLl420b7evosskyTTldkGeosq6otFyIZ87Pj6NxFrTP54ycXD52g+7A7Q9j
	v/uDO7cVAlMPVdCGAwE23ubiNf0hL6NxleRz6oHgjUm3vCneoW3nZgTHEXFHKY2y7QQhIb
	8Xuz/txSbodeiNiihHCZ0W3Ii9N4hexgPZ+DuL/21iKlMkLQqETl99X4i2jutCVIevEU4C
	Dn78vYOebdBe94gm3CJLWzlJ0JlCqNvMLlpMM2/XIV//hZjokHPX2d066kU0BF4iM/KPbo
	jrFyIS8Plhl3rcXdJ+dMfKq9MbITAb978m7kMBvBQKUvW8Q0hSQiGPAqMsAS/g==
From: Philippe Gerum <rpm@xenomai.org>
To: Giulio Moro <giulio@bela.io>
Cc: xenomai@lists.linux.dev
Subject: Re: evl ps cpu time reporting issue
In-Reply-To: <ae5e9ded-d9c9-92f2-7652-22d63340c988@bela.io> (Giulio Moro's
	message of "Fri, 20 Feb 2026 14:22:46 -0500")
References: <21b140ef-69b2-6dbe-f12c-c4c46a28a67e@bela.io>
	<ae5e9ded-d9c9-92f2-7652-22d63340c988@bela.io>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 24 Feb 2026 15:01:28 +0100
Message-ID: <87wm02s0jr.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedtfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepvdduuefhvedvtdehhfelpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepvddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepghhiuhhlihhosegsvghlrgdrihho
X-GND-State: clean

Giulio Moro <giulio@bela.io> writes:

>> The most crucial one is that sometimes it reports excessive CPU usage, e.g. (running watch -n1 evl  ps -st):
>>  CPU   PID   ISW     CTXSW     SYS       RWA       STAT     TIMEOUT
>> %CPU      CPUTIME       NAME
>> ...
>>    0   1011  6640    31157     37608     23656      W          -         1193652.1      0:642.101    thread:947:0xffffb3c0fe30:2214587712
>> ...
>
>
> I forgot to mention that most of the time this thread reports 0% usage as expected. To confirm this is not an issue with libevl's visualisation, but the issue is somewhere deeper, one further log:
>
> # while sleep 0.1; do cat /sys/devices/virtual/thread/thread\:8011\:0xffff97cdfe30\:2491661632/stats; done
>
> 8926 41873 50471 29419 609329129 0
> 8927 41875 50474 29420 609388012 11133
> 8927 41876 50475 29420 609410796 0
> 8927 41878 50477 29420 609451945 0
> 8928 41880 50480 29420 609481429 0
> 8928 41881 50481 29420 609498449 0
> 8928 41883 50483 29420 609535063 0
> 8929 41886 50486 29420 609574946 0
> 8929 41887 50487 29420 609592925 0
> 8929 41889 50489 29420 609632058 1
> 8930 41891 50492 29420 609663628 0
> 8930 41892 50493 29420 609680457 0
> 8930 41894 50495 29420 609717002 0
> 8931 41896 50498 29420 609746761 0
> 8931 41897 50499 29420 609766180 0
> 8931 41898 50500 29420 609783920 0
> 8932 41901 50504 29420 609836897 0
> 8932 41902 50505 29420 609858481 0
> 8932 41903 50506 29420 609887230 0
> 8933 41906 50510 29420 609946013 20581947
> 8933 41907 50511 29421 609971602 0
> 8933 41908 50512 29422 609998161 0
> 8933 41909 50513 29423 610025640 0
> 8934 41912 50517 29424 610095202 5239
> 8934 41913 50518 29424 610113607 0
> 8934 41914 50519 29424 610137617 0
>
>
> Best,
> Giulio

Can you please add this patch to your kernel? This may help in figuring
out which input to the calculation is wrong.

diff --git a/kernel/evl/thread.c b/kernel/evl/thread.c
index 41c7505384ffc..3c1b08bb62b8d 100644
--- a/kernel/evl/thread.c
+++ b/kernel/evl/thread.c
@@ -2619,7 +2619,7 @@ static ssize_t stats_show(struct device *dev,
 			struct device_attribute *attr,
 			char *buf)
 {
-	ktime_t period, exectime, account, total;
+	ktime_t period, exectime, _exectime, account, _account, total;
 	struct evl_thread *thread;
 	unsigned long flags;
 	struct evl_rq *rq;
@@ -2650,6 +2650,8 @@ static ssize_t stats_show(struct device *dev,
 
 	raw_spin_unlock_irqrestore(&thread->lock, flags);
 
+	_exectime = exectime;
+	_account = account;
 	if (account) {
 		while (account > 0xffffffffUL) {
 			exectime >>= 16;
@@ -2662,13 +2664,13 @@ static ssize_t stats_show(struct device *dev,
 	} else
 		usage = 0;
 
-	ret = snprintf(buf, PAGE_SIZE, "%lu %lu %lu %lu %Lu %d\n",
+	ret = snprintf(buf, PAGE_SIZE, "%lu %lu %lu %lu %Lu %d %Lu %Lu\n",
 		evl_opt_counter_read(&thread->stat.isw),
 		evl_opt_counter_read(&thread->stat.csw),
 		evl_opt_counter_read(&thread->stat.sc),
 		evl_opt_counter_read(&thread->stat.rwa),
 		total,
-		usage);
+		usage, _exectime, _account);
 
 	evl_put_element(&thread->element);
 

-- 
Philippe.
