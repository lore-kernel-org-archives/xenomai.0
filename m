From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="DlALyoxAOd"
Content-Transfer-Encoding: 7bit
Message-ID: <17612.58055.398043.315669@domain.hid>
Date: Sun, 30 Jul 2006 18:48:07 +0200
Subject: Re: [Xenomai-core] [BUG] rt_task_delete kills caller
In-Reply-To: <1154251439.4965.23.camel@domain.hid>
References: <44C09BC0.4030307@domain.hid> <44C0A083.6000101@domain.hid>
	<44C0CD07.4070708@domain.hid> <44C0F36F.8040608@domain.hid>
	<1154251439.4965.23.camel@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>


--DlALyoxAOd
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
 > The second bug causing spurious RT32 signals to be notified is more of a
 > GDB issue

When running the attached program inside gdb, the RT32 signal seems to
be used as the asynchronous cancellation signal. Or at least when
running with libthread_db.so.

-- 


					    Gilles Chanteperdrix.

--DlALyoxAOd
Content-Type: text/plain
Content-Disposition: inline;
	filename="cancel.c"
Content-Transfer-Encoding: 7bit

#include <pthread.h>

void *routine(void *cookie)
{
	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);

	for (;;)
		;

	return cookie;
}

int main(int argc, const char *argv[])
{
	pthread_t tid;
	pthread_create(&tid, NULL, routine, NULL);
	pthread_cancel(tid);
	pthread_join(tid, NULL);

	return 0;
}

--DlALyoxAOd--

