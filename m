MIME-Version: 1.0
In-Reply-To: <20180410135030.qh2gep2yxj5tnyga@csclub.uwaterloo.ca>
References: <CAOuPNLgfpzTWgeBZcsntHDP07cOPyvhPEZM6WsQ453s=6id3tA@mail.gmail.com>
 <20180410135030.qh2gep2yxj5tnyga@csclub.uwaterloo.ca>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Tue, 10 Apr 2018 19:41:38 +0530
Message-ID: <CAOuPNLjPbzwhVfaY=Kmk6cv2q5L1U+qXcmG7tcN=qsZbkRn7vA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] [RTNET]: Which rtnet driver to use with beagle bone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Apr 10, 2018 at 7:20 PM, Lennart Sorensen
<lsorense@csclub.uwaterloo.ca> wrote:
> On Tue, Apr 10, 2018 at 06:52:11PM +0530, Pintu Kumar wrote:
>> Hi,
>>
>> I am using:
>> Beagle Bone Kernel: 4.9.51
>> Xenomai: 3.0.6
>> Board: Beagle Bone White
>>
>> When I enable RTNET, the following ethernet drivers are build.
>> $ ls drivers/xenomai/net/drivers/*.ko
>> drivers/xenomai/net/drivers/rt_8139too.ko
>> drivers/xenomai/net/drivers/rt_eepro100.ko
>> drivers/xenomai/net/drivers/rt_loopback.ko
>>
>> But I think beagle bone using different ethernet driver.
>> ti_cpsw
>> CONFIG_TI_CPSW=y
>> Also this is by default in-built into the kernel. So I cannot remove the module.
>>
>> When I try installing the available once it did install but network
>> did not work.
>> rtnet                  52594  10
>> rt_8139too,rtipv4,rt_loopback,rtmac,rt_eepro100,rtpacket,rtudp,rt_e1000,rtcfg,tdma
>>
>> # /usr/xenomai/sbin/rtifconfig rteth0 up
>> ioctl: No such device
>>
>>
>> So, I wanted to know is there any rtnet ethernet driver available
>> which works with beagle bone ?
>
> Well based on the list above, the answer appears to be none of them.
>
> The cpsw is one of the weirdest network designs I have ever encountered.
> It is a network interface missing a bunch of standard features (like mac
> filtering) connected to a switch chip which is responsible for the mac
> filtering and such while also being a switch.  It can be quite annoying
> to deal with.
>
> On the design I worked on we ended up using a PRU ethernet port for
> xenomai instead because the cpsw was just not sane to work with.
> Don't have that option on the beagle though.
>

So, this means there is no rtnet driver available for beagle bone ?
Then it looks like we have to drop Xenomai for beagle bone... :-(

However, I found that somebody have ported TI ethernet driver here:
https://github.com/hiddeate2m/rtnet/tree/master/drivers

https://sourceforge.net/p/rtnet/mailman/message/32523245/

Is it worth to try ?


Thanks,
Pintu

> --
> Len Sorensen

