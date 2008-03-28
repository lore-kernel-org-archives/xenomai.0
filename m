Date: Fri, 28 Mar 2008 20:03:10 +0100
From: Robert Schwebel <r.schwebel@domain.hid>
Message-ID: <20080328190310.GB9009@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Subject: [Xenomai-core] [PATCH][SOLO] add more warnings
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

Contrary to what one would assume, -Wall doesn't warn on everything. It
turned out to add a few more options, like -Wsign-compare, -Wfloat-equal
and -Wformat-security, which is what the patch below does.

When running with these options, we get the following warnings:

kernelLib.c: In function 'kernelInit':
kernelLib.c:63: warning: comparison between signed and unsigned
msgQLib.c: In function 'msgQReceive':
msgQLib.c:165: warning: comparison between signed and unsigned
msgQLib.c: In function 'msgQSend':
msgQLib.c:227: warning: comparison between signed and unsigned
msgQLib.c:237: warning: comparison between signed and unsigned
taskLib.c: In function 'taskSpawn':
taskLib.c:382: warning: signed and unsigned type in conditional expression
pt.c: In function 'get_pt_from_id':
pt.c:56: warning: comparison between signed and unsigned
pt.c:58: warning: comparison between signed and unsigned
queue.c: In function 'get_queue_from_id':
queue.c:49: warning: comparison between signed and unsigned
queue.c: In function '__q_send':
queue.c:224: warning: comparison between signed and unsigned
queue.c: In function '__q_broadcast':
queue.c:311: warning: comparison between signed and unsigned
queue.c: In function '__q_receive':
queue.c:365: warning: comparison between signed and unsigned
rn.c: In function 'get_rn_from_id':
rn.c:41: warning: comparison between signed and unsigned
sem.c: In function 'get_sem_from_id':
sem.c:41: warning: comparison between signed and unsigned
task.c: In function 'find_psos_task':
task.c:54: warning: comparison between signed and unsigned
task.c: In function 'find_psos_task_or_self':
task.c:86: warning: comparison between signed and unsigned
task.c: In function 'get_psos_task':
task.c:110: warning: comparison between signed and unsigned
task.c: In function 'get_psos_task_or_self':
task.c:131: warning: comparison between signed and unsigned
task.c:140: warning: comparison between signed and unsigned
task.c: In function 'check_task_priority':
task.c:232: warning: comparison between signed and unsigned
tm.c: In function 'get_tm_from_id':
tm.c:43: warning: comparison between signed and unsigned

I've looked into the first ones only yet and it looks to me like the
type definitions have to be reviewed carefully. For example, TASK_ID is
defined to be unsigned long, whereas the vxworks documentation [1] looks
more like if we need 'int' there. Which also makes me wonder if vxworks
has a special idea about what 'int' is; guessing from [2] it looks like
it assumes sint32_t, so in order to fix this on 64 bit boxes, shouldn't
these cases be converted to use the inttypes.h definitions?

However, somebody with more vxworks knowledge than myself should have a
look at this.

Signed-off-by: Robert Schwebel <r.schwebel@domain.hid>

[1] http://spacegrant.colorado.edu/~dixonc/vxworks/docs/vxworks/ref/taskLib.html#taskActivate
[2] http://www.xs4all.nl/~borkhuis/vxworks/vxw_pt6.html

---
 configure.in |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: xenomai-solo/configure.in
===================================================================
--- xenomai-solo.orig/configure.in	2008-03-28 19:17:23.000000000 +0100
+++ xenomai-solo/configure.in	2008-03-28 19:19:15.000000000 +0100
@@ -163,7 +163,8 @@
 dnl Exported CFLAGS and LDFLAGS
 XENO_USER_APP_CFLAGS=$XENO_USER_CFLAGS
 XENO_USER_APP_LDFLAGS=$XENO_USER_LDFLAGS
-XENO_USER_CFLAGS="$XENO_USER_CFLAGS -Wall -pipe -fstrict-aliasing $gcc_w_noalias"
+XENO_USER_CFLAGS="$XENO_USER_CFLAGS -Wall -Wsign-compare -Wfloat-equal -Wformat-security"
+XENO_USER_CFLAGS="$XENO_USER_CFLAGS -pipe -fstrict-aliasing $gcc_w_noalias"
 
 if test x$debug_symbols = xy; then
    XENO_USER_CFLAGS="-g -O0 $XENO_USER_CFLAGS -D__SOLO_DEBUG__"

-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9


