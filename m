Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <patchbomb.1381827036@devws164.be.alcatel-lucent.com>
Date: Tue, 15 Oct 2013 10:50:36 +0200
From: Kim De Mey <kim.demey@gmail.com>
Subject: [Xenomai] [PATCH 0 of 3] Xenomai-forge: Initial implementation of
 registry for pSOS
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This patch set adds an initial implementation of registry for pSOS 
tasks, semaphores and queues. It is similar as the already existing 
vxworks implementation but with more output data.

Important to mention is that the "size" parameter in the read function
is not used (it is also not used in the vxworks implementation).
This will be an issue if the data to output is larger than the buffer 
used. This is now possible to happen as I added messages in the queue 
read function and timers in the task read function. In that case an 
implementation which uses size & offset is necessary.

I am busy implementing a second patch that does this. 
It creates a local buffer which is filled with the data on an "open" 
call. A pointer to the local buffer is saved in the fuse_file_info->fh
field (requires FUSE version >=  2.5). A read will then just read from 
the local buffer with offset and size given. A release is also needed to
free the buffer.

However while I continue with this I would like to know whether you see
this as the right way to go. Does the data I output (and the format) in
this patch make sense to you? And in case yes, shall I continue to 
implement the second patch as described above or are there other views
on this? It might be a bit vague without actually seeing code but if you
want I can already submit a preliminary version of the second patch.

Kim


 include/psos/psos.h |    2 ++
 lib/psos/queue.c    |   77 ++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++
 lib/psos/queue.h    |    1 +
 lib/psos/sem.c      |   43 +++++++++++++++++++++++++++++++++++++++++++
 lib/psos/sem.h      |    1 +
 lib/psos/task.c     |  115 ++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/psos/task.h     |    4 ++++
 7 files changed, 243 insertions(+), 0 deletions(-)

