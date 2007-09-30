From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46FF78DF.7090104@domain.hid>
References: <46F9167F.20008@domain.hid> <1190756271.26427.0.camel@domain.hid>
	<46FA26ED.4070505@domain.hid>  <46FF78DF.7090104@domain.hid>
Content-Type: text/plain
Date: Sun, 30 Sep 2007 12:52:25 +0200
Message-Id: <1191149545.5989.7.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Non-APIC setup broken for 2.4-SVN?
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Sun, 2007-09-30 at 12:22 +0200, Jan Kiszka wrote:
> Jan Kiszka wrote:
> > Philippe Gerum wrote:
> >> On Tue, 2007-09-25 at 16:09 +0200, Jan Kiszka wrote:
> >>> Hi,
> >>>
> >>> to make it short has anyone or could anyone try latest SVN over kernel 
> >>> 2.6.20 (i-pipe for 2.6.22 is instable) _without_ LAPIC? It works for me, 
> >>> but exposes milliseconds of latencies. Same setup with LAPIC enabled is 
> >>> fine and obviously stable. Before digging into this (time is short 
> >>> anyway), I would like to exclude problems of my notebook hardware.
> >>>
> >> Not confirmed here. Everything looks ok.
> > 
> > Yes, I found a second box working fine with a comparable (though not 
> > identical) config. I suspect some hw issue of my notebook now, but I 
> > will try to look into this a bit deeper once time permits.
> 
> It was a correlation between trying to use the PIT while Linux fiddled
> with the HPET (when HPET is in use, the PIT cannot be programmed). See
> my attached warning patch which may prevent others from pulling hairs.
> 

Yes, this one looks better than the previous attempt to prevent HPET
+Xenomai globally which would create unwanted situations with x86_64
IIRC. I'll test this, and will probably merge.

> > More important is to understand and fix the consistent 2.6.22 issues I 
> > see. Only works in qemu for me, all real i386 boxes lock up sooner or 
> > later. :-/
> 
> I'm on this. Multiple bugs are involved, at least one of them is visible
> already with vanilla on my work notebook.

Do you work with 2.6.22 baseline, or the latest stable update?

>  Another one is related to
> Xenomai not dealing with the lapic device being in
> CLOCK_EVT_MODE_SHUTDOWN whenever the NMI watchdog is in use.

Btw, I have a patch for the latest issue we talked about regarding
kernel-disabled LAPIC. It changes the generic inner interface a bit for
other archs too, so I will commit this asap.

>  And a third
> one only gives me "Detected illicit call from domain Xenomai" before the
> box reboots. :(

Grmff... Do you run with your smp_processor_id() instrumentation in?

> 
> Jan
-- 
Philippe.



