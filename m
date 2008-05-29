Message-ID: <483ECB35.6020403@domain.hid>
Date: Thu, 29 May 2008 17:26:45 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <60078.189.4.74.190.1209348044.squirrel@domain.hid>	<481682B8.4050104@domain.hid>	<4816BF96.6010400@domain.hid>	<57472.150.162.12.153.1209499591.squirrel@domain.hid>	<48180F67.4080809@domain.hid>
	<482B8494.7050009@domain.hid>	<482BD2D4.5070408@domain.hid>
	<482C922E.1080002@domain.hid>	<482C9719.1080803@domain.hid>
	<482CA5B9.3030203@domain.hid>	<482CA862.9070105@domain.hid>
	<482D988A.8040503@domain.hid>	<48328F76.4090603@domain.hid>
	<4833A8F5.5070109@domain.hid>	<4834344E.4090706@domain.hid>	<48344261.2060102@domain.hid>
	<4834501C.30709@domain.hid>	<48345105.1060008@domain.hid>
	<48353FC2.3060708@domain.hid>	<49280.189.58.74.62.1211542371.squirrel@domain.hid>
	<4836AFD3.1090402@domain.hid> <4836C147.8020300@domain.hid>
	<48371813.6050007@domain.hid> <48372098.7080702@domain.hid>
	<48372EFE.1070503@domain.hid> <4837BFE8.40209@domain.hid>
	<483EC852.3080504@domain.hid>
In-Reply-To: <483EC852.3080504@domain.hid>
Content-Type: multipart/mixed; boundary="------------040202090704080909020707"
Subject: Re: [Xenomai-help] [Socketcan-users] RT - Socketcan
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Breno <breno@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------040202090704080909020707
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Breno wrote:
> Wolfgang Grandegger wrote:
>> Breno wrote:
>>   
>>> Wolfgang Grandegger wrote:
>>>     
>>>> Breno wrote:
>>>>  
>>>>       
>>>>> Wolfgang Grandegger wrote:
>>>>>    
>>>>>         
>>>>>> Wolfgang Grandegger wrote:
>>>>>>        
>>>>>>           
>>>>>>> breno@domain.hid wrote:
>>>>>>>            
>>>>>>>             
>>>>>>>>> Breno wrote:
>>>>>>>>>                    
>>>>>>>>>                 
>>>>>>>>>> Wolfgang Grandegger wrote:
>>>>>>>>>>                        
>>>>>>>>>>                   
>>>>>>>>>>> Breno wrote:
>>>>>>>>>>>
>>>>>>>>>>>                            
>>>>>>>>>>>                     
>>>>>>>>>>>> Wolfgang Grandegger wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>                                
>>>>>>>>>>>>                       
>>>>>>>>>>>>> Breno wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>                                    
>>>>>>>>>>>>>                         
>>>>>>>>>>>>>> Hi Wolfgang, I got the cannetdriver26 as you suggested some
>>>>>>>>>>>>>> e-mail
>>>>>>>>>>>>>> ago. Sorry my ignorance but how can I get it working o my
>>>>>>>>>>>>>> kernel. I
>>>>>>>>>>>>>> mentioned before that you have a script do get it build.
>>>>>>>>>>>>>> Could you
>>>>>>>>>>>>>> help me again on this issue?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>                                         
>>>>>>>>>>>>>>                           
>>>>>>>>>>>>> For what kernel?
>>>>>>>>>>>>>
>>>>>>>>>>>>> Wolfgang.
>>>>>>>>>>>>>
>>>>>>>>>>>>>                                     
>>>>>>>>>>>>>                         
>>>>>>>>>>>> Hi Wolfgang, I got a DENX Linux 2.6 Kernel Tree from DENX
>>>>>>>>>>>> project.
>>>>>>>>>>>> The last
>>>>>>>>>>>> commit I have is:
>>>>>>>>>>>>
>>>>>>>>>>>> commit 76e8fbcc9e3e928a6898a93e6077264f5cb8f432
>>>>>>>>>>>>   Author: Wolfgang Grandegger <wolf@domain.hid>
>>>>>>>>>>>>   Date:   Thu Mar 27 17:41:09 2008 +0100
>>>>>>>>>>>>
>>>>>>>>>>>>   Socket-CAN: merge with SVN trunk revision 690
>>>>>>>>>>>>
>>>>>>>>>>>>                                 
>>>>>>>>>>>>                       
>>>>>>>>>>> Can you use linux-2.6.25.4 from kernel.org for your hardware?
>>>>>>>>>>>
>>>>>>>>>>> Wolfgang.
>>>>>>>>>>>
>>>>>>>>>>>                             
>>>>>>>>>>>                     
>>>>>>>>>> But it doesn't have support for Xenomai, rigth? If so, which
>>>>>>>>>> version
>>>>>>>>>> should I use?
>>>>>>>>>>                         
>>>>>>>>>>                   
>>>>>>>>> You are right, an ADEOS i-Pipe patch is not yet avaliable for
>>>>>>>>> 2.6.25.
>>>>>>>>> Just to understand your requirements. You want to use the Xenomai
>>>>>>>>> real-time extension because you have hard real-time requirements,
>>>>>>>>> right?
>>>>>>>>> Do you want to access the CAN bus from a Xenomai real-time task?
>>>>>>>>> If yes,
>>>>>>>>> then you should use RT-Socket-CAN.
>>>>>>>>>
>>>>>>>>>                    
>>>>>>>>>                 
>>>>>>>>>> Anyway,I got the Denx-2.6.25 and I wanna configure it on my system
>>>>>>>>>> regardless of this
>>>>>>>>>> version doesn't have Xenomai support. To get an correct kernel
>>>>>>>>>> image on
>>>>>>>>>> my
>>>>>>>>>> present tree(2.6.24-commit
>>>>>>>>>> 76e8fbcc9e3e928a6898a93e6077264f5cb8f432 ) I
>>>>>>>>>> executed make lite5200_defconfig, at the kernel option and I set
>>>>>>>>>> lite5200.dts
>>>>>>>>>> and then do make zImage. That new tree seems have some
>>>>>>>>>> differences, do
>>>>>>>>>> you
>>>>>>>>>> know what commands do I have to execute? I'm using lite5200 powerpc
>>>>>>>>>> board.
>>>>>>>>>>                         
>>>>>>>>>>                   
>>>>>>>>> It does not make sense to switch to 2.6.25 now if you have real-time
>>>>>>>>> requirements. Please stop jumping from one setup to another. If
>>>>>>>>> something is not working, I'm willing to help.
>>>>>>>>>
>>>>>>>>> Wolfgang.
>>>>>>>>>
>>>>>>>>>                     
>>>>>>>>>                 
>>>>>>>> Hi Wolfgang, thanks for your support. I'm intending to use CAN
>>>>>>>> along with
>>>>>>>> rt-tasks. I had dropped the rt-socket CAN because of the error it
>>>>>>>> appears
>>>>>>>> when I send messages as explained some e-mails ago. For example:
>>>>>>>>
>>>>>>>> ./rtcanconfig rtcan0 -b100000 start ---> works properly!
>>>>>>>> ./rtcanrecv rtcan1 &
>>>>>>>> ./rtcansend rtcan0 -i0x123 1 2 3 4 5 6 7 8
>>>>>>>> #0 [8] <0x123> 00 00 00 04 05 06 07 08 ---> it seems to lose the
>>>>>>>> threes
>>>>>>>> first data.
>>>>>>>>                 
>>>>>>>>               
>>>>>>> Then let's try to fix that. Have you built and ran rtcansend and
>>>>>>> rtcanrecv as I suggested (the one created by "$ make" in the
>>>>>>> Xenomai top
>>>>>>> directory)? Did it make a difference?
>>>>>>>
>>>>>>> Do you see errors when you use the rtcanrecv option "-e 0xffff"?
>>>>>>>
>>>>>>>    ./rtcanrecv -e 0xffff rtcan1
>>>>>>>
>>>>>>>            
>>>>>>>             
>>>>>>>> My socket-can applications works perfectly!!!
>>>>>>>>                 
>>>>>>>>               
>>>>>>> Fine, but it's not useful to call Socket-CAN from an Xenomai real-time
>>>>>>> application. You will loose determinism.
>>>>>>>
>>>>>>> And we should continue this thread with CC to the Xenomai-help mailing
>>>>>>> list because it might be useful for others as well.
>>>>>>>             
>>>>>>>             
>>>>>> Maybe there is something wrong with your MSCAN clock settings.
>>>>>>
>>>>>> What frequency have you specified for
>>>>>> CONFIG_XENO_DRIVERS_CAN_MSCAN_CLOCK (check your kernel .config)?
>>>>>>
>>>>>> And what MPC5200 CPU do you have? Could you show use the initial output
>>>>>> of your bootloader?
>>>>>>
>>>>>> Wolfgang.
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>         
>>>>>>           
>>>>> Hi Wolfgang, I have a stick on my board with lite5200 v2.0b. And at the
>>>>> top of my processor chip I have MPC5200b. The clock frequency is 
>>>>> 400MHz.
>>>>>     
>>>>>         
>>>> Well, this information does not match the boot output below.
>>>>
>>>>  
>>>>       
>>>>> My first messages on boot process is:
>>>>>
>>>>> U-Boot 1.1.4 (Feb 10 2006 - 11:06:33)
>>>>>     CPU:   MPC5200 v1.2 at 462 MHz
>>>>>     
>>>>>         
>>>> Seems to be a Rev. A CPU at 462 MHz. 1.1.4 is very old, though.
>>>>
>>>>  
>>>>       
>>>>>          Bus 132 MHz, IPB 66 MHz, PCI 33 MHz
>>>>>
>>>>>   Board: Motorola MPC5200 (IceCube)
>>>>>     
>>>>>         
>>>> BTW: do you have one or two PCI connectors on the board?
>>>>
>>>>  
>>>>       
>>>>>   I2C:   85 kHz, ready
>>>>>   DRAM:  64 MB
>>>>>   FLASH: 16 MB
>>>>>   PCI:   Bus Dev VenId DevId Class Int
>>>>>           00  1a  1057  5803  0680  00
>>>>>   In:    serial
>>>>>   Out:   serial
>>>>>   Err:   serial
>>>>>   Net:   FEC ETHERNET
>>>>>   IDE:   Bus 0: not available      Autostarting. Press any key to
>>>>> abort...
>>>>>     Hit any key to stop autoboot:  5
>>>>>   => tftp
>>>>>   Using FEC ETHERNET device
>>>>>   TFTP from server 192.168.1.100; our IP address is 192.168.1.101
>>>>>   Filename '5200/cuImage.52xx'.
>>>>>   Load address: 0x100000
>>>>>   Loading:
>>>>> *#################################################################
>>>>>        #################################################################
>>>>>        #################################################################
>>>>>        #################################################################
>>>>>   done
>>>>>   Bytes transferred = 1329135 (1447ef hex)
>>>>>   => bootm
>>>>>   ## Booting image at 00100000 ...
>>>>>      Image Name:   Linux-2.6.24.4-g5e9901e9-dirty
>>>>>      Created:      2008-04-15  16:35:09 UTC
>>>>>      Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>>>>>      Data Size:    1329071 Bytes =  1.3 MB
>>>>>      Load Address: 00400000
>>>>>      Entry Point:  0040055c
>>>>>      Verifying Checksum ... OK
>>>>>      Uncompressing Kernel Image ... OK
>>>>>
>>>>>  
>>>>> The frequency specified on CONFIG_XENO_DRIVERS_CAN_MSCAN_CLOCK is
>>>>> 66000000Hz. Is that correct?
>>>>>     
>>>>>         
>>>> For MPC5200 Rev. B CPU, it should be 33000000, but you have an old Rev.
>>>> A CPU and in that case 66000000 is correct.
>>>>
>>>> There is some help for corresponding Kconfig option:
>>>>
>>>>   config XENO_DRIVERS_CAN_MSCAN_CLOCK
>>>>         depends on XENO_DRIVERS_CAN_MSCAN
>>>>         int "Clock Frequency in Hz"
>>>>         default 66000000
>>>>         help
>>>>
>>>>         The MSCAN driver selects the oscillator clock (SYS_XTAL_IN) as
>>>>         clock source for MSCAN, which is typically 33 MHz. Due to a
>>>>         hardware bug on the MPC5200 Rev. A chips, the IP bus clock
>>>>         (IP_CLK) is used instead, which is typically 66 or 132 MHz.
>>>>
>>>> How does your CAN cabling look like. Is the CAN bus properly terminated
>>>> on both ends?
>>>>
>>>> Wolfgang.
>>>>   
>>>>       
>>> Hi Wolfgang, it's not a professional cable!!! I just use a 10 pins flat
>>> cable to connect CAN0 and CAN1 on board interfaces  for testings, I
>>> mean, I don't have  a bus exactly but just a simple cable. Could you
>>> pass me a  good reference of cables for a property use?
>>>     
>>
>> Handmade cables are OK but you need proper termination with 120 Ohm at
>> both ends of the cable. Either there is on-board termination, sometimes
>> selectable via jumpers, or you have to add resistors at the end of your
>> cable. Take an Ohmmeter and measure the resistance between pin 2 and 7
>> of your connector.
>>
>> Wolfgang.
>>   
> Hi Wolfgang, I got the rt-socket working now. I did your suggestion
> about xenomai make and make install steps.

Good news.

> But It doesn't mean that all application I have made using Xenomai API I
> have to follow those steps, right?  I can use the Makefile in
> Xenomais/examples just as is to generate my "executables".

Of course, no problem if you build your application correctly. In the
meantime I have verified that RT-Socket-CAN is working correctly on my
TQM5200 board. The attached log file might be useful for you as well.

Wolfgang.

--------------040202090704080909020707
Content-Type: text/x-log;
 name="rt-socket-can-test.log"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="rt-socket-can-test.log"

$ export CROSS_COMPILE=ppc_6xx
$ cd <work-dir>


>>> Get the sources

$ git clone git://git.denx.de/linux-2.6-denx.git
$ export KDIR=$PWD/linux-2.6-denx

$ svn co http://svn.gna.org/svn/xenomai/branches/v2.4.x xenomai-2.4.x
$ export XDIR=$PWD/xenomai-2.4.x

$ cd $KDIR
$ git checkout origin/DENX-v2.6.24-stable


>>> Prepare kernel to use Xenomai

$ cd $XDIR
$ scripts/prepare-kernel.sh --linux=$KDIR --verbose --arch=powerpc


>>> Configure and make the Linux kernel with RT-Socket-CAN support

$ cd $KDIR
$ make ARCH=powerpc tqm5200_defconfig
$ make ARCH=powerpc menuconfig
  ... enable RT-Socket-CAN and MSCAN driver ...
  <*> RT-Socket-CAN, CAN raw socket interface
  [*]   Enable debug output (NEW)
  [ ]   Enable TX loopback to local sockets (NEW)
  (1024) Size of receive ring buffers (must be 2^N) (NEW)
  (4)   Maximum number of devices (NEW)
  (16)  Maximum number of receive filters per device (NEW)
  < >   Virtual CAN bus driver (NEW)
  <*>   MSCAN driver for MPC52xx
  [*]     Enable CAN 1 (NEW)
  [*]     Enable CAN 2 (NEW)
  (66000000) Clock Frequency in Hz (NEW)
          Pin Configuration (CAN 1 on I2C1 pins, CAN 2 on TMR01 pin
  ...
$ make ARCH=powerpc uImage
$ cp -p arch/powerpc/boot/uImage /tftpboot/tqm5200/


>>> Configure, make and install the Xenomai user space utilities

$ cd $XDIR
$ ./configure --host=ppc-linux --prefix=/root/xeno-rsc
$ make
$ export DESTDIR=/opt/eldk/ppc_6xx
$ make install

>>> Boot the new kernel and mount the rootfs /opt/eldk/ppc_6xx

## Booting kernel from Legacy Image at 00600000 ...
   Image Name:   Linux-2.6.24.7-dirty
   Created:      2008-05-23  13:01:44 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1694392 Bytes =  1.6 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Flattened Device Tree blob at 00000000
   Booting using the fdt blob at 0x5f0000
Using tqm5200 machine description
Linux version 2.6.24.7-dirty (wolf@domain.hid) (gcc version 4.0.0 (DENX ELDK 4.1 4.0.0)) #2 Fri May 23 15:01:42 CEST 2008
Zone PFN ranges:
  DMA             0 ->    32768
  Normal      32768 ->    32768
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->    32768
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
Kernel command line: root=/dev/nfs rw nfsroot=10.0.30.2:/opt/eldk4/ppc_6xx ip=10.0.30.210:10.0.30.2:::tqm5200:eth0:off panic=1 console=ttyPSC0,115200
MPC52xx PIC is up and running!
PID hash table entries: 512 (order: 9, 2048 bytes)
clocksource: timebase mult[79364d9] shift[22] registered
I-pipe 2.1-03: pipeline enabled.
console [ttyPSC0] enabled
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 125908k/131072k available (3364k kernel code, 5004k reserved, 152k data, 288k bss, 160k init)
SLUB: Genslabs=11, HWalign=32, Order=0-1, MinObjects=4, CPUs=1, Nodes=1
Mount-cache hash table entries: 512
net_namespace: 64 bytes
NET: Registered protocol family 16
PCI: Probing PCI hardware
DMA: MPC52xx BestComm driver
DMA: MPC52xx BestComm engine @f0001200 ok !
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Time: timebase clocksource has been installed.
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
I-pipe: Domain Xenomai registered.
Xenomai: hal/powerpc started.
Xenomai: real-time nucleus v2.5-devel (Flying In A Blue Dream) loaded.
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.
JFFS2 version 2.2. (NAND) ������ 2001-2006 Red Hat, Inc.
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Generic RTC Driver v1.07
Serial: MPC52xx PSC UART driver
f0002000.serial: ttyPSC0 at MMIO 0xf0002000 (irq = 129) is a MPC52xx PSC
f0002200.serial: ttyPSC1 at MMIO 0xf0002200 (irq = 130) is a MPC52xx PSC
f0002400.serial: ttyPSC2 at MMIO 0xf0002400 (irq = 131) is a MPC52xx PSC
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
loop: module loaded
mpc52xx MII bus: probed
Driver 'sd' needs updating - please use bus_type methods
ata: MPC52xx IDE/ATA libata driver
scsi0 : mpc52xx_ata
ata1: PATA max PIO4 ata_regs 0xf0003a00 irq 135
usbmon: debugfs is not available
ppc-of-ohci f0001000.usb: OF OHCI
ppc-of-ohci f0001000.usb: new USB bus registered, assigned bus number 1
ppc-of-ohci f0001000.usb: irq 134, io mem 0xf0001000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
i2c /dev entries driver
RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development Team
MSCAN: CAN 1 routed to I2C1 pins and CAN2 to TMR01 pins
rtcan: registered rtcan0
rtcan0: MSCAN driver loaded (port 1, base-addr 0xf0000900 irq 145)
rtcan: registered rtcan1
rtcan1: MSCAN driver loaded (port 2, base-addr 0xf0000980 irq 146)
RTCAN SJA1000 driver initialized
PEAK-PCI-CAN: initializing device 001c:0001
PEAK-PCI-CAN: base_addr=c907c000 conf_addr=c907a000 irq=16
rtcan: registered rtcan2
PEAK-PCI-CAN: base_addr=c907e400 conf_addr=c907a000 irq=16
rtcan: registered rtcan3
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
net eth0: attached phy 0 to driver LXT971
IP-Config: Guessing netmask 255.0.0.0
IP-Config: Complete:
      device=eth0, addr=10.0.30.210, mask=255.0.0.0, gw=255.255.255.255,
     host=tqm5200, domain=, nis-domain=(none),
     bootserver=10.0.30.2, rootserver=10.0.30.2, rootpath=
Looking up port of RPC 100003/2 on 10.0.30.2
PHY: f0003000:00 - Link is Up - 100/Full
Looking up port of RPC 100005/1 on 10.0.30.2
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 160k init
modprobe: FATAL: Could not load /lib/modules/2.6.24.7-dirty/modules.dep: No such file or directory

modprobe: FATAL: Could not load /lib/modules/2.6.24.7-dirty/modules.dep: No such file or directory

INIT: version 2.85 booting
                Welcome to DENX Embedded Linux Environment
                Press 'I' to enter interactive startup.
Building the cache [  OK  ]
 storage network audio done[  OK  ]
Timed out waiting for time change.
Setting clock : Thu Oct 24 04:56:47 UTC 1963 [  OK  ]
Setting hostname tqm5200:  [  OK  ]
Mounting local filesystems:  [  OK  ]
Enabling swap space:  [  OK  ]
INIT: Entering runlevel: 3
Entering non-interactive startup
Bringing up loopback interface:  [  OK  ]
Starting system logger: [  OK  ]
Starting kernel logger: [  OK  ]
Starting portmap: portmap: fork: No such device[  OK  ]
Mounting NFS filesystems:  [  OK  ]
Mounting other filesystems:  [  OK  ]
Starting xinetd: [  OK  ]

DENX ELDK version 4.1 build 2007-01-19
Linux 2.6.24.7-dirty on a ppc

tqm5200 login: root
Last login: Thu Oct 24 04:58:31 from 10.0.30.2

# export PATH=$PATH:/root/xeno-rsc/sbin:/root/xeno-rsc/bin

# rtcanconfig rtcan0 -b 500000 up
# rtcanconfig rtcan1 -b 500000 up

# cat /proc/rtcan/devices
Name___________ _Baudrate State___ TX_Counter RX_Counter ____Errors
rtcan0             500000 active            0          0          0
rtcan1             500000 active            0          0          0
rtcan2          undefined stopped           0          0          0
rtcan3          undefined stopped           0          0          0

# cat /proc/rtcan/rtcan0/info 
Device     rtcan0
Controller MSCAN-MPC5200
Board      unkown
Clock-Hz   33000000
Baudrate   500000
Bit-time   brp=3 prop_seg=0 phase_seg1=16 phase_seg2=5 sjw=1 sam=0
Ctrl-Mode  
State      active
TX-Counter 0
RX-Counter 0
Errors     0
Refcount   0

# cat /proc/rtcan/rtcan2/info 
Device     rtcan2
Controller SJA1000
Board      PEAK-PCI
Clock-Hz   8000000
Baudrate   undefined
Bit-time   brp=0 prop_seg=0 phase_seg1=0 phase_seg2=0 sjw=0 sam=0
Ctrl-Mode  
State      stopped
TX-Counter 0
RX-Counter 0
Errors     0
Refcount   0

# rtcanrecv -v -e 0xffff &
interface all
Using err_mask=0xffff
#0: (2) <0x001> [8] 01 02 03 04 05 06 07 08
#1: (2) <0x001> [8] 01 02 03 04 05 06 07 08
#2: (2) <0x001> [8] 01 02 03 04 05 06 07 08
#3: (2) <0x001> [8] 01 02 03 04 05 06 07 08
#4: (2) <0x001> [8] 01 02 03 04 05 06 07 08
#5: (2) <0x001> [8] 01 02 03 04 05 06 07 08
#6: (2) <0x001> [8] 01 02 03 04 05 06 07 08
#7: (2) <0x001> [8] 01 02 03 04 05 06 07 08
#8: (2) <0x001> [8] 01 02 03 04 05 06 07 08
#9: (2) <0x001> [8] 01 02 03 04 05 06 07 08

# rtcansend -d 500 -l 10 rtcan0 1 2 3 4 5 6 7 8

# cat /proc/rtcan/devices
Name___________ _Baudrate State___ TX_Counter RX_Counter ____Errors
rtcan0             500000 active           10          0          0
rtcan1             500000 active            0         10          0
rtcan2          undefined stopped           0          0          0
rtcan3          undefined stopped           0          0          0


--------------040202090704080909020707--

