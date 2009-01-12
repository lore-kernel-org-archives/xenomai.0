Message-ID: <496B16FE.7000404@domain.hid>
Date: Mon, 12 Jan 2009 10:10:06 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <21175505.1231747787507.JavaMail.ngmail@domain.hid>
In-Reply-To: <21175505.1231747787507.JavaMail.ngmail@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai and Perfmon2?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

M. Koehrer wrote:
> Hi everybody,
> 
> I am using Xenomai for real time system that has to compute complex simulations.
> For that, not only real time behaviour but also computation power is relevant.
> I am using Intel's Core 2 Duo/Quad CPUs.
> The perfom2 package (http://perfmon2.sourceforge.net/) allows to access the CPU's
> perfomance monitoring registers fairly easily.
> It contains a kernel patch and a user mode frontend.
> I have now tried to apply the Xenomai patch (first) and the perfom2 patch (second) which seems to work
> (some slight modifications on the perfom2 patch have been necessary) partially.
> I can now use the system-wide mode of pfmon, however I can not attach from pfmon to a running
> realtime task (the kernel freezes), but at least the system-wide mode is quite helpful.
> 
> My questions to this combination:
> - Can the perfmon2 kernel patch somehow destroy the real time behaviour of the Xenomai executable?
> 
> - I am mostly interested in things like EIST mode (Intel speed Step) changes, bus access delays etc.
> Is there more simple way to access this information but using the perfom2 patch?
> 
> Thanks for any response on that questions!

Hi Mathias,

you can not apply a patch made for Linux to a xenomai-patched kernel and
hope that it automatically works for Xenomai, it does not work that way,
you will have to modify the patch to get it running with Xenomai.
Without any modification the patch will only work for plain linux tasks.

If the patch is simple, the modifications may be simple too (for
instance, replacing some spinlocks with ipipe_spinlocks), but you are
talking about a 900K patch, I am afraid it will require more work.

As for Intel speed Step, it is not recommended to run xenomai with it:
Xenomai assumes a constant CPU frequency.

Regards.

-- 
                                                 Gilles.

