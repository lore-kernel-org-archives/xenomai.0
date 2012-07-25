Message-ID: <50104878.8030300@grandegger.com>
Date: Wed, 25 Jul 2012 21:26:48 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <CE2E43470FE5444A811B580382FE5EDF2113D8D95A@KEMPMAIL2.woodward.com>
	<5009A292.4060508@grandegger.com>
	<CE2E43470FE5444A811B580382FE5EDF2113EA8DE7@KEMPMAIL2.woodward.com>
In-Reply-To: <CE2E43470FE5444A811B580382FE5EDF2113EA8DE7@KEMPMAIL2.woodward.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai installation on P1020RDB
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lukasz Zemla <Lukasz.Zemla@woodward.com>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Hi Lukasz,

On 07/25/2012 06:18 PM, Lukasz Zemla wrote:
> Hi Wolfgang,
> 
> Thank you for your mail, especially for sharing detailed latency results. 
> Find my answers below.
> 
>> -----Original Message-----
>> From: Wolfgang Grandegger [mailto:wg@grandegger.com]
>> Sent: Friday, July 20, 2012 8:25 PM
>> To: Lukasz Zemla
>> Cc: Xenomai@xenomai.org
>> Subject: Re: [Xenomai] Xenomai installation on P1020RDB
>>
>> Hi Lukasz,
>>
>> On 07/20/2012 04:31 PM, Lukasz Zemla wrote:
>>> Hello,
>>>
>>> Has anyone some experience with installing Xenomai on P1020RDB board?
>> I'd like to perform some benchmarks on this board.
>>> I'm trying to install it using the latest Freescale SDK 1.2 based on
>>> Yocto. But hints for SDK 1.0.3 would be also fine. Finally every way
>>> for getting it working... ;-)
>>>
>>> What I'm doing is getting Freescale kernel (3.0.34):
>>
>> If you can, use a *mainline* kernel. The latest Xenomai patch is for
>> Linux 3.2.21 and that version does well support the P1020RDB, IIRC.
> 
> I tried to install Xenomai on 3.2.21 - it boots, but waits about 76 seconds after initialization of first eth0 controller: 
> 
> 	[    0.905820] fsl-gianfar ethernet.1: eth0: TX BD ring size for Q[7]: 256
> 	[   77.451135] fsl-gianfar ethernet.2: eth1: mac: 00:04:9f:02:2d:11
> 
> There is no delay between eth1 and eth2. 
> 
> The vanilla 3.2.21 does not have any delays - it initializes eth0, eth1, eth2 immediately.

Strange. Could you please show us your .config. Is SMP enabled?

> [...]
> 
>>> Next I tried to install Xenomai on vanilla 3.1.10 kernel. I got
>> compilation error:
>>>
>>>         arch/powerpc/sysdev/fsl_lbc.c: In function
>> 'fsl_lbc_ctrl_irq':
>>>         arch/powerpc/sysdev/fsl_lbc.c:247:3: error: 'TASK_NORMAL'
>>> undeclared (first use in this function)
>>
>> That has nothing to do with Xenomai. Did you try to build the vanilla
>> kernel first?
> 
> The vanilla 3.1.10 kernel builds and boots properly.
> I double checked and confirm that 3.1.10 vanilla kernel after patching using adeos-ipipe-3.1.10-powerpc-2.13-08.patch has problem with compilation presented above.
> After fsl_lbc.c file correction I can compile it and boot (what I forgot last time was rebuilding DTB file ('make ARCH=powerpc CROSS_COMPILE=powerpc-fsl-linux-gnuspe- p1020rdb.dtb'). With the new DTB system goes further but hangs for some time rises exception:

I'm unable to reproduce that issue. What defconfig did you use? Could
you show use your .config. I used mpx85xx_smp_defconfig abd it compiled
fine.

> ***
> The information in this email is confidential and intended solely for the individual or entity to whom it is addressed. If you have received this email in error please notify the sender by return e-mail, delete this email, and refrain from any disclosure or action based on the information.
> ***

This note does not make sense when sending to a public mailing list.

Wolfgang.


