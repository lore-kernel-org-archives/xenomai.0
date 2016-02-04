Date: Thu, 4 Feb 2016 07:55:00 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160204065500.GB11143@hermes.click-hack.org>
References: <8db451acc3862440f398037d839fe83@cweb14.nm.nhnsystem.com>
 <20160203074150.GG18030@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160203074150.GG18030@hermes.click-hack.org>
Subject: Re: [Xenomai] ubuntu15.04 - xenomai3.0.1 - kernel 3.18.20 - build
 error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?67CV7J6s7ZmN?= <1805pjh@naver.com>
Cc: xenomai@xenomai.org

On Wed, Feb 03, 2016 at 08:41:50AM +0100, Gilles Chanteperdrix wrote:
> On Wed, Feb 03, 2016 at 03:45:05PM +0900, 박재홍 wrote:
> > ﻿hello
> >  
> > after ipipe patched,  build error  
> >  
> >  
> > # cd linux-3.18.20
> >  
> > # ../xenomai-3.0.1/scripts/prepare-kernel.sh --arch=x86_64 --ipipe=../ipipe-core-3.18.20-x86-4.patch
> >  
> > # make menuconfig 
> > -&gt; "Power Management and ACPI options" -- "CPU Frequency scaling" -- "CPU Frequency scaling"
> > -&gt; "Power Management and ACPI options" -- "ACPI(~) Support" -- "Processor"
> > -&gt; "Power Management and ACPI options" -- "Cpuidle Driver for Intel Processors"
> > -&gt; "Power Management and ACPI options" -- "CPU idle PM Support"
> > -&gt; "Bus options(PCI etc.)" -- "Message Signaled Interrupts (MSI and MSI-X)"
> 
> Enabling MSI/MSI-X is recommended, as it helps avoiding irqs lines
> to be shared between real-time and non real-time drivers.

If you are interesting in testing rapidly xenomai on an x86 machine,
you could try the live cd:

http://xenomai.org/~gch/xeno-live.iso

-- 
					    Gilles.
https://click-hack.org

