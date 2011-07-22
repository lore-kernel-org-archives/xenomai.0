Message-ID: <4E299162.8000309@domain.hid>
Date: Fri, 22 Jul 2011 17:04:02 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] __wrap_clock_gettime
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

Hi Gilles,

pulling assert_context.c into the common libxenomai created a problem
around picking the right __wrap_clock_gettime. As libpthread_rt depends
on libxenomai, the latter is loaded first and defines the debug version
of __wrap_clock_gettime as the default. There is no chance to pull the
posix skin implementation.

I don't have a nice idea yes how to resolve this. Options are:
 - drop __wrap_clock_gettime from assert_context.c (affects any skin
   user != posix)
 - put assert_context stuff into separate library again
 - put __wrap_clock_gettime in all skin libs != posix

I'm favoring the simplest approach ATM, ie. the first one. Other ideas?

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

