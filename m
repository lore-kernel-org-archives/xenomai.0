Message-ID: <4EB55759.2020404@domain.hid>
Date: Sat, 05 Nov 2011 16:33:45 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.6.0
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

please find Xenomai 2.6.0 at the usual place:
http://download.gna.org/xenomai/stable/xenomai-2.6.0.tar.bz2

This new branch started as a reboot of the v2.5 branch, for changes
which needed breaking the ABI, said changes being:
* a correct handling of signals when waiting for condition variables;

* a change in the way thread mode is accessed in user-space, to fix
possible leaks depending on the libc;

* the automatic switch back to secondary mode after a primary mode
system call, for threads running with SCHED_OTHER scheduling policy,
except when they hold a mutex.


However, at this chance, we also included some new features to this release:
* support for a new architecture: sh4;

* CLOCK_HOST_REALTIME, a clock synchronized with Linux CLOCK_REALTIME
clock, safe to be read when in primary mode;

* new analogy drivers for NI 660x and NI 670x boards;

* a simplified user-space configuration for the ARM architecture, where
the default user-space libraries generated are no longer generated for
only one SOC, without any loss of performance;

* a simplified xeno-test script, which should now work more reliably,
and is based on a "xeno-test-run" interpreter, which will allow to write
different test scenarios;

* the beginnings of a regression test suite;

* a move of the rtdk library to the common "libxenomai" library,
allowing to have printf being rt-safe when using the posix skin;

* pkg-config support, each skin library is available as
"libxenomai_skin" pkg-config package;

* and the usual amount of upgrades and adeos patches to follow the linux
kernel changes.

Enjoy.

-- 
                                                                Gilles.

