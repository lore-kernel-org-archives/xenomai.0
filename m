MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18446.25325.177648.610425@domain.hid>
Date: Wed, 23 Apr 2008 00:13:01 +0200
In-Reply-To: <480DB48F.5050303@domain.hid>
References: <480A4F7F.4000909@domain.hid> <480DB1B5.10700@domain.hid>
	<480DB48F.5050303@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] warning: symlink-is-self-recursive
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
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
 > Roland Stigge wrote:
 > > Hi,
 > > 
 > > Roland Stigge wrote:
 > >> =========================================================================
 > >> W: libxenomai-dev: symlink-is-self-recursive
 > >> usr/include/xenomai/asm-generic/xenomai .
 > >> N:
 > >> N:   The symbolic link is recursive to a higher directory of the symlink
 > >> N:   itself. This means, that you can infinitely chdir with this symlink.
 > >> N:   This is usually not okay, but sometimes wanted behaviour.
 > >> N:
 > >> W: libxenomai-dev: symlink-is-self-recursive
 > >> usr/include/xenomai/asm-sim/asm .
 > >> W: libxenomai-dev: symlink-is-self-recursive
 > >> usr/include/xenomai/asm-sim/xenomai .
 > >> W: libxenomai-dev: symlink-is-self-recursive
 > >> usr/include/xenomai/asm-x86/xenomai .
 > >> W: libxenomai-dev: symlink-is-self-recursive usr/include/xenomai/xenomai .
 > >> =========================================================================
 > >>
 > >> I.e. installing Xenomai created those recursive links which might be
 > >> there for source compatibility reasons. Can they be removed at some
 > >> point or should I accept the above issue as intended for the future?
 > > 
 > > No comment from anyone? Maybe I should detect the necessity for those
 > > links by removing and seeing if anyone complains? ;-)
 > >
 > 
 > Those links are intended. We need them to build applications, so that the
 > include paths in userland look like the kernel ones, since we share header files
 > between both environments.

If we really wanted to remove the recursive symlinks (I do not advocate
this, in fact I have no opinion about it, for instance are there really
tools that go wild with such links ?), we could move include/asm-* to
include/xenomai/asm-* and use #include <xenomai/asm/foo.h> everywhere.

-- 


					    Gilles.

