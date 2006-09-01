Message-ID: <44F80898.3030203@domain.hid>
Date: Fri, 01 Sep 2006 12:16:56 +0200
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] v2.2.x broken (r1534)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi,

I just did a fresh checkout of the v2.2.x and it does not compile:

gcc: pthread_create: No such file or directory
gcc: pthread_detach: No such file or directory
gcc: pthread_setschedparam: No such file or directory
gcc: pthread_getschedparam: No such file or directory
gcc: pthread_yield: No such file or directory
gcc: sched_yield: No such file or directory
gcc: sem_init: No such file or directory
gcc: sem_destroy: No such file or directory
gcc: sem_post: No such file or directory
...


Any idea of what's broken?

Thanks.

