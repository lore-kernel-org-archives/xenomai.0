Date: Sun, 8 Mar 2015 16:52:48 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150308155248.GE5998@hermes.click-hack.org>
References: <44siduq7us.fsf@be-well.ilk.org> <54EE07A9.4040702@xenomai.org>
 <444mq9lo5c.fsf@be-well.ilk.org> <44vbipk8m9.fsf@be-well.ilk.org>
 <54EF014A.9000902@xenomai.org> <447fv4sk55.fsf@lowell-desk.lan>
 <54EF5E45.30907@xenomai.org> <44a900eaqu.fsf@lowell-desk.lan>
 <20150226201100.GB434@hermes.click-hack.org>
 <44r3t1hgxa.fsf@be-well.ilk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44r3t1hgxa.fsf@be-well.ilk.org>
Subject: Re: [Xenomai] interrupt service
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lowell Gilbert <kludge@be-well.ilk.org>
Cc: xenomai@xenomai.org

On Fri, Mar 06, 2015 at 05:58:25PM -0500, Lowell Gilbert wrote:
> I meant *without* using /proc/xenomai/affinity. Fixed below:
> 
> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> writes:
> 
> > Another problem may be in handling the /proc/xenomai/affinity, so
> > could you try without using it? Same for isolcpus. If the ISR runs
> > on cpu0 and the tasks run on cpu1, an IPI should be sent in
> > __xnpod_schedule to wake up the task blocked in read, you can check
> > whether the IPI is sent by using ipipe_trace_special for instance
> > and checking the tracer trace.
> 
> How would I get a kernel task to run on a specific CPU without using
> /proc/xenomai/affinity? rtdm_task_init() specifically calls out
> ALL_CPUS.
> 
> Yes, I could change that code, but it seems like the sort of thing that
> exists -- I just can't find it.

The idea is to stop forcing the task to run on a specific CPU to see
whether the problem you observe comes from there.

-- 
					    Gilles.

