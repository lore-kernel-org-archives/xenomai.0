Resent-Message-ID: <20150318134120.GD24525@hermes.click-hack.org>
Resent-To: xenomai@xenomai.org
Date: Wed, 18 Mar 2015 14:39:21 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150318133921.GC24525@hermes.click-hack.org>
References: <tencent_07B7EF291D718FAF2A4D5BBC@qq.com>
 <20150318075122.GL16113@hermes.click-hack.org>
 <tencent_1DF1E8A94FD8F46B59E71CC9@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_1DF1E8A94FD8F46B59E71CC9@qq.com>
Subject: Re: [Xenomai] I find a way to reduce latency, but I don't know why.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Zhoupeng <zhoupeng1982@qq.com>

On Wed, Mar 18, 2015 at 09:31:33PM +0800, Zhoupeng wrote:
> > On Tue, Mar 17, 2015 at 09:41:05PM +0800, 书呆子 wrote:
> > > The x86 machine have two CPUs, and I need periodic task on CPU1.
> > > In order to reduce latency, a busy task will run on CPU2.
> > > 
> > > cpu1_task
> > > {
> > >   rt_task_wait_period;
> > >   real_work;
> > >   rt_sem_v(&busySEM);
> > > }
> > > 
> > > cpu2_task
> > > {
> > >   rt_sem_p(&busySEM);
> > >   rt_timer_spin(spin_ns);
> > > }
> > > 
> > > And spin_ns will be long enough: spin_ns + real_work_ns > periodic cycle.
> > > Yes, it means rt_code is always running on CPU1 or CPU2.
> > > 
> > > In doing this, the cpu1_task will get low latency and drift, but why ?
> 
> > Two possibilities:
> > - task2 is cache friendly, so if the cache is shared between the two
> > cpus, it prevents Linux from evicting xenomai and I-pipe code from
> > the cache, we know that cache has a big influence on latency;
> 
> I agree this is the best guess, the I5 CPUs do share L3 cache between them. 
> 
> I also use rt_timer_read() wrap real_work() to measure time consumption: 
> without task2 real_work() expend 20 to 36us, with task2 real_work() 
> expend 20 to 22us to compelte. 
> real_work() only contain float-point arithmetic, the time stability is
> improved obviously.
> 
> If this is cache problem, is task2 the right way to keep code in cache ?
> 
> > - task2 prevents the cpu from entering idle mode, and so potentially
> > prevents any low power optimization from happening, low power modes
> > are generally not latency friendly.
> 
> CONFIG_CPU_FREQ and CONFIG_CPU_IDLE is already disabled, smi workaround
> also enabled.
> I have notice C1E mode is disabled in Xenomai 3, but not in Xenomai 2,
> but C1E is triggered by mwait, I don't think this is the problem.

Linux idle task uses mwait, and nothing prevents the chip maker to
do any optimization he wants when hlt is called. On geode
processors, with some configuration, hlt causes the tsc to be
stopped for instance.

-- 
					    Gilles.

