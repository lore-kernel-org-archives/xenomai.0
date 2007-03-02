Message-ID: <45E7F01D.2080304@domain.hid>
Date: Fri, 02 Mar 2007 10:36:29 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] problems installing peak CAN dongle
References: <bc4264770703020023o4e15cdafh6e254fff4b225e8a@domain.hid>	
	<45E7E49C.2000005@domain.hid>
	<bc4264770703020123s28450a37n60bb1e49798f32b8@domain.hid>
In-Reply-To: <bc4264770703020123s28450a37n60bb1e49798f32b8@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

roland Tollenaar wrote:
>> >
>> > FATAL: Error inserting xeno_can_peak_dng (xeno_can_peak_dng.ko): No 
>> such
>> > device
>>
>> Is there som additional kernel output visible via "dmesg"?
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

OK ==> the device cannot be accessed. Either the I/O address "0x378" and 
partport type "epp" is incorrect (you did not answer my question on 
that) or the parallel port is not operational (power off, etc.).
Please check what is actually selected in the BIOS of your system.

>> How do you have configured the parport in the kernel? Are there modules
>> loaded (check /proc/modules)? Retry after removing lp and parport_pc:
> 
> Have looked can't see any. Have attached the output of /proc/modules
> 
> 
>>
>>    $ rmmod lp
>>    $ rmmod parport_pc
> 
> I get a message that it cannot find these modules in /proc/modules

Try "modporbe parport". If the module does not exists, configure and 
rebuild your kernel with parport support.

In the meantime I'm going to apply the fix Jan mentioned.

Wolfgang.


