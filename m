MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17358.42102.613327.327841@domain.hid>
Date: Wed, 18 Jan 2006 21:26:30 +0100
Subject: Re: [Xenomai-core] Scheduling while atomic
In-Reply-To: <43CE9FCB.2070305@domain.hid>
References: <fd6a47a90601171559x13acf2c2m@domain.hid>
	<43CE9FCB.2070305@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > Jeroen Van den Keybus wrote:
 > > Gilles,
 > > 
 > > 
 > > I cannot reproduce those messages after turning nucleus debugging on.
 > > Instead, I now either get relatively more failing mutexes or even hard
 > > lockups with the test program I sent to you. If the computer didn't crash,
 > > dmesg contains 3 Xenomai messages relating to a task being movend to
 > > secondary domain after exception #14. As when the computer crashes: I have
 > > written the last kernel panic message on a paper. Please tell if you want
 > > also the addresses or (part of) the call stack.
 > > 
 > > I'm still wondering if there's a programming error in the mutex test
 > > program. After I sent my previous message, and before I turned nucleus
 > > debugging on, I managed (by reducing the sleeptimes to max. 5.0e4) to
 > > fatally crash the computer, while spewing out countless 'scheduling while
 > > atomic messages'. Is the mutex error reproducible ?
 > 
 > I was not able to crash my box or generate that scheduler warnings, but
 > the attached patch fixes the false positive warnings of unlocked
 > mutexes. We had a "leak" in the unlock path when someone was already
 > waiting. Anyway, *this* issues should not have caused any other problems
 > then the wrong report of rt_mutex_inquire().

Actually the patch seem insufficient, the whole block :
	{
	xnsynch_set_owner(&mutex->synch_base,&task->thread_base);
	mutex->owner = task;
	mutex->lockcnt = 1;
	goto unlock_and_exit;
	}

should be done after xnsynch_sleep_on in rt_mutex_lock.

-- 


					    Gilles Chanteperdrix.

