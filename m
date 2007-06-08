Date: Fri, 8 Jun 2007 12:49:27 +0200
From: Daniel Simon <Daniel.Simon@domain.hid>
Message-ID: <20070608124927.1b789a9e@domain.hid>
In-Reply-To: <4668440F.7020706@domain.hid>
References: <2404.194.199.21.225.1181233422.squirrel@domain.hid>
	<4668440F.7020706@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help]  measuring tasks execution time
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

On Thu, 07 Jun 2007 19:44:47 +0200
Jan Kiszka <jan.kiszka@domain.hid> wrote:

Hello, opening a new thead forking from the one opened yesterday by Arnaud
Desvages

> Hmm, the patch looks like it consequently reimplements existing runtime
> statistics instead of reusing them as a foundation...
> 
Yes, might be simpler now. This patch has been done in urgency upon
xenomai 2.1 and was more or less sleeping since one year. It has been weakly
tested, only on Pentium 3 cpus.

> Anyway, I think we could discuss some API extension of Xenomai (for
> native, probably via  ). Likely we would keep this report
> optional, ie. make it return -1 or so if CONFIG_XENO_OPT_STATS is off.
> Tracking stats is not as costly as other instrumentations, but it's also
> not free. If you are interested, let us know. It won't be a one-liner,
> but it doesn't look like it has to be as invasive as your approach.

Our goal is computing the accumulated cost of some selected real-time tasks
to get an image of the  cpu load.

What we need is a record of  the accumulated execution time of the
rt_tasks (not the response time, hence the instants when the task is
preempted or suspended must not be counted).
This record must be accessible at any time, either from the calling
task or by another one.  

Our current patch only does that for tasks running in primary mode (and
moreover the measure seems not correctly updated for the calling
task record).  

Thus we would be very happy to get an improved instrumentation api.
I understand that  xnstat_runtime_update() handles the measure we need? 
Making it available, e.g.  via a rt_task_inquire call, would be great! 

	Daniel
-- 
       Daniel SIMON    Projet NeCS  INRIA Rhone-Alpes
        Inovallee, 655 avenue de l'Europe, Montbonnot
             38 334 Saint Ismier Cedex France
 Daniel.Simon@domain.hid Phone:(33)476615328 Fax:(33)476615252
          http://necs.inrialpes.fr/people/simon/



