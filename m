Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B602147F9
	for <xenomai@lists.linux.dev>; Sat, 20 Jun 2026 11:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781954231; cv=none; b=MWYXAKTrAYTJc61FP5wzj8+WEVBmdWaViEMpx5wkVJsK5BgO8JUaUhHQQtTnkzHXYg09vwW+tuLfrH1FY2eA9evjW8JfZPQW7pOF3Vly9unzB89qWKAkB9TVCa8w4aXgzLRAblQ3iU5o/js4/5kmQIyC1CI4+dOxwPElCIPFb+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781954231; c=relaxed/simple;
	bh=sBvbTKfKjGRIhYHDRrQ1Fz74MVQqv67pVeJGQfiNbKs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tkz+qOQtHV2oY0PQrDLbpHT6r4uigfrKO1KdzefBaW4R86MTRCU8o+S7z0Kpd4d9wXmVXXh5alD8OAJ8vtbQHlolrkVyWkiENgVxBX3TrNcfHLHspgKzSJAqIB/Lxxpirk9w80L0+PR3ZHx9f2indQAn9fLiIH2+WQdanGSURaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=YN3JiwCs; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="YN3JiwCs"
Received: by mail.gandi.net (Postfix) with ESMTPSA id CC3443EC43;
	Sat, 20 Jun 2026 11:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781954222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i5QUXsq+E+odyyEGU2tpc2EMe8JvGDxNz981uEwT5I8=;
	b=YN3JiwCsVL4+36fxrMhCJEpTrO2BmN60b5pWApTyosogqpHdSVnKeg0C/mCodrMUL//8q6
	GjptGyNq62fKfXkPnmJVIRgeHOWLL79awifKl/czEIf90eEn6aU//QcQjBAhxRFb8r/oOB
	a5tzTWfvLU/nsLkXAQ1QavvPiggd2W53razxiayQuXwpR6MbYJKle4rrDy/WmlvxSxD0bC
	Y0WnjotUbF1+LxzG3LiqKSFrJ9Rh1hy8fS7B335UTcO7OQ1gJWyzVbcRWs8lRIKlIhkmFn
	iKSEgacOAacZ7sVgzYSbYr8IRvtEk4PPXYROAbRIHYENcKdBIO3xmUTkhaWoMQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [libevl][PATCH 2/2] tests: sched-quota-accuracy: Add preempting
 FIFO thread
In-Reply-To: <87cxxlbik5.fsf@xenomai.org> (Philippe Gerum's message of "Sat,
	20 Jun 2026 12:41:14 +0200")
References: <83bfeeef-c3b2-473e-b94f-8d270b0a512c@siemens.com>
	<38c143a3-5021-4617-ab2f-ff3c9f3adc74@siemens.com>
	<87cxxlbik5.fsf@xenomai.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 20 Jun 2026 13:17:01 +0200
Message-ID: <87jyrta2c2.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTFzU1rpCZrahGB4kz047Vp9gsuTpEC4Fm2ZS23WZfvy9cyli8Elgs8pR4GGVp0YEpVowP4IlNe94FCg7Dtwm2RSa5T28lyBlBxJU5wShRJnrd3+A4/GKhF9z5ealPn3AYgXxlV5AqZ8UEVKenTVrPkm07fq7WEe6RpOjAdKCho6dMMX2wuTj1781yGc5kkQq5ekPwEx6UxHW8n2GUPkWztbByZ+//XsdRTz/4jAd4BtVDUS4aEtwitRE8RmLD5AIpbm2ln98M7gBWfF+HwtRBT1VkdT5a4NOggTv0NwsfJgCWB0L65/cm3vHDS9GBor3h1FypWriQUIdoPh1XmQ2YBHlqSVZx3Xkl3tExPqDkDVFCU3iZtzCWdN4Tnt5bavfHsfHOv/LCKLIyx6A5i094+TV8iwaNe5NKVES3JdF2okwYq7dBU4cIYyGuDhY4UITe3LvqEARjq/rZ4wj8hcRzhJeifDysh9fhSp0vm5hpMlhrvVQT/hCZfpjCfLwtbq1BgTTBX2EEaMkFm/NIzq3xN2nWzxo24sLT2xJ1YxS4LPhIU794tmUxN9UyDjHjYrFdvf3Lxui55m2ATrEBhE9IVMlct1Tq62AU8EbY1Gu1x2M2dbx/BhRrJejZZROUvMcntR1KeHbmMCbDk/zkGrn7iFZ7GkIdM9ZBAUtVFLvYRbOw

Philippe Gerum <rpm@xenomai.org> writes:

> Jan Kiszka <jan.kiszka@siemens.com> writes:
>
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Test that higher-prio SCHED_FIFO threads do not run on the bill of
>> SCHED_QUOTA threads and that their accounting is not otherwise
>> disturbed.
>>
>
> This patch introduced a regression when determining the accuracy of the
> policy with respect to allotting threads the expected runtime budget:
>
> root@phytec-mira-evl:~# evl test sched-quota-accuracy
> sched-quota-accuracy: 494.0%
>
> The proper result would rather be close to the following:
>
> root@phytec-mira-evl:~# evl test sched-quota-accuracy
> sched-quota-accuracy: 99.1%

Ok, I guess the fact that the calibration process does not factor in the
disruptor explains the full breakage we have with the accounting now:

root@phytec-mira-evl:~# evl test sched-quota-accuracy -- -v
picked CPU1 for execution
CPU1: calibrating: 893547 loops/sec
CPU1: new thread group #0, quota sum is 10%
CPU1: done quota_thread[0], count=150399
CPU1: done quota_thread[1], count=145636
CPU1: done quota_thread[2], count=141552
CPU1: 3 threads: cap=10%, effective=49.0%, disruption=49.6%
sched-quota-accuracy: 489.7%

Which does not make any sense since the effective value should be capped
at 10% in the above case, compared to the nominal (full) report which
should be:

root@phytec-mira-evl:~# evl test sched-quota-accuracy -- -v
picked CPU1 for execution
CPU1: calibrating: 899203 loops/sec
CPU1: new thread group #0, quota sum is 10%
CPU1: done quota_thread[0], count=26818
CPU1: done quota_thread[1], count=26709
CPU1: done quota_thread[2], count=35612
CPU1: 3 threads: cap=10%, effective=9.9%
sched-quota-accuracy: 99.1%

Dropping this patch from the -next branch for now.

-- 
Philippe.
