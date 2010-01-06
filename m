From: Flavio Alves <flavio.alves@domain.hid>
In-Reply-To: <4B426A3D.5020706@domain.hid>
References: <725957.56219.qm@domain.hid>
	<4AF04886.9040903@domain.hid>
	<1f3e02580911030745o128df8aeve4bdd44bad9c3db7@domain.hid>
	<4AF15D68.7060001@domain.hid>
	<873433.54790.qm@domain.hid>
	<1f3e02580911060139q60bc91f8k4e71d933a50895ba@domain.hid>
	<20091215213210.19d5b6a5@domain.hid>
	<1f3e02580912151715n1f587e87x48834799baf7eea7@domain.hid>
	<4303dd240912310452m6db83032rb42d13777efbf5a3@domain.hid>
	<4B3CC62D.6070709@domain.hid>
	<1262643246.20365.10.camel@domain.hid>
	<4B426A3D.5020706@domain.hid>
Content-Type: multipart/related; type="multipart/alternative";
	boundary="=-7prbHU9Fwx0X4YmlBoyg"
Date: Wed, 06 Jan 2010 08:56:34 -0200
Message-Id: <1262775394.7828.9.camel@domain.hid>
Mime-Version: 1.0
Subject: Re: [Xenomai-help] Porting I-Pipe for new ARM board
Reply-To: flavio.alves@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


--=-7prbHU9Fwx0X4YmlBoyg
Content-Type: multipart/alternative; boundary="=-ePSlCNX3QLo8hp9bN50L"


--=-ePSlCNX3QLo8hp9bN50L
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Indeed ... 

Making this pointer not null (initializing the tsc pointer) solve this
issue. Thanks again for your help.

Now I have the following situation in my xenomai boot process:

Starting
kernel ...                                                             
                                                                                
Uncompressing
Linux.............................................................
Linux version 2.6.29-rc8-davinci1 (flavio@domain.hid) (gcc version
4.3.3 (So0
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ),
cr=00053177                   
CPU: VIVT data cache, VIVT instruction
cache                                    
Machine: DaVinci DA850
EVM                                                      
Memory policy: ECC disabled, Data cache
writeback                               
DA0850 variant
0x0                                                              
Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
8128       
Kernel command line: mem=32M console=ttyS2,115200n8 root=/dev/ram0 rw
initrd=0x1
PID hash table entries: 128 (order: 7, 512
bytes)                               
I-pipe 1.13-03: pipeline
enabled.                                               
Console: colour dummy device
80x30                                              
Dentry cache hash table entries: 4096 (order: 2, 16384
bytes)                   
Inode-cache hash table entries: 2048 (order: 1, 8192
bytes)                     
Memory: 32MB = 32MB
total                                                       
Memory: 24248KB available (3580K code, 368K data, 148K
init)                    
Calibrating delay loop... 149.09 BogoMIPS
(lpj=745472)                          
Mount-cache hash table entries:
512                                             
CPU: Testing write buffer coherency:
ok                                         
net_namespace: 880
bytes                                                        
NET: Registered protocol family
16                                              
Pin I2C1_SCL already used for
UART2_RXD.                                        
Pin I2C1_SDA already used for
UART2_TXD.                                        
DaVinci: 144 gpio
irqs                                                          
bio: create slab <bio-0> at
0                                                   
SCSI subsystem
initialized                                                      
usbcore: registered new interface driver
usbfs                                  
usbcore: registered new interface driver
hub                                    
usbcore: registered new device driver
usb                                       
musb_hdrc: version 6.0, cppi4.1-dma, host,
debug=0                              
Waiting for PHY clock
good...                                                   
musb_hdrc: USB Host mode controller at fee00000 using DMA, IRQ
58               
musb_hdrc musb_hdrc: MUSB HDRC host
driver                                      
musb_hdrc musb_hdrc: new USB bus registered, assigned bus number
1              
usb usb1: configuration #1 chosen from 1
choice                                 
hub 1-0:1.0: USB hub
found                                                      
hub 1-0:1.0: 1 port
detected                                                    
NET: Registered protocol family
2                                               
IP route cache hash table entries: 1024 (order: 0, 4096
bytes)                  
TCP established hash table entries: 1024 (order: 1, 8192
bytes)                 
TCP bind hash table entries: 1024 (order: 0, 4096
bytes)                        
TCP: Hash tables configured (established 1024 bind
1024)                        
TCP reno
registered                                                             
NET: Registered protocol family
1                                               
checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd 
Freeing initrd memory:
4096K                                                    
I-pipe: Domain Xenomai
registered.                                              
Xenomai: hal/arm
started.                                                       
Xenomai: real-time nucleus v2.4.9.1 (Big Bad Moon)
loaded.                      
Xenomai: starting native API
services.                                          
Xenomai: starting POSIX
services.                                               
Xenomai: starting RTDM
services.                                                
msgmni has been set to
55                                                       
io scheduler noop
registered                                                    
io scheduler anticipatory registered
(default)                                  
Serial: 8250/16550 driver, 3 ports, IRQ sharing
disabled                        
serial8250.0: ttyS0 at MMIO 0x1c42000 (irq = 25) is a
16550A                    
serial8250.0: ttyS1 at MMIO 0x1d0c000 (irq = 53) is a
16550A                    
serial8250.0: ttyS2 at MMIO 0x1d0d000 (irq = 61) is a
16550A                    
console [ttyS2]
enabled                                                         
brd: module
loaded                                                              
davinci_emac_probe: using random MAC addr:
6a:c9:27:5d:9b:5c                    
emac-mii:
probed                                                                
dm9000 Ethernet Driver,
V1.31                                                   
console [netcon0]
enabled                                                       
netconsole: network logging
started                                             
Linux video capture interface:
v2.00                                            
Driver 'sd' needs updating - please use bus_type
methods                        
ahci ahci: forcing PORTS_IMPL to
0x1                                            
ahci ahci: AHCI 0001.0100 32 slots 1 ports 3 Gbps 0x1 impl SATA
mode            
ahci ahci: flags: ncq sntf pm led clo only pmp pio slum
part                    
scsi0 :
ahci                                                                    
ata1: SATA max UDMA/133 irq
67                                                  

I still cannot boot my kernel using xenomai.

I would like to ask you some advice about the reasons why the kernel
boot stops at this point?

Thanks again for all the help

Best regards,

Flavio

On Seg, 2010-01-04 at 23:22 +0100, Gilles Chanteperdrix wrote:

> Flavio Alves wrote:
> > <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000 
> > Looking at the code (and perform some analysis) I saw that the call that
> > is crashing the kernel is:
> > 
> >  __asm__("ldmia %1, %M0\n":
> > 	    "=r"(result.full): "r"(local_tsc), "m"(*local_tsc));
> > 
> > And looking into the implementation of this function for other
> > platforms, I can see that it is the same instruction, without
> > difference.
> 
> On all other platforms the "local_tsc" pointer is not NULL...
> 










Flavio de
Castro Alves
Filho
flavio.alves@domain.hid

Tel.: + 55 11
8494-5676
Embedded
Software
Services

www.phiinnovations.com











Escritórios::
São Paulo
Campinas



--=-ePSlCNX3QLo8hp9bN50L
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.24.1.1">
</HEAD>
<BODY>
Indeed ... <BR>
<BR>
Making this pointer not null (initializing the tsc pointer) solve this issue. Thanks again for your help.<BR>
<BR>
Now I have the following situation in my xenomai boot process:<BR>
<BR>
Starting kernel ...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
Uncompressing Linux.............................................................<BR>
Linux version 2.6.29-rc8-davinci1 (flavio@domain.hid) (gcc version 4.3.3 (So0<BR>
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
CPU: VIVT data cache, VIVT instruction cache&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
Machine: DaVinci DA850 EVM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
Memory policy: ECC disabled, Data cache writeback&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
DA0850 variant 0x0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
Built 1 zonelists in Zone order, mobility grouping on.&nbsp; Total pages: 8128&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
Kernel command line: mem=32M console=ttyS2,115200n8 root=/dev/ram0 rw initrd=0x1<BR>
PID hash table entries: 128 (order: 7, 512 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
I-pipe 1.13-03: pipeline enabled.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
Console: colour dummy device 80x30&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
Memory: 32MB = 32MB total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
Memory: 24248KB available (3580K code, 368K data, 148K init)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
Calibrating delay loop... 149.09 BogoMIPS (lpj=745472)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
Mount-cache hash table entries: 512&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
CPU: Testing write buffer coherency: ok&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
net_namespace: 880 bytes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
NET: Registered protocol family 16&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
Pin I2C1_SCL already used for UART2_RXD.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
Pin I2C1_SDA already used for UART2_TXD.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
DaVinci: 144 gpio irqs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
bio: create slab &lt;bio-0&gt; at 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
SCSI subsystem initialized&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
usbcore: registered new interface driver usbfs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
usbcore: registered new interface driver hub&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
usbcore: registered new device driver usb&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
musb_hdrc: version 6.0, cppi4.1-dma, host, debug=0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
Waiting for PHY clock good...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
musb_hdrc: USB Host mode controller at fee00000 using DMA, IRQ 58&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
musb_hdrc musb_hdrc: MUSB HDRC host driver&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
musb_hdrc musb_hdrc: new USB bus registered, assigned bus number 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
usb usb1: configuration #1 chosen from 1 choice&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
hub 1-0:1.0: USB hub found&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
hub 1-0:1.0: 1 port detected&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
NET: Registered protocol family 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
TCP established hash table entries: 1024 (order: 1, 8192 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
TCP: Hash tables configured (established 1024 bind 1024)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
TCP reno registered&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
NET: Registered protocol family 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd <BR>
Freeing initrd memory: 4096K&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
I-pipe: Domain Xenomai registered.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
Xenomai: hal/arm started.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
Xenomai: real-time nucleus v2.4.9.1 (Big Bad Moon) loaded.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
Xenomai: starting native API services.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
Xenomai: starting POSIX services.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
Xenomai: starting RTDM services.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
msgmni has been set to 55&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
io scheduler noop registered&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
io scheduler anticipatory registered (default)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
Serial: 8250/16550 driver, 3 ports, IRQ sharing disabled&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
serial8250.0: ttyS0 at MMIO 0x1c42000 (irq = 25) is a 16550A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
serial8250.0: ttyS1 at MMIO 0x1d0c000 (irq = 53) is a 16550A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
serial8250.0: ttyS2 at MMIO 0x1d0d000 (irq = 61) is a 16550A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
console [ttyS2] enabled&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
brd: module loaded&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
davinci_emac_probe: using random MAC addr: 6a:c9:27:5d:9b:5c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
emac-mii: probed&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
dm9000 Ethernet Driver, V1.31&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
console [netcon0] enabled&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
netconsole: network logging started&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
Linux video capture interface: v2.00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
Driver 'sd' needs updating - please use bus_type methods&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
ahci ahci: forcing PORTS_IMPL to 0x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
ahci ahci: AHCI 0001.0100 32 slots 1 ports 3 Gbps 0x1 impl SATA mode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
ahci ahci: flags: ncq sntf pm led clo only pmp pio slum part&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
scsi0 : ahci&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
ata1: SATA max UDMA/133 irq 67&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
<BR>
I still cannot boot my kernel using xenomai.<BR>
<BR>
I would like to ask you some advice about the reasons why the kernel boot stops at this point?<BR>
<BR>
Thanks again for all the help<BR>
<BR>
Best regards,<BR>
<BR>
Flavio<BR>
<BR>
On Seg, 2010-01-04 at 23:22 +0100, Gilles Chanteperdrix wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
Flavio Alves wrote:
&gt; &lt;1&gt;Unable to handle kernel NULL pointer dereference at virtual address 00000000 
&gt; Looking at the code (and perform some analysis) I saw that the call that
&gt; is crashing the kernel is:
&gt; 
&gt;  __asm__(&quot;ldmia %1, %M0\n&quot;:
&gt; 	    &quot;=r&quot;(result.full): &quot;r&quot;(local_tsc), &quot;m&quot;(*local_tsc));
&gt; 
&gt; And looking into the implementation of this function for other
&gt; platforms, I can see that it is the same instruction, without
&gt; difference.

On all other platforms the &quot;local_tsc&quot; pointer is not NULL...

</PRE>
</BLOCKQUOTE>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100">
<TR>
<TD ALIGN="left" VALIGN="bottom">
<IMG SRC="cid:1262775212.7828.4.camel@domain.hid" ALIGN="bottom" BORDER="0">
</TD>
<TD WIDTH="7" VALIGN="bottom">
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
</TD>
<TD WIDTH="188" VALIGN="bottom">
<B><FONT SIZE="1"><FONT COLOR="#5d9db5">Flavio de Castro Alves Filho</FONT></FONT></B><BR>
<FONT SIZE="1"><FONT COLOR="#000080"><A HREF="mailto:hayram.nicacio@domain.hid">flavio.alves@domain.hid.</A><A HREF="mailto:hayram.nicacio@domain.hid">com</A></FONT></FONT><BR>
<BR>
<FONT SIZE="1"><FONT COLOR="#272976">Tel.: + 55 11 8494-5676</FONT></FONT><BR>
<FONT SIZE="1"><FONT COLOR="#272976">Embedded Software Services</FONT></FONT><BR>
<BR>
<FONT SIZE="1"><FONT COLOR="#6f7072"><A HREF="http://www.phiinnovations.com">www.phiinnovations.com</A></FONT></FONT>
</TD>
<TD WIDTH="7" VALIGN="bottom">
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
</TD>
<TD WIDTH="69" VALIGN="bottom">
<FONT SIZE="1"><FONT COLOR="#6f7072">Escrit&#243;rios::</FONT></FONT><BR>
<FONT SIZE="1"><FONT COLOR="#272976">S&#227;o Paulo</FONT></FONT><BR>
<FONT SIZE="1"><FONT COLOR="#272976">Campinas</FONT></FONT>
</TD>
</TR>
</TABLE>
<BR>
<BR>
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-ePSlCNX3QLo8hp9bN50L--

--=-7prbHU9Fwx0X4YmlBoyg
Content-ID: <1262775212.7828.4.camel@domain.hid>
Content-Disposition: attachment; filename="logo.gif"
Content-Type: image/gif; name="logo.gif"
Content-Transfer-Encoding: base64

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
6Zze6Z6+hEEAADs=


--=-7prbHU9Fwx0X4YmlBoyg--


