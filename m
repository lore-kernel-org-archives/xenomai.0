From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18407.58512.849738.173184@domain.hid>
Date: Mon, 24 Mar 2008 18:27:44 +0100
In-Reply-To: <18407.43111.568301.509775@domain.hid>
References: <16201.81.252.86.91.1205764989.squirrel@domain.hid>
	<18400.53752.538963.384358@domain.hid>
	<6621.81.252.86.91.1205927700.squirrel@domain.hid>
	<2ff1a98a0803190613r7572d87eibef16aecf39ef71a@domain.hid>
	<10023.62.39.72.60.1205940829.squirrel@domain.hid>
	<18407.43111.568301.509775@domain.hid>
Subject: Re: [Xenomai-help] Application crash
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fabien MAHOT <fabien.mahot@domain.hid>, xenomai@xenomai.org

Gilles Chanteperdrix wrote:
 > Fabien MAHOT wrote:
 >  > >> Are you sure this is the right .config ? I see that priority coupling
 >  > >> is enabled.
 >  > >
 >  > > I want the priority coupling be enabled. (I have a problem when it was
 >  > > disabled : I have a main thread with highest priority which creates other
 >  > > threads. When all the threads are created, the main thread reduces its
 >  > > priority at the minimum, broadcats a condition and unlock the associated
 >  > > mutex to start the other threads . But, after that main thread unlocks the
 >  > > mutex, it stays a short while in execution in spite of its priority)
 >  > 
 >  > ---> I make a mistake, when Main thread reduces its priority at the
 >  > minimum (with pthread_setschedparam), it's not preempted by a thread which
 >  > has an higher priority and which is ready to run.
 >  > 
 >  > 
 >  > Could you try to run my program on your arm with enabled priority
 >  > coupling, please?
 > 
 > I see that you have the interrupt shield enabled, could you try and
 > disable it ? The thread "thread2" never suspends, with the interrupt
 > shield enabled, it means that Linux will never heandle its IRQs.

That said, the interrupt shield should not enter in action since the
shield bit is not armed for any thread. And indeed, your program runs
fine with the same configuration as you (including interrupt shield) on
ARM.

I tend to think about an hardware or configuration issue. I will now try
to run your example on an x86 with the same configuration as you, to see
if it is a configuration issue.

The only thing that bothers me when reading your configuration is that
you select 586MMX whereas you have a Geode. You should really select
Geode, this would let the kernel enable any quirk needed for this
platform. Another question: do xenomai various tests run normally on
your platform ? The Geode has (or had ?) known issues with stopping tsc
and SMIs, but I do not know the current status of these issues with
recent kernels. Maybe someone with more experience on Geodes can comment
?

-- 


					    Gilles.

