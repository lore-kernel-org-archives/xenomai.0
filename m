Message-ID: <470F247C.1060502@domain.hid>
Date: Fri, 12 Oct 2007 09:38:36 +0200
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
References: <470CB974.6040605@domain.hid> <470DCFD2.1000908@domain.hid>
	<470E2A6F.2020406@domain.hid>
In-Reply-To: <470E2A6F.2020406@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-help@domain.hid

Jan Kiszka wrote:
>> This does work, but only as long as sizeof(int) == sizeof(<pointer>),
>> which is true on 32 bit systems, but not on 64 bit systems. So I would
>> like to add an extra pointer field to the rtdm_device structure,
>> pointing to some device-data to allow this to work on both 32 and 64 bit
>> systems.
>>     
> Hmm, that's what we had in an early RTDM version, but the more common
> use-case turned out to be
>
> per_device_data = my_per_device_data[device->device_id];
>
> where my_per_device_data is a global variable, typical a data structure
> containing all the required per-device information.
>   

I considered that as well. The main problem is that you have to 
statically allocate the memory based on the maximum number of devices 
you want to support, and I prefer to allocate the memory for each 
available device.

> Anyway, as you are adding this field, not replacing the ID with it, I
> think I'm going to merge this.
>   
One should have a very good reason to replace or remove a field in a 
system-structure, and this is just an addition to the structure, so no 
real need to replace anything.

Thanks.

Kind regards,
    Johan Borkhuis


