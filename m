From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sat, 23 Dec 2006 19:31:23 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612231931.23828.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Buildbot detects failure in recent build
Reply-To: niklaus.giger@domain.hid
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

Hi Philippe

It seems that your revision 1978 or 1979 broke building PSOS+ on ppc and
PPC405. 
See e.g. http://ngiger.dyndns.org/buildbot/hcu3_q/builds/97/step-mk_kernel/1
which complains about
  CC [M]  kernel/xenomai/skins/psos+/syscall.o
kernel/xenomai/skins/psos+/syscall.c: In function '__rn_create':
kernel/xenomai/skins/psos+/syscall.c:1083: error: 'psosrn_t' undeclared (first 
use in this function)
kernel/xenomai/skins/psos+/syscall.c:1083: error: (Each undeclared identifier 
is reported only once
kernel/xenomai/skins/psos+/syscall.c:1083: error: for each function it appears 
in.)
kernel/xenomai/skins/psos+/syscall.c:1083: error: 'rn' undeclared (first use 
in this function)
kernel/xenomai/skins/psos+/syscall.c:1084: warning: ISO C90 forbids mixed 
declarations and code
kernel/xenomai/skins/psos+/syscall.c:1112: error: parse error before ')' token
kernel/xenomai/skins/psos+/syscall.c: In function '__rn_delete':
<...>

Best regards
-- 
Niklaus Giger

