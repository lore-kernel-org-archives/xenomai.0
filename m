Message-ID: <49B3A61E.3040306@domain.hid>
Date: Sun, 08 Mar 2009 12:03:58 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <49B39DB5.8040601@domain.hid>
In-Reply-To: <49B39DB5.8040601@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] xnshadow_relax in taskexit_event
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> this looks suspicious to me:
> 
> static inline void do_taskexit_event(struct task_struct *p)
> {
> 	...
> 	if (xnpod_shadow_p())
> 		xnshadow_relax(0);
> 
> A) The only call context of this hook is do_exit() - and that's Linux
> kernel code which should always run in secondary mode, no?
>

It is a left-over from the days when do_exit() could be called from primary 
context directly on behalf on the shadow unmapping code; now we go through an 
APC, so that should be ok.

> B) Even if we were called once in a while from primary mode here, too,
> the check xnpod_shadow_p() would only tell us that we are a shadow
> thread, not in which mode we currently run.
> 

Nak, this test is fine, even if probably useless now. xnpod_shadow_p() 
implicitely checks that your current Xenomai thread is not in secondary mode, 
because you cannot find the XNSHADOW bit set in the root thread tcb, which must 
be active in secondary mode.

> I've tested a removal of this hunk and found no regressions so far. Will
> post a patch unless someone can explain why we actually need this (and
> why A) and B) are non-issues).

Let's replace this code with a BUG_ON(xnpod_shadow_p()).

> 
> Jan
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


