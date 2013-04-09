Message-ID: <51646B6B.6040104@xenomai.org>
Date: Tue, 09 Apr 2013 21:26:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Preparing the 2.6.3 release
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>


Hi,

it is time for a 2.6.3 release. In order to avoid what happened with the
last release, here is a list of items which I intend to get handled for
the release. If I forget anything, please reply to this mail.

- x86: 3.5.7 with intel graphic card, try and find the source of high
latencies
- rt_mutex_create issues, see Petr posts, probably setting
mutex->fastlock to NULL in rt_mutex_delete is enough
- SMI workaround: a vanilla driver exists with all the ids of intel
chipset supporting SMI workaround, try and see if we can not hook the
workaround with this driver, if not, copy the ids list
- _FORTIFY_SOURCE: get printf wrapping to work even with _FORTIFY_SOURCE
- tsc test: remove the hardcoded 80, pin the thread to one cpu
- manpages: update outdated manpages, now that they use the asciidoc format
- switchtest: fix error handling (other errors than ENOSYS in
open_rtttest are probably real errors)
- problem with periodic timing enabled: tsctons or tickstons were
reported wrong
- socket return codes: catch all the NOTSUPPORT codes
- separate libxenomai headers from include/asm
- documentation: find a place to add the "generic" error values,
TROUBLESHOOTING or Doxygen
- try and reproduce /proc vfile issues (I seem to remember we had a post
with a way to reproduce this systematically, and I got it while
stress-testing 3.8.2 on ARM).

Regards.

-- 
                                                                Gilles.

