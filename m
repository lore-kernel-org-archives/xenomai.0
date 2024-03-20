Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDF485C70
	for <xenomai@lists.linux.dev>; Wed, 20 Mar 2024 21:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970570; cv=none; b=LnUgS2fFrAu7gGx77NtKHOC78c4SeQboyVd2ewyQG7omyyId0NRxTuC9kaFwTiJLmSmSPHNYZkAc/p15yW41KdEOsjYYnfGz5opkOKm6ReA/qJtBZoys9ubVThjFHO0Lo300sqOnamNbFkwc3fkN/6UWoJvrjujcNuy902bGSGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970570; c=relaxed/simple;
	bh=0sDMRpSl6tjnVWnNCMKtmzjWcKcOWPTzxX/6hnrrpCQ=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=RBX0bKdWYbESSMq9ETCVeyFTYQDDSXRGoenTwTgm/hFwM6Rrk2f7kHYZRDcWM6G6g6fpUP34UHooPH5BVa85Yqv29On65z2g4rWGZLUZDYdxbSAgRy8C9qfccWveadhz6IHNI1HAZXYr2sMNawHAKaIz74mSWcCTlR5GBEQswtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33ec7e38b84so158209f8f.1
        for <xenomai@lists.linux.dev>; Wed, 20 Mar 2024 14:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710970566; x=1711575366;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BpZcOMm0H7qvQRHZZl4C6DVdDAhFTbj9HLH4tDJre4=;
        b=d5PSYrGDMRBNFzxH/6hzuwDp9wyTsDRuajSdInLkjK37MB6inWG/a11EobR2tucT8u
         cU7UC+rOY+va+1J6ImG9edaOWBfRbEFVOC4iKIdw619JRxOTAZuoFigR7p2rAjqn/gsP
         7xDDlsLSLREBPERvkHonoKaMQf6L+jeZ0UIse2ikigEI8JbYMJv5Ah9qnplNcefW9E7/
         BUPM/guljxeT4Z2xrk8qCq/UJoESPQcU8CLnF3xuwDJR+InbmiF3++8ihhy64d7Wn3MR
         Z93biXtPhbG7VbLc1VUaru3SjPfGc9dMecYP4m5a72SrZCVU94wGRJfTxr22aPTnP13Z
         s6/Q==
X-Gm-Message-State: AOJu0Yytn6qg0vlqGQYTeGI51L533zKgliWV3ZDPFKitr/V8Crt3BAj+
	8J5x14jIcC6wM6wVyqzod1NKQ3sRp7m3dcohlYj2WJuJSuNRuSRBpsEC/CS1
X-Google-Smtp-Source: AGHT+IEKARxXlBDrIgXJFZPhd5UmXlmqG9R0Z8OdERFQsg5nld/DAEs/eRs6eiamg4VMPka3RvU4Yw==
X-Received: by 2002:a5d:5224:0:b0:33d:5f98:82e3 with SMTP id i4-20020a5d5224000000b0033d5f9882e3mr188892wra.13.1710970565673;
        Wed, 20 Mar 2024 14:36:05 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id l15-20020a5d410f000000b0033cf4e47496sm15514332wrp.51.2024.03.20.14.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 14:36:05 -0700 (PDT)
References: <DM6PR04MB538655375C57CF07EDDE5089E2242@DM6PR04MB5386.namprd04.prod.outlook.com>
 <DM6PR04MB538673AA2E912100093BBA7CE2242@DM6PR04MB5386.namprd04.prod.outlook.com>
 <DM6PR04MB53864A2698B4F2147B79413CE2242@DM6PR04MB5386.namprd04.prod.outlook.com>
 <87bk7kwu9z.fsf@xenomai.org>
 <DM6PR04MB53868485664BC9374914AC69E22A2@DM6PR04MB5386.namprd04.prod.outlook.com>
User-agent: mu4e 1.10.5; emacs 29.2
From: Philippe Gerum <rpm@xenomai.org>
To: "Rosenow, James" <jim.rosenow@mts.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: Hang at "loading initial ramdisk ..." on Generation 11 CPU, Gen
 9, 7, and 6 work.
Date: Wed, 20 Mar 2024 22:25:06 +0100
In-reply-to: <DM6PR04MB53868485664BC9374914AC69E22A2@DM6PR04MB5386.namprd04.prod.outlook.com>
Message-ID: <87jzlwfuwv.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


"Rosenow, James" <jim.rosenow@mts.com> writes:

>> "Rosenow, James" <jim.rosenow@mts.com> writes:
>> 
>> > We have a COM express carrier with an on-board SSD.  The SSD has
>> > Ubuntu 22.04 installed on it, on top of that, I've installed the
>> > latest Xenomai (master) alongside the 'v6.5-dovetail-rebase' kernel
>> > from the linux-dovetail repository .  Given that our board supports
>> > COM Express, we can easily swap between various processors and have
>> > been doing so looking for the best price/performance ratio and of
>> > course, low latency.
>> >
>> > I have two modules that I am currently testing, an i3-11100HE and an i7-
>> 9850HL.  Since the SSD is on the base board, I'm running the exact same
>> version of Ubuntu, kernel and root file system regardless of the installed
>> processor board.
>> >
>> > The gen9 processor boots and runs the Xenomai kernel without any
>> > trouble at all.  I'm having SMI issues but that is another subject.
>> > When I put the gen11 board on the carrier, it hangs at 'loading
>> > initial ramdisk .'.  It is noteworthy that if I interrupt grub and
>> > select the stock 6.5.x Ubuntu kernel on either, both gen 11 and gen 9
>> > boot and run fine.  I've verified the Xenomai kernel runs fine on
>> > generation 7 and 6 CPU's as well.
>> >
>> > I've searched the web for possible reasons why Linux would hang at that
>> point; for Linux in general, it is a common thing and I've tried many,
>> many of the solutions that others have found to work, all to no avail.  I
>> do not know how to get additional information on what is hanging as there
>> is really no context from which to proceed.
>> >
>> > I'm looking for suggestions on next steps to root cause this hang.
>> >
>> > Thanks and regards,
>> > Jim
>> 
>> Could you boot the machine with the stock kernel that works, then paste
>> the output of /proc/interrupts? This may help finding out which IRQ
>> controller might be involved in the issue.
>>
>
> Hello Philippe,
> Here is the output of /proc/interrupts from the stock 6.5.0 kernel.
>
> $ cat /proc/interrupts
>             CPU0       CPU1       CPU2       CPU3
>  134:          0          0          0          0  accel_3d-dev0       accel_3d_consumer0
>  136:          0          0          0          0  als-dev1       als_consumer1
>  142:          0          0          0          0  magn_3d-dev3       magn_3d_consumer3

Could you disable these features before retrying?

CONFIG_HID_SENSOR_MAGNETOMETER_3D
CONFIG_HID_SENSOR_ACCEL_3D
CONFIG_HID_SENSOR_ALS? (maybe.. there is a truckload of light sensors).

If the issue persists, disabling all IIO drivers could be a sensible
option to confirm that there may be an issue with some irqchip those
drivers depend on when it comes to dealing with Dovetail.

-- 
Philippe.
