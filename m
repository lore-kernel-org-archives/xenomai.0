Message-ID: <48A1A01F.2080006@domain.hid>
Date: Tue, 12 Aug 2008 16:37:19 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4874E1D8.6020307@domain.hid>
	<200807111518.16150@domain.hid>	<200807151642.18829@domain.hid>
	<487CBC4A.5050309@domain.hid>	<200807161039.8828@domain.hid>
	<487F1D25.5080508@domain.hid>	<200807211258.30164@domain.hid>
	<48847272.3080605@domain.hid> <200807311814.25994@domain.hid>
In-Reply-To: <200807311814.25994@domain.hid>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Segmentation error by heavy dynamic RT_QUEUE
	usage
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai@xenomai.org

Petr Cervenka wrote:
> Hello,
> I wanted to make an small example to find the kernel panic (and I failed with it). But during my tests I found another possible error.
> I made a small application (as netbeans c++ project) with two tasks:
> 1) server task with its RT_QUEUE waiting for a request.
> 2) client task which creates RT_QUEUES for response and sends requests to the server task
>>From time to time I get an segmentation error.
> It's always in the server task, when the server binds the clients queue, allocates a message buffer in it.
> It seems when the server starts to work with this buffer, the client could already close the queue.
> But this shouldn't be possible, because normally any attempt to close a queue binded by someone else ends with -EBUSY error.
> The error needs some time to produce and 2 CPUs (cores). One for server and one for client.
> My configuration(s):
> Athlon XP 2600GHz  X86_64
> kernel 2.6.24 (and 2.6.25.11)
> adeos 2.6.24 2.0-03 (and 2.0-07)
> xenomai 2.4.1 and 2.4.4
> I'm sending also examples of the execution script and proper input.txt file
> both of them should be much longer (input.txt could be several MB)!!!!
> In the attachement there is also disassemble of my executable
> And finally, one of the segmentation error messages:
> [ 2553.818731] QT_SERVER[5919]: segfault at 2aaaaac96800 rip 4022b5 rsp 4000fe00 error 6
> But there are more types, but allways when working with the allocated send buffer.
> I know, I'm annoying, but I can't help myself.... ;-)

Yeah, but I can't help running useful test code people cared to write either, so
that's ok.

There was a silly bug in the userland wrapper, unmapping the memory pool from
the application process, albeit the syscall just denied deletion (-EBUSY). This
issue also affects RT_HEAP objects the very same way.

Fixed in both trees. Thanks for narrowing the issue.

Note: creating / binding to a _shared_ queue switches the caller to secondary
mode, because in both cases, we need to use regular kernel services to mmap()
the memory pool to the application process.

--- src/skins/native/queue.c	(revision 4086)
+++ src/skins/native/queue.c	(working copy)
@@ -114,21 +114,18 @@
 {
 	int err;

-	err = __real_munmap(q->mapbase, q->mapsize);
-
-	if (err)
-		return -EINVAL;
-
 	err = XENOMAI_SKINCALL1(__native_muxid, __native_queue_delete, q);
-
 	if (err)
 		return err;

+	if (__real_munmap(q->mapbase, q->mapsize))
+		err = -errno;
+
 	q->opaque = XN_NO_HANDLE;
 	q->mapbase = NULL;
 	q->mapsize = 0;

-	return 0;
+	return err;
 }

 void *rt_queue_alloc(RT_QUEUE *q, size_t size)

PS: careful with the subject line, heavy / light RT_QUEUE usage is irrelevant
wrt this bug, it is purely a matter of sequence (queue_create -> queue_bind ->
queue_delete) that triggers the rt_queue_delete() wrapper issue.

-- 
Philippe.

