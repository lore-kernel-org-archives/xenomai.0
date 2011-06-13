Message-ID: <4DF64C3A.6080407@domain.hid>
Date: Mon, 13 Jun 2011 19:43:22 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DF5EA11.5010006@domain.hid>
In-Reply-To: <4DF5EA11.5010006@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai on i7-870
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jakub Nowacki <j.s.nowacki@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 06/13/2011 12:44 PM, Jakub Nowacki wrote:
> Dear All,
> 
> I've recently installed Xenomai for our RT lab machine that uses RTXI 
> (http://www.rtxi.org/). I followed the installation instruction on the 
> web page but I got a number of issues in the process. Just to set some 
> common ground: the machine is mentioned i7-870 on Intel's Q57 board; the 
> setup is done for kernel 2.6.37.6 on Xubuntu 11.04 with the latest 
> stable Xenomai (2.5.6) and Adeos patch. As for myself, I have some 
> experience with Linux kernel setup but I'm not an expert.
> 
> Before I found that the Intel's white paper describing Xenomai 
> installation [Ugal 2009] shouldn't be used, I followed some suggestions 
> there and disabled power management (PM) completely. The kernel compiles 
> without any problems and works fine, but I the system sees only 4 out of 
> 8 cores (just a reminder that i7-870 has 4 cores but 8 threads that are 
> normally visible as CPUs). It is not end of the world for me at this 
> point and the system seems to work fine (I have low latencies etc.) but 
> I wanted to fix that.
> 
> I've started to read into the installation and other resources, and 
> disabled only the important bits, i.e. CONFIG_CPU_FREQ, 
> CONFIG_ACPI_PROCESSOR, CONFIG_INTEL_IDLE; the rest of the kernel is 
> pretty much generic Ubuntu config (I used 
> https://wiki.ubuntu.com/KernelTeam/GitKernelBuild as a reference). The 
> outcome is that machine now seems to have all cores but just after login 
> the system freezes completely (without running anything related with 
> Xenomai, just a couple of seconds after each login into Xfce). I 
> actually managed to find on the mailing list that it can be caused by 
> CONFIG_HPET_TIMER but I'm not able to disable it. Meaning, it is 
> excluded from config GUIs (I've tried practically all of them) and if I 
> change it manually in the .config file, it just somehow switches back to 
> being enabled when I compile the kernel.
> BTW I've tried the APIC options from the FAQ, but they do not fix the 
> freezing. Also, HPET_TIMER is enabled in the previous kernel config 
> where I disable whole PM, and the system seems to work fine with it.
> 
> Also I had similar problem with CONFIG_PCI_MSI, namely, it is blocked 
> (cannot be disabled) in the GUI when PM is enabled (or something there, 
> I'm not sure). But than later in the HPET thread I've found that I 
> should leave MSI enabled, hence, I'm not sure what should I do here.
> 
> Moreover, there is a problem with CONFIG_APM in this kernel, namely, it 
> seems to not be there. I'm not sure if it just does not exist for the 
> new kernel or I'm not doing something right.
> 
> Do you have any suggestions? I can provide you with the config file. 
> Also, I can try doing some test and debugging if it's needed.

Please post your .config.

-- 
                                                                Gilles.

