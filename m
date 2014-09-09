MIME-Version: 1.0
In-Reply-To: <540E9981.1000903@web.de>
References: <CAMoEH9VtdHc6usxhhYGVn74ssWC_6CQSPzK0mLSQ4Wmog3KG5A@mail.gmail.com>
 <540E9981.1000903@web.de>
Date: Mon, 8 Sep 2014 23:28:21 -0700
Message-ID: <CAMoEH9Wg_SpjcK64Y18f6+jWV-2ce31VxCf9+mw7c4zhhGqmtA@mail.gmail.com>
From: Nicholas Rotella <nrotella@usc.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Xenomai and usb4rt IRQ issues
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: xenomai@xenomai.org

Hi Jan,

Thanks for your reply.  The issue was solved by restricting the system
ram to 4Gb, something I had overlooked previously.  I suppose the IRQs
were being handled properly all along but the data was being copied
into a portion of memory which wasn't accessible due to the memory
limit.  Everything works great now.  Looking forward to your updated
driver!

- Nick

On Mon, Sep 8, 2014 at 11:09 PM, Jan Kiszka <jan.kiszka@web.de> wrote:
> On 2014-08-27 04:59, Nicholas Rotella wrote:
>> Hi all,
>>
>> I have some issues getting real-time USB working with my device, an
>> inertial sensor which normally uses the non-RT cdc-acm driver.  I'm
>> running Ubuntu 12.04 (linux kernel version 3.8.13) with Xenomai 2.6.3.
>> I know that this is the Xenomai mailing list so I'm not sure if anyone
>> is very familiar with the usb4rt project (cloned from
>> http://git.kiszka.org/?p=3Dusb4rt.git;a=3Dsummary and working off the
>> cdc-acm branch) but I thought it was worth a try (anyway the issue may
>> be more general).
>>
>> Short story is this: I am able to compile usb4rt, load the drivers,
>> open a real-time USB port via the rt_cdc_acm module and write to the
>> device.  It responds, but I am never able to read data from it.  I'm
>> sure it's sending data because IRQs are triggered and nothing else
>> shares this interrupt line.
>>
>> Long story is this: I am able to load the correct modules and bind
>> them to a UHCI-compatible USB card (USB 1.1), my device is recognized
>> and the rt_cdc_acm driver gets loaded properly, creating rtser0 (as
>> confirmed by checking /proc/xenomai/rtdm/rtser0/information).  I can
>> then use RT serial
>> (http://www.xenomai.org/documentation/trunk/html/api/group__rtserial.htm=
l)
>> commands to interact with the virtual serial device.  I can open the
>> port and send commands, which I'm sure the device is receiving.
>> However, I receive no data when I try to read from the device.  I can
>> put this device into a "streaming" mode in which it sends packets in
>> an uninterrupted fashion and, by watching /proc/xenomai/irq, I can see
>> that packets are coming in from the device (the rt_uhci driver's IRQ
>> count increases steadily).  My suspicion is that there is somehow an
>> IRQ mismatch which causes the usb4rt drivers to miss the IRQs issued
>> by the device when data is ready for reading, but I am not sure.
>>
>> Any thoughts or advice on how to proceed would be much appreciated.
>> The following is a portion of the script I use to compile and bring up
>> the usb4rt drivers (after unbinding the non-RT drivers from devices
>> which would otherwise share the same IRQ line that usb4rt uses):
>>
>> git clone git://git.kiszka.org/usb4rt.git
>> git checkout cdc-acm
>> cd /usr/src/usb4rt
>> ./configure --enable-drv-cdc-acm --disable-bandw-reclam
>> --with-xeno-user-dir=3D/usr/
>> make && make install
>> echo -n "0000:05:00.0" > /sys/bus/pci/drivers/uhci_hcd/unbind
>> echo -n "0000:00:1a.0" > /sys/bus/pci/drivers/ehci-pci/unbind
>> sleep 1
>> insmod /usr/local/usb4rt/modules/rt_usbcore.ko
>> sleep 1
>> insmod /usr/local/usb4rt/modules/rt_uhci_hcd.ko irq=3D16
>> insmod /usr/local/usb4rt/modules/rt_cdc_acm.ko vendor=3D0x199b
>> product=3D0x3065 start_index=3D0
>>
>> The following is the portion of my systemlog pertaining to the loading
>> of the usb4rt drivers:
>>
>> [23407.104492] ********** Realtime USB-Core Module 0.0.5 ***********
>> [23407.104494] RT-USBCORE: Max 16 Controller
>> [23407.104495] RT-USBCORE: Max 128 USB-Devices
>> [23407.104496] RT-USBCORE: Common debugging: disabled
>> [23407.104497] RT-USBCORE: Queue head debugging: disabled
>> [23407.104498] RT-USBCORE: Transfer descriptor debugging: disabled
>> [23407.104498] RT-USBCORE: Time debugging: disabled
>> [23407.104503] RT-USBCORE: Control-URB @ 0xffff8803b5429200 with  8
>> Byte Packet-Size
>> [23407.104504] RT-USBCORE: Control-URB @ 0xffff8803b5428e00 with 16
>> Byte Packet-Size
>> [23407.104505] RT-USBCORE: Control-URB @ 0xffff8803b542a200 with 32
>> Byte Packet-Size
>> [23407.104506] RT-USBCORE: Control-URB @ 0xffff8803b542b000 with 64
>> Byte Packet-Size
>> [23407.104507] RT-USBCORE: Initialize Hub-List
>> [23407.104507] RT-USBCORE: Initialize Controller-List
>> [23407.104508] RT-USBCORE: Loading Completed (1152 Byte allocated)
>> [23408.103279] ********* Realtime Driver for Universal Host Controller
>> 0.0.5 **********
>> [23408.103283] RT-UHC-Driver: Searching for Universal-Host-Controller
>> [23408.103284] RT-UHC-Driver: -> Use only HC with IRQ 16
>> [23408.103288] USB Universal Host Controller found : Vendor =3D 0x1106,
>> Device =3D 0x3038, IRQ =3D 16, IO-Port =3D 0x00002020 (32 Bytes)
>> [23408.103290] RT-UHC-Driver: Request IO-Port @ 0x00002020 (32 Byte)
>> for UHC[0] ... [OK]
>> [23408.103292] RT-UHC-Driver: Request RTDM IRQ 16 ... [OK]
>> [23408.103349] RT-USBCORE: Register Host-Controller Driver
>> [23408.103350] RT-USBCORE: Host-Controller added to USB-Controller-List
>> [23408.548646] RT-USBCORE: Registering CTRL-URB (8 Byte) @ Host-Controll=
er 0
>> [23408.549819] 000:00-000: Setting Address 1
>> [23408.549885] 000:00-001: Switch to URB with 64 Byte Packet-Size
>> [23408.580736] 000:00-001: Manufacturer : MicroStrain, Inc.
>> [23408.581010] 000:00-001: Product : 3DM-GX3-25 Orientation Sensor
>> [23408.581205] 000:00-001: Device 1 configured
>> [23408.581206] --- DUMP USB-DEVICE @ ffffffffa05773b8 ------------------=
-------
>> [23408.581207]  Number          : 1
>> [23408.581208]  Vendor          : 0x199b
>> [23408.581209]  Product         : 0x3065
>> [23408.581210]  Root-Hub-Port   : 0x00
>> [23408.581210]  Class           : 0x02
>> [23408.581211]  Subclass        : 0x00
>> [23408.581212]  Protocol        : 0x00
>> [23408.581213]  In use          : no
>> [23408.581214]  Status          : 0x00
>> [23408.581214]  Speed           : 0x02
>> [23408.581215]  Host-Controller @ 0xffff8803f5381880
>> [23408.581216]
>> [23408.581217]  Endpoint         ---0 ---1 ---2 ---3 ---4 ---5 ---6
>> ---7 ---8 ---9 --10 --11 --12 --13 --14 --15
>> [23408.581218]  Ctrl-Mask IN        X    -    -    -    -    -    -
>> -    -    -    -    -    -    -    -    -
>> [23408.581220]  Ctrl-Mask OUT       X    -    -    -    -    -    -
>> -    -    -    -    -    -    -    -    -
>> [23408.581222]  Bulk-Mask IN        -    X    -    -    -    -    -
>> -    -    -    -    -    -    -    -    -
>> [23408.581224]  Bulk-Mask OUT       -    -    -    X    -    -    -
>> -    -    -    -    -    -    -    -    -
>> [23408.581225]  Int-Mask IN         -    -    X    -    -    -    -
>> -    -    -    -    -    -    -    -    -
>> [23408.581227]  Int-Mask OUT        -    -    -    -    -    -    -
>> -    -    -    -    -    -    -    -    -
>> [23408.581229]  Iso-Mask IN         -    -    -    -    -    -    -
>> -    -    -    -    -    -    -    -    -
>> [23408.581230]  Iso-Mask OUT        -    -    -    -    -    -    -
>> -    -    -    -    -    -    -    -    -
>> [23408.581232]  Toggle-Mask IN      -    -    -    -    -    -    -
>> -    -    -    -    -    -    -    -    -
>> [23408.581234]  Toggle-Mask OUT     -    -    -    -    -    -    -
>> -    -    -    -    -    -    -    -    -
>> [23408.581236]  Max-Packet IN    0064 0064 0008 0000 0000 0000 0000
>> 0000 0000 0000 0000 0000 0000 0000 0000 0000
>> [23408.581237]  Max-Packet OUT   0064 0000 0000 0064 0000 0000 0000
>> 0000 0000 0000 0000 0000 0000 0000 0000 0000
>> [23408.581238] --- END USB-DEVICE --------------------------
>> [23408.581239] --- LIST USB-DEVICES -------------------------
>> [23408.581240]  No HCD VENDOR   PROD  CLS SCLS PROT ->CTRL CTRL->
>> ->BULK BULK->  ->INT  INT-> ->ISOC ISOC-> STATE SPEED USED
>> [23408.581242] 001 000 0x199b 0x3065 0x02 0x00 0x00 0x0001 0x0001
>> 0x0002 0x0008 0x0004 0x0000 0x0000 0x0000 00000 00002    -
>> [23408.581244] --- END USB-DEVICES --------------------------
>> [23408.581258] RT-UHC-Driver: Loading Completed (48 Byte allocated)
>> [23408.582245] --- LIST USB-DEVICES -------------------------
>> [23408.582248]  No HCD VENDOR   PROD  CLS SCLS PROT ->CTRL CTRL->
>> ->BULK BULK->  ->INT  INT-> ->ISOC ISOC-> STATE SPEED USED
>> [23408.582251] 001 000 0x199b 0x3065 0x02 0x00 0x00 0x0001 0x0001
>> 0x0002 0x0008 0x0004 0x0000 0x0000 0x0000 00000 00002    X
>> [23408.582254] --- END USB-DEVICES --------------------------
>> [23408.582255] rt_cdc_acm[0]: device found, vendor=3D0x199b, product=3D0=
x3065
>>
>> I can provide more detailed info for debugging if it helps.  There is
>
> Does this issue persist?
>
>> also this warning when I compile usb4rt which seems a little
>> suspicious:
>>
>> /usr/src/usb4rt/host/rt_uhci.c: In function =E2=80=98rt_irq_handler=E2=
=80=99:
>> /usr/src/usb4rt/host/rt_uhci.c:854:12: warning: =E2=80=98p_td=E2=80=99 m=
ay be used
>> uninitialized in this function [-Wuninitialized]
>> /usr/src/usb4rt/host/rt_uhci.c:968:9: note: =E2=80=98p_td=E2=80=99 was d=
eclared here
>
> This is harmless (but will be silenced soon): p_td is never touched in
> case it remained uninitialized.
>
> Jan
>
>

