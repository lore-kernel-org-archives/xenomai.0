Date: Wed, 18 Mar 2015 08:51:22 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150318075122.GL16113@hermes.click-hack.org>
References: <tencent_07B7EF291D718FAF2A4D5BBC@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_07B7EF291D718FAF2A4D5BBC@qq.com>
Subject: Re: [Xenomai] I find a way to reduce latency, but I don't know why.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?5Lmm5ZGG5a2Q?= <zhoupeng1982@qq.com>
Cc: xenomai <xenomai@xenomai.org>

On Tue, Mar 17, 2015 at 09:41:05PM +0800, 书呆子 wrote:
> The x86 machine have two CPUs, and I need periodic task on CPU1.
> In order to reduce latency, a busy task will run on CPU2.
> 
> cpu1_task
> {
>   rt_task_wait_period;
>   real_work;
>   rt_sem_v(&busySEM);
> }
> 
> cpu2_task
> {
>   rt_sem_p(&busySEM);
>   rt_timer_spin(spin_ns);
> }
> 
> And spin_ns will be long enough: spin_ns + real_work_ns > periodic cycle.
> Yes, it means rt_code is always running on CPU1 or CPU2.
> 
> In doing this, the cpu1_task will get low latency and drift, but why ?

Two possibilities:
- task2 is cache friendly, so if the cache is shared between the two
cpus, it prevents Linux from evicting xenomai and I-pipe code from
the cache, we know that cache has a big influence on latency;
- task2 prevents the cpu from entering idle mode, and so potentially
prevents any low power optimization from happening, low power modes
are generally not latency friendly.

Note however that measurements on an idle system do not really
matter much for finding the worst case latency. Real measurements
should last for hours and with the machine put under load. I bet
with measurements done this way, the differences you observe with
the tests you do would be negligible compared to the worst case
latency. And if there is a real difference, then the I-pipe tracer
would help you find from where it comes.

-- 
					    Gilles.

