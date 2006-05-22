Message-ID: <4471DB7E.9000402@domain.hid>
Date: Mon, 22 May 2006 17:40:46 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: Xenomai v2.2-rc2. PowerPC 405GPr board does
	not	start up
References: <446F852B.7090400@domain.hid> <e4s8e4$7f9$1@domain.hid>
In-Reply-To: <e4s8e4$7f9$1@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

Niklaus Giger wrote:
> Hi everybody
> 
> Philippe Gerum wrote:
> 
>>Here is the second release candidate for the v2.2 branch. Short log
>>follows:
> 
> Sorry for reporting so late.
> 
> But as my tests did not yet include starting up my board I did not notice
> that changes (probably between 2006-05-10 19:30 and 2006-05-11 20:31) made
> my board unbootable. 
> 
> The board hangs after emitting "(Engines Of Creation) loaded." output is:
> ocp: exit
> arch: exit
> Linux version 2.6.14hcu3 (buildslave@domain.hid) (gcc version 3.4.4) #17 Tue May 16
> 19:24:07 CEST 2006
> HCU3 Netstal Maschinen AG with U-Boot 1.1.2.
> Built 1 zonelists
> Kernel command line: console=ttyS0,9600 root=/dev/nfs rw
> nfsroot=172.25.1.58:/home/hcu/rootfs ip=172.25.1.5:172.15.1.58:::hcu4::off
> panic=30
> PID hash table entries: 256 (order: 8, 4096 bytes)
> I-pipe 1.3-02: pipeline enabled.
> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Memory: 29756k available (1856k kernel code, 604k data, 100k init, 0k
> highmem)
> Mount-cache hash table entries: 512
> softlockup thread 0 started up.
> NET: Registered protocol family 16
> 
> TIMER IRQ is 32
> I-pipe: Domain Xenomai registered.
> Xenomai: hal/powerpc started.
> Xenomai: real-time nucleus v2.2-rc1 (Engines Of Creation) loaded.
> 
> I have no ideas why, as my PowerBook is running fine with an actual Xenomai
> based kernel. But I now that the timer architecture for the PPC40x family
> is quite different to the PPC en general.
> 
> Any ideas where to begin debugging? I am familiar whith the timer/interrupt
> architecture of the PPC405 but a hint would be welcome. I will take my BDI
> debugger from Abatron home to have a look where the processor hangs, but
> will not have time till tomorrow or Wednesday to dig into this problem.

Could you try building all skins as modules with only the nucleus
statically built into the kernel? I'd like to know whether the lockup
occurs when one of the skin attempts to initialize, or if the problem is
in the early Xenomai bootstrap. TIA,

-- 

Philippe.


