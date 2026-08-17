Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA6318DB1F
	for <xenomai@lists.linux.dev>; Mon, 17 Aug 2026 06:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786948515; cv=pass; b=uWGdde1AFjP61p77TVkbxfTsS2kzlparr1iAYGrkbU/ZLUkhSRF9jIqyt5BnbQqVUA193Jm8yg63spZT34bdeBYwXzE3t6k0vEQVuyPl8pVOFDEgEIPEDabQy3s/vaF9sOCUmiDeS+Bw0LiZtUy1uaBctL83ASaROdzT8uvD/U0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786948515; c=relaxed/simple;
	bh=dnhGxfX2CFMnwME23XZy9AXNRZ5Qm5+IHSNRFBR/njM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=iz50BRhmRSAu3kQ/KbBj0XzGhgSiMjuLTIKaBAQe2IWPTSREOoOsbBH3FAflS1uzqIwEkDgesx7G5bPfoWo7Uj3XBpwUp4FINkhkXEhWmIoJLE/ABrAoxs1hWPDmxQa6af2mrVbEVIfCqVS8oG1F1wM+PITpviNF1SXf1/GyYGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lmi3d.com; spf=pass smtp.mailfrom=lmitechnologies.com; dkim=pass (1024-bit key) header.d=lmi3d.com header.i=@lmi3d.com header.b=fVVje8Oq; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lmi3d.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lmitechnologies.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lmi3d.com header.i=@lmi3d.com header.b="fVVje8Oq"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15d111ca99so315323566b.0
        for <xenomai@lists.linux.dev>; Sun, 16 Aug 2026 23:35:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786948512; cv=none;
        d=google.com; s=arc-20260327;
        b=OvUfQhpAe7wD4BGELBUTmgnyzXWhwUnwPp6yqeyMMBa56KnpZ714CmvCDcEWRUajxd
         leAAM8YJgsiVCSKbkpTNeTgpMSZGwgI3RJ8INpAh+2cIOmHnA09PvFuJa+v4MsiMG3sr
         nq3dQ2x1AQU2iBgxpuWvhFSz9IQa1EczBIUBF0FQmA8s6J/q1eSHdqDnSnJRjESAgjau
         RvTfGB32/ZTsZN/hPbuUu94KQDJLklSBBNynqf5rcCkSjV87Pz1FrUaLHSNNmp9yzXrT
         /yoX+0q7c7+HeKS1PdAG+fH7hU8PuezT5bsjfav8HpuA6Tw2sZmipqDU5WLl9wlAnn8I
         sWaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=qSiamwU4q5LcQkoRc9hnJT78w30efABFLSMkR2iTSKQ=;
        fh=YB3B87WifQ96wNOuamgxI2TmGE/J/7vmGnp4rylPnkg=;
        b=DNFCI/nlujPOJV3BHPNtOoi0Jj0u36Sqod1hf9v+maPpbDZsr4LipunWXaC/E8CV5f
         Njlw0qagC0hTymqEjDECyQHn5y2oUp+8dcyoJ7IrfjBP/kCPJkZbvNF4u18eoh3wThY/
         13tZp2uzz4CkWtrORnGoRi9E0UzjTUepIy0Ao5BIH+jqZby+s6/pgPbS5gsWUpTqaB0Z
         HKz07fbN+XgxXK/C3TmD1JeHt59LhmOk1YaumCh90Ojoy6l2FtZaGcHiS1EEj41tPAxi
         QUaUXgsh5rGhFdWZ1p+UsJQtT3v+KvqDuOdWALzjEZQ2tv9Iogy8OzmS2zZ8CjxN9f9B
         j0xA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lmi3d.com; s=google; t=1786948512; x=1787553312; darn=lists.linux.dev;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qSiamwU4q5LcQkoRc9hnJT78w30efABFLSMkR2iTSKQ=;
        b=fVVje8OqroswlLa+aDnbagFRXTJ1J59vkesWBsWvEluk5DXcIRb0mFtHWIzOT6YcP9
         fw24qW+6B91jf74oA7bmmNY+KpLZsZcPtFxkoyZ1OW7A6VQUq1ETCSg/MTdoTho+L1Bj
         yiCkeF5VUt63rbGEWLLF6+BYWl8nYxCJV5kZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786948512; x=1787553312;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qSiamwU4q5LcQkoRc9hnJT78w30efABFLSMkR2iTSKQ=;
        b=oPI5SFDZ8/1ZYW/pKFI0TpBT/+MXMMd3rj+/RJ7xYU3HYbKgGe5LYWm/YYSGve9ZqJ
         YCsMlgQC7HReHZQkBxwLX0hnOTZFzjA1qw9QjX72+eFrT35A8g7f0lc0SYGvg1ZuDyv5
         ocTk3JqE9ucCDAobY/2F8xDpNd7erO9weZ75+MrmHUz7K5cKiVZJkZS9XI6T5j/Ar0O5
         I8qWQrYxZM4PgX3kkLB3aWbbsHC/1SwYxZxcwxXmHxWTfM/EgFsfsWT7PgiV6aXAjiZC
         g6zdemOXIgrDvUt46ybwSj4B366mx59MB9VjWfBsKH8Up2Qgi5pYktjY+EnptI7pyWM8
         oozA==
X-Gm-Message-State: AOJu0YwgCiWVobwFE2hSPn18sJYHl9dOa0DKjPMgiGMam0668bLsJZtI
	vXuuOVxznKdKx5aLJS14kJHcOalF45kk/vqpdIQd2st0k2nFPDjNrxjPA8dlrvdcm8j3McIxKDX
	aytOPBIkLx+NclayL9UtmRC2O0ZnFFUl/T71MYxPK6bAVGz0VfxYElJj9l8z7eptIBwg5wJduB5
	YUz7ocnb0U+ZKlFWOm5lviHrm2HgzY8cWHawZP1fVZtNL/jPyjG/wtY0a+GM20J1sl/zoIPgFYq
	fCOnLOfEQQumiM2rBnJZUZ+hGnRv+UTt8iNHIneTj/KdDAbCOQI
X-Gm-Gg: AR+sD11wWR8yDTI2RxEgDxKvGLqQerPO7Dui9dukvv8C6Q+/Dwtk0h9oZPAUTmln1X4
	di/EO17UWDOwyc6lYV7HeZaAZpEvQI16Nbs4I6GURjf/ISpM97pAN0zhbfzk1C9YOLcxmSaQjwM
	gJEg5TxIbYH8vZvRyZICH4t2XMeLbBzE6ZwdyNz/6etwt+6YQi3I/NMNlY8LOJwZueqqqy9Z050
	SrXlNbbQlWIzc2LszmWXNIt0mIYItoKuPhN2ReH/Mqk1zwMMFwp+3Pd5+b8aVs/2OaQfKPMMVdL
	Xg3OkpZsHpC53pnpcmTmR4U0O2Tui+q7NG3D2KysQp1uCcDDQbL+4MP7EKBATe3O+Lmb8crjeUu
	UgTBZY4fDsQy5l8+dc+QmYIZQ0QGIOlPg8PnhjBvI445QDyi17I0yTybf2hTiHVc=
X-Received: by 2002:a17:906:9c95:b0:c20:f529:2d6a with SMTP id
 a640c23a62f3a-c212a309111mr987686566b.22.1786948511858; Sun, 16 Aug 2026
 23:35:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Gerte Hoogewerf <ghoogewerf@lmi3d.com>
Date: Mon, 17 Aug 2026 08:34:44 +0200
X-Gm-Features: AcwNN1V2ZydDAZwrdGip6pPUG_MqEEppqseW2OJ9yMRXkCz1HR3NgvMDF9Bz6MA
Message-ID: <CAKndYJGo5Yu7Ak694tX=cqRjtJneXs22DPjz=UDVkUcNJMWyOA@mail.gmail.com>
Subject: The state of Xenomai 4 on Xilinx Zynq-7000 (or ARM32 in general)
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Xenomai team,

At LMI, we are in the machine vision industry, where some applications
require predictable and bounded ISR latency.   Although we are
gradually migrating our installations to Xilinx Zynq UltraScale+, most
field installations still run on the older Xilinx Zynq-7000 SoC.

We've been running Xenomai on our customized Zynq-7000 boards since
2021 or so.  Our products have been shipping with Xenomai 3, ipipe,
kernel 4.14 all this time.  Although it still runs and performs well,
the age of the stack is starting to affect security certification.

On multiple occasions, I've tried newer versions of Xenomai.   The
most recent version that still functions properly was kernel 5.4 (i.e.
the last version to support ipipe + Xenomai 3).  I was never able to
successfully boot anything newer than that version.

It typically hangs partway through boot, like this:

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 6.18.29-01121-g5d9e6ccea5cc
(ghoogewerf@NLKRLTF0FQR04) (arm-none-linux-gnueabihf-gcc (LMI3D G++
11.4.1-p1) 11.4.1 20240321, GNU ld (LMI3D G++ 11.4.1-p1) 2.40) #2 SMP
PREEMPT EVL Mon Jul 13 12:06:58 CEST 2026
[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=18c5387d
[.....]
[    0.815404] io scheduler kyber registered
[    0.820358] zynq-pinctrl 700.pinctrl: zynq pinctrl initialized
[    0.831589] dma-pl330 f8003000.dma-controller: Loaded driver for
PL330 DMAC-241330
[    0.839180] dma-pl330 f8003000.dma-controller:
DBUFF-128x8bytes Num_Chans-8 Num_Peri-4 Num_Events-16
[    0.857446] brd: module loaded
[    0.865454] loop: module loaded
[    1.260102] Freeing initrd memory: 5620K
<======    HANG    ======>

The peculiar thing is that either "CONFIG_EVL=n" or "CONFIG_SMP=n"
works around this problem.  But that's not a good solution for obvious
reasons.

I am curious where Xenomai 4 stands regarding support for Zynq-7000
(or ARM32 in general).  Are you aware of problems with these older
boards?  Is there anything we can do ourselves to debug this further?
We are happy to share the full boot log, kernel config, and device
tree if that would help.  Any guidance or support you can offer would
be appreciated.

Thanks,

-- 
Gerte Hoogewerf
Senior Software Team Lead
LMI Technologies
Wiebachstraat 25b, Kerkrade 6466 NG, The Netherlands

-- 


This
email and any attachment(s) it may contain is confidential and is 
intended
solely for the use of the individual(s) to whom it is addressed. 
If you are not
the intended recipient of this email, you must not take 
action based on the
contents, nor distribute, nor expose any part of the 
content(s) to entities or
person(s) beyond the original distribution list. 
Please contact the sender and
delete the email if you have received it in 
error. Thank you.
