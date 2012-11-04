From: Michael Haberler <mail17@mah.priv.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Mon, 5 Nov 2012 00:06:19 +0100
Message-Id: <45719C85-5E5A-4600-831C-26CCFA62E4F0@mah.priv.at>
Mime-Version: 1.0 (Apple Message framework v1283)
Subject: [Xenomai] RTDM shm design question - does this make sense?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I need to port RTAI code to RTDM, which uses rtai_kmalloc and =
rtai_malloc for usr/usr and usr/kernel shared memory segments

they might be allocated by kernel or usermode first, and both kernel and =
userland should have an identical view; tracking between kernel and =
userland is in place (which module/process uses a shared segment, and =
'used in kernel or not')

userland might map a part of an existing shm segment, unmap it, and =
later map a larger part of same segment

Now, rtdm_mmap_to_user() gives me kernel->user mapping, but not =
user->kernel, nor user->user; all three are provided by =
rtai_kmalloc/rtai_malloc through the name argument (int)

does the following rtai_kmalloc/rtai_malloc replacement make sense?

- allocation _always_ happens in-kernel by kmalloc
-- directly in-kernel as needed, recording name and size
- for userland: through an RTDM ioctl to allocate by name/size
---driver checks if name unallocated
-- allocates with kmalloc if name not existent, recording name and and =
address
- a separate RTDM ioctl to map a segment by name/size to userspace


- Michael



