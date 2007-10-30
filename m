Message-ID: <472740DE.2040908@domain.hid>
Date: Tue, 30 Oct 2007 15:34:06 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200709201549.13035.lepalom@domain.hid>	<200710291858.33645.lepalom@domain.hid>	<200710292355.56188.berlemont.hauw@domain.hid>
	<200710301524.43681.lepalom@domain.hid>
In-Reply-To: <200710301524.43681.lepalom@domain.hid>
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
> A Dilluns 29 Octubre 2007, Alexis Berlemont va escriure:
>> Hi,
>>
>>> some time ago we wrote about the avalaible of the jr3_pci driver. The
>>> option to have someone at the end of October. So, how is it?
>> A pre-version is available in the svn branch "comedi-rtdm-dev". You will
>> find in "comedi_drivers/misc_drivers", the driver jr3_pci.
>>
>> The source code was ported from the original Comedi project (as the API has
>> changed). Unfortunately, It is not tested (no hardware available).
> 
> Ok, I have download, compiled and installed. I'm using xenomai 2.4-rc4. All 
> have compiled without any problem. Howeber I don't know how to use it.
> 
> If I try to install the modules:
> 
> insmod comedi.ko   
> 
> no problem
> 
> but if I do:
>  insmod ./comedi_drivers/misc_drivers/jr3pci.ko  
> 
> I got
> 
> insmod: error inserting './comedi_drivers/misc_drivers/jr3pci.ko': -1 Unknown 
> symbol in module
> 
> 
> where the dmesg says:
> 
> jr3pci: no version for "comedi_add_drv" found: kernel tainted.
> jr3pci: Unknown symbol release_firmware
> jr3pci: Unknown symbol device_unregister
> jr3pci: Unknown symbol request_firmware
> jr3pci: Unknown symbol device_register
> jr3pci: Unknown symbol release_firmware
> jr3pci: Unknown symbol device_unregister
> jr3pci: Unknown symbol request_firmware
> jr3pci: Unknown symbol device_register
> 
> and now I'm blocked ....

modprobe firmware?

> 
>>> It could be possible to have it for xenomai-2.4?
>> So far, the only way to get the driver sources  is through subversion. A
>> great amount of work (development, test,...) must be achieved before
>> considering an official release.
> 
> ok
> 
> I should help if I want this driver working with xenomai ....
> 
> Regards,
> 
> Leo
> 
> PS use me as betatester of the driver, so if told me any test that I could do.

Nice to see that this train is about to gain more passengers! :)

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

