Message-ID: <52BF6547.5050204@zultron.com>
Date: Sat, 28 Dec 2013 17:56:55 -0600
From: John Morris <john@zultron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Kernel oops:  x86 arch, Xenomai 2.6.3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Updated RPMS, Xenomai 2.6.3 and Linux 3.8.13, crash on most tested
platforms (Fedora 18/19 & EL6 32-bit, but strangely not EL6 64-bit).  In
some cases the crash occurs during boot.  In the pasted example [1] (EL6
32-bit), the crash occurred after starting a Xenomai application (LinuxCNC).

Xenomai package [9] updates:
- Update Xenomai from 2.6.2.1 to 2.6.3
- _FORTIFY_SOURCE=2 flag re-enabled
  (see prev. discussion [2,3]; Gilles indicated this has been fixed)
- --enable-dlopen-skins removed ("WARNING: unrecognized option")
- devel package follows Debian:  use prepare-kernel.sh instead of
  prepare-patch.sh

Kernel package [4] updates:
- (Package was rebased on top of elrepo.org packages)
- Update Linux from 3.5.7 to 3.8.13
- Base .config from Fedora ~3.8.13 kernel
  - added a few missing answers [5,6]
- Xenomai .config 'overrides' unchanged [7,8]

Although nobody but me runs Xenomai on Red Hat, these .configs and
packaging scripts will be the basis for updating the Debian packages;
therefore, solving these issues is more valuable than it seems.  ;)  Thanks!

	John


[1] http://pastebin.ca/2519330
[2] http://www.xenomai.org/pipermail/xenomai/2013-January/027341.html


[3] http://www.xenomai.org/pipermail/xenomai/2013-January/027342.html


[4] https://github.com/zultron/kernel-rt-rpm
[5] https://github.com/zultron/kernel-rt-rpm/blob/master/config-i686
[6] https://github.com/zultron/kernel-rt-rpm/blob/master/config-x86_64
[7] https://github.com/zultron/kernel-rt-rpm/blob/master/config-xenomai-i686
[8]
https://github.com/zultron/kernel-rt-rpm/blob/master/config-xenomai-x86_64
[9] https://github.com/zultron/xenomai-rpm

