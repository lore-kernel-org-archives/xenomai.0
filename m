Message-ID: <48AAD622.8030402@domain.hid>
Date: Tue, 19 Aug 2008 16:18:10 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20080812075358.4cg1ix9945msccsc@domain.hid>	<48A12EA8.4070601@domain.hid>
	<48A34D75.9090509@domain.hid>	<48A359D4.9090002@domain.hid>
	<48A3D20B.2080509@domain.hid>	<48A3D595.9040607@domain.hid>	<20080814125307.1uviqgmj95no4k0k@domain.hid>	<48A43555.3070701@domain.hid>
	<48A45084.3000208@domain.hid>	<48A46408.7010602@domain.hid>
	<48A6B8EC.8020302@domain.hid>	<48AA9DAA.3040801@domain.hid>
	<20080819123133.n9ool6j5d5msowk8@domain.hid>
In-Reply-To: <20080819123133.n9ool6j5d5msowk8@domain.hid>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Adeos-main] [RTnet-users] e1000 & MSI
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: bernhard@domain.hid
Cc: adeos-main <adeos-main@gna.org>, RTnet-users@domain.hid

bernhard@domain.hid wrote:
> Zitat von Philippe Gerum <rpm@xenomai.org>:
> 
>> Bernhard Pfund wrote:
>>> Philippe Gerum wrote:
>>>> Bernhard Pfund wrote:
>>>>>> I see no option aside of ironing the inner code that reads/writes the PCI
>>>>>> config, so here is an ugly yet possible solution for x86, that might work
>>>>>> (totally untested):
>>>>>>
>>>>>> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
>>>>>> index 6e64aaf..7f32101 100644
>>>>>> --- a/arch/x86/pci/common.c
>>>>>> +++ b/arch/x86/pci/common.c
>>>>>> @@ -75,7 +75,7 @@ int pcibios_scanned;
>>>>>>   * This interrupt-safe spinlock protects all accesses to PCI
>>>>>>   * configuration space.
>>>>>>   */
>>>>>> -DEFINE_SPINLOCK(pci_config_lock);
>>>>>> +IPIPE_DEFINE_SPINLOCK(pci_config_lock);
>>>>>>
>>>>>>  static int __devinit can_skip_ioresource_align(const struct   
>>>>>> dmi_system_id *d)
>>>>>>  {
>>>>>> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
>>>>>> index 39bb96b..9a74083 100644
>>>>>> --- a/drivers/pci/access.c
>>>>>> +++ b/drivers/pci/access.c
>>>>>> @@ -12,7 +12,7 @@
>>>>>>   * configuration space.
>>>>>>   */
>>>>>>
>>>>>> -static DEFINE_SPINLOCK(pci_lock);
>>>>>> +static IPIPE_DEFINE_SPINLOCK(pci_lock);
>>>>>>
>>>>>>  /*
>>>>>>   *  Wrappers for all PCI configuration access functions.  They   
>>>>>> just check
>>>>>>
>>>>> This results in:
>>>>>
>>>>> arch/x86/pci/common.c:78: error: conflicting types for ‘pci_config_lock’
>>>>> arch/x86/pci/pci.h:84: error: previous declaration of ‘pci_config_lock’
>>>>> was here
>>>>>
>>>>> Didn't look into it, just tried ;)
>>>>>
>>>> Just change the declaration in pci.h the same way.
>>>>
>>> Ok, thanx! Seems to work for now, no extensive testing done (yet)
>>> though. What's the plan for the future? Will this change find its way
>>> into the official patch?
>>>
>> This change could be merged into the 2.6.26 patch provided it does   
>> not raise any
>> pathological latency when enabling MSI. I would rather ask people to refrain
>> from using MSI until it is fixed (once again) in later releases,   
>> than suffering
>> random latency peaks. 2.6.27 and beyond is another issue; this will need a
>> different approach than simply ironing the PCI lock in any case.
>>
>> We need more test data for 2.6.26 + this patch.
>>
> 
> Let me know if I can be of any help. I'm in an early stage of the  
> project, so there's some time available for MSI experiments...
> 

Thanks. Basically, we need to know the impact of this patch under high load for
at least four hours runtime, with significant interrupt traffic to/from MSI
devices in parallel.

-- 
Philippe.

