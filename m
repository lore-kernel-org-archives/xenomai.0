Message-ID: <50A3FE14.8060704@xenomai.org>
Date: Wed, 14 Nov 2012 21:24:52 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CADy-PFhkr+VzMXQV-+0Gn2KvFvVs5QYHazZYpcLoifem4wSDMA@mail.gmail.com>
In-Reply-To: <CADy-PFhkr+VzMXQV-+0Gn2KvFvVs5QYHazZYpcLoifem4wSDMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 2.6.1 Kernel 3.2 on new Xeon E5 machine
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jonathan Bohren <jonathan.bohren@gmail.com>
Cc: xenomai@xenomai.org

On 11/14/2012 09:18 PM, Jonathan Bohren wrote:

> All,
> 
> I'm trying to set up a new realtime box with a single Intel Xeon E5-1620
> CPU running with Xenomai 2.6.1 and Kernel 3.2.21.
> 
> So far, I can get it to boot, but then the mouse and keyboard respond as if
> they're dropping events and lagging dramatically (both in X11 and magic
> sysreq). However, I don't seem to see any lag issues when logged in over
> ssh from another machine.
> 
> I couldn't disable MSI in the kernel config, but I do have the "pci=nomsi"
> boot args.
> 
> I also tried using the SMI workaround, and adding my LPC ID to smi.c, but I
> still get the same GUI lag issues.
> 
> Any ideas?


Please post:
- the result of cat /proc/interrupts
- the result of cat /proc/xenomai/irq
- the result of cat /proc/xenomai/timer
- your full booot logs
- your .config

-- 
                                                                Gilles.

