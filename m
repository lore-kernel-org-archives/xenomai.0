Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <4B46590F.2060308@domain.hid>
Date: Thu, 07 Jan 2010 22:58:39 +0100
From: Alexis Berlemont <berlemont.hauw@domain.hid>
MIME-Version: 1.0
References: <4bed572e0911221135s64fc4726x1cd7235f116e11a4@domain.hid>	
	<4B16F674.5090200@domain.hid>	
	<4bed572e0912150741l37bea514t773c71f645fbeba5@domain.hid>	
	<4B28208B.7000305@domain.hid>	
	<4bed572e0912160458i32834958q9512476f1603979d@domain.hid>	
	<4B2BF4D9.6000503@domain.hid>	
	<4bed572e1001051015l21e71e8eyaec207701c2e21ad@domain.hid>	
	<4B43BE72.6040101@domain.hid>	
	<4bed572e1001060557x12ffd808k193573c565830a1b@domain.hid>	
	<4B450B7E.80106@domain.hid>
	<4bed572e1001071124x55a964f8u22558c05c2a4485c@domain.hid>
In-Reply-To: <4bed572e1001071124x55a964f8u22558c05c2a4485c@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Help on analogy_ni_pcimio (Alexis Berlemont?)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ettore Pedretti <epedrett@domain.hid>
Cc: xenomai@xenomai.org

Hi,

Ettore Pedretti wrote:
> Hi,
> 
> I did not quite understand how to checkout  the analogy branch. When I
> do git branch -a either in xenomai-head or in xenomai-2.5 I get only:
> 
> * master
>   origin/HEAD
>   origin/master
> 
> no other branch is available for checkout. I'm obviously missing something.
> 
> I tried to apply the patch but it failed. At the end I edited
> mio_common.c directly. I hope I did not introduce any error.
> Everything compiled and installed fine.
> 
> The attach command did not complain this time:
> 
> analogy_config analogy0 analogy_ni_pcimio
> 
> The error trace is attached (dmesg_07Jan2010.txt). I also attached the
> kernel config as you asked: (config_analogy).
> 
> However the device /dev/analogy0 does not seem to be created.

That's the common behaviour. The dev files you find in the /dev
directory belong to the Linux drivers. The RTDM dev nodes can be listed
in the following proc file:

# cat /proc/xenomai/rtdm/named_devices
Hash Name Driver /proc
1B analogy0 rtdm_analogy analogy0
1C analogy1 rtdm_analogy analogy1
1D analogy2 rtdm_analogy analogy2
1E analogy3 rtdm_analogy analogy3
1F analogy4 rtdm_analogy analogy4
20 analogy5 rtdm_analogy analogy5
21 analogy6 rtdm_analogy analogy6
22 analogy7 rtdm_analogy analogy7
23 analogy8 rtdm_analogy analogy8
24 analogy9 rtdm_analogy analogy9

Roughly, a user application which communicates with RTDM drivers does
not use the same channels as a user application which communicates with
Linux drivers. Unlike Linux' ones, the RTDM devices are not reachable
through specific files.

So, instead of calling open("/dev/analogy0",...), we call
rtdm_open("analogy0", ...).

> 
> The content of /proc/analogy/drivers is:
> 
> --  Analogy drivers --
> 
> | idx | driver name
> |  00 | analogy_ni_pcimio
> |  01 | analogy_8255
> 
> /proc/analogy/devices is:
> 
> --  Analogy devices --
> 
> | idx | status | driver
> |  00 | Linked | analogy_ni_pcimio
> |  01 | Unused | No driver
> |  02 | Unused | No driver
> |  03 | Unused | No driver
> |  04 | Unused | No driver
> |  05 | Unused | No driver
> |  06 | Unused | No driver
> |  07 | Unused | No driver
> |  08 | Unused | No driver
> |  09 | Unused | No driver
Ok. The attach procedure went well.

> 
> /proc/analogy/00-analogy_ni_pcimio
> 
> --  Subdevices --
> 
> | idx | type
> |  00 | Unused subdevice
> |  01 | Analog output subdevice
> |  02 | Digital input/output subdevice
> |  03 | Unused subdevice
> |  04 | Unused subdevice
> |  05 | Calibration subdevice
> |  06 | Memory subdevice
> |  07 | Digital input/output subdevice
> |  08 | Unused subdevice
> |  09 | Serial subdevice
> |  10 | Unused subdevice
> |  11 | Counter subdevice
> |  12 | Counter subdevice
> |  13 | Counter subdevice
> 
> When I try cmd_write I get this
> 
> cmd_write: triggering failed (ret=-16)
-16 means -EBUSY. Did you get this error at the first launch?

Before checking asynchronous writes (with cmd_write), could you test the
synchronous writes (with insn_write)?

> 
> I was expecting complaints about /dev/analogy0 not existing. I'm confused.
> 
> Progress though!
> 
> Ettore
> 

Alexis.

