Mime-Version: 1.0
Date: Sat, 20 Jun 2009 16:32:20 +0530
Message-ID: <1245495740.3498.8.camel@domain.hid>
From: Shashank Bhatia <shashank.bhatia@domain.hid>
content-type: text/plain
content-transfer-encoding: 7bit
Subject: [Xenomai-core] Regarding enabling SMP with Xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai Help <xenomai@xenomai.org>

Dear All,
              I have been trying to install Xenomai on my Dual Core
Intel Machine. This CPU has 2 cores, so i wanted to enable the SMP flag
in the kernel configuration.

I started with downloading kernel ver 2.6.25.11 from kernel.org, and got
adeos patch as well as xenomai-2.4.7 downloaded. I used the
prepare-kernel script for patching. 

When i go to the make menuconfig. The real time subsystem section gives
a meassage that either the HPET_TIMER must be turned off or
X68_LOCAL_APIC must be turned off. 

After a lot of trials, i failed to find the options for turning of the
X86_LOCAL_APIC flag. 

Then i went on to fiddle and do some trials. 

I tried with subarchitecture type PC compatible, and the Processor type
to be Core2 or newer. The xenomai gets installed, but the latency i get
is really high. I am getting a maximum latency of around 30 us and even
this is not constant. it varies a lot. 

After some googling i found that i must have the SMI workaround. 
I enabled that and recompiled my kernel. But could not get good
latencies still.

Now please guide me as to how can i have the SMP enabled. I want that
the OS must use both the Cores of my CPU. 

Please also suggest if there is some documentation i can read to achieve
lower latencies.


Thanks in Advance

Shashank



-------------------------------------
Hi-Tech Gears Limited, Gurgaon, India





