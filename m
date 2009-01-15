Message-ID: <496F0DBE.5010108@domain.hid>
Date: Thu, 15 Jan 2009 11:19:42 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Pending patches
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

currently I have the following six patches in my assorted queue
(git://git.kiszka.org/xenomai.git queue/assorted). All have been posted
before, I just rebased them since then a few times. Should I repost
any/all of them (would be no problem), or are some already queued for
potential merge?

Jan

--------

commit 728fc8970e2032b3280971788f1223f3ad82d80d
Author: Jan Kiszka <jan.kiszka@domain.hid>
Date:   Thu Jan 15 11:10:24 2009 +0100

    xnpipe: Fix racy callback handlers
    
    Invocation of input, output and alloc handler must take place under
    nklock to properly synchronize with xnpipe_disconnect. Change all
    callers to comply with this policy.
    
    Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>

 ksrc/nucleus/pipe.c |   96 ++++++++++++++++++++++----------------------------
 1 files changed, 42 insertions(+), 54 deletions(-)

commit a631ab2c531d5e381ba8a0a59bf301a0276d9f99
Author: Jan Kiszka <jan.kiszka@domain.hid>
Date:   Thu Jan 15 11:10:24 2009 +0100

    POSIX: Do not auto-shadow main with dlopen enabled
    
    Don't perform auto-shadowing in POSIX skin if we might be loaded via
    dlopen. Otherwise the wrong thread, the undefined dlopen caller, may be
    (re-)shadowed, assigning wrong scheduling settings.
    
    Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>

 src/skins/posix/init.c |   43 ++++++++++++++++++++++++++++---------------
 1 files changed, 28 insertions(+), 15 deletions(-)

commit 91ae3da822ca558804bf33be4d164ea4c2667c1b
Author: Jan Kiszka <jan.kiszka@domain.hid>
Date:   Thu Jan 15 11:10:24 2009 +0100

    Replace --without-__tread with --enable-dlopen-skins
    
    In practice, you only want to disable __thread support when Xenomai skin
    libraries should be loadable via dlopen. Therefore rename the related
    configure switch accordingly.
    
    Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>

 configure.in |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

commit 2af3cfcbcb21591089ed33da9e6efb0b5f78a71b
Author: Jan Kiszka <jan.kiszka@domain.hid>
Date:   Thu Jan 15 11:10:24 2009 +0100

    Mark libs nodlopen on initial-exec TLS
    
    Mark libs with nodlopen if initial-exec __thread variables are used
    because dlopen and this TLS model are in conflict.
    
    Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>

 configure.in                  |    3 +++
 src/skins/native/Makefile.am  |    2 +-
 src/skins/posix/Makefile.am   |    2 +-
 src/skins/psos+/Makefile.am   |    2 +-
 src/skins/rtai/Makefile.am    |    2 +-
 src/skins/rtdm/Makefile.am    |    2 +-
 src/skins/uitron/Makefile.am  |    2 +-
 src/skins/vrtx/Makefile.am    |    2 +-
 src/skins/vxworks/Makefile.am |    2 +-
 9 files changed, 11 insertions(+), 8 deletions(-)

commit 028d4766a38b6937d9a2c02a20022e3ee5b67b55
Author: Jan Kiszka <jan.kiszka@domain.hid>
Date:   Thu Jan 15 11:10:24 2009 +0100

    POSIX: Fix initialization of SCHED_RR threads
    
    Passing SCHED_RR as policy to pthread_create has currently not the
    desired effect. The kernel part expects that user space adjusts the
    policy and prio via __pse51_thread_setschedparam after setting up the
    shadow. And this is what the patch does by calling the wrapped
    pthread_setschedparam instead of the real one.
    
    Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>

 src/skins/posix/thread.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

commit 71666ce04ef216d281fe86ee82a5560c2b57c6dd
Author: Jan Kiszka <jan.kiszka@domain.hid>
Date:   Thu Jan 15 11:10:24 2009 +0100

    Handle priority changes of SCHED_RR tasks
    
    If shadowed Linux tasks with SCHED_RR policy change their priority,
    do_setsched_event currenty ignores this. Extend the condition to catch
    this case as well.
    
    Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>

 ksrc/nucleus/shadow.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

-- 
Siemens AG, Corporate Technology, CT SE 26
Corporate Competence Center Embedded Linux

