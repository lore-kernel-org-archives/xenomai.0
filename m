Message-ID: <4C573E2F.2060304@domain.hid>
Date: Mon, 02 Aug 2010 23:52:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C562838.8050000@domain.hid>	
	<1280727778.6700.70.camel@domain.hid>	
	<4C565F26.5090200@domain.hid>
	<1280770720.6700.82.camel@domain.hid>
	<4C5706E9.50101@domain.hid> <4C572FF7.5090200@domain.hid>
In-Reply-To: <4C572FF7.5090200@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Shared memory between a Xenomai user task and a
 standard Linux process?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bob Feretich <bob.feretich@domain.hid>
Cc: xenomai@xenomai.org

Bob Feretich wrote:
>   Thank you for the solution. Using Linux shm shared memory should have 
> been obvious. :-[
> 
> I was still thinking of Xenomai user tasks as running in a walled of 
> environment. I've got to remember that when a rt user task is in 
> secondary mode it has full access to Linux facilities.
> 
> When my rt user task starts and ends it is in secondary mode. It can 
> easily shmat() and shmdt() during these start and end periods.

Yes, and a process running Xenomai threads may also run non-Xenomai
threads, they will share the same memory, without needing to resort to
shared memories.

As for the shared memory, you may also use the POSIX interface:
shm_open/ftruncate/mmap/shm_close/shm_unlink

You may find it more convenient.

> 
> As Philippe states, I just need to be careful about the synchronization 
> method I use. The Linux process must never be able to block the rt task. 
> (If the rt task wraps the buffer, we'll just throw away the history data 
> until space becomes available and report a "data overrun" on the next 
> block written.) As I said before, the buffer should be large enough so 
> that never happens anyway.

You can use a FIFO, with a periodic non-rt thread polling one of the
FIFO's pointers. This would look a lot like what rt_printf does (file
src/rtdk/rt_print.c in Xenomai sources).


-- 
					    Gilles.

