MIME-Version: 1.0
Date: Mon, 28 Jun 2021 10:29:28 +0200
From: 77dab@tiscali.it
Subject: Re: Raspberry pi 4 second monitor problem on xeno3
In-Reply-To: <CALLqZ8TGTWVBj=VoZSVXizQPWLevYVCBr6R6gBf0TBtZui0kvg@mail.gmail.com>
References: <22d045f858ff5e9b4daddb410540be94@tiscali.it>
 <CALLqZ8TGTWVBj=VoZSVXizQPWLevYVCBr6R6gBf0TBtZui0kvg@mail.gmail.com>
Message-ID: <c6eea2e7c5c83292853a70c76a951cfe@tiscali.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

  
Hi, Found out it's using iPipe here. 
Is there something I can look
for to understand why it doesn't work? 

Il 26.06.2021 15:09 Greg
Gallagher ha scritto: 

> On Sat, Jun 26, 2021 at 9:06 AM davide via
Xenomai wrote: 
> 
>> Hi, it is the first time I ask for an help on this
mailing list.
>> My
>> setup:
>> -Raspberry Pi 4, 4gb ram (forced to
3gb) running debian buster
>> 64bit.
>> 
>> pi@picat:~ $ uname -a
>>
Linux picat 4.19.126-v8-xeno3+ #1 SMP
>> PREEMPT Wed Mar 24 12:53:24 +07
2021 aarch64 GNU/Linux 
>> 
>> pi@picat:~ $
>> hostnamectl
>> 
>>
...cut...
>> Operating System: Debian GNU/Linux 10 (buster)
>> 
>>
Kernel: Linux 4.19.126-v8-xeno3+
>> Architecture: arm64
>> 
>> - two
HDMI
>> identical monitor connected . 1920x1080 60Hz 148.6 MHz clock.
>>

>> My
>> propblem:
>> on a clean raspbian 64bit, with 5.x kernel both
monitors work
>> as expected.
>> I'm working on a prebuilt image to use
as an Ethercat
>> Master, Picat4, from simplerobot.org [1], which has
this kernel, and what
>> happens is that at booting both monitors start,
I see booting info on
>> second monitor for 2-3 seconds, after that
image get frozen on the
>> second monitor and the first starts as
expected with the system running
>> fine.
>> 
>> this is an extract of
dmesg:
>> 
>> pi@picat:~ $ dmesg | grep fb
>> [
>> 0.000000] Kernel
command line: coherent_pool=1M 8250.nr_uarts=0 cma=64M
>>
bcm2708_fb.fbwidth=1920 bcm2708_fb.fbheight=1080 bcm2708_fb.fbswap=1
>>
smsc95xx.macaddr=DC:A6:32:F5:24:DE vc_mem.mem_base=0x3ec00000
>>
vc_mem.mem_size=0x40000000 console=ttyS0,115200 console=tty1
>>
root=PARTUUID=84c8ffd9-02 rootfstype=ext4 elevator=deadline
>>
fsck.repair=yes rootwait quiet splash plymouth.ignore-serial-consoles
>>
isolcpus=2,3 xenomai.supported_cpus=0xC
>> [ 0.172711] pci_bus
0000:00:
>> root bus resource [mem 0x600000000-0x603ffffff] (bus
address
>> [0xf8000000-0xfbffffff])
>> [ 0.176577] bcm2708_fb soc:fb: FB
found 2
>> display(s)
>> [ 0.209547] bcm2708_fb soc:fb: Registered
framebuffer for
>> display 0, size 1920x1080
>> [ 0.233066] bcm2708_fb
soc:fb: Registered
>> framebuffer for display 1, size 1920x1080
>> 
>>
from those commands I confirm
>> monitors are recognized:
>> 
>>
pi@picat:~ $ tvservice -l
>> 2 attached
>> device(s), display ID's are :

>> Display Number 2, type HDMI 0
>> Display
>> Number 7, type HDMI 1
>>
pi@picat:~ $ tvservice -v 2 -s
>> state 0xa [HDMI CEA
>> (16) RGB lim
16:9], 1920x1080 @ 60.00Hz, progressive
>> pi@picat:~ $
>> tvservice -v
7 -s
>> state 0xa [HDMI CEA (16) RGB lim 16:9], 1920x1080 @
>> 60.00Hz,
progressive
>> 
>> ...and 2 framebuffers are created:
>> 
>> pi@picat:~
$
>> ls /dev/fb*
>> /dev/fb0 /dev/fb1
>> 
>> BUT xrandr give me this:
>>

>> pi@picat:~ $
>> xrandr 
>> xrandr: Failed to get size of gamma for
output default
>> Screen 0:
>> minimum 1920 x 1080, current 1920 x 1080,
maximum 1920 x 1080
>> default
>> connected 1920x1080+0+0 0mm x 0mm
>>
1920x1080 0.00*
>> 
>> only one
>> monitor...
>> 
>> I know that's a
Raspberry, and I have to expect strange
>> behave, but it looks
promising that at booting both monitors work,
>> so..
>> 
>> Can you
point me in the right direction to look where, when and
>> why the
second monitor stops to work?
>> 
>> Thanks, Davide.
>> 
>> Con Tiscali
Mobile Smart 70 hai 70 GB in 4G, minuti illimitati e 100 SMS a soli
7,99EUR al mese http://tisca.li/Smart70 [2]
> 
> Hi, 
> Are you using
ipipe or dovetail? This may not be a xenomai issue, how do you build
your kernel? 
> Thanks 
> Greg
  


Con Tiscali Mobile Smart 70 hai 70 GB in 4G, minuti illimitati e 100 SMS a soli 7,99€ al mese http://tisca.li/Smart70

