Message-ID: <459E6F93.8060306@domain.hid>
Date: Fri, 05 Jan 2007 09:32:35 -0600
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai v2.3
References: <1167131039.4148.7.camel@domain.hid>
In-Reply-To: <1167131039.4148.7.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> Here is Xenomai v2.3...

I finally had a chance to upgrade to the latest version of Xenomai.  Everything works great.  Thanks to all the developers for your hard work!

System:

FC6 i386 Distribution
AMD Athlon(tm) 64 FX-62 Dual Core Processor
Linux 2.6.19.1 SMP Athon/Duron/K7
xenomai2.3.0
adeos-ipipe-2.6.19-i386-1.6-03.patch

Config:

I started with the Fedora Core 6 /boot/config-2.6.18-1.2849.fc6, and then:

Changed the processor type to Athon/Duron/K7.
I then disabled:
  Support for hot-pluggable CPUs
  ACPI Support/Processor
  APM BIOS Support
  CPU Frequency scaling
  Message Signaled Interrupts
I then enabled:
  Ext3 support
  Serial ATA drivers/NVIDIA SATA support

Sorry I could not report my results on one of the release candidates, but by the time I got a chance to try out rc3, 2.3.0 had just been released.  I thought that I would report my results anyway, since most of the developers do not have modern AMD hardware for testing.

Thanks!

-Jeff

