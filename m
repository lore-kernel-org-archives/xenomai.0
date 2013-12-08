From: "Andreas Gareis" <andreas.gareis@hs-augsburg.de>
References: 
In-Reply-To: 
Date: Sun, 8 Dec 2013 20:44:21 +0100
Message-ID: <006201cef44d$e4967d90$adc378b0$@hs-augsburg.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Content-Language: de
Subject: [Xenomai] rtdm can on mpc5121e - no rtcan devices detected
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi Wolfgang, 

Thanks for your answer. 

On 11/30/2013 01:00, Wolfgang Grandegger wrote 
>Hi Andreas,
> 
>On 11/29/2013 03:06 PM, andreas.gareis wrote: 
>> Hello,
>> 
>> I am trying to get running xenomai with RTDM support on an embedde 
>>linux  system. A powerpc mpc5121e operates on this system. I've 
>>suceeded in  patching the linux (3.0.4) with xenomai (2.6.2.1). The 
>>xenomai kernel  seems to work correct as I was able to run some of the 
>>xenomai examples  and my own test application.
>> Now I want to use the CAN interface in realtime. I've activated 
>>"Real-time sub-system => Drivers => CAN drivers => RT-Socket-CAN,  CAN 
>>raw socket interface" and "Real-time sub-system => Drivers =>  CAN 
>>drivers => MSCAN driver for MPC52xx and MPC512x"
>> ("module" as well as "build-in")  and also  deactivated "Networking 
>>support => CAN bus subsystem support => Raw CAN  Protocol (raw access 
>>with CAN-ID filtering)" in the linux kernel  configuration. The entry 
>>"Networking support => CAN bus subsystem support

>> => CAN Device Drivers Freescale MPC5xxx onboard CAN controller" is 
>> enabled as the xenomai module "xeno_can_mscan.ko" isn't able to start 
>> without it.

>> When xenomai CAN modules are used as module (not build-in) I started 
>> the module "xeno_can.ko" and "xeno_can_mscan.ko" afterwards. No 
>> errors or warnings appear but there aren't new devices in "/dev", too.
> 
> Is the MSCAN device defined in your device tree (dts file)? If not, no 
> devices will be detected.

Yes, but I didn't modify the dts-file (which is used for "normal" (non
xenomai) Linux) as in rtcan_mscan_mpc5xxx.c there is a line which includes: 
 .compatible = "fsl,mpc5121-mscan" 
  
CAN0 entry in dts-file: 
   mscan@1300 { 
       compatible = "fsl,mpc5121-mscan"; 
       interrupts = <12 8>; 
       reg = <0x1300 0x80>; 
       fsl,mscan-clock-source = "ip"; 
   }; 

> RTCAN devices are not visible in /dev. It's not a character device. 
> You can find more informations in /proc/rtnet.
    
The files "devices" and "sockets" which are located in /proc/rtcan don't
have any entries. (/proc/rtnet doesn't exist on my system) 

>> How can I check if the module is working correctly? Or do I have to 
>> do some other initialization?
> 
> See above. When a MSCAN device is detected you should find a related 
> line in the kernel log (dmesg), starting with "MSCAN at ...".
> 
> Next time please make a CC to the Xenomai mailing list. 
> 
> Wolfgang. 

In kernelconfig I have enabled "Networking support => CAN bus subsystem
support => CAN Device Drivers Freescale MPC5xxx onboard CAN controller"
(Otherwise "insmod xeno_can_mscan.ko" gets stuck) 

After boot up dmesg shows: 

  I-pipe 2.13-03: pipeline enabled. 
  ... 
  I-pipe: Domain Xenomai registered. 
  Xenomai: hal/powerpc started. 
  Xenomai: scheduling class idle registered. 
  Xenomai: scheduling class rt registered. 
  Xenomai: real-time nucleus v2.6.0-rc5 (head) loaded. 
  Xenomai: debug mode enabled. 
  Xenomai: starting native API services. 
  Xenomai: starting POSIX services. 
  Xenomai: starting RTDM services. 
  ... 
  CAN device driver interface
  mpc5xxx_can 80001300.mscan: using 'ips_clk' with frequency divider 1
  mpc5xxx_can 80001300.mscan: MSCAN at 0xd10da300, irq 16, clock 66660000 Hz

  mpc5xxx_can 80001380.mscan: using 'ips_clk' with frequency divider 1
  mpc5xxx_can 80001380.mscan: MSCAN at 0xd10de380, irq 18, clock 66660000 Hz

  mpc5xxx_can 80002300.mscan: using 'ips_clk' with frequency divider 1
  mpc5xxx_can 80002300.mscan: MSCAN at 0xd10e2300, irq 90, clock 66660000 Hz

  mpc5xxx_can 80002380.mscan: using 'ips_clk' with frequency divider 1
  mpc5xxx_can 80002380.mscan: MSCAN at 0xd10e6380, irq 91, clock 66660000 Hz

  .. 
  can: controller area network core (rev 20090105 abi 8)
  ... 
  mpc5xxx_can 80001300.mscan: bitrate error 1.0%
  mpc5xxx_can 80001300.mscan: setting BTR0=0x05 BTR1=0x26
  can0 bitrate: 1010000, sample-point: 0.727
  mpc5xxx_can 80001380.mscan: bitrate error 1.0%
  mpc5xxx_can 80001380.mscan: setting BTR0=0x05 BTR1=0x26
  can1 bitrate: 1010000, sample-point: 0.727
  mpc5xxx_can 80002380.mscan: bitrate error 1.0%
  mpc5xxx_can 80002380.mscan: setting BTR0=0x05 BTR1=0x26
  can3 bitrate: 1010000, sample-point: 0.727 

After executing "insmod xeno_can.ko" dmesg shows: 
  RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development Team 

After executing "insmod xeno_can_mscan.ko" dmesg shows nothing. 

lsmod shows: 
  xeno_can_mscan 10840 0 - Live 0xd311a000
  xeno_can 16632 1 xeno_can_mscan, Live 0xd310b000 
  
Is there a problem when mpc5xxx_can is running before xeno_can_mscan is
loaded? 

Regards, Andreas




