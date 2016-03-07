MIME-Version: 1.0
In-Reply-To: <CANBp=-hcC5DHb=HpMzqbewQswwwh-dF-+i+DoOd6KRHoXbv2qw@mail.gmail.com>
References: <CANBp=-hcC5DHb=HpMzqbewQswwwh-dF-+i+DoOd6KRHoXbv2qw@mail.gmail.com>
From: Michele Belotti <miki.belotti@gmail.com>
Date: Mon, 7 Mar 2016 11:33:31 +0100
Message-ID: <CANBp=-iWByct=fMOPB6u8PrS10h2M0w9MbaOGrJAvfGqsjCVCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Fwd: Latency test fails. Problem during installation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello everybody,
We recently migrated my project on a new and more powerful workstation but
I can obtain the previous performance.

We observed by running the standard Xenomai tools that there are very high
latencies, hinting for an issue in the kernel configuration (or maybe
unsupported HW features by Xenomai ?).

We are trying to install Xenomai version 2.6.3 on a HP Z840 workstation Red
Hat system 7.2.
The Workstation has  a double 12 cores CPU Intel Xeon E5-2690v3 on it.

We follow the installation guide and the troubleshooting but the latency is
still very high with some high jumps.
We tried to deal with the different options described in the guide

CONFIG_CPU_FREQ, CONFIG_CPU_IDLE, CONFIG_CONTEXT_TRACKING_FORCE
XENO_OPT_STATS  NO_HZ_FULL_ALL  BSD_PROCESS_ACCT  but none has impacted the
system, only marginal improvements.

We also tried to modify the  SMI detection parameters adding the following
string to kernel command line
xeno_hal.smi = 1
but without any effect.
Note: to notice that xenomai does not recognize the ethernet and we needed
to install again the ethernet card driver.  We don't know if this has some
impact on the system. We also noticed some freeze when recovering from the
sleep mode implying to restart the machine.

Would you have any idea how we can proceed to isolate the issue?

Thanks for the support

Regards


Michele
