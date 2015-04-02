Date: Thu, 2 Apr 2015 22:41:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150402204139.GL31175@hermes.click-hack.org>
References: <54F56C9C.6080507@siemens.com>
 <CAPRPZsC9mPitPUmXXR6QQfAGN3UMa2u6hkVwjtO4Eoh-NzC7wA@mail.gmail.com>
 <54FDB495.3060303@triphase.com> <5501FC89.2040205@siemens.com>
 <20150313163431.GE1497@hermes.click-hack.org>
 <550319B3.1050902@siemens.com>
 <20150313171211.GH1497@hermes.click-hack.org>
 <CAPRPZsD4503Yc92d=e0jqR8HtLiV8rXo_vA2e5ea5V_gyCTOzA@mail.gmail.com>
 <20150402191555.GK31175@hermes.click-hack.org>
 <CAPRPZsCcAQCYNbVXzB5yW+hNzhLcrDLETDteFLgDLnuzz6RCsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPRPZsCcAQCYNbVXzB5yW+hNzhLcrDLETDteFLgDLnuzz6RCsA@mail.gmail.com>
Subject: Re: [Xenomai] xeno3_rc3 - Watchdog detected hard LOCKUP
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Apr 02, 2015 at 09:29:29PM +0200, Jeroen Van den Keybus wrote:
> 2015-04-02 21:15 GMT+02:00 Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org>:
> > On Thu, Apr 02, 2015 at 08:47:30PM +0200, Jeroen Van den Keybus wrote:
> >> I've been testing for two weeks now and the system has crashed three
> >> more times under dohell load. Two with 3.14.28, the other with 3.16.0.
> >> Time to crash varied between 3 hours and 90 hours.
> >>
> >> The scenario is always the same: one CPU (has already been any of the
> >> 4) gets stuck and the others start reporting soft lockups. The trouble
> >> is: I've been unable to get hold of a stack trace of the hardlocked
> >> CPU. SysRq L does not work and the CPU does not respond to the NMIs it
> >> is given from the softlocked CPUs. I also enabled hardlockup_panic to
> >> make sure I get all stack traces but to no avail.
> >>
> >> Does anyone know another trick to possibly get the backtrace from this CPU ?
> >
> 
> > You can modify ipipe_trace_freeze to get the trace of a different
> > CPU.
> 
> Ah yes, I forgot. It is probably locked outside the Linux domain. That
> would explain why the regular panic won't work. Is that correct ?

You will probably know that when you know why you get a lockup.

> 
> > But if I were you I would test the latest stable release
> > first.
> 
> Ok. I'll do that. I would have liked to know the cause of the lockups
> though, And above all, we wanted to test Xenomai 3 from the start of a
> new project.

I am talking about Linux stable releases. Something more recent than
3.14.28 or 3.16.0.

-- 
					    Gilles.

