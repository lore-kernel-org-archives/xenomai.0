Message-ID: <4C4A292F.5040900@domain.hid>
Date: Fri, 23 Jul 2010 16:43:43 -0700
From: Bob Feretich <bob.feretich@domain.hid>
MIME-Version: 1.0
References: <4C43C83F.5030401@domain.hid>
	<4C43D265.9080609@domain.hid>	<4C43FC4F.3010006@domain.hid>
	<4C440D6F.1060204@domain.hid>	<4C44E9C9.3020600@domain.hid>
	<4C454C0C.6000100@domain.hid>	<4C4550C8.3070504@domain.hid>
	<4C45541C.5090507@domain.hid> <4C45CEE6.5000903@domain.hid>
	<4C460506.3010103@domain.hid> <4C46141F.50103@domain.hid>
	<4C468040.3030509@domain.hid> <4C468485.5060408@domain.hid>
	<4C47597F.1010406@domain.hid>
	<4C478313.2030606@domain.hid>
	<4C48C1BB.8080606@domain.hid> <4C48C2CE.1030706@domain.hid>
In-Reply-To: <4C48C2CE.1030706@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------040401050406050206060908"
Subject: Re: [Xenomai-help] Adeos patch prevents IRQ 384 (MMC Chip Detect)
 on omap-2.6.33
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------040401050406050206060908
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

  I have started a new thread with a name that better describes the 
failure I am seeing. This may or may not be the reason I was seeing root 
file system mount hang on omap-2.6.31 (previous thread).

The SD card/MMC  "Chip Detect" interrupt (activated when a SD card is 
inserted or removed) can't be tested when the root file system is on the 
SD card. So I rebuilt my 2.6.33 BeagleBoard system to mount the root 
file system via NFS. Now the  failure of Xenomai to handle twl4030 
interrupts can be identified and isolated.

2.6.33 without the Adeos patch...
The Angstrom Distribution beagleboard ttyS2

Angstrom 2010.4-test-20100518 beagleboard ttyS2

beagleboard login: root
root@domain.hid:~# cat /proc/interrupts
            CPU0
   7:          2        INTC  TWL4030-PIH
  12:        203        INTC  DMA
  37:       1219        INTC  gp timer
  56:        368        INTC  i2c_omap
  61:          0        INTC  i2c_omap
  74:        125        INTC  serial
  77:      10694        INTC  ehci_hcd:usb2
  83:        106        INTC  mmc0
  92:          1        INTC  musb_hdrc
  93:          0        INTC  musb_hdrc
378:          2     twl4030  twl4030_usb
379:          0     twl4030  rtc0
384:          0     twl4030  mmc0
Err:          0
root@domain.hid:~# ls /dev
block               ram6                tty39
... snipped ...
mem                 tty2                tty58
mmcblk0             tty20               tty59
mmcblk0p1           tty21               tty6
mmcblk0p2           tty22               tty60
network_latency     tty23               tty61
... snipped ...
root@domain.hid:~# umount /dev/mmcblk0p1
root@domain.hid:~# umount /dev/mmcblk0p2

****** I removed the SD card here ****************************

root@domain.hid:~# [  122.126495] mmc0: card 0007 removed
root@domain.hid:~# ls /dev
block               ram9                tty40
... snipped ...
mem                 tty21               tty59 <=== mmc entries are gone
network_latency     tty22               tty6
... snipped ...
root@domain.hid:~# cat /proc/interrupts
            CPU0
   7:          3        INTC  TWL4030-PIH
  12:        208        INTC  DMA
  37:       2477        INTC  gp timer
  56:        388        INTC  i2c_omap
  61:          0        INTC  i2c_omap
  74:        437        INTC  serial
  77:      12374        INTC  ehci_hcd:usb2
  83:        135        INTC  mmc0
  92:          1        INTC  musb_hdrc
  93:          0        INTC  musb_hdrc
378:          2     twl4030  twl4030_usb
379:          0     twl4030  rtc0
384:          1     twl4030  mmc0 <===== notice the Chip Detect irpt
Err:          0

****** I reinserted the SD card here ****************************

root@domain.hid:~# [  270.691955] mmc0: new high speed SD card at 
address 0007
[  270.699981] mmcblk0: mmc0:0007 SD01G 972 MiB
[  270.704742]  mmcblk0: p1 p2
[  271.448608] EXT2-fs (mmcblk0p2): warning: mounting ext3 filesystem as 
ext2
[  271.455749] EXT2-fs (mmcblk0p2): warning: mounting unchecked fs, 
running e2fsck is recommended

root@domain.hid:~# cat /proc/interrupts
            CPU0
   7:          4        INTC  TWL4030-PIH
  12:        358        INTC  DMA
  37:       3520        INTC  gp timer
  56:        416        INTC  i2c_omap
  61:          0        INTC  i2c_omap
  74:        625        INTC  serial
  77:      14021        INTC  ehci_hcd:usb2
  83:        247        INTC  mmc0
  92:          1        INTC  musb_hdrc
  93:          0        INTC  musb_hdrc
378:          2     twl4030  twl4030_usb
379:          0     twl4030  rtc0
384:          2     twl4030  mmc0 <===== notice second Chip Detect irpt
Err:          0

2.6.33 with the Adeos patch and Xenomai enabled...
The Angstrom Distribution beagleboard ttyS2

Angstrom 2010.4-test-20100518 beagleboard ttyS2

beagleboard login: root
root@domain.hid:~# cat /proc/interrupts
            CPU0
   7:     161656        INTC  TWL4030-PIH
  12:        176        INTC  DMA
  37:       2642        INTC  gp timer
  56:     585760        INTC  i2c_omap
  61:          0        INTC  i2c_omap
  74:         85        INTC  serial
  77:      11018        INTC  ehci_hcd:usb2
  83:        144        INTC  mmc0
  92:          1        INTC  musb_hdrc
  93:          0        INTC  musb_hdrc
378:          0     twl4030  twl4030_usb
379:          0     twl4030  rtc0
384:          0     twl4030  mmc0
Err:          0
root@domain.hid:~# ls /dev
block               rtp11               tty29
... snipped ...
mem                 rtp30               tty48
mmcblk0             rtp31               tty49
mmcblk0p1           rtp4                tty5
mmcblk0p2           rtp5                tty50
network_latency     rtp6                tty51
... snipped ...
root@domain.hid:~# umount /dev/mmcblk0p1
root@domain.hid:~# umount /dev/mmcblk0p2

****** I removed the SD card here, no removal msg  *****************

root@domain.hid:~# ls /dev
block               rtp11               tty29
... snipped ...
mem                 rtp30               tty48
mmcblk0             rtp31               tty49
mmcblk0p1           rtp4                tty5
mmcblk0p2           rtp5                tty50
network_latency     rtp6                tty51
... snipped ...
root@domain.hid:~# cat /proc/interrupts
            CPU0
   7:    1106318        INTC  TWL4030-PIH
  12:        180        INTC  DMA
  37:      13933        INTC  gp timer
  56:    4029606        INTC  i2c_omap
  61:          0        INTC  i2c_omap
  74:        440        INTC  serial
  77:      12416        INTC  ehci_hcd:usb2
  83:        364        INTC  mmc0
  92:          1        INTC  musb_hdrc
  93:          0        INTC  musb_hdrc
378:          0     twl4030  twl4030_usb <=== also 0, but not sure if 
its meaningful
379:          0     twl4030  rtc0
384:          0     twl4030  mmc0 <===== no Chip Detect irpt
Err:          0

Reinserting the SD card did not result in a message. The SD card file 
systems seemed to be in a half mounted state.

I suspect that this bug effects all interrupts received via twl4030 
family devices.

Regards,
Bob Feretich

On 7/22/2010 3:14 PM, Gilles Chanteperdrix wrote:
> ... snipped ...
> As I said, the absence of IRQ 378 in 2.6.33 looks like a regression,
> which should be easy to find with git bisect. Then when you know the
> commit which caused the regression, tell me, I will revert it on 2.6.33,
> so that I can reproduce the bug you are facing on my board, and
> hopefully what happens with the Adeos patch.
>
>

--------------040401050406050206060908
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#ffffff" text="#000000">
    I have started a new thread with a name that better describes the
    failure I am seeing. This may or may not be the reason I was seeing
    root file system mount hang on omap-2.6.31 (previous thread).<br>
    <br>
    The SD card/MMC  "Chip Detect" interrupt (activated when a SD card
    is inserted or removed) can't be tested when the root file system is
    on the SD card. So I rebuilt my 2.6.33 BeagleBoard system to mount
    the root file system via NFS. Now the  failure of Xenomai to handle
    twl4030 interrupts can be identified and isolated.<br>
    <br>
    2.6.33 without the Adeos patch...<br>
    <small><tt>The Angstrom Distribution beagleboard ttyS2<br>
        <br>
        Angstrom 2010.4-test-20100518 beagleboard ttyS2<br>
        <br>
        beagleboard login: root<br>
        root@domain.hid:~# cat /proc/interrupts<br>
                   CPU0<br>
          7:          2        INTC  TWL4030-PIH<br>
         12:        203        INTC  DMA<br>
         37:       1219        INTC  gp timer<br>
         56:        368        INTC  i2c_omap<br>
         61:          0        INTC  i2c_omap<br>
         74:        125        INTC  serial<br>
         77:      10694        INTC  ehci_hcd:usb2<br>
         83:        106        INTC  mmc0<br>
         92:          1        INTC  musb_hdrc<br>
         93:          0        INTC  musb_hdrc<br>
        378:          2     twl4030  twl4030_usb<br>
        379:          0     twl4030  rtc0<br>
        384:          0     twl4030  mmc0<br>
        Err:          0<br>
        root@domain.hid:~# ls /dev<br>
        block               ram6                tty39<br>
        ... snipped ...<br>
        mem                 tty2                tty58<br>
        mmcblk0             tty20               tty59<br>
        mmcblk0p1           tty21               tty6<br>
        mmcblk0p2           tty22               tty60<br>
        network_latency     tty23               tty61<br>
        ... snipped ...<br>
        root@domain.hid:~# umount /dev/mmcblk0p1<br>
        root@domain.hid:~# umount /dev/mmcblk0p2<br>
        <br>
        ****** I removed the SD card here ****************************<br>
        <br>
        root@domain.hid:~# [  122.126495] mmc0: card 0007 removed<br>
        root@domain.hid:~# ls /dev<br>
        block               ram9                tty40<br>
        ... snipped ...<br>
        mem                 tty21               tty59  &lt;=== mmc
        entries are gone<br>
        network_latency     tty22               tty6<br>
        ... snipped ...<br>
        root@domain.hid:~# cat /proc/interrupts<br>
                   CPU0<br>
          7:          3        INTC  TWL4030-PIH<br>
         12:        208        INTC  DMA<br>
         37:       2477        INTC  gp timer<br>
         56:        388        INTC  i2c_omap<br>
         61:          0        INTC  i2c_omap<br>
         74:        437        INTC  serial<br>
         77:      12374        INTC  ehci_hcd:usb2<br>
         83:        135        INTC  mmc0<br>
         92:          1        INTC  musb_hdrc<br>
         93:          0        INTC  musb_hdrc<br>
        378:          2     twl4030  twl4030_usb<br>
        379:          0     twl4030  rtc0<br>
        384:          1     twl4030  mmc0          &lt;===== notice the
        Chip Detect irpt<br>
        Err:          0<br>
      </tt></small><small><tt><br>
        ****** I reinserted the SD card here
        ****************************<br>
        <small><br>
        </small> </tt><tt>root@domain.hid:~# [  270.691955] mmc0: new
        high speed SD card at address 0007<br>
        [  270.699981] mmcblk0: mmc0:0007 SD01G 972 MiB <br>
        [  270.704742]  mmcblk0: p1 p2<br>
        [  271.448608] EXT2-fs (mmcblk0p2): warning: mounting ext3
        filesystem as ext2<br>
        [  271.455749] EXT2-fs (mmcblk0p2): warning: mounting unchecked
        fs, running e2fsck is recommended<br>
        <br>
        root@domain.hid:~# cat /proc/interrupts<br>
                   CPU0<br>
          7:          4        INTC  TWL4030-PIH<br>
         12:        358        INTC  DMA<br>
         37:       3520        INTC  gp timer<br>
         56:        416        INTC  i2c_omap<br>
         61:          0        INTC  i2c_omap<br>
         74:        625        INTC  serial<br>
         77:      14021        INTC  ehci_hcd:usb2<br>
         83:        247        INTC  mmc0<br>
         92:          1        INTC  musb_hdrc<br>
         93:          0        INTC  musb_hdrc<br>
        378:          2     twl4030  twl4030_usb<br>
        379:          0     twl4030  rtc0<br>
        384:          2     twl4030  mmc0  </tt></small><small><tt>     
        &lt;===== notice second Chip Detect irpt</tt></small><br>
    <small><tt>Err:          0<br>
      </tt></small><br>
    2.6.33 with the Adeos patch and Xenomai enabled...<br>
    <small><tt>The Angstrom Distribution beagleboard ttyS2<br>
        <br>
        Angstrom 2010.4-test-20100518 beagleboard ttyS2<br>
        <br>
        beagleboard login: root<br>
        root@domain.hid:~# cat /proc/interrupts<br>
                   CPU0<br>
          7:     161656        INTC  TWL4030-PIH<br>
         12:        176        INTC  DMA<br>
         37:       2642        INTC  gp timer<br>
         56:     585760        INTC  i2c_omap<br>
         61:          0        INTC  i2c_omap<br>
         74:         85        INTC  serial<br>
         77:      11018        INTC  ehci_hcd:usb2<br>
         83:        144        INTC  mmc0<br>
         92:          1        INTC  musb_hdrc<br>
         93:          0        INTC  musb_hdrc<br>
        378:          0     twl4030  twl4030_usb<br>
        379:          0     twl4030  rtc0<br>
        384:          0     twl4030  mmc0<br>
        Err:          0<br>
        root@domain.hid:~# ls /dev<br>
        block               rtp11               tty29<br>
        ... snipped ...<br>
        mem                 rtp30               tty48<br>
        mmcblk0             rtp31               tty49<br>
        mmcblk0p1           rtp4                tty5<br>
        mmcblk0p2           rtp5                tty50<br>
        network_latency     rtp6                tty51<br>
        ... snipped ...<br>
        root@domain.hid:~# umount /dev/mmcblk0p1<br>
        root@domain.hid:~# umount /dev/mmcblk0p2<br>
        <br>
      </tt></small><small><tt>****** I removed the SD card here, no
        removal msg  *****************</tt></small><br>
    <small><tt><br>
        root@domain.hid:~# ls /dev<br>
        block               rtp11               tty29<br>
        ... snipped ...<br>
        mem                 rtp30               tty48<br>
        mmcblk0             rtp31               tty49<br>
        mmcblk0p1           rtp4                tty5<br>
        mmcblk0p2           rtp5                tty50<br>
        network_latency     rtp6                tty51<br>
        ... snipped ...<br>
        root@domain.hid:~# cat /proc/interrupts<br>
                   CPU0<br>
          7:    1106318        INTC  TWL4030-PIH<br>
         12:        180        INTC  DMA<br>
         37:      13933        INTC  gp timer<br>
         56:    4029606        INTC  i2c_omap<br>
         61:          0        INTC  i2c_omap<br>
         74:        440        INTC  serial<br>
         77:      12416        INTC  ehci_hcd:usb2<br>
         83:        364        INTC  mmc0<br>
         92:          1        INTC  musb_hdrc<br>
         93:          0        INTC  musb_hdrc<br>
        378:          0     twl4030  twl4030_usb </tt></small><small><tt>
        &lt;=== also 0, but not</tt><tt> </tt></small><small><tt>sure
        if its meaningful</tt></small><br>
    <small><tt>379:          0     twl4030  rtc0<br>
        384:          0     twl4030  mmc0   </tt></small><small><tt>  
        &lt;===== no Chip Detect irpt</tt></small><br>
    <small><tt>Err:          0</tt></small><br>
    <br>
    Reinserting the SD card did not result in a message. The SD card
    file systems seemed to be in a half mounted state.<br>
    <br>
    I suspect that this bug effects all interrupts received via twl4030
    family devices.<br>
    <br>
    Regards,<br>
    Bob Feretich<br>
    <br>
    On 7/22/2010 3:14 PM, Gilles Chanteperdrix wrote:
    <blockquote cite="mid:4C48C2CE.1030706@domain.hid" type="cite">
      <pre wrap="">... snipped ...
</pre>
      <pre wrap="">
As I said, the absence of IRQ 378 in 2.6.33 looks like a regression,
which should be easy to find with git bisect. Then when you know the
commit which caused the regression, tell me, I will revert it on 2.6.33,
so that I can reproduce the bug you are facing on my board, and
hopefully what happens with the Adeos patch.

</pre>
      <br>
    </blockquote>
  </body>
</html>

--------------040401050406050206060908--

