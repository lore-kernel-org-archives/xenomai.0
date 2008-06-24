MIME-Version: 1.0
Date: Tue, 24 Jun 2008 16:22:36 +0200
From: Matthieu <matthieu.connaulte_xenomai@domain.hid>
In-Reply-To: <79d394791426e089eda84f208d108ce1@domain.hid>
References: <79d394791426e089eda84f208d108ce1@domain.hid>
Message-ID: <8ed9619aa4ce06ac877e8b4b42cde58b@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] xenomai scheduler's ticks period
Reply-To: matthieu.connaulte_xenomai@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi

I encounter a problem. I patch my xeno_vxworks module. It seem's working
well. But the result doesn't seem to be the one looked for. In fact, I
create a vxworks task that enter in a while loop and give me the time spe=
nd
to the next tick using taskDelay(1). Here is the code of my task :

#include <vxworks/vxworks.h>
#include <native/timer.h>
#include <stdio.h>
#include <sys/mman.h>

long tid;

void tick_value(void *cookie){
	RTIME now, previous;
	long tick;
	previous =3D rt_timer_read();
	while (1) {
		now =3D rt_timer_read();
		tick =3D (long)((now - previous));
		printf("Duree du tick : %1ld,%06ld ms\n",tick/1000000,tick%1000000);
                  previous =3D now;
		taskDelay(1);
	}
}

void clean_exit(int dummy) {
  taskDelete(tid);
}

int main(int argc, char* argv[])
{
	mlockall(MCL_CURRENT | MCL_FUTURE);
	tid =3D taskSpawn ( "tick", 100, 0x100, 2000,( FUNCPTR)tick_value, 0, 0,=
 0,
0, 0, 0, 0, 0, 0, 0);
	pause();
	fflush(NULL);
	return 0;
}

When I use modprobe xeno_vxworks tick_arg=3D3D1000, I have a 1ms tick per=
iod,
so that's good.
What I expected is that with a tick_arg=3D3D0, taskDelay(1) suspend my ta=
sk
until an announceTick come. But when I execute my task, taskDelay doesn't
wait. I think that the scheduler is always ruuning : I have a minimum tic=
k
period around 10 =3DC2=3DB5s (limitation due to the changing context from
printf I think).

Let me know if I've done something wrong ...

Matthieu



