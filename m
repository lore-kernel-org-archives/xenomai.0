Message-ID: <48B2AC6E.9060100@domain.hid>
Date: Mon, 25 Aug 2008 14:58:22 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20080812075358.4cg1ix9945msccsc@domain.hid>	<48A12EA8.4070601@domain.hid>
	<48A34D75.9090509@domain.hid>	<48A359D4.9090002@domain.hid>
	<48A3D20B.2080509@domain.hid>	<48A3D595.9040607@domain.hid>	<20080814125307.1uviqgmj95no4k0k@domain.hid>	<48A43555.3070701@domain.hid>
	<48A45084.3000208@domain.hid>	<48A46408.7010602@domain.hid>
	<48A6B8EC.8020302@domain.hid>	<48AA9DAA.3040801@domain.hid>	<20080819123133.n9ool6j5d5msowk8@domain.hid>	<48AAD622.8030402@domain.hid>
	<48AB32B8.5040403@domain.hid>	<48ABE629.5090303@domain.hid>
	<20080825141624.3hk4ndxf9xwcgkcg@domain.hid>
In-Reply-To: <20080825141624.3hk4ndxf9xwcgkcg@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [RTnet-users] e1000 & MSI
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: bernhard@domain.hid
Cc: adeos-main <adeos-main@gna.org>, rpm@xenomai.org, RTnet-users@domain.hid

bernhard@domain.hid wrote:
> Zitat von Philippe Gerum <rpm@xenomai.org>:
> 
>> The risk in ironing those PCI locks is to run with hw interrupts   
>> disabled for a
>> long time, inducing pathological latencies, so running RTAI's latency test in
>> the background should help detecting those peaks.
>>
>> However, we may find nothing bad if the kernel uses the MMConfig   
>> access method
>> to the PCI space since this is basically fast mmio there. But since   
>> you seem to
>> be running on x86_32, we may want to check whether BIOS or direct   
>> access to the
>> PCI config does not raise the typical latency too much, as well (I'm  
>>  unsure that
>> PCI_GOBIOS will give us decent results though).
>>
>> To sum up: with different settings for the PCI config access method in "Bus
>> options" (by order of criticality, MMConfig then Direct, then maybe   
>> BIOS), does
>> the latency tool report pathological peaks?
>>
> 
> Hi Philippe
> 
> I played with the different PCI configurations and the results are  
> devastating. Latencies (and jitter) skyrocket after some minutes of  
> testing and peak at several milliseconds. I didn't do the regression  
> with 'normal' INTs though, but that's something up next. Additionally  
> MMCONFIG produced some strange msg at boot.

Could you catch some path traces with the ipipe latency tracer when this
happens? See [1] for details. Dunno if RTAI's latency tool is prepared
to support you here (triggering a trace on new peaks), but
CONFIG_IPIPE_TRACE_IRQSOFF should already suffice in this case - if the
latency is due to IRQ disabling over PCI code.

Thanks,
Jan

[1] http://www.xenomai.org/index.php/I-pipe:Tracer

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

