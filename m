Message-ID: <trinity-db1a9f17-84fe-4cd6-a77d-b6fe73d680a6-1449571352953@3capp-webde-bap21>
From: "Jochen Behnke" <JK.Behnke@web.de>
Date: Tue, 8 Dec 2015 11:42:32 +0100
In-Reply-To: <20151204204107.GE29398@hermes.click-hack.org>
References: <trinity-3a616500-d86a-4f71-bb11-16fa1d6cf8a2-1448533977790@3capp-webde-bs12>
 <20151128064325.GC10399@hermes.click-hack.org>
 <trinity-4550a539-a311-4cb6-853e-f6f5fb983201-1448975385774@3capp-webde-bap47>
 <20151201181155.GC30041@hermes.click-hack.org>
 <trinity-8e5e4a49-df3c-4391-b1ce-b1bc4d77ffcc-1449061119000@3capp-webde-bs35>
 <trinity-edf656b8-4eef-4967-92eb-85856ad3f8bd-1449246268211@3capp-webde-bs27>
 <20151204163315.GD29398@hermes.click-hack.org> <5661E4D5.5010804@web.de>,
 <20151204204107.GE29398@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] "RT throttling" issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

   Hello Gilles,

   > > >> Now I have the following questions
   > > >> 1. What is meant by "domain stalled", "current" and
   "current+stalled"?
   > > >> 2. What is that process having ID "[ 0]"
   > > >> 3. How can I tell processes running in secondary mode from
   others?
   > > >> (just by looking at the priority value?)
   > > >>
   > > >> Any hint on interpreting my frozen file is appreciated.
   > > >
   > > > This trace is worthless. To have a meaningful trace, enable
   tracing
   > > > on functions entry (the default when you enable the I-pipe
   tracer).
   > > >
   > > Do you mean CONFIG_FUNCTION_TRACE?
   >
   > I mean CONFIG_IPIPE_TRACE_MCOUNT
   >
   I enabled CONFIG_IPIPE_TRACE_MCOUNT=Y and set
   CONFIG_IPIPE_TRACE_SHIFT=18
   to get 256000 lines of backtrace history.
   I captured some frozen files, when RT Throttling occurred and during
   normal
   operation.
   To me, they look very similar and I am not sure at what functions
   I should look at.

   The longest delay values (>= 1000us) I observe for the following
   functions.
   They occur every 5..10 ms.
   __ipipe_halt_root           : delays = 1000us .. 3900us
   __ipipe_restore_root_nosync : delays = 1000us .. 3900us

   As "__ipipe_halt_root" is called by "default_idle", and the delay
   values
   increase (up to 9984 us), when the application is not running, I guess
   this
   is actually CPU idle time and not relevant.

   "ipipe_root_only" also occasionally has long delay times.
   Is ipipe_root_only run when Linux is executing?
   Is this critical?
   See extract below.
   ================== start: extract from frozen file
   ================================
   :    +func               -420045+   1.443  ipipe_root_only+0x4
   (copy_to_user+0x31)
   :    +func               -420044      0.260  __ipipe_syscall_root+0x5
   (sysenter_past_esp+0x5b)
   :    +func               -420043      0.200  sys_time+0x5
   (sysenter_do_call+0x12)
   :    +func               -420043      0.210  get_seconds+0x3
   (sys_time+0xf)
   :    +func               -420043! 3910.393  ipipe_root_only+0x4
   (sys_time+0x1c)
   :|   +func               -416132      0.651  __ipipe_handle_irq+0x5
   (common_interrupt+0x2c)
   :|   +func               -416132      0.340  __ipipe_dispatch_irq+0x9
   (__ipipe_handle_irq+0x7f)
   ================== end: extract from frozen file
   ================================

   Any other suggestions where to look at?
   Thanks in advance
   Jochen
