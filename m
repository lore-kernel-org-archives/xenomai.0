From: "Jonas Witt" <Jonas@domain.hid>
Date: Fri, 11 May 2007 19:57:47 +0200
Message-ID: <000f01c793f5$e2792810$c67ba8c0@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4644C144.1020004@domain.hid>
Subject: Re: [Xenomai-help] Serial Port Driver(rtser):
	NoRTSER_RTIOC_WAIT_EVENT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Jan Kiszka' <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jonas Witt wrote:
> Jonas Witt wrote:
>> Jonas Witt wrote:
>>> Jonas Witt wrote:
>>>>> Hi everybody,
>>>>>
>>>>> =20
>>>>>
>>>>> i am having a problem with the serial port driver in xenomai for a
> while
>>>>> now..
>>>>>
>>>>> =20
>>>>>
>>>>> I have tried different programs like
>>>>> http://www.captain.at/xenomai-serial-port-example.php
>>>>>
>>>>> =20
>>>>>
>>>>> I have also changed the code of cross-link.c to use the same port =
for
>>>>> writing and reading (as i only have one serial port in my =
computer).
>>> Opening
>>>>> a port and writing the configuration seems to work form e.. also
>>> writing.
>>>>> The Problem stems from the call to:
>>>>>
>>>>> =20
>>>>>
>>>>> rt_dev_ioctl(read_fd, RTSER_RTIOC_WAIT_EVENT, &rx_event);
>>>>>
>>>>> =20
>>>>>
>>>>> which keeps waiting forever and never receives an interrupt. I =
tried a
>>>>> self-made loopback-adapter and a sensor with a serial interface =
(so at
>>> least
>>>>> _something_ should come back). Nothing worked. The serial port is
>>> working
>>>>> fine with the linux-driver, though. I already figured that the =
calls
to
>>>>> rt_dev_write do not work from non-xenomai-tasks (which should =
really
be
>>>>> emphasized in the documentation..)
>>>>>
>>>> Some suggestions:
>>>>
>>>>  o check the hardware configuration (ie. the module parameters of
>>>>    xeno_16550A) twice, you can easily get them wrong
>>>>
>>>>  o check /proc/xenomai/irq for any progress on transmission as well =
as
>>>>    on reception. If there is nothing happen on tx, the IRQ number =
may
be
>>>>    wrong, if there is nothing on rx, your port configuration might =
be
>>>>    broken.
>>>>
>>>>  o try the driver from trunk, it can handle PnP-related issues
(hardware
>>>>    gets powered off when Linux driver is removed)
>>>>
>>>> Jan
>>>>
>>>> Thanks for the fast reply!
>>>>
>>>> I am using the following kernel parameters:
>>>>
>>>> kernel		/boot/vmlinuz-2.6.19-ipipe root=3D/dev/sda1 ro
>> 8250.nr_uarts=3D0
>>>> xeno_16550A.ioaddr=3D0x3f8 xeno_16550A.irq=3D4
>>>>
>>> OK, that leads to another suggestion: try going the modular path for
>>> xeno_16550A first, it's the more common one. Above /should/ be no
>>> problem /wrt the the RT driver, but kicking 8250 out of the game =
could
>>> cause that PnP power issue I sketched.
>>>
>>>> I got these settings from setserial prior to disabling the
> kernel-driver.
>> To
>>>> be honest i don't know how to 'check' /proc/xenomai/irq for =
progress. I
>> took
>>>> a look at the folder prior to and while running my modified
>> cross-link-code
>>>> but irq is an empty file in both cases. Is there some special
>> trick/function
>>>> to handle the files in the proc-folder?
>>> You mean the file is existing but empty??? That would be fairly
uncommon.
>>>
>>> (without any driver loaded)
>>> # cat /proc/xenomai/irq
>>> IRQ         CPU0
>>> 217:           0
>>> 226:           0         [virtual]
>>>
>>> The serial driver pops up here once the port is opened. The per-cpu =
irq
>>> hit counter should then increase as interrupts come in.
>>>
>>>> To the last point.. so there is an updated version of the driver
>>> available?
>>>> I think i will try that one.. is it just a question of executing =
'make'
>>> and
>>>> modprobing or are there more actions involved?
>>> No, it's not that easy (more files, changed Makefiles and RTDM API).
>>> First try the modular driver path, ie. keep 8250, switch off the =
Linux
>>> port with setserial, and load the RT driver as a module. Then, if =
this
>>> doesn't help, you could consider upgrading your Xenomai installation =
(at
>>> least for a test) to SVN trunk.
>>>
>>> Jan
>>>
>>> Ah, ok.. ehem... i tried to look at the file with gedit.. and it
displays
>>> nothing.. ;)
>>> Now i get:
>>>
>>> IRQ         CPU0
>>>   4:           0         rtser0
>>> 216:         521         [timer]
>>> 226:         620         [virtual]
>>>
>>> This is how it looks like after the program starts.. after that it
> increases
>>> just the [virtual] and the [timer] counter . Rtser0 stays at 0 all =
the
> time
>>> (although information is successfully written to the port, judging =
from
> the
>>> return value of rt_dev_write).
>>>
>>> So i guess that is where the problem lies.. what can I do about =
that?
>> Apply the other suggestion I made. You may try to talk to a dead =
device
>> if 8250 is not loaded and takes over the PnP work.
>>
>> Jan
>>=20
>> I already tried my luck with a modular driver.. does not work =
either..
>>=20
>
> :-/
>
>> Now i compiled a new 2.6.20-kernel with xenomai-trunk. I tried to
modprobe
>> as usual:
>> modprobe xeno_16550A ioaddr=3D0x3f8 irq=3D4
>> but somehow the 'ioaddr'-parameter is not accepted by the module.. =
did
>> something change there?
>
> Yep, it has been refactored to "io=3D" (like other Xenomai drivers).
>=20
> Jan

Sorry.. i drew a wrong conclusion.. actually changing to a modular =
serial
driver and deactivating the kernel-driver with setserial does change the
situation in /proc/xenomai/irq: now the rtser0 entry is counted upwards,
too. Anyway this does not change the situation with my modified =
cross-link
program (that's where i drew the wrong conclusion, since i tested with a
modular serial driver before).

Anyway.. i am going to try the latest driver-version now. With the new
infos, is there another thing i can check?

Jonas


