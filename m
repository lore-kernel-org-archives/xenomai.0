Date: Wed, 27 Jun 2007 10:57:26 +0200
From: Daniel Simon <Daniel.Simon@domain.hid>
Message-ID: <20070627105726.7db7a459@domain.hid>
In-Reply-To: <467FF391.8020401@domain.hid>
References: <2404.194.199.21.225.1181233422.squirrel@domain.hid>
	<4668440F.7020706@domain.hid>
	<20070608124927.1b789a9e@domain.hid>
	<46693B6B.1010201@domain.hid>
	<20070625175107.438849fa@domain.hid>
	<467FF391.8020401@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] measuring tasks execution time
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

On Mon, 25 Jun 2007 18:55:45 +0200
Jan Kiszka <jan.kiszka@domain.hid> wrote:



> My idea was to keep a persistent version the existing xnstat_runtime_t
> instance in xnthread (and later on also xnintr). That one shall not be
> reset on readout via /proc.
Is it necessary to keep also the reset one?

> Instead, you establish quite some new calculations that break
> the existing API (the switch date is given via "start" - which was
> misnamed so far, I just changed it to "date") 

ok, better fit the behaviour.
I should better work from the last svn version?

>and increase the runtime
> overhead in the hotpath. Why? All the information you should need is
> already there, it just has to be saved from being vaporised when the
> user dumps /proc/xenomai/stat.
> 
> >  	(sched)->last_account_switch = start; \
> >  } while (0)
> >    
> 
> Let's try it like this: Change Xenomai so that it leaves the existing
> xnthread_t::stat.account untouched when it reads /proc. Rather add
> something like "xnstat_runtime_t last;" to xnthread_t::stat. On readout
> for /proc output, 
Where is this done? I've found one place in module::stat_seq_open where total is
reset to 0, is it the only one? 
In fact I don't have a clear picture of the stat
process and what it is assumed to do (and thus did not want to break something!)
>do the stats now like "account-last" and then move
> account into last. For your task exectime, you can then read
> xnthread_t::stat.account directly, because it will always reflect the
> full task history. Would't this work better?

> Thanks for working on this!
I'll try to find enough time by the end of this week to improve this...

	Daniel

-- 
       Daniel SIMON    Projet NeCS  INRIA Rhone-Alpes
        Inovallee, 655 avenue de l'Europe, Montbonnot
             38 334 Saint Ismier Cedex France
 Daniel.Simon@domain.hid Phone:(33)476615328 Fax:(33)476615252
          http://necs.inrialpes.fr/people/simon/



