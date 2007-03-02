Message-ID: <bc4264770703020123s28450a37n60bb1e49798f32b8@domain.hid>
Date: Fri, 2 Mar 2007 09:23:42 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] problems installing peak CAN dongle
In-Reply-To: <45E7E49C.2000005@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_49353_13950666.1172827422076"
References: <bc4264770703020023o4e15cdafh6e254fff4b225e8a@domain.hid>
	<45E7E49C.2000005@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_49353_13950666.1172827422076
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> >
> > FATAL: Error inserting xeno_can_peak_dng (xeno_can_peak_dng.ko): No such
> > device
>
> Is there som additional kernel output visible via "dmesg"?

Yes:

SCSI device sdb: 3963904 512-byte hdwr sectors (2030 MB)
sdb: Write Protect is off
sdb: Mode Sense: 43 00 00 00
sdb: assuming drive cache: write through
SCSI device sdb: 3963904 512-byte hdwr sectors (2030 MB)
sdb: Write Protect is off
sdb: Mode Sense: 43 00 00 00
sdb: assuming drive cache: write through
 sdb: sdb1
sd 3:0:0:0: Attached scsi removable disk sdb
usb-storage: device scan complete
ERROR! No SJA1000 device found!
ERROR while trying to register SJA1000 device -19!
Init failed with -19

are the final lines.


>
> How do you have configured the parport in the kernel? Are there modules
> loaded (check /proc/modules)? Retry after removing lp and parport_pc:

Have looked can't see any. Have attached the output of /proc/modules


>
>    $ rmmod lp
>    $ rmmod parport_pc

I get a message that it cannot find these modules in /proc/modules





>
> Wolfgang.
>

------=_Part_49353_13950666.1172827422076
Content-Type: text/plain; name="modules.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="modules.txt"
X-Attachment-Id: f_eysha0lc


------=_Part_49353_13950666.1172827422076--

