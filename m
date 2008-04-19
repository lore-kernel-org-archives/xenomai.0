Message-ID: <480A4F7F.4000909@domain.hid>
Date: Sat, 19 Apr 2008 22:01:03 +0200
From: Roland Stigge <stigge@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Debian lintian warning: symlink-is-self-recursive
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi,

Debian's lintian(1), the package checker, tells me:

=========================================================================
W: libxenomai-dev: symlink-is-self-recursive
usr/include/xenomai/asm-generic/xenomai .
N:
N:   The symbolic link is recursive to a higher directory of the symlink
N:   itself. This means, that you can infinitely chdir with this symlink.
N:   This is usually not okay, but sometimes wanted behaviour.
N:
W: libxenomai-dev: symlink-is-self-recursive
usr/include/xenomai/asm-sim/asm .
W: libxenomai-dev: symlink-is-self-recursive
usr/include/xenomai/asm-sim/xenomai .
W: libxenomai-dev: symlink-is-self-recursive
usr/include/xenomai/asm-x86/xenomai .
W: libxenomai-dev: symlink-is-self-recursive usr/include/xenomai/xenomai .
=========================================================================

I.e. installing Xenomai created those recursive links which might be
there for source compatibility reasons. Can they be removed at some
point or should I accept the above issue as intended for the future?

Thanks,

Roland

