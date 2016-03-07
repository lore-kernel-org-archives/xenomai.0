Date: Mon, 7 Mar 2016 12:32:39 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20160307123239.531fabe6@md1em3qc>
In-Reply-To: <CANBp=-iWByct=fMOPB6u8PrS10h2M0w9MbaOGrJAvfGqsjCVCw@mail.gmail.com>
References: <CANBp=-hcC5DHb=HpMzqbewQswwwh-dF-+i+DoOd6KRHoXbv2qw@mail.gmail.com>
 <CANBp=-iWByct=fMOPB6u8PrS10h2M0w9MbaOGrJAvfGqsjCVCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Fwd: Latency test fails. Problem during installation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michele Belotti <miki.belotti@gmail.com>
Cc: xenomai@xenomai.org

Hello Michele,

you seem to be having multiple, possibly unrelated, issues. Some of them
seem related to the kernel you are using. Please provide the kernel
version and ipipe version you are talking about.
For the high latency cases you should provide an event-trace.

Henning

On Mon, 7 Mar 2016 11:33:31 +0100
Michele Belotti <miki.belotti@gmail.com> wrote:

> Hello everybody,
> We recently migrated my project on a new and more powerful
> workstation but I can obtain the previous performance.
> 
> We observed by running the standard Xenomai tools that there are very
> high latencies, hinting for an issue in the kernel configuration (or
> maybe unsupported HW features by Xenomai ?).
> 
> We are trying to install Xenomai version 2.6.3 on a HP Z840
> workstation Red Hat system 7.2.
> The Workstation has  a double 12 cores CPU Intel Xeon E5-2690v3 on it.
> 
> We follow the installation guide and the troubleshooting but the
> latency is still very high with some high jumps.
> We tried to deal with the different options described in the guide
> 
> CONFIG_CPU_FREQ, CONFIG_CPU_IDLE, CONFIG_CONTEXT_TRACKING_FORCE
> XENO_OPT_STATS  NO_HZ_FULL_ALL  BSD_PROCESS_ACCT  but none has
> impacted the system, only marginal improvements.
> 
> We also tried to modify the  SMI detection parameters adding the
> following string to kernel command line
> xeno_hal.smi = 1
> but without any effect.
> Note: to notice that xenomai does not recognize the ethernet and we
> needed to install again the ethernet card driver.  We don't know if
> this has some impact on the system. We also noticed some freeze when
> recovering from the sleep mode implying to restart the machine.
> 
> Would you have any idea how we can proceed to isolate the issue?
> 
> Thanks for the support
> 
> Regards
> 
> 
> Michele
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


