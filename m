Message-ID: <44E37321.1010400@domain.hid>
Date: Wed, 16 Aug 2006 21:33:53 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] problem with installation
References: <20060816190510.20935.qmail@domain.hid>
	<49365.155.98.4.150.1155755874.squirrel@domain.hid>
In-Reply-To: <49365.155.98.4.150.1155755874.squirrel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Brandt Erickson wrote:
> I had similar problems installing xenomai when I had seperate / and /boot
> partitions.  When I configured the system with no /boot partition, it work
> fine.

Good that someone read the real error...

Was this issues related to Xenomai or the Adeos patch? Or were there
just some drivers missing in the kernel directly or initfs?

It is typically fine to derive the Xenomai kernel .config from an
existing one (e.g. that your your distro), just switching of the
features listed as problematic.

Jan

> -Brandt
> 
>> Hi all.
>>
>>      I'm trying to install Xenomai on my pc.
>> To do that I'm following this guide
>> http://www.captain.at/xenomai-2.1-installation.php
>>
>> I'm using Kubuntu 6.6, linux-2.6.17 kernel and xenomai-2.2.0
>>
>> I have runned the script prepare-kernel.sh with the correct option as in
>> README.INSTALL
>>
>> Everything go well untill I reboot the system, then I have those errors
>>
>>
>>
>> Uncompressing Linux... ok, booting the kernel
>> MP-BIOS bug 8254 timer not connected to IO-APIC
>> Xenomai: incompatible timer mode(aperiodic found, need aperiodic)
>> Xenomai: VxWorks skin init failed code -16
>> Kernel Panic - not syncing: VFS Unable to mount root fs on unknow
>>  -block(0,0)
>>
>>
>> Someone can give me an help? where I can found an official installation
>> guide
>>
>> (Sorry for my bad english)
>> Thanks
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>>
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


