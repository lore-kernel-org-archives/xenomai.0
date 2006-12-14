Subject: Re: [Adeos-main] [PATCHES] cleanup minor quirks for 1.6-01
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4577546A.7040208@domain.hid>
References: <4572DB9F.7040505@domain.hid> <1165157023.4952.361.camel@domain.hid>
	<4572E7D1.5020103@domain.hid> <1165160855.4952.415.camel@domain.hid>
	<457310FA.90706@domain.hid> <1165177332.4952.450.camel@domain.hid>
	<4577546A.7040208@domain.hid>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 21:53:39 +0100
Message-Id: <1166129619.23946.164.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org

On Thu, 2006-12-07 at 00:38 +0100, Jan Kiszka wrote:

> > 
> >> If there is actually something to protect, than it should be calling
> >> this proc handler vs. unregistering the domain (and it's proc entry) -
> >> but that is only feasible with something like synchronize_sched, i.e.
> >> waiting a grace period after unregistering so that all handlers are
> >> through. A really uncritical race which exists with a lot of /proc code.
> >>
> > 
> > This race could crash the box, would the descriptor from the
> > unregistered domain belong to a module being unloaded. Since
> > ipipe_register_domain() grabs the critical lock, masking IRQs in
> > the /proc handler would do the trick, but this is a fairly high price to
> > pay for running such a routine. 
> > 
> 
> Better no IRQ lock for this.
> 

Clearly.

> Well, also my synchronize_sched idea is not truly safe (unless the proce
> handler would be called under rcu_read_lock - don't think this is the
> case). I really can't tell how to safely cleanup proc entries that have
> volatile data structures attached. I once asked on LKML for a correct
> pattern but got no reply.

Let's go for a simple mutex excluding the unregistration routine for
now. Not perfect, but still better than the previous situation. It's
been introduced in 1.6-02/x86.

-- 
Philippe.



