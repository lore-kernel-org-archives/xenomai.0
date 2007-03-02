Message-ID: <45E807B7.3050304@domain.hid>
Date: Fri, 02 Mar 2007 12:17:11 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] problems installing peak CAN dongle
References: <bc4264770703020023o4e15cdafh6e254fff4b225e8a@domain.hid>	<45E7E49C.2000005@domain.hid>	<bc4264770703020123s28450a37n60bb1e49798f32b8@domain.hid>	<45E7F453.9090803@domain.hid>	<bc4264770703020228p4d01b96co85731b9657fce7b6@domain.hid>	<45E7FFA6.3060405@domain.hid>
	<bc4264770703020250q3ead4769kb2cbcc67d130dc3f@domain.hid>
In-Reply-To: <bc4264770703020250q3ead4769kb2cbcc67d130dc3f@domain.hid>
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
> Hi,
> 
> My situation is slightly different. The modules don;t get loaded for
> some or other reason (not sure why because I do have parport support
> <M> selected in the kernel config.
> 
> My BIOS settings said ECP instead of EPP ( I still don;t know the
> difference) I set it to EPP and the driver seems to load with modprobe
> now.
> 
> Interestingly enough before I changed the BIOS I did try
> 
> modprobe xeno_can_peak_dng type=ecp io=0x378 irq=7
> 
> but it tells me that ecp is an invalid argument? Why is that?

Simply because the module only supports the types epp and sp (= spp). 
But if I remember correctly, the driver does also work with type "epp" 
and ecp configured in the BIOS. Could you please apply my PNP patch and 
  tell me if it's working (check output of "dmesg" after loading it).

Thanks.

Wolfgang.

> 
> Kind regards,
> 
> Roland
> 
> 
> On 3/2/07, Markus Franke <Markus.Franke@domain.hid> wrote:
>> roland Tollenaar wrote:
>> > You mean this must be run as a boot option? Sorry I am not familiar
>> > with the term kernel commandline.
>>
>> Yes, I mean boot option.
>>
>> >
>> > Sounds like its worth a try.
>> >
>> > Lp and parport_pc are not loaded.
>>
>> In my case it was the problem that parport_pc and lp were loaded during
>> system boot. When I removed these modules in order to load my parport
>> module, the parallelport was always switched off by linux and it was not
>> possible to activate it again.
>>
>> >
>> > Thanks
>> >
>> > Roland
>> >
>> >> the kernel commandline.
>> >> Maybe this can also help you.
>> >>
>> >> Regards,
>> >> Markus Franke
>> >>
>> >> roland Tollenaar wrote:
>> >> >> >
>> >> >> > FATAL: Error inserting xeno_can_peak_dng 
>> (xeno_can_peak_dng.ko): No
>> >> >> such
>> >> >> > device
>> >> >>
>> >> >> Is there som additional kernel output visible via "dmesg"?
>> >> >
>> >> >
>> >> > Yes:
>> >> >
>> >> > SCSI device sdb: 3963904 512-byte hdwr sectors (2030 MB)
>> >> > sdb: Write Protect is off
>> >> > sdb: Mode Sense: 43 00 00 00
>> >> > sdb: assuming drive cache: write through
>> >> > SCSI device sdb: 3963904 512-byte hdwr sectors (2030 MB)
>> >> > sdb: Write Protect is off
>> >> > sdb: Mode Sense: 43 00 00 00
>> >> > sdb: assuming drive cache: write through
>> >> > sdb: sdb1
>> >> > sd 3:0:0:0: Attached scsi removable disk sdb
>> >> > usb-storage: device scan complete
>> >> > ERROR! No SJA1000 device found!
>> >> > ERROR while trying to register SJA1000 device -19!
>> >> > Init failed with -19
>> >> >
>> >> > are the final lines.
>> >> >
>> >> >
>> >> >>
>> >> >> How do you have configured the parport in the kernel? Are there
>> >> modules
>> >> >> loaded (check /proc/modules)? Retry after removing lp and 
>> parport_pc:
>> >> >
>> >> >
>> >> > Have looked can't see any. Have attached the output of /proc/modules
>> >> >
>> >> >
>> >> >>
>> >> >>    $ rmmod lp
>> >> >>    $ rmmod parport_pc
>> >> >
>> >> >
>> >> > I get a message that it cannot find these modules in /proc/modules
>> >> >
>> >> >
>> >> >
>> >> >
>> >> >
>> >> >>
>> >> >> Wolfgang.
>> >> >>
>> >> >
>> >> >
>> >> 
>> ------------------------------------------------------------------------
>> >> >
>> >> > _______________________________________________
>> >> > Xenomai-help mailing list
>> >> > Xenomai-help@domain.hid
>> >> > https://mail.gna.org/listinfo/xenomai-help
>> >>
>> >> --
>> >> Nichts ist so praktisch wie eine gute Theorie!
>> >>
>> >
>>
>> -- 
>> Nichts ist so praktisch wie eine gute Theorie!
>>
>>
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 
> 


