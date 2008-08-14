Message-ID: <48A44E50.5040506@domain.hid>
Date: Thu, 14 Aug 2008 17:25:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20080812075358.4cg1ix9945msccsc@domain.hid>	<48A12EA8.4070601@domain.hid>	<48A34D75.9090509@domain.hid>	<48A359D4.9090002@domain.hid>	<48A3D20B.2080509@domain.hid>	<48A3D595.9040607@domain.hid>	<20080814125307.1uviqgmj95no4k0k@domain.hid>
	<48A43555.3070701@domain.hid>
In-Reply-To: <48A43555.3070701@domain.hid>
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
To: rpm@xenomai.org
Cc: adeos-main <adeos-main@gna.org>, RTnet-users@domain.hid

Philippe Gerum wrote:
>> (ipipe_check_context+0x94)
>>   |  +*func                    0 find_next_bit+0xa (__next_cpu+0x1a)
>>   |  +*func                    0 __next_cpu+0x9 (ipipe_check_context+0x88)
>>   |  +*func                    0 find_next_bit+0xa (__next_cpu+0x1a)
>>   |  +*func                    0 __next_cpu+0x9 (ipipe_check_context+0x88)
>>   |  +*func                    0 find_next_bit+0xa (__next_cpu+0x1a)
>>   |  +*func                    0 __next_cpu+0x9 (ipipe_check_context+0x88)
>>   |  +*func                    0 find_next_bit+0xa (__next_cpu+0x1a)
>>   |  +*func                    0 __next_cpu+0x9 (ipipe_check_context+0x88)
>>   |  +*func                    0 find_first_bit+0xa (__first_cpu+0x12)
>>   |  +*func                   -1 __first_cpu+0x8 (ipipe_check_context+0x66)
>>   |  +*func                   -1 ipipe_check_context+0x14  
>> (_spin_lock_irqsave+0x1e)
>>   |  +*func                   -1 _spin_lock_irqsave+0x12  
>> (pci_bus_read_config_word+0x36)
>>   |  +*func                   -1 pci_bus_read_config_word+0x14  
>> (__msi_set_enable+0x46)
>>   |  +*func                   -1 __msi_set_enable+0x14 (msi_set_mask_bits+0xd8)
>>   |  +*func                   -1 msi_set_mask_bits+0xe (unmask_msi_irq+0x17)
>>   |  +*func                   -1 unmask_msi_irq+0x9 (default_enable+0x1a)
>>   |  +*func                   -1 default_enable+0x9 (rt_enable_irq+0xe  

Excuse my naive question: but for every MSI interrupts, we need to issue
a PCI read and look for some bits ? Is not this a bit insane ?

-- 
                                                 Gilles.

