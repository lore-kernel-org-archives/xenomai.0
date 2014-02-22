Message-ID: <5308C79B.30708@athel.de>
Date: Sat, 22 Feb 2014 16:51:55 +0100
From: =?ISO-8859-15?Q?Christian_G=F6beler?= <christian@athel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] changing priority and policy VS unblocking
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

One question regarding xenomai best practices.

I have to modify an application running user defined code in worker
threads (POSIX threads).

Performance-wise is it better to create designated RT-Threads waiting
for a condition to be signaled and then continue to run in primary mode
whatever code the user passed in or would it be just as fast and
reliable to promote an already running worker thread by changing its
priority to let's say 99 for example and its sched-policy to FIFO?


Thanks

Christian

