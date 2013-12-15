Message-ID: <52AE0F6D.10007@xenomai.org>
Date: Sun, 15 Dec 2013 21:22:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Reworking file descriptors
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <xenomai@xenomai.org>


Hi Jan,

I have starting reworking the posix skin on forge to use the cobalt
registry instead of the ad-hoc registry it currently uses. The next step
for that work is to convert the file descriptors, offering a unified
access with select to posix skin message queues and rtdm drivers, and
working correctly with fork().

I have a clear idea on how I would do it for the posix message queues
only. Just as I did for the semaphores, I would implement a hash table,
where the file descriptor structures are indexed by the user-space file
descriptor (obtained with open(/dev/null) for instance, so that xenomai
file descriptors follow the posix specification, and use the smallest
available descriptor), and the mm structure.

However, RTDM allows opening file descriptors in kernel-space, so it
would break my implementation, because we can use NULL or &init_mm as
the mm key, but what would we use as the file descriptor index?

Any idea is welcome.
Regards.

-- 
                                                                Gilles.

