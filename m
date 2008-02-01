Message-ID: <47A326D0.3060703@domain.hid>
Date: Fri, 01 Feb 2008 15:04:00 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <18338.15747.218667.236566@domain.hid>	
	<18338.46934.267322.303918@domain.hid>	
	<47A2F023.3030700@domain.hid>
	<2ff1a98a0802010223k41c32f38p3d56cb40eb60a55d@domain.hid>
In-Reply-To: <2ff1a98a0802010223k41c32f38p3d56cb40eb60a55d@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [Patch] bre^H^H^H^H reworking self deletion,
	take 3.
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> On Fri, Feb 1, 2008 at 11:10 AM, Philippe Gerum <rpm@xenomai.org> wrote:
>> Gilles Chanteperdrix wrote:
>>  > Gilles Chanteperdrix wrote:
>>  >  >
>>  >  > Hi Philippe,
>>  >  >
>>  >  > here comes a new patch on the theme "reworking self deletion". This
>>  >  > time, execution of nkpod delete hooks is made before the context switch
>>  >  > whereas finalizing the thread takes place after the context
>>  >  > switch. Special care has been taken to call xnfreesync before we run the
>>  >  > hooks, in order to avoid freeing the thread control block before the
>>  >  > finalization, and xnheap_t::idleq was made a per-cpu thing for the same
>>  >  > purpose.
>>  >  >
>>  >  > I made a simple watchdog test with all debugs enabled, and
>>  >  > xnshadow_unmap did not complain.
>>  >  >
>>  >  > If you are OK with this patch, I will rebase the unlocked context switch
>>  >  > patch on it.
>>  >
>>  > Thinking a bit more about the unlocked context switch case: do we
>>  > tolerate that an ISR may delete a thread that is not current ? Because
>>  > if an ISR deleted a non current thread, we would not run the hooks over
>>  > the deleted thread context, so we would be again in the case where
>>  > xnshadow_unmap is not run by current. Besides, at first sight, it seems
>>  > to simplify greatly the case of the unlocked context switch.
>>  >
>>
>>  No we don't; thread deletion is normally a service callable from thread
>>  context only. We allow the watchdog code to call into
>>  xnpod_delete_thread() as an exception, because we have no other mean to
>>  fix the runaway situation properly, and we know that this will work
>>  precisely because the deleted thread is current.
>>
>>  Any other situation would lockup, because the termination signal would
>>  never make it to the runaway thread since Linux is starved from CPU at
>>  that point, and we can't even relax the thread either. So, yes, we may
>>  safely assume that thread deletion is either called from a thread, or
>>  called on behalf of an ISR for the preempted thread only (and solely for
>>  internal code and well-know situations).
> 
> Unfortunately, my reasoning was UP only, in SMP, it may happen that a
> distant CPU deletes from a valid context the thread being currently
> switched out with nklock unlocked on current CPU. So, we have to take
> care about this case anyway.
> 

IIUC, this should only be a problem with kernel threads, others would
end up self-deleting on behalf of a termination signal from the remote CPU.

-- 
Philippe.

