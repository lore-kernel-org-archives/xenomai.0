Date: Fri, 8 Jun 2007 15:09:53 +0200
From: Daniel Simon <Daniel.Simon@domain.hid>
Message-ID: <20070608150953.3095d7bd@domain.hid>
In-Reply-To: <46693B6B.1010201@domain.hid>
References: <2404.194.199.21.225.1181233422.squirrel@domain.hid>
	<4668440F.7020706@domain.hid>
	<20070608124927.1b789a9e@domain.hid>
	<46693B6B.1010201@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-help] measuring tasks execution time
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

On Fri, 08 Jun 2007 13:20:11 +0200
Jan Kiszka <jan.kiszka@domain.hid> wrote:

> Daniel Simon wrote:
> > On Thu, 07 Jun 2007 19:44:47 +0200
> > Jan Kiszka <jan.kiszka@domain.hid> wrote:
> > 
> > Hello, opening a new thead forking from the one opened yesterday by Arnaud
> > Desvages
> 
> I moved the thread to xenomai-core, hope you don't mind.

OK,  I guess it is the right place
> > 
[...]
> > Our goal is computing the accumulated cost of some selected real-time tasks
> > to get an image of the  cpu load.
> > 
> > What we need is a record of  the accumulated execution time of the
> > rt_tasks (not the response time, hence the instants when the task is
> > preempted or suspended must not be counted).
> > This record must be accessible at any time, either from the calling
> > task or by another one.  
> > 
> > Our current patch only does that for tasks running in primary mode (and
> > moreover the measure seems not correctly updated for the calling
> > task record).  
> > 
> > Thus we would be very happy to get an improved instrumentation api.
> > I understand that  xnstat_runtime_update() handles the measure we need? 
> 
> It was designed to collect precise runtime statistics to be displayed in
> /proc/xenomai/stat. We would just have to keep a total counter for each
> task as dumping /proc resets the statistics ATM.
> 
> > Making it available, e.g.  via a rt_task_inquire call, would be great! 
> 
> Well, the best (==most comfortable :o) ) way from my POV would be if you
> could try rebasing your work on your own first. Questions, even on minor
> details, are always welcome, review on patches will be provided. Should
> be no problem to get this into Xenomai 2.4.
> 
> The rough to-do list would be:
> 
>  o add some persistent runtimer counter to xnthread::stat and maintain
>    it
>  o introduce an xnpod service (inline function) to obtain it (let that
>    thing return [0..LONGLONG_MAX] when stats are available, -1
>    otherwise)
>  o export the runtime via struct rt_task_info, maybe also the task start
>    time
> 
> Jan
> 
I am afraid that it is far beyond my own programming capabilities, and I have no
longer skilled enough students at hand...
Anyway there are some highly skilled (and overloaded) engineers around, i'll try
to hire one of them!
	Daniel


-- 
       Daniel SIMON    Projet NeCS  INRIA Rhone-Alpes
        Inovallee, 655 avenue de l'Europe, Montbonnot
             38 334 Saint Ismier Cedex France
 Daniel.Simon@domain.hid Phone:(33)476615328 Fax:(33)476615252
          http://necs.inrialpes.fr/people/simon/



