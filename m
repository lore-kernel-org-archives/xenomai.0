Message-ID: <443B1991.9070206@domain.hid>
Date: Mon, 10 Apr 2006 22:50:57 -0400
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] bad/slow TSC hw  detected by  2.6.17-rc1-mm1
References: <4436C5DF.6060005@domain.hid> <4437782C.9030203@domain.hid>
In-Reply-To: <4437782C.9030203@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Jim Cromie wrote:
>   
>> FYI,
>>
>> Ive just built 17-rc1-mm1, and noted that the new time-keeping-system
>> http://lwn.net/Articles/176837/
>>
>> can now detect the buggy TSC on my GEODE-sc1100 cpu,
>> and also that its apparently fixable by adding 'idle=poll' to
>> kernel-boot-line.
>>     
>
> Keeps your CPU safe and warm, I guess. ;)
>
>   
for me personally, its the new-found certainty that the bug is 
repeatedly observable and correctable :-)

Ive historically had an issue with  my ntp-server on this box,
which slips badly when running latency tests under certain conditions
(ie, the dd workload is using /dev/hda, a real interrupt source, rather 
than /dev/zero)

FWIW, my 2.6.16-ipipe-122 kernel takes a *long* time to boot,
even while printk numbers look good.

The delays/pauses are in several subsystems, most notably after these 
dmesg lines:

[   30.768098] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   30.775141] ide: Assuming 33MHz system bus speed for PIO modes; 
override with idebus=xx

(1 min pause)

[   31.209246] hda: SanDisk SDCFB-512, CFA DISK drive

[   30.561093] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ 
sharing disabled

30.574876] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   30.586719] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A

(more delays, in various spots, and Im now much more aware of them..)

FWIW, before now, Ive never needed idle=poll, so it seems that 
adeos/xenomai
is more sensitive to these long delays than vanilla linux,  (same for more
recent versions of kernel & adeos).  OTOH, Ive only recently added 
timestamps to
printks, and Im also a bit more sensitive now than I once was ..


Does it make any sense that adeos / xenomai is more sensitive to a bad TSC
than it used to be ?

thanks
jimc

