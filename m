Message-ID: <43B8ED00.9070908@domain.hid>
Date: Mon, 02 Jan 2006 10:06:08 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.1-rc1
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org, xenomai@xenomai.org


So new that the paint is still wet, here is the first candidate release 
of the upcoming 2.1 series. The major changes since v2.0.x are as follows:

* New build system which allows to compile Xenomai statically into the 
kernel image, and ensures proper decoupling between kernel and 
user-space supports.
* SMP support for ppc64 and tree refactoring toward 2.6.15/powerpc.
* Backport to Linux 2.4 for x86 and ppc32.
* Port to the Blackfin architecture (http://blackfin.uclinux.org/).

and a number of updates to the nucleus, rtdm, the native and POSIX APIs. 
As usual, see the ChangeLog for details.

Since we have a few major updates still cooking outside of the main tree 
which are planned for inclusion in 2.1 final, this is not a feature 
freeze, yet.

Also note that starting with the v2.1 series, the simulator is available 
as a separate tarball.

http://download.gna.org/xenomai/testing/xenomai-2.1-rc1.tar.bz2
http://download.gna.org/xenomai/testing/simulator/xenosim-2.1-rc1.tar.bz2

Best wishes to all for this New Year.

-- 

Philippe.

