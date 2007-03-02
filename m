Message-ID: <45E7FFA6.3060405@domain.hid>
Date: Fri, 02 Mar 2007 11:42:46 +0100
From: Markus Franke <Markus.Franke@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] problems installing peak CAN dongle
References: <bc4264770703020023o4e15cdafh6e254fff4b225e8a@domain.hid>	
	<45E7E49C.2000005@domain.hid>	
	<bc4264770703020123s28450a37n60bb1e49798f32b8@domain.hid>	
	<45E7F453.9090803@domain.hid>
	<bc4264770703020228p4d01b96co85731b9657fce7b6@domain.hid>
In-Reply-To: <bc4264770703020228p4d01b96co85731b9657fce7b6@domain.hid>
Content-Type: multipart/mixed; boundary="------------080808070604020803090701"
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

This is a multi-part message in MIME format.
--------------080808070604020803090701
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

roland Tollenaar wrote:
> You mean this must be run as a boot option? Sorry I am not familiar
> with the term kernel commandline.

Yes, I mean boot option.

> 
> Sounds like its worth a try.
> 
> Lp and parport_pc are not loaded.

In my case it was the problem that parport_pc and lp were loaded during
system boot. When I removed these modules in order to load my parport
module, the parallelport was always switched off by linux and it was not
possible to activate it again.

> 
> Thanks
> 
> Roland
> 
>> the kernel commandline.
>> Maybe this can also help you.
>>
>> Regards,
>> Markus Franke
>>
>> roland Tollenaar wrote:
>> >> >
>> >> > FATAL: Error inserting xeno_can_peak_dng (xeno_can_peak_dng.ko): No
>> >> such
>> >> > device
>> >>
>> >> Is there som additional kernel output visible via "dmesg"?
>> >
>> >
>> > Yes:
>> >
>> > SCSI device sdb: 3963904 512-byte hdwr sectors (2030 MB)
>> > sdb: Write Protect is off
>> > sdb: Mode Sense: 43 00 00 00
>> > sdb: assuming drive cache: write through
>> > SCSI device sdb: 3963904 512-byte hdwr sectors (2030 MB)
>> > sdb: Write Protect is off
>> > sdb: Mode Sense: 43 00 00 00
>> > sdb: assuming drive cache: write through
>> > sdb: sdb1
>> > sd 3:0:0:0: Attached scsi removable disk sdb
>> > usb-storage: device scan complete
>> > ERROR! No SJA1000 device found!
>> > ERROR while trying to register SJA1000 device -19!
>> > Init failed with -19
>> >
>> > are the final lines.
>> >
>> >
>> >>
>> >> How do you have configured the parport in the kernel? Are there
>> modules
>> >> loaded (check /proc/modules)? Retry after removing lp and parport_pc:
>> >
>> >
>> > Have looked can't see any. Have attached the output of /proc/modules
>> >
>> >
>> >>
>> >>    $ rmmod lp
>> >>    $ rmmod parport_pc
>> >
>> >
>> > I get a message that it cannot find these modules in /proc/modules
>> >
>> >
>> >
>> >
>> >
>> >>
>> >> Wolfgang.
>> >>
>> >
>> >
>> ------------------------------------------------------------------------
>> >
>> > _______________________________________________
>> > Xenomai-help mailing list
>> > Xenomai-help@domain.hid
>> > https://mail.gna.org/listinfo/xenomai-help
>>
>> -- 
>> Nichts ist so praktisch wie eine gute Theorie!
>>
> 

-- 
Nichts ist so praktisch wie eine gute Theorie!

--------------080808070604020803090701
Content-Type: text/x-vcard; charset=utf-8;
 name="Markus.Franke.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Markus.Franke.vcf"

begin:vcard
fn:Markus Franke
n:Franke;Markus
adr;quoted-printable:;;Vettersstra=C3=9Fe 64/722;Chemnitz;Saxony;09126;Germany
email;internet:Markus.Franke@domain.hid
x-mozilla-html:FALSE
url:http://www.tu-chemnitz.de/~franm
version:2.1
end:vcard


--------------080808070604020803090701--

