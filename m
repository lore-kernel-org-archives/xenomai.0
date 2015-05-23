Date: Sat, 23 May 2015 20:26:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150523182625.GD1987@hermes.click-hack.org>
References: <245D3361-0412-466A-BFA1-22F2EDDC18B6@gatech.edu>
 <20150522210503.GA1987@hermes.click-hack.org>
 <9184F070-BBB8-44F8-AD64-79536BCDFA52@gatech.edu>
 <20150522215216.GB1987@hermes.click-hack.org>
 <64026009-C15A-45D5-B090-94546E3E25BB@gatech.edu>
 <20150522222627.GC1987@hermes.click-hack.org>
 <C2E076E7-9C2C-4981-B9D5-09BA8AAB10CD@gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C2E076E7-9C2C-4981-B9D5-09BA8AAB10CD@gatech.edu>
Subject: Re: [Xenomai] 3.14.17 patch initial ram disk hangup
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Yogi A. Patel" <yapatel@gatech.edu>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Sat, May 23, 2015 at 02:14:10PM -0400, Yogi A. Patel wrote:
> 
> > On May 22, 2015, at 18:26, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> > 
> > On Fri, May 22, 2015 at 06:00:56PM -0400, Yogi A. Patel wrote:
> >>> On May 22, 2015, at 17:52, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> >>> 
> >>>> On Fri, May 22, 2015 at 05:37:16PM -0400, Yogi A. Patel wrote:
> >>>> 
> >>>>> On May 22, 2015, at 17:05, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> >>>>> 
> >>>>> On Fri, May 22, 2015 at 04:47:59PM -0400, Yogi A. Patel wrote:
> >>>>>> Hi -
> >>>>>> 
> >>>>>> I have a Dell OptiPlex 9020 running 3.14.17. I am trying to get this system to run 3.14.17 with xenomai (using the 3.14.17 patch in the xenomai 2.6.4 source).
> >>>>>> 
> >>>>>> The computer hangs when I select the kernel at “Loading initial ram disk”. I tried booting into recovery mode and go the following output:
> >>>>>> 
> >>>>>> Kernel panic - not syncing: timer doesn’t work through Interrupt-remapped IO-APIC.
> >>>>>> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.14.17-xenomai-2.6.4.
> >>>>>> 
> >>>>>> I’m having a hard time finding the source of the error. I’ve attached my config file. Any suggestions appreciated!
> >>>>> 
> >>>>> Does the exact same kernel configuration, but without CONFIG_IPIPE
> >>>>> and CONFIG_XENOMAI work ?
> >>>>> 
> >>>>> -- 
> >>>>>                       Gilles.
> >>>> 
> >>>> Sorry, I may have misunderstood but if you’re asking if 3.14.17 works out of the box (withough being patched), then yes it does work.
> >>> 
> >>> The question is: with the exact same configuration?
> >>> 
> >>> -- 
> >>>                       Gilles.
> >> 
> >> I can't get the kernel to compile if I turn those two options off (but leave everything else the same).
> >> 
> >> I get the following error: 
> >> 
> >> kernel/fork.c: In function ‘dup_task_struct’:
> >> kernel/fork.c:317:29: error: ‘struct thread_info’ has no member named ‘ipipe_data’
> >> __ipipe_init_threadinfo(&ti->pipe_data);
> >> make[2] *** [kernel/fork.o] Error 1
> >> make[1] *** [kernel] Error 2
> > 
> > You were talking about the unpatched kernel. Does the unpatched
> > kernel work with the exact same configuration (only without
> > CONFIG_IPIPE and CONFIG_XENOMAI).
> > 
> > -- 
> > 					    Gilles.
> 
> Yes, I compiled an unpatched kernel with all the same options (turn off processor ACPI, frequency scaling, etc) and I can successfully boot up.

I am sorry, but this does not look like the "exact same
configuration". To get the exact same configuration, simply copy the
damn .config file, the unpatched kernel kbuild system should cope
with the missing CONFIG_XENOMAI and CONFIG_IPIPE. This will remove
any uncertainty. Run diff to get 100% sure that nothing else is
changed.

Also, as mentioned in the documentation, starting from a "full
monty" configuration like the ones you find in a distribution, and
simply removing CONFIG_ACPI_PROCESSOR, CONFIG_CPUFREQ) IS NOT the
recommended way. It is better to start from a lean configuration
where only what you need is enabled, this makes the kernel build
process much faster and so further attempts less expensive, and you
have more chances to void enabling an option that nobody else uses
with Xenomai.

> 
> With the patched kernel, if I provide “noapci” to the kernel boot commands, I can get past the “Loading initial ramdisk” but then the system freezes prior to getting to the login screen.
> 
> I tried the same config with a patched 3.14.17 kernel on a different machine (not the same model as the one that is hanging at initrd) - and the system boots up successfully into 3.14.17 with xenomai.

The obvious answer, which I believe you can find many times
mentioned in the archives, and even in the troubleshooting guide Is
to disable the kernel "silent" mode if it is not disabled, and
enable early printk.

Seeing a user which does not read and follow the basic guides makes
me reluctant to answer him.

-- 
					    Gilles.

