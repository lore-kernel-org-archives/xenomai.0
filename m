Message-ID: <53DFB5A3.2000107@xenomai.org>
Date: Mon, 04 Aug 2014 18:32:35 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAMi4Dw02AiGx9ZQFcc3aesJCKkaKdkJ+3V+jPiOuReeC=o5L0A@mail.gmail.com>
In-Reply-To: <CAMi4Dw02AiGx9ZQFcc3aesJCKkaKdkJ+3V+jPiOuReeC=o5L0A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Shared interrupts
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Hidde Verstoep (E2M)" <hverstoep@e2mtechnologies.eu>, xenomai@xenomai.org

On 08/04/2014 02:10 PM, Hidde Verstoep (E2M) wrote:
> Hello,
> 
> I have a computer where, when running a kernel with Xenomai, a lot of
> devices share one interrupt (see xenomai.log). I want to use eth0 with
> RTnet (I already have a working driver), but I also want to keep having
> access to my graphical interface and USB. These devices are all on the same
> interrupt. As far as I know IRQ sharing is not possible between the Linux
> and Xenomai domain, so this is a problem.
> 
> On a regular Linux kernel the devices are spread differently among the
> interrupts (see linux.log). I believe this is due to MSI (correct me if I'm
> wrong). http://www.xenomai.org/index.php/Configuring_x86_kernels clearly
> states that I have to disable this.

This information is outdated unfortunately. A new web site is brewing,
at this chance we'll fix it.

 However, the linked discussion is not
> entirely clear to me. Does MSI only cause issues for a Xenomai device
> driver and for the device it controls or for Linux device drivers and the
> rest of the system as well? If MSI only causes issues for Xenomai device
> drivers, could I enable CONFIG_MSI and make sure the Xenomai device drivers
> (like the one for eth0) don't use MSI? Or would this have other
> consequences as well?
> 
> If not in the above way, is there another way to solve my issue? Is there
> any more information I should provide?
> 

Basically, enabling MSI should be fine with Xenomai (*), provided no
real-time code (i.e. running in "primary" mode) ever attempts to
request/free/mask/unmask an MSI descriptor. However, MSIs may be
received by real-time handlers.

This rule is enforced at API level by the upcoming Xenomai 3, but
enabling MSI with Xenomai 2 is already possible, by carefully invoking
services like rtdm_irq_request/free/enable/disable() from a plain linux
context (typically on behalf of module_init/exit routines), and not from
a RTDM task.

This is in essence what should be checked on the RTnet side.

(*) the distance from "should be" to "is" is due to the fact that I did
not check with recent x86 kernels yet, however a quick look at the
related kernel code in 3.14 did not reveal any obvious showstopper, so
there is hope.

-- 
Philippe.

