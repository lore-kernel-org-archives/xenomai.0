Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E92633062
	for <xenomai@lists.linux.dev>; Wed, 20 Mar 2024 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970667; cv=none; b=S0IvXX0rOVUOdhroc/ZFYrmCvIZ2omPB4tqMYfVclBMcfbwxLn2U+ms7ypgTebHdbXIAnMQ0uODmPRLnDWAntwXl4LEIBAD1G7LC1FHnYpcZaH4xl6mlslETc23NsTH5/RShQsLJxQb9gFcnO7Gnz9ax7+KuVTolimJGfbv0q/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970667; c=relaxed/simple;
	bh=PBlDkny6wz1sTKb8IHGOXksmBTnQvpok4EXnqoA7CWc=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=A3ubX8/WJOygqOCLXJu9yMgaBpJEd935SCWpW6IB5okuJMNWriSEtIlxK2PshNy5PZiHuhxNwo2PxmnifiGf87aNn6dxue17i0I7dFXDEQM+MS/6Zv5qe4h7uGbh6gpE+pbBlaKQ4xMso/3Sbr0ZP4G/+Vx7OjJqECGcF2vJGsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33ed4dd8659so897521f8f.0
        for <xenomai@lists.linux.dev>; Wed, 20 Mar 2024 14:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710970663; x=1711575463;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7O6ZnHgcNeZg4RZU6i1LgGPjbdY6zdLlBP6/cAOGePQ=;
        b=rQMoa4gSzt+4+XuvbFGdEYW2CsJC95kA8LXBJKsmxWPvbO8bTRljLUK8xtjx0S/aJv
         26OY+XErwLaq4BY9QTh4qPoONBNRS6C+EoHeK4sTzf+koaiVFKUOwqclkIHLOdn0enaH
         XqUvZOe0/hefWmQoYn08umu6Q+rljZ2T4kz45HQ8VCp666BSVYMcP701pEFD6V3j3Y4B
         2Hg0aEcmL+FKTJwaT9wiMrHggVdGANcEoPTynC3t3HoPxfj6sePSUapFN4SDNcH8WTKu
         ut0sQe9S0JaLea9XtoJbhgsK8x1wzU8IuthsQNb7pTJaVu8SePV84dWblPnQk8BGwP8q
         OswQ==
X-Gm-Message-State: AOJu0YzHCkyMjGojj3A8+uhVWGK17M9V8QmxZpZyntW3xp6C00QuObVG
	9akZaccU+bH3xK1QWW3aw5/uG8lC2KBqnOXBeeRQxT2tMsUpHcz2zsaurJMU
X-Google-Smtp-Source: AGHT+IHH08VKQNxavzAQ5ASrxnJK4msZS2RQ7t6vevarDtlSd4gKlLp76TavCD4ed5vxT+MvMszWLg==
X-Received: by 2002:a5d:6250:0:b0:33e:d2f3:cbff with SMTP id m16-20020a5d6250000000b0033ed2f3cbffmr698736wrv.23.1710970663406;
        Wed, 20 Mar 2024 14:37:43 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id u17-20020a5d4351000000b0034180f6d3cfsm6158663wrr.73.2024.03.20.14.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 14:37:43 -0700 (PDT)
References: <DM6PR04MB538655375C57CF07EDDE5089E2242@DM6PR04MB5386.namprd04.prod.outlook.com>
 <DM6PR04MB538673AA2E912100093BBA7CE2242@DM6PR04MB5386.namprd04.prod.outlook.com>
 <DM6PR04MB53864A2698B4F2147B79413CE2242@DM6PR04MB5386.namprd04.prod.outlook.com>
 <87bk7kwu9z.fsf@xenomai.org>
 <DM6PR04MB53868485664BC9374914AC69E22A2@DM6PR04MB5386.namprd04.prod.outlook.com>
 <DM6PR04MB5386D31E1CB453165917BD24E22A2@DM6PR04MB5386.namprd04.prod.outlook.com>
User-agent: mu4e 1.10.5; emacs 29.2
From: Philippe Gerum <rpm@xenomai.org>
To: "Rosenow, James" <jim.rosenow@mts.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: Hang at "loading initial ramdisk ..." on Generation 11 CPU, Gen
 9, 7, and 6 work.
Date: Wed, 20 Mar 2024 22:36:25 +0100
In-reply-to: <DM6PR04MB5386D31E1CB453165917BD24E22A2@DM6PR04MB5386.namprd04.prod.outlook.com>
Message-ID: <87cyrofuu1.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


"Rosenow, James" <jim.rosenow@mts.com> writes:

>> > "Rosenow, James" <jim.rosenow@mts.com> writes:
>> >
>> > > We have a COM express carrier with an on-board SSD.  The SSD has
>> > > Ubuntu 22.04 installed on it, on top of that, I've installed the
>> > > latest Xenomai (master) alongside the 'v6.5-dovetail-rebase' kernel
>> > > from the linux-dovetail repository .  Given that our board supports
>> > > COM Express, we can easily swap between various processors and have
>> > > been doing so looking for the best price/performance ratio and of
>> > > course, low latency.
>> > >
>> > > I have two modules that I am currently testing, an i3-11100HE and an
>> > > i7-
>> > 9850HL.  Since the SSD is on the base board, I'm running the exact
>> > same version of Ubuntu, kernel and root file system regardless of the
>> > installed processor board.
>> > >
>> > > The gen9 processor boots and runs the Xenomai kernel without any
>> > > trouble at all.  I'm having SMI issues but that is another subject.
>> > > When I put the gen11 board on the carrier, it hangs at 'loading
>> > > initial ramdisk .'.  It is noteworthy that if I interrupt grub and
>> > > select the stock 6.5.x Ubuntu kernel on either, both gen 11 and gen
>> > > 9 boot and run fine.  I've verified the Xenomai kernel runs fine on
>> > > generation 7 and 6 CPU's as well.
>> > >
>> > > I've searched the web for possible reasons why Linux would hang at
>> > > that
>> > point; for Linux in general, it is a common thing and I've tried many,
>> > many of the solutions that others have found to work, all to no avail.
>> > I do not know how to get additional information on what is hanging as
>> > there is really no context from which to proceed.
>> > >
>> > > I'm looking for suggestions on next steps to root cause this hang.
>> > >
>> > > Thanks and regards,
>> > > Jim
>> >
>> > Could you boot the machine with the stock kernel that works, then
>> > paste the output of /proc/interrupts? This may help finding out which
>> > IRQ controller might be involved in the issue.
>> >
>> 
>> Hello Philippe,
>> Here is the output of /proc/interrupts from the stock 6.5.0 kernel.
>> 
>> $ cat /proc/interrupts
>>             CPU0       CPU1       CPU2       CPU3
>>    0:         15          0          0          0   IO-APIC    2-edge
>> timer
>>    3:          0          0          0          2   IO-APIC    3-edge
>>    4:          0          0          0          2   IO-APIC    4-edge
>>    8:          0          0          0          0   IO-APIC    8-edge
>> rtc0
>>    9:        611        154          0          0   IO-APIC    9-fasteoi
>> acpi
>>   14:          0          0          0          0   IO-APIC   14-fasteoi
>> INT34C6:00
>>   16:        699          0          0          0   IO-APIC   16-fasteoi
>> i801_smbus, intel_ish_ipc
>>   18:          0          0          0          0   IO-APIC   18-fasteoi
>> i2c_designware.0
>>   27:          0          0          0          0   IO-APIC   27-fasteoi
>> idma64.1, i2c_designware.1
>>   29:          0          0          0          0   IO-APIC   29-fasteoi
>> idma64.2, i2c_designware.2
>>   30:          0          0          0          0   IO-APIC   30-fasteoi
>> idma64.3, i2c_designware.3
>>   31:          0          0          0          0   IO-APIC   31-fasteoi
>> idma64.4, i2c_designware.4
>>   32:          0          0          0          0   IO-APIC   32-fasteoi
>> idma64.5, i2c_designware.5
>>  126:          0          0          0          0  PCI-MSI-0000:00:0d.0
>> 0-edge      xhci_hcd
>>  127:          0          0          0      21855  PCI-MSI-0000:00:17.0
>> 0-edge      ahci[0000:00:17.0]
>>  128:          0          0          1          0  PCI-MSIX-0000:04:00.0
>> 0-edge      enp4s0
>>  129:        371          0          0         35  PCI-MSIX-0000:04:00.0
>> 1-edge      enp4s0-TxRx-0
>>  130:         36          0          0        310  PCI-MSIX-0000:04:00.0
>> 2-edge      enp4s0-TxRx-1
>>  131:          0         36        334          0  PCI-MSIX-0000:04:00.0
>> 3-edge      enp4s0-TxRx-2
>>  132:          0          0        285          0  PCI-MSIX-0000:04:00.0
>> 4-edge      enp4s0-TxRx-3
>>  133:       1681         74          0          0  PCI-MSI-0000:00:14.0
>> 0-edge      xhci_hcd
>>  134:          0          0          0          0  accel_3d-dev0
>> accel_3d_consumer0
>>  136:          0          0          0          0  als-dev1
>> als_consumer1
>>  142:          0          0          0          0  magn_3d-dev3
>> magn_3d_consumer3
>>  150:         49          0          0          0  PCI-MSI-0000:00:16.0
>> 0-edge      mei_me
>>  157:       5552        319          0          0  PCI-MSI-0000:00:02.0
>> 0-edge      i915
>>  NMI:          1          0          3          3   Non-maskable
>> interrupts
>>  LOC:      25207        348      30717      29537   Local timer interrupts
>>  SPU:          0          0          0          0   Spurious interrupts
>>  PMI:          1          0          3          3   Performance monitoring
>> interrupts
>>  IWI:       2162         11        119        207   IRQ work interrupts
>>  RTR:          2          0          0          0   APIC ICR read retries
>>  RES:       2902        326       3213       2405   Rescheduling
>> interrupts
>>  CAL:      46790       5794      43018      41150   Function call
>> interrupts
>>  TLB:        273          0        258        149   TLB shootdowns
>>  TRM:          0          0          0          0   Thermal event
>> interrupts
>>  THR:          0          0          0          0   Threshold APIC
>> interrupts
>>  DFR:          0          0          0          0   Deferred Error APIC
>> interrupts
>>  MCE:          0          0          0          0   Machine check
>> exceptions
>>  MCP:          1          2          2          2   Machine check polls
>>  ERR:          2
>>  MIS:          0
>>  PIN:          0          0          0          0   Posted-interrupt
>> notification event
>>  NPI:          0          0          0          0   Nested posted-
>> interrupt event
>>  PIW:          0          0          0          0   Posted-interrupt
>> wakeup event
>> 
>> > Also, you may want to check whether enabling CONFIG_IRQ_PIPELINE only
>> > (i.e. w/o CONFIG_DOVETAIL and therefore no Xenomai on top) still
>> > causes the issue. That might help pointing the finger at either a
>> > generic IRQ pipelining issue, or something related to the tick device
>> instead.
>> >
>> 
>> I will try this today and respond as soon as I get the results.
>> Regards,
>> Jim
>> 
>
> I can confirm that the system hangs with "CONFIG_IRQ_PIPELINE=y" and "CONFIG_DOVETAIL is not set".
> This is identical to the original failure.
>

Ok, so this points the finger at irq pipelining. Something may be
missing in some irqchip driver to support this.

-- 
Philippe.
