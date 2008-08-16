Message-ID: <48A6B8EC.8020302@domain.hid>
Date: Sat, 16 Aug 2008 13:24:28 +0200
From: Bernhard Pfund <bernhard@domain.hid>
MIME-Version: 1.0
References: <20080812075358.4cg1ix9945msccsc@domain.hid>	<48A12EA8.4070601@domain.hid>
	<48A34D75.9090509@domain.hid>	<48A359D4.9090002@domain.hid>
	<48A3D20B.2080509@domain.hid>	<48A3D595.9040607@domain.hid>
	<20080814125307.1uviqgmj95no4k0k@domain.hid>
	<48A43555.3070701@domain.hid> <48A45084.3000208@domain.hid>
	<48A46408.7010602@domain.hid>
In-Reply-To: <48A46408.7010602@domain.hid>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
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
> Bernhard Pfund wrote:
>>> I see no option aside of ironing the inner code that reads/writes the P=
CI
>>> config, so here is an ugly yet possible solution for x86, that might wo=
rk
>>> (totally untested):
>>>
>>> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
>>> index 6e64aaf..7f32101 100644
>>> --- a/arch/x86/pci/common.c
>>> +++ b/arch/x86/pci/common.c
>>> @@ -75,7 +75,7 @@ int pcibios_scanned;
>>>   * This interrupt-safe spinlock protects all accesses to PCI
>>>   * configuration space.
>>>   */
>>> -DEFINE_SPINLOCK(pci_config_lock);
>>> +IPIPE_DEFINE_SPINLOCK(pci_config_lock);
>>>
>>>  static int __devinit can_skip_ioresource_align(const struct dmi_system=
_id *d)
>>>  {
>>> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
>>> index 39bb96b..9a74083 100644
>>> --- a/drivers/pci/access.c
>>> +++ b/drivers/pci/access.c
>>> @@ -12,7 +12,7 @@
>>>   * configuration space.
>>>   */
>>>
>>> -static DEFINE_SPINLOCK(pci_lock);
>>> +static IPIPE_DEFINE_SPINLOCK(pci_lock);
>>>
>>>  /*
>>>   *  Wrappers for all PCI configuration access functions.  They just ch=
eck
>>>
>> This results in:
>>
>> arch/x86/pci/common.c:78: error: conflicting types for =91pci_config_loc=
k=92
>> arch/x86/pci/pci.h:84: error: previous declaration of =91pci_config_lock=
=92
>> was here
>>
>> Didn't look into it, just tried ;)
>>
>=20
> Just change the declaration in pci.h the same way.
>=20

Ok, thanx! Seems to work for now, no extensive testing done (yet)
though. What's the plan for the future? Will this change find its way
into the official patch?

Bernhard


