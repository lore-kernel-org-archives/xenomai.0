Subject: Re: [Xenomai-help] Dynamic load of shared object files in real
	time applications
In-Reply-To: <10623239.1168007940021.JavaMail.ngmail@domain.hid>
References: <10623239.1168007940021.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Thu, 11 Jan 2007 20:17:53 +0100
Message-Id: <1168543073.25399.154.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
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

On Fri, 2007-01-05 at 15:39 +0100, M. Koehrer wrote:
> Hi everybody,
> 
> I have a question that is similar to the one concerning the system() call out of
> a real time context.
> I want to create a flexible framework that allows dynamic loading of shared objects
> during runtime. (The loading itself can of course not work in real time).
> The main application itself should run for a very long time (a couple of days)
> and during that long run time I want to load and unload small pieces of code that
> have to be executed.
> After loading a .so file I want to hook loaded routines into the (already existing) real time context
> of my main application.
> Is it possible that this kind of operation can cause any memory issue similar to that
> I detected in the 2.6.19 kernel (the system() call out of a real time context)?
> I ask as the dlopen() call probably extends the valid address range of the current
> process.
> 

The initial VM_NOCOW patch only affects the mm copy code on the process
fork path, not the mmap code. And shared libs do depend on COW, for
relocation fixups and other issues. In short, I don't think dynamic
binding would be safe wrt COW handling using this patch.
However, the recent VM_NOFAULT patch Gilles has just posted to the -core
mailing list should solve the issue: the point is to have COW pages
excluded from all VMAs mapped by a (real-time) task, and this is what
ipipe_disable_task_faults() does among other things.

You might also want to try telling the dynamic linker to resolve all
symbols from your shared libs at startup using the LD_BIND_NOW boolean
variable; maybe this would prevent further fixups involving COW
breakage. Static storage data defined by the library that might need to
break COW and as such generate a fault are another issue though.

> Thanks for any feedback on that question.
> 
> Regards
> 
> Mathias
> 
> 
> 
-- 
Philippe.



