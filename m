Message-ID: <4569E699.6050003@domain.hid>
Date: Sun, 26 Nov 2006 20:10:17 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Adeos support for 2.6.18 merged PowerPC
	architecture.
References: <20061124105346.e442448d.benjamin.zores@domain.hid>	<4566C5AF.7030107@domain.hid>
	<20061124113009.08c0a490.benjamin.zores@domain.hid>
In-Reply-To: <20061124113009.08c0a490.benjamin.zores@domain.hid>
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
To: Benjamin Zores <benjamin.zores@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Benjamin Zores wrote:
> On Fri, 24 Nov 2006 11:13:03 +0100
> Wolfgang Grandegger <wg@domain.hid> wrote:
> 
>> Yes, the PowerPC tree is not yet supported.
> 
> Yes but as i need it now i've decided to port it ;-)
> Or at least of a try.

Good, :-)

>> You might have realized my hack to get ride of radix-tree.h for the ppc 
>> tree.
> 
> Actually not, have some patch ?

For the ppc tree, I have added

   #ifdef CONFIG_PPC_MERGE
   #include <linux/radix-tree.h>
   #endif

to include/powerpc/irq.h to get rid of the trouble with radix-tree.h.

>> What defconfig do you use? Unfortunately I do not have a board by hand 
>> supported by the PowerPC tree.
> 
> mpc834x_itx_defconfig

I briefly reviewed your patch. At a first glance, it looks OK, but it is 
not yet complete and it does not compile. Quickly, I spotted the 
following problems:

- NR_IRQS is not defined. This is a problem with the include weirdness 
due to radix-tree.h, IIRC. It is set to 512 for all PowerPC archs, puh, 
that's overkill (but not our problem for the time being).

_ipipe_grab_irq(): special IRQ numbers have changed. Check for 
NO_IRQ_IGNORE in the attached patch. Also the new IRQ handling needs a 
more detailed review (check irq.c in the powerpc tree).

- disarm_decr[] has disappeared. It was used to disable the programming 
of the decrementer in arch/ppc/kernel/time.c:timer_interrupt(). It needs 
an appropriate replacement in the powerpc tree. A quick, untested hack 
is in the attached patch.

There might be more issues.

We should also avoid code duplication of IPIPE files, but that's 
something I will fix later-on.

Hope this helps you to get a bit further (kernel booted).

Wolfgang.


