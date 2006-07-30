Subject: Re: [Xenomai-core] [BUG] rt_task_delete kills caller
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <17612.58055.398043.315669@domain.hid>
References: <44C09BC0.4030307@domain.hid> <44C0A083.6000101@domain.hid>
	<44C0CD07.4070708@domain.hid> <44C0F36F.8040608@domain.hid>
	<1154251439.4965.23.camel@domain.hid>
	<17612.58055.398043.315669@domain.hid>
Content-Type: text/plain
Date: Sun, 30 Jul 2006 18:57:53 +0200
Message-Id: <1154278674.4970.5.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Sun, 2006-07-30 at 18:48 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > The second bug causing spurious RT32 signals to be notified is more of a
>  > GDB issue
> 
> When running the attached program inside gdb, the RT32 signal seems to
> be used as the asynchronous cancellation signal. Or at least when
> running with libthread_db.so.
> 

Mm, ok. This would also correlate with GDB going south when ptracing the
asynchronous cancellation handler defined by the pthread library.

> plain text document attachment (cancel.c)
> #include <pthread.h>
> 
> void *routine(void *cookie)
> {
> 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
> 
> 	for (;;)
> 		;
> 
> 	return cookie;
> }
> 
> int main(int argc, const char *argv[])
> {
> 	pthread_t tid;
> 	pthread_create(&tid, NULL, routine, NULL);
> 	pthread_cancel(tid);
> 	pthread_join(tid, NULL);
> 
> 	return 0;
> }
-- 
Philippe.



