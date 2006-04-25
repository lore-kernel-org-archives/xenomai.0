From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17486.15478.535257.678014@domain.hid>
Date: Tue, 25 Apr 2006 17:12:54 +0200
Subject: Re: [Xenomai-help] Posix skin illegal seek on sem_wait
In-Reply-To: <20060425165423.7b7d231b@domain.hid>
References: <20060425134316.017836e8@domain.hid>
	<17486.10146.597736.78655@domain.hid>
	<20060425165423.7b7d231b@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Simon <Daniel.Simon@domain.hid>
Cc: xenomai@xenomai.org

Daniel Simon wrote:
 > On Tue, 25 Apr 2006 15:44:02 +0200
 > Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
 > 
 > > The term "Xenomai thread" comes from the document "Life with Adeos":
 > 
 > The shadowing process is not clear in this paper, e.g. bottom of page 6:
 > 
 > <<Xenomai allows to run real-time threads either strictly in kernel
 > space, or within the address space of a Linux process. In the rest of
 > this article, we will refer to the latter as the Xenomai threads, not
 > to be confused with regular Linux tasks (even when they belong to the
 > SCHED_FIFO class).>> 
 > 
 > I guess that "regular Linux tasks unknown to Xenomai, and which
 > only happen to belong to the SCHED_FIFO class" are those compiled and
 > linked against the regular pthread library?

The difference between regular threads and Xenomai threads is rather a
run-time issue than a link-time issue. If Xenomai POSIX skin
pthread_create and pthread_setschedparam services are called with
incorrect arguments (not SCHED_FIFO), they fall back to the services of
the regular posix threading library.

 > 
 > Anyway, my threads are created with the SCHED_FIFO flag; may be there
 > is a conflict with main() which, as I understand, can be only a regular
 > thread?

Real-time shadows are listed in /proc/xenomai/sched; do you see them
there ? You may use pthread_set_name_np to set their name.

 > 
 > >signals sent by the timer_* services will
 > >cause migration of the target thread to secondary mode
 > 
 > I notice that timer_settime(...) also returns an error (perror
 > says "Operation not permitted" while errno is set to 29 "illegal
 > seek", as for the sem_wait)

As documented, if the caller context is invalid, the error should be
EPERM (Operation not permitted), not ESPIPE (illegal seek). Anyway, I am
trying to run your program here to see what is wrong.

 > 
 > >signals [...] cause migration of the target thread to secondary mode
 > 
 > is it only a "not yet implemented" feature or is it a basic
 > conflict between signals and hard real-time?

It is not yet implemented.

-- 


					    Gilles Chanteperdrix.

