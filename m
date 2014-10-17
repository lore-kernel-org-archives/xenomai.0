From: Lowell Gilbert <kludge@be-well.ilk.org>
References: <A83EBA0226A300439B44DB00FD90D6560F2C18@NDMSMBX402.ndc.nasa.gov>
Date: Fri, 17 Oct 2014 14:30:38 -0400
In-Reply-To: <A83EBA0226A300439B44DB00FD90D6560F2C18@NDMSMBX402.ndc.nasa.gov>
 (Udayan Mallik's message of "Fri, 17 Oct 2014 14:44:20 +0000")
Message-ID: <44iojio8fl.fsf@lowell-desk.lan>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Xenomai] Menuconfig
Reply-To: "xenomai@xenomai.org" <xenomai@xenomai.org>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Mallik, Udayan (GSFC-5640)" <udayan.mallik-1@nasa.gov>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

"Mallik, Udayan (GSFC-5640)" <udayan.mallik-1@nasa.gov> writes:

> I am installing Xenomai-2.6.4 on my Linux box with Linux-3.10.32.

on a PC-type machine, most likely...

Do you have a kernel working with the ipipe extensions before adding
Xenomai? 

> I disabled all but the MSI switch (I could not change this one!) under
> menuconfig and my installation ran into a Kernel Panic mode "kernel
> panic not syncing: timer does not work through Interrupt remapped
> IO-APIC."

MSI is unlikely to be relevant if you're not launching any
Xenomai-enabled processes before the panic.

> Today I read more about Xenomai and it seems to need some of the switches it told me to disable.

Can you be more specific? Which switches, why you think that, etc.?

> Should I fiddle with Menuconfig at all?

What happens if you don't?

I assume you started from a kernel codebase and configuration that
worked before you started on any of the Xenomai work. You really want
that as a baseline before starting to change things.

