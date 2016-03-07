References: <CANBp=-hcC5DHb=HpMzqbewQswwwh-dF-+i+DoOd6KRHoXbv2qw@mail.gmail.com>
 <CANBp=-iWByct=fMOPB6u8PrS10h2M0w9MbaOGrJAvfGqsjCVCw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <56DD69F6.9050507@xenomai.org>
Date: Mon, 7 Mar 2016 12:45:58 +0100
MIME-Version: 1.0
In-Reply-To: <CANBp=-iWByct=fMOPB6u8PrS10h2M0w9MbaOGrJAvfGqsjCVCw@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
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
To: Michele Belotti <miki.belotti@gmail.com>, xenomai@xenomai.org

On 03/07/2016 11:33 AM, Michele Belotti wrote:
> Hello everybody,
> We recently migrated my project on a new and more powerful workstation but
> I can obtain the previous performance.
> 
> We observed by running the standard Xenomai tools that there are very high
> latencies, hinting for an issue in the kernel configuration (or maybe

What does "high" mean? The output of a latency test showing the peak
would help.

> unsupported HW features by Xenomai ?).
> 
> We are trying to install Xenomai version 2.6.3 on a HP Z840 workstation Red
> Hat system 7.2.

2.6.3 is an outdated release of a Xenomai series which is EOL. Any
reason to use a totally unmaintained version?

Also, Xenomai releases are validated on mainline kernels. You are
basically on your own when running it over vendor kernels.

> The Workstation has  a double 12 cores CPU Intel Xeon E5-2690v3 on it.
>

- SMI are always a problem, affecting many x86 workstations and laptops
- Hyperthreading is always a problem
- Power management should be carefully audited

Please note that running Xenomai in dual kernel mode over so many cores
won't fly. You will likely have to restrict the number of cores usable
in real-time operations to get better performances at some point.

> We follow the installation guide and the troubleshooting but the latency is
> still very high with some high jumps.
> We tried to deal with the different options described in the guide
> 
> CONFIG_CPU_FREQ, CONFIG_CPU_IDLE, CONFIG_CONTEXT_TRACKING_FORCE
> XENO_OPT_STATS  NO_HZ_FULL_ALL  BSD_PROCESS_ACCT  but none has impacted the
> system, only marginal improvements.

Which guide mentions these ones: NO_HZ_FULL_ALL  BSD_PROCESS_ACCT?

> 
> We also tried to modify the  SMI detection parameters adding the following
> string to kernel command line
> xeno_hal.smi = 1
> but without any effect.

.smi = 1 just tells Xenomai to try enabling the work around. A message
in the kernel log should tell you whether the work around was enabled
successfully. I suspect it was not for various reasons.

Other ways to detect SMIs available on the net:
- the hwlat_detector module and script.
- reading MSR 0x34 on each CPU, using https://01.org/msr-tools

Check your BIOS:
- find out whether digital thermal sensors are present. If they are, you
may want to talk to your hw supplier about the potential implication of
DTS in SMI events, and see what might be done for fixing their BIOS in
case they are involved.
- disable any PS/2 emulation for mouse/kbd.

> Note: to notice that xenomai does not recognize the ethernet and we needed
> to install again the ethernet card driver. 

What do you mean by "installing"?

 We don't know if this has some
> impact on the system. We also noticed some freeze when recovering from the
> sleep mode implying to restart the machine.
> 

There is no support for this, neither the interrupt pipeline or Xenomai
care for it in any way.

> Would you have any idea how we can proceed to isolate the issue?
> 

A lot of information is missing. Following those guidelines may help you
in getting some answers:

http://xenomai.org/asking-for-help/

-- 
Philippe.

