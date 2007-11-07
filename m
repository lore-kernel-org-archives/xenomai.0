Message-ID: <4731D205.9020004@domain.hid>
Date: Wed, 07 Nov 2007 15:56:05 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200709201549.13035.lepalom@domain.hid>	<200710311036.01469.lepalom@domain.hid>	<200711060032.36444.berlemont.hauw@domain.hid>
	<200711061102.13154.lepalom@domain.hid>
In-Reply-To: <200711061102.13154.lepalom@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Comedi driver for use with xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Leopold Palomo-Avellaneda <lepalom@domain.hid>
Cc: xenomai@xenomai.org

Leopold Palomo-Avellaneda wrote:
> A Dimarts 06 Novembre 2007, Alexis Berlemont va escriure:
>> Hi
>>
>>> And after, the jr3 driver, but I got with dmesg:
>>>
>>> jr3pci: module license 'unspecified' taints kernel.
>>> jr3pci: no version for "comedi_add_drv" found: kernel tainted.
>>> jr3pci: Unknown symbol device_unregister
>>> jr3pci: Unknown symbol device_register
>>>
>>>
>>> so, I cannot load the driver. What I'm doing grong?
>> Oops. My fault. Fixed in subversion.
>>
>> Please update.
>>
> done, but when I do:
> sudo insmod comedi_drivers/misc_drivers/jr3pci.ko
> 
> I got a console hangs, with no response and the dmesg says:
> jr3pci: no version for "comedi_add_drv" found: kernel tainted.
> comedi_add_drv: name=jr3_pci
> comedi_lct_drv: name=jr3_pci
> 
> 
> Now, I'm still blocked ....

Are you sure the (re-)build was clean? I haven't checked the comedi
branch recently for changes and/or problems with the build system, but
this used to work fine for me - once. :)

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

