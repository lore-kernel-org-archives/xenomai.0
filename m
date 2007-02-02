Subject: Re: Re: [Xenomai-help] Error: cat: /proc/xenomai/stat: Cannot allocate
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <19495517.1170421114020.JavaMail.ngmail@domain.hid>
References: <1170420270.4981.58.camel@domain.hid>
	<19981456.1170405795640.JavaMail.ngmail@domain.hid>
	<1170408789.4981.1.camel@domain.hid> <1170409755.4981.11.camel@domain.hid>
	<45C309BF.9090808@domain.hid>  <1170415388.4981.36.camel@domain.hid>
	<19495517.1170421114020.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Fri, 02 Feb 2007 15:35:30 +0100
Message-Id: <1170426931.4981.71.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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

On Fri, 2007-02-02 at 13:58 +0100, M. Koehrer wrote:
> Hi Philippe, 
> 
> I can. Which of the many values in /proc/vmstat is the relevant one to check?
> 

$ vmstat 1
or
$ watch -n 1 free

The value in the free space column should decrease slowly but constantly
while the read loop runs.

> Regards
> 
> Mathias
> 
> > On Fri, 2007-02-02 at 12:23 +0100, Philippe Gerum wrote:
> > > On Fri, 2007-02-02 at 10:51 +0100, Gilles Chanteperdrix wrote:
> > > > Philippe Gerum wrote:
> > > > > On Fri, 2007-02-02 at 10:33 +0100, Philippe Gerum wrote:
> > > > > 
> > > > >>On Fri, 2007-02-02 at 09:43 +0100, M. Koehrer wrote:
> > > > >>
> > > > >>>Hi everybody,
> > > > >>>
> > > > >>>I have a strange issue frequently when reading /proc/xenomai/stat.
> > > > >>>I do a cat /proc/xenomai/stat and I get an "Cannot allocate memory"
> > error.
> > > > >>>This happens typcially after I have started and terminated by
> > application that uses a number of tasks.
> > > > >>>I am able to reproduce it deterministically...
> > > > >>>While the application is running, I can see the stat values
> > perfectly.
> > > > >>>Here is the head output of all /proc/xenomai/* files:
> > > > >>
> > > > >>At first sight looking at the code, there seems to be a memory leak
> > > > >>caused by an unfree kmalloc() block in the sched & stat sequence
> > > > >>routines. Will confirm and fix. Thanks,
> > > > >>
> > > > > 
> > > > > 
> > > > > Not confirmed for the leakage part regarding kmalloc(). We do have a
> > > > > seq_release_private() freeing the allocated block, so back to square
> > #1.
> > > > > This said, some kernel memory is not released somewhere, as running
> > > > > vmstat tells me here.
> > > > > 
> > > > > Btw, is the rest of your system functional after the error occurs, or
> > is
> > > > > a reboot needed afterwise?
> > > > 
> > > > Do you observe the same leakage without the nocow patch ?
> > > > 
> > > 
> > > Yes, 2.6.19-1.6-04 (without nowcow) has the same problem. But the
> > > interesting things is that reading /proc/interrupts in loop seems to
> > > silently eat kernel memory by small chunks too. I'm now trying on a
> > > vanilla kernel.
> > > 
> > 
> > Confirmed. A vanilla 2.6.19 silently eats memory when
> > reading /proc/interrupts in loop. Mathias, could you please confirm this
> > on your box too? TIA,
> > 
> > -- 
> > Philippe.
> > 
> > 
> > 
> 
-- 
Philippe.



