Message-ID: <4E63E503.8090206@domain.hid>
Date: Sun, 04 Sep 2011 22:52:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai 2.6.0-rc1
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>, Xenomai core <Xenomai-core@domain.hid>


Hi,

The first release candidate for the 2.6.0 version may be downloaded here:

http://download.gna.org/xenomai/testing/xenomai-2.6.0-rc1.tar.bz2

This version fixes a few issues in the 2.5.x branch which required
breaking the ABI:
- user-space heap mapping;
- user-space access to thread mode;
- get threads running with SCHED_OTHER scheduling policy to
automatically return to secondary mode after each primary mode only
system call (except when holding a mutex);
- fix both native and posix condition variables signal handling.

contains a few improvements as well:
- add support for CLOCK_HOST_REALTIME, a real-time clock synchronized
with Linux clock;
- factor proc filesystem handling;
- the "xeno-test" scripts has been simplified and rebased on
"xeno-test-run", which will allow writing custom test scripts;
- add support for sh4 architecture;
- simplify arm user-space configure script;
- move rtdk to libxenomai library, printf is now rt-safe when using the
posix skin;
- add support for pkg-config, the xenomai skin libraries are available
each as a "libxenomai_skin" pkg-config package.

Regards.

-- 
                                                                Gilles.

