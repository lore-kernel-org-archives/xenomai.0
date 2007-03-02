Message-ID: <45E7F453.9090803@domain.hid>
Date: Fri, 02 Mar 2007 10:54:27 +0100
From: Markus Franke <Markus.Franke@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] problems installing peak CAN dongle
References: <bc4264770703020023o4e15cdafh6e254fff4b225e8a@domain.hid>	<45E7E49C.2000005@domain.hid>
	<bc4264770703020123s28450a37n60bb1e49798f32b8@domain.hid>
In-Reply-To: <bc4264770703020123s28450a37n60bb1e49798f32b8@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Reply-To: Markus.Franke@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

I had the same problems with a parallelport dongle. When I removed the
modules "parport_pc" and "lp" the parallel port device was always
powered off and it was not possible to receive interrupts anymore. A
workaround for this "power off" was to append "pnpbios=off"-option to
the kernel commandline.
Maybe this can also help you.

Regards,
Markus Franke

roland Tollenaar wrote:
>> >
>> > FATAL: Error inserting xeno_can_peak_dng (xeno_can_peak_dng.ko): No
>> such
>> > device
>>
>> Is there som additional kernel output visible via "dmesg"?
> 
> 
> Yes:
> 
> SCSI device sdb: 3963904 512-byte hdwr sectors (2030 MB)
> sdb: Write Protect is off
> sdb: Mode Sense: 43 00 00 00
> sdb: assuming drive cache: write through
> SCSI device sdb: 3963904 512-byte hdwr sectors (2030 MB)
> sdb: Write Protect is off
> sdb: Mode Sense: 43 00 00 00
> sdb: assuming drive cache: write through
> sdb: sdb1
> sd 3:0:0:0: Attached scsi removable disk sdb
> usb-storage: device scan complete
> ERROR! No SJA1000 device found!
> ERROR while trying to register SJA1000 device -19!
> Init failed with -19
> 
> are the final lines.
> 
> 
>>
>> How do you have configured the parport in the kernel? Are there modules
>> loaded (check /proc/modules)? Retry after removing lp and parport_pc:
> 
> 
> Have looked can't see any. Have attached the output of /proc/modules
> 
> 
>>
>>    $ rmmod lp
>>    $ rmmod parport_pc
> 
> 
> I get a message that it cannot find these modules in /proc/modules
> 
> 
> 
> 
> 
>>
>> Wolfgang.
>>
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Nichts ist so praktisch wie eine gute Theorie!

