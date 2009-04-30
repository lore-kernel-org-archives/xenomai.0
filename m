Message-ID: <1a8178a117805c2dc47266d6a1b9d49f.squirrel@domain.hid>
Date: Thu, 30 Apr 2009 03:10:16 -0700 (PDT)
From: "Frederik Bayart" <frederik.bayart@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] --posix-ldflags and rt_task_shadow() of main
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

Hallo,

I have a following question :

I have an executable linked linked with
xeno-config --posix-ldflags

so depends on :
libpthread_rt.so.1

If I want to turn my main function into a realtime task with
rt_task_shadow like code sample below, EBUSY is returned and I get the
message :

rt_task_shadow() failed: Device or resource busy.

This would mean that my main task is already a realtime task and I don't
have to call rt_task_shadow anymore. Is this correct ? It seems very
strange to me and I didn't find any documentation which confirms that if
you link with posix-flags your main thread is automatically realtime.

I don't get this message if I link with the xeno-config --xeno-ldflags,
but the reason that I want to link with the posix flags is that I also
use the shm_open function in my binary.

Below a code sample.

Frederik


int main()
{

mlockall(MCL_CURRENT | MCL_FUTURE);

if ((err =3D rt_task_shadow(&this_task, "Model:" QUOTE(MODEL), 1, T_FPU))
!=3D 0)
        printf("rt_task_shadow() failed: %s.\n", strerror(-err));

}


