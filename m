Message-ID: <45E82887.8090809@domain.hid>
Date: Fri, 02 Mar 2007 14:37:11 +0100
MIME-Version: 1.0
Subject: Re: [Xenomai-help] problems installing peak CAN dongle
References: <bc4264770703020023o4e15cdafh6e254fff4b225e8a@domain.hid>	<45E7E49C.2000005@domain.hid>	<bc4264770703020123s28450a37n60bb1e49798f32b8@domain.hid>	<45E7F453.9090803@domain.hid>	<bc4264770703020228p4d01b96co85731b9657fce7b6@domain.hid>	<45E7FFA6.3060405@domain.hid>	<bc4264770703020250q3ead4769kb2cbcc67d130dc3f@domain.hid>
	<bc4264770703020252i8856466i80dfc882b9ad3ce2@domain.hid>
	<45E808C7.4010101@domain.hid> <45E80CDB.1040504@domain.hid>
	<45E82460.1030809@domain.hid>
In-Reply-To: <45E82460.1030809@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>, Xenomai-help@domain.hid

> 
> Inspect /proc/rtcan or watch the log messages.
> 
>> Then I presume I will send a message on 1 and then see it appear on 
>> the rtcanrecv rtcan1 ?
> 
> Yes, but with rtcan2.
Does this not depend on the outcome of the earlier inspection of 
/proc/rtcan or is rtcan2 an educated guess? To clarify: I will be 
sending and recieving on rtcan2 in loopback mode in order to test?

> 
>>
>> If things are a bit slow on my side its because I am rushing around 
>> doing other mandatory things. Only reason I am busy with this as well 
>> at the moment is because I don;t want to lose the opportunity of 
>> having you all at your desks :)

While I think about it. How DO I apply your patch. I mean besides using 
the patch tool, which installation steps must I repeat?
1-patch your file
2-run patch_kernel again
3-rebuild the kernel
4-rebuild the modules (make modules)
5-Install modules
(or can I skip 3 and only do 4 and 5?)

Roland

> 
> Good, because I will be on holiday next week ;-).

That is not good. You sure you don;t want to postpone for a week? :)

> 
> Wolfgang.
> 
>> Thanks, "ich melde mich" soon. :)
>>
>>
>> Roland.
>>
>>>
>>> Wolfgang.
>>>
>>>>
>>>> Roland
>>>>
>>>>
>>>>
>>>> On 3/2/07, roland Tollenaar <rolandtollenaar@domain.hid> wrote:
>>>>> Hi,
>>>>>
>>>>> My situation is slightly different. The modules don;t get loaded for
>>>>> some or other reason (not sure why because I do have parport support
>>>>> <M> selected in the kernel config.
>>>>>
>>>>> My BIOS settings said ECP instead of EPP ( I still don;t know the
>>>>> difference) I set it to EPP and the driver seems to load with modprobe
>>>>> now.
>>>>>
>>>>> Interestingly enough before I changed the BIOS I did try
>>>>>
>>>>> modprobe xeno_can_peak_dng type=ecp io=0x378 irq=7
>>>>>
>>>>> but it tells me that ecp is an invalid argument? Why is that?
>>>>>
>>>>>
>>>>> Kind regards,
>>>>>
>>>>> Roland
>>>>>
>>>>>
>>>>> On 3/2/07, Markus Franke <Markus.Franke@domain.hid> 
>>>>> wrote:
>>>>> > roland Tollenaar wrote:
>>>>> > > You mean this must be run as a boot option? Sorry I am not 
>>>>> familiar
>>>>> > > with the term kernel commandline.
>>>>> >
>>>>> > Yes, I mean boot option.
>>>>> >
>>>>> > >
>>>>> > > Sounds like its worth a try.
>>>>> > >
>>>>> > > Lp and parport_pc are not loaded.
>>>>> >
>>>>> > In my case it was the problem that parport_pc and lp were loaded 
>>>>> during
>>>>> > system boot. When I removed these modules in order to load my 
>>>>> parport
>>>>> > module, the parallelport was always switched off by linux and it 
>>>>> was not
>>>>> > possible to activate it again.
>>>>> >
>>>>> > >
>>>>> > > Thanks
>>>>> > >
>>>>> > > Roland
>>>>> > >
>>>>> > >> the kernel commandline.
>>>>> > >> Maybe this can also help you.
>>>>> > >>
>>>>> > >> Regards,
>>>>> > >> Markus Franke
>>>>> > >>
>>>>> > >> roland Tollenaar wrote:
>>>>> > >> >> >
>>>>> > >> >> > FATAL: Error inserting xeno_can_peak_dng 
>>>>> (xeno_can_peak_dng.ko): No
>>>>> > >> >> such
>>>>> > >> >> > device
>>>>> > >> >>
>>>>> > >> >> Is there som additional kernel output visible via "dmesg"?
>>>>> > >> >
>>>>> > >> >
>>>>> > >> > Yes:
>>>>> > >> >
>>>>> > >> > SCSI device sdb: 3963904 512-byte hdwr sectors (2030 MB)
>>>>> > >> > sdb: Write Protect is off
>>>>> > >> > sdb: Mode Sense: 43 00 00 00
>>>>> > >> > sdb: assuming drive cache: write through
>>>>> > >> > SCSI device sdb: 3963904 512-byte hdwr sectors (2030 MB)
>>>>> > >> > sdb: Write Protect is off
>>>>> > >> > sdb: Mode Sense: 43 00 00 00
>>>>> > >> > sdb: assuming drive cache: write through
>>>>> > >> > sdb: sdb1
>>>>> > >> > sd 3:0:0:0: Attached scsi removable disk sdb
>>>>> > >> > usb-storage: device scan complete
>>>>> > >> > ERROR! No SJA1000 device found!
>>>>> > >> > ERROR while trying to register SJA1000 device -19!
>>>>> > >> > Init failed with -19
>>>>> > >> >
>>>>> > >> > are the final lines.
>>>>> > >> >
>>>>> > >> >
>>>>> > >> >>
>>>>> > >> >> How do you have configured the parport in the kernel? Are 
>>>>> there
>>>>> > >> modules
>>>>> > >> >> loaded (check /proc/modules)? Retry after removing lp and 
>>>>> parport_pc:
>>>>> > >> >
>>>>> > >> >
>>>>> > >> > Have looked can't see any. Have attached the output of 
>>>>> /proc/modules
>>>>> > >> >
>>>>> > >> >
>>>>> > >> >>
>>>>> > >> >>    $ rmmod lp
>>>>> > >> >>    $ rmmod parport_pc
>>>>> > >> >
>>>>> > >> >
>>>>> > >> > I get a message that it cannot find these modules in 
>>>>> /proc/modules
>>>>> > >> >
>>>>> > >> >
>>>>> > >> >
>>>>> > >> >
>>>>> > >> >
>>>>> > >> >>
>>>>> > >> >> Wolfgang.
>>>>> > >> >>
>>>>> > >> >
>>>>> > >> >
>>>>> > >> 
>>>>> ------------------------------------------------------------------------ 
>>>>>
>>>>> > >> >
>>>>> > >> > _______________________________________________
>>>>> > >> > Xenomai-help mailing list
>>>>> > >> > Xenomai-help@domain.hid
>>>>> > >> > https://mail.gna.org/listinfo/xenomai-help
>>>>> > >>
>>>>> > >> --
>>>>> > >> Nichts ist so praktisch wie eine gute Theorie!
>>>>> > >>
>>>>> > >
>>>>> >
>>>>> > --
>>>>> > Nichts ist so praktisch wie eine gute Theorie!
>>>>> >
>>>>> >
>>>>>
>>>>
>>>> _______________________________________________
>>>> Xenomai-help mailing list
>>>> Xenomai-help@domain.hid
>>>> https://mail.gna.org/listinfo/xenomai-help
>>>>
>>>>
>>>
>>>
>>
>>
> 
> 

