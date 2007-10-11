Message-ID: <470E2A6F.2020406@domain.hid>
Date: Thu, 11 Oct 2007 15:51:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <470CB974.6040605@domain.hid> <470DCFD2.1000908@domain.hid>
In-Reply-To: <470DCFD2.1000908@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Passing data from device init to open function
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Johan Borkhuis <j.borkhuis@domain.hid>
Cc: Xenomai-help@domain.hid

Johan Borkhuis wrote:
> This is something I try to avoid (replying to my own messages), but I'll
> do it this time.
> 
> Johan Borkhuis wrote:
>> Hello,
>>
>> I am facing the following problem. During device initialization I am
>> filling a structure with device specific data. This structure is
>> provided to the Linux driver using pci_set_drvdata. Now I want my
>> Xenomai driver to have access to this data as well.
>>   
> 
> I made a fix for the problem I described, but I would also like to
> propose a change to the rtdm_device structure.
> 
> What I did to solve this problem is add the following statement to my
> device initialization function (the PCI probe function) after the
> pci_set_drvdata:
> 
>    MyDevice *unit;
>    ....
>    pci_set_drvdata(dev, unit);
>    my_rtdm_device.device_id = (int)dev;
> 
> In my ops-functions I can now use the following statement to access the
> device data:
> 
> int myrtdm_open_nrt(struct rtdm_dev_context    *context,
>                 rtdm_user_info_t              *user_info,
>                 int                            oflags)
> {
>    MyDevice *unit = pci_get_drvdata((struct pci_dev
> *)context->device->device_id);
> 
> This does work, but only as long as sizeof(int) == sizeof(<pointer>),
> which is true on 32 bit systems, but not on 64 bit systems. So I would
> like to add an extra pointer field to the rtdm_device structure,
> pointing to some device-data to allow this to work on both 32 and 64 bit
> systems.
> 
> I attached a diff-file containing a patch to rtdm_driver.h that makes
> this change.

Hmm, that's what we had in an early RTDM version, but the more common
use-case turned out to be

per_device_data = my_per_device_data[device->device_id];

where my_per_device_data is a global variable, typical a data structure
containing all the required per-device information.

Anyway, as you are adding this field, not replacing the ID with it, I
think I'm going to merge this.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

