Message-ID: <449BADE7.8060205@domain.hid>
Date: Fri, 23 Jun 2006 11:01:27 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] RTDM driver add-on infrastructure
References: <449A3AAE.7090403@domain.hid> <449A5549.40104@domain.hid>
In-Reply-To: <449A5549.40104@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>> Hello,
>>
>> I'm currently implementing a RTDM real-time CAN driver, which raises the
>> the problem of adding the driver to the Xenomai source tree. My first
>> idea was to provide RTCAN as a patch for Xenomai:
> 
> So you prefer to maintain RTCAN out-of-tree on the long term? What are
> the reasons?

No, when the code is stable it can go to the Xenomai repository, like 
for the Linux kernel. It clearly simplifies maintenance , at least for 
the maintainer of the driver. Nevertheless, an Add-On facility would be 
nice to have.

> 
>>   $ cd xenomai
>>   $ patch -p1 < xenomai-rtcan-add-on.patch
>>   $ scripts/prepare_kernel ...
>>   ...
>>   $ <configure and make kernel>
>>   $ <configure, make and install Xenomai user space stuff>
>>
>> This does not work because of autoconf files needed to copy header files
>> to the installation path. Is this really necessary?
>> Another issue is where to put utility and test programs. Making them
>> without autoconf and friends works by using xeno-config. But they should
>> be installed with make install as well. Likely there are other issues.
>>
>> Any ideas or comments on how to provide a generic RTDM driver add-on
>> infrastructure?
> 
> When you first talked about an "RTDM plugin" interface for Xenomai, I
> got the idea of dragging external sources into the Xenomai kernel build
> process. I haven't thought about this technically yet, but it would
> allow to keep driver source packages maintained externally while still
> providing them the option to become built into the kernel.
> 
> Ok, let's think about this for a while: We would need some management
> script(s) to link an external source tree into the config and build
> process, the remove it again, and probably to give a list of the
> currently active plugins. Should be feasible without huge magic,
> shouldn't it? But does this make sense, is it desirable (to me it is
> when I think about making RTnet build cleanly against 2.6.17 yesterday...)?

Ala Xenomai's prepare_kernel script, which mainly adds links to the 
kernel tree and modifies some Makefiles and Kconfig (Config.in) files. 
Removing an Add-On seems not to be that important for me. This sounds 
reasonable.

Adding the RTCAN driver to Xenomai really solved a lot of build and 
installations issues without caring about the kernel version 2.4 or 2.6 :-).

> This does not address your user mode utils, but I think they should
> rather be distributed independently (something I have in mind for RTnet
> as well once we ever switch from /dev/rtnet to some RTDM socket/device
> for config work). The required rtdm/rtcan.h should be merged into
> Xenomai, yet unmerged revisions could alternatively come with the
> rtcan-utils packages to make it build (autoconf if your friend to detect
> the available revision).

I think the Add-on package should provide both, the driver _and_ 
user-space utility and test programs.

Wolfgang.




