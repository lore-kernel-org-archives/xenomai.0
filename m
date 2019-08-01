Message-ID: <7077517db50c06adaefa6ca637855ab9639c1701.camel@sprinte.eu>
Subject: Re: SCHED_WEAK vs linux regular threads
From: Julien Blanc <julien.blanc@sprinte.eu>
Date: Thu, 01 Aug 2019 15:11:14 +0200
In-Reply-To: <17cd5997-6de8-3676-cf38-58a2d989849e@siemens.com>
References: <4a206d9deb77bc032eef9c689aa1266cf9ed12c3.camel@sprinte.eu>
 <17cd5997-6de8-3676-cf38-58a2d989849e@siemens.com>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Le jeudi 01 août 2019 à 13:25 +0200, Jan Kiszka a écrit :
> On 01.08.19 11:53, Julien Blanc via Xenomai wrote:
> > Hi,
> > 
> > Let’s say i have four threads :
> > * thread 1, RT, with SCHED_FIFO policy and a sched_param value of
> > 90
> > * thread 2, RT, with SCHED_WEAK policy and a sched_param value of 0
> > * thread 3, RT, with SCHED_WEAK policy and a sched_param value of 0
> 
> Should 2 and 3 have the same parameters in your scenario?

That is not necessary. But our kernel currently lacks OPT_SCHED_WEAK,
so i need to consider whether we need to rebuild and deploy a new one
or not (i’d like to avoid it for now).

> You can assign non-zero prios to thread 2 and 3, ordering it this
> way, but then also while both are in primary mode. For "weak"
> ordering, you could also leave their prio at 0 and play with their
> nice level. That would be a Linux-only "prio".

I’ll give that a try.

Thanks and thanks to Philippe for your detailed answers, this is much
clearer now.

Regards,

Julien


