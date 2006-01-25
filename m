Message-ID: <43D7CD2F.9030709@domain.hid>
Date: Wed, 25 Jan 2006 11:10:39 -0800
From: Nathaniel Villaume <villaume@domain.hid>
MIME-Version: 1.0
References: <200601251105.k0PB5uPK028509@domain.hid>
In-Reply-To: <200601251105.k0PB5uPK028509@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Dual Xeon, 2.6.10, adeos-r13
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

Hi all,

I can't seem to find any info about Dual Xeon and Xenomai (well, ADEOS, 
really). Is this a configuration that is expected to work?  What about 
smp Athlon? or DualCore Athlon? (I think Opteron is not in the picture 
yet, right?)

For the dual Xeon, I'm able to patch and build fine, but boot stalls 
after the hardware has been initialized by the init process.
(i.e. The last line I get from Fedora Core 3 Init 2.85 booting says: 
Initializing hardware... storage network, audio done [ok])

I've done what I think are correct:
- turned off HyperThreading in both bios and in kernel config
- disabled REGPARM

The Processor family  is set to Pentium 4 and sub arch is set to Generic 
architecture (X86_GENERICARCH), but I've also tried Pc Compatible (X86) 
to  the same effect.
I used an adeos-r9 patch that came with RTAI, and I at least got the 
system to boot. But RTAI puked when loading the SMP scheduler....

Is there anything else I might do to make this work?  What is the 
confidence level in SMP support?

Thanks,
-Nate





