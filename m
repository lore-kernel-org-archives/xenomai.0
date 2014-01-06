MIME-Version: 1.0
In-Reply-To: <52CA622D.806@xenomai.org>
References: <CAFnctWFSGJc0Q6ebZ0zBhxRmFEwkvCYKinAEgD-xzcCbfLaPBg@mail.gmail.com>
 <52C7CF1E.2050404@xenomai.org> <52C85088.7020501@xenomai.org>
 <52C86093.4000609@xenomai.org>
 <CAFnctWG1QoQ=f9JCsdxAoU25mc797fKoT9dVS_DdZFRcQ5CP3A@mail.gmail.com>
 <52C891C1.2090007@xenomai.org>
 <CAFnctWFb-dNtNDGf0kckejhQ+tFAj2hBw3gm5Xv8DoALi6f26g@mail.gmail.com>
 <52C949D6.6090904@xenomai.org> <52C9B255.7030702@xenomai.org>
 <52CA622D.806@xenomai.org>
Date: Mon, 6 Jan 2014 11:10:58 -0800
Message-ID: <CAFnctWGs-mqukTTujenvex9Doq0DoJ_ohFEPDjd7ECYRzu6tpw@mail.gmail.com>
From: Nima Nourozi <n.nourozi@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] rtdm_task_init call freezes the system
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Sun, Jan 5, 2014 at 11:58 PM, Philippe Gerum <rpm@xenomai.org> wrote:

> On 01/05/2014 08:28 PM, Gilles Chanteperdrix wrote:
>
>> On 01/05/2014 01:02 PM, Philippe Gerum wrote:
>>
>>> On 01/05/2014 01:25 AM, Nima Nourozi wrote:
>>>
>>>> On Sat, Jan 4, 2014 at 2:57 PM, Philippe Gerum <rpm@xenomai.org
>>>> <mailto:rpm@xenomai.org>> wrote:
>>>>
>>>>      On 01/04/2014 09:29 PM, Nima Nourozi wrote:
>>>>
>>>>          Here is the task function. But I'm not seeing the printout.
>>>>
>>>>          void xx_start_transfer(void *arg) {
>>>>              rtdm_wait_period();
>>>>
>>>>
>>>>      What about checking the return code of rtdm_wait_period()? If
>>>>      something goes wrong there, you do want to know, instead of
>>>> entering
>>>>      a tight runaway loop.
>>>>
>>>>      --
>>>>      Philippe.
>>>>
>>>>
>>>> I can't print anything since the system freezes so I don't know how I
>>>> can check return value? Also, what loop are you referring to I don't
>>>> have a loop just a print statement.
>>>>
>>>
>>> It does not make sense to have a single wait statement in a periodic
>>> task, you should have a loop. Or you don't have periodic task. So your
>>> task should implement a loop.
>>>
>>> To force a direct output through the serial console port, you may want
>>> to try enabling DEBUG_LL and IPIPE_DEBUG, then call
>>> __ipipe_serial_debug(), instead of printk. Do not use this in regular
>>> code, this is for debugging purpose only, in mostly hopeless situations
>>> where using buffered console output is not an option.
>>>
>>
>> I do not think 2.6.38 has __ipipe_serial_debug,
>>
>
> It does. printascii() alone would not prevent output races, so it's better
> to use __ipipe_serial_debug() for this.
>
>
>  it as printascii though.
>
>>
>>
>>
> --
> Philippe.
>


OK I patched xenomai 2.6.3 and enabled DEBUG_LL,  IPIPE_DEBUG and
disabled CONFIG_HIGH_RES_TIMERS.
I've attached the latest .config for reference.

Here is the task initialization code:

*rtdm_printk("kicking of tasklet...\n");*
* retval =3D rtdm_task_init(&heartbeat_task, "spi_transfer",
xx_start_transfer, NULL, 99, 100000000 /* 100 ms */);*
* __ipipe_serial_debug("*******return value =3D %d\n", retval);*
* if(retval)*
* {*
* __ipipe_serial_debug("error initializing task: %i\n", retval);*
* }*

Here is the task function:

void xx_start_transfer(void *arg)
{

int ret;

while (1) {
ret =3D rtdm_task_wait_period();
__ipipe_serial_debug("*******return value =3D %d\n", ret);
gpio_set_value(LED, 1);
rtdm_task_sleep(0);
}
}

I'm not seeing any output from any of the __ipipe_serial_debug(), however I=
'm
seeing the following kernel error (full console output attached):

------------[ cut here ]------------

WARNING: at kernel/sched.c:3826 add_preempt_count+0x68/0x104()

Modules linked in:

Backtrace:

[<c002ea10>] (dump_backtrace+0x0/0x110) from [<c02d7b84>]
(dump_stack+0x18/0x1c)
 r6:c035110f r5:00000ef2 r4:00000000

[<c02d7b6c>] (dump_stack+0x0/0x1c) from [<c003fc30>]
(warn_slowpath_common+0x54/
0x6c)

[<c003fbdc>] (warn_slowpath_common+0x0/0x6c) from [<c003fc6c>]
(warn_slowpath_nu
ll+0x24/0x28)

 r8:c03554b1 r7:00000001 r6:c03a3830 r5:c0543a60 r4:00000001

[<c003fc48>] (warn_slowpath_null+0x0/0x28) from [<c0038824>]
(add_preempt_count+
0x68/0x104)

[<c00387bc>] (add_preempt_count+0x0/0x104) from [<c0040998>]
(vprintk+0x54/0x400
)

 r4:00000000

[<c0040944>] (vprintk+0x0/0x400) from [<c02d7e04>] (printk+0xfc/0x1a8)

[<c02d7d08>] (printk+0x0/0x1a8) from [<c0075c80>]
(ipipe_check_context+0xa0/0xd0
)

 r3:00001c70 r2:c03517a4 r1:c0355d9b r0:c03554b1

 r8:00000000 r7:eef84a10 r6:c03a3830 r5:c0543a60 r4:c0541d40

[<c0075be0>] (ipipe_check_context+0x0/0xd0) from [<c00387d4>]
(add_preempt_count
+0x18/0x104)

 r6:c3900050 r5:c02453cc r4:00000001

[<c00387bc>] (add_preempt_count+0x0/0x104) from [<c0025130>]
(do_undefinstr+0x90
/0x1c8)

 r4:c3901548

[<c00250a0>] (do_undefinstr+0x0/0x1c8) from [<c002abd4>]
(__und_svc+0x54/0x80)

Nima
-------------- next part --------------
Starting kernel ...                                                        =
     =

                                                                           =
     =

Uncompressing Linux... done, booting the kernel.                           =
     =

Linux version 2.6.38.8 (nima@nima-ThinkPad-W530) (gcc version 4.4.1 (Source=
ry G+
+ Lite 2010q1-202) ) #12 PREEMPT Mon Jan 6 10:59:01 PST 2014               =
     =

CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=3D00053177            =
       =

CPU: VIVT data cache, VIVT instruction cache                               =
     =

Machine: Valhalla Base Station 32                                          =
     =

Memory policy: ECC disabled, Data cache writeback                          =
     =

Clocks: CPU 198 MHz, master 99 MHz, main 18.432 MHz                        =
     =

Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256 =
     =

Kernel command line: mem=3D64M console=3DttyS0,115200 root=3D/dev/mtdblock2=
 rw rootfst
ype=3Djffs2 mtdparts=3Datmel_nand:1M(bootloader),2M(kernel),-(rootfs)      =
         =

PID hash table entries: 256 (order: -2, 1024 bytes)                        =
     =

Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)              =
     =

Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)               =
     =

Memory: 64MB =3D 64MB total                                                =
       =

Memory: 59388k/59388k available, 6148k reserved, 0K highmem                =
     =

Virtual kernel memory layout:                                              =
     =

    vector  : 0xffff0000 - 0xffff1000   (   4 kB)                          =
     =

    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)                          =
     =

    DMA     : 0xffc00000 - 0xffe00000   (   2 MB)                          =
     =

    vmalloc : 0xc4800000 - 0xfee00000   ( 934 MB)                          =
     =

    lowmem  : 0xc0000000 - 0xc4000000   (  64 MB)                          =
     =

    modules : 0xbf000000 - 0xc0000000   (  16 MB)                          =
     =

      .init : 0xc0008000 - 0xc0025000   ( 116 kB)                          =
     =

      .text : 0xc0025000 - 0xc0395000   (3520 kB)                          =
     =

      .data : 0xc0396000 - 0xc0536560   (1666 kB)                          =
     =

NR_IRQS:192                                                                =
     =

AT91: 96 gpio irqs in 3 banks                                              =
     =

AT91 I-pipe timer: div: 32, freq: 3.104000 MHz, wrap: 21.113402 ms         =
     =

I-pipe, 3.104 MHz clocksource                                              =
     =

I-pipe 1.18-09: pipeline enabled.                                          =
     =

Console: colour dummy device 80x30                                         =
     =

console [ttyS0] enabled                                                    =
     =

Calibrating delay loop... 93.24 BogoMIPS (lpj=3D45696)                     =
       =

pid_max: default: 32768 minimum: 301                                       =
     =

Mount-cache hash table entries: 512                                        =
     =

CPU: Testing write buffer coherency: ok                                    =
     =

NET: Registered protocol family 16                                         =
     =

bio: create slab <bio-0> at 0                                              =
     =

Switching to clocksource ipipe_tsc                                         =
     =

NET: Registered protocol family 2                                          =
     =

IP route cache hash table entries: 1024 (order: 0, 4096 bytes)             =
     =

TCP established hash table entries: 2048 (order: 2, 16384 bytes)           =
     =

TCP bind hash table entries: 2048 (order: 1, 8192 bytes)                   =
     =

TCP: Hash tables configured (established 2048 bind 2048)                   =
     =

TCP reno registered                                                        =
     =

UDP hash table entries: 256 (order: 0, 4096 bytes)                         =
     =

UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)                    =
     =

NET: Registered protocol family 1                                          =
     =

RPC: Registered udp transport module.                                      =
     =

RPC: Registered tcp transport module.                                      =
     =

RPC: Registered tcp NFSv4.1 backchannel transport module.                  =
     =

I-pipe: Domain Xenomai registered.                                         =
     =

Xenomai: hal/arm started.                                                  =
     =

Xenomai: scheduling class idle registered.                                 =
     =

Xenomai: scheduling class rt registered.                                   =
     =

Xenomai: real-time nucleus v2.6.3 (Lies and Truths) loaded.                =
     =

Xenomai: debug mode enabled.                                               =
     =

Xenomai: starting native API services.                                     =
     =

Xenomai: starting POSIX services.                                          =
     =

Xenomai: starting RTDM services.                                           =
     =

JFFS2 version 2.2. (NAND) ?=A9 2001-2006 Red Hat, Inc.                     =
       =

ROMFS MTD (C) 2007 Red Hat, Inc.                                           =
     =

msgmni has been set to 115                                                 =
     =

NET: Registered protocol family 38                                         =
     =

io scheduler noop registered (default)                                     =
     =

atmel_usart.0: ttyS0 at MMIO 0xfefff200 (irq =3D 1) is a ATMEL_SERIAL      =
       =

brd: module loaded                                                         =
     =

NAND device: Manufacturer ID: 0xec, Chip ID: 0xda (Samsung NAND 256MiB 3,3V=
 8-bi
t)                                                                         =
     =

Scanning device for bad blocks                                             =
     =

Bad eraseblock 182 at 0x0000016c0000                                       =
     =

Bad eraseblock 788 at 0x000006280000                                       =
     =

Bad eraseblock 1116 at 0x000008b80000                                      =
     =

Bad eraseblock 1117 at 0x000008ba0000                                      =
     =

Bad eraseblock 1206 at 0x0000096c0000                                      =
     =

Bad eraseblock 1422 at 0x00000b1c0000                                      =
     =

Bad eraseblock 1678 at 0x00000d1c0000                                      =
     =

Bad eraseblock 1679 at 0x00000d1e0000                                      =
     =

Bad eraseblock 1812 at 0x00000e280000                                      =
     =

Bad eraseblock 1952 at 0x00000f400000                                      =
     =

Creating 3 MTD partitions on "NAND 256MiB 3,3V 8-bit":                     =
     =

0x000000000000-0x000000100000 : "U-boot"                                   =
     =

0x000000100000-0x000000300000 : "Kernel"                                   =
     =

0x000000300000-0x000010000000 : "File system"                              =
     =

atmel_spi atmel_spi.0: Atmel SPI Controller at 0xfffc8000 (irq 12)         =
     =

kicking of tasklet...                                                      =
     =

------------[ cut here ]------------                                       =
     =

WARNING: at kernel/sched.c:3826 add_preempt_count+0x68/0x104()             =
     =

Modules linked in:                                                         =
     =

Backtrace:                                                                 =
     =

[<c002ea10>] (dump_backtrace+0x0/0x110) from [<c02d7b84>] (dump_stack+0x18/=
0x1c)
 r6:c035110f r5:00000ef2 r4:00000000                                       =
     =

[<c02d7b6c>] (dump_stack+0x0/0x1c) from [<c003fc30>] (warn_slowpath_common+=
0x54/
0x6c)                                                                      =
     =

[<c003fbdc>] (warn_slowpath_common+0x0/0x6c) from [<c003fc6c>] (warn_slowpa=
th_nu
ll+0x24/0x28)                                                              =
     =

 r8:c03554b1 r7:00000001 r6:c03a3830 r5:c0543a60 r4:00000001               =
     =

[<c003fc48>] (warn_slowpath_null+0x0/0x28) from [<c0038824>] (add_preempt_c=
ount+
0x68/0x104)                                                                =
     =

[<c00387bc>] (add_preempt_count+0x0/0x104) from [<c0040998>] (vprintk+0x54/=
0x400
)                                                                          =
     =

 r4:00000000                                                               =
     =

[<c0040944>] (vprintk+0x0/0x400) from [<c02d7e04>] (printk+0xfc/0x1a8)     =
     =

[<c02d7d08>] (printk+0x0/0x1a8) from [<c0075c80>] (ipipe_check_context+0xa0=
/0xd0
)                                                                          =
     =

 r3:00001c70 r2:c03517a4 r1:c0355d9b r0:c03554b1                           =
     =

 r8:00000000 r7:eef84a10 r6:c03a3830 r5:c0543a60 r4:c0541d40               =
     =

[<c0075be0>] (ipipe_check_context+0x0/0xd0) from [<c00387d4>] (add_preempt_=
count
+0x18/0x104)                                                               =
     =

 r6:c3900050 r5:c02453cc r4:00000001                                       =
     =

[<c00387bc>] (add_preempt_count+0x0/0x104) from [<c0025130>] (do_undefinstr=
+0x90
/0x1c8)                                                                    =
     =

 r4:c3901548                                                               =
     =

[<c00250a0>] (do_undefinstr+0x0/0x1c8) from [<c002abd4>] (__und_svc+0x54/0x=
80)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config
Type: application/octet-stream
Size: 37121 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140106/1e5d5e9=
1/attachment.obj>
