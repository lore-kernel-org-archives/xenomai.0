Message-ID: <52B71AB4.5090204@xenomai.org>
Date: Sun, 22 Dec 2013 18:00:36 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] file descriptors rework
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>


Here is the new proposed API for file descriptors:

struct xnfd_ops {
	int (*destroy)(struct xnfd *fd);
	int (*select_bind)(struct xnfd *fd, struct xnselector *selector,
			unsigned type, unsigned index);
};

struct xnfd {
	unsigned magic;
	struct mm_struct *mm;
	int ufd;
	struct xnfd_ops *ops;
	unsigned refs;
	struct hlist_node hlink; /* Link in global hash */
	struct list_head link;	 /* Link in per-process queue */
};

int xnfd_enter(struct xnfd *xnfd, unsigned magic, int ufd,
	struct mm_struct *mm, struct xnfd_ops *ops);

struct xnfd *xnfd_get(int ufd, struct mm_struct *mm, unsigned magic);

int xnfd_put(struct xnfd *xnfd);

int xnfd_close(struct xnfd *xnfd);

The xnfd structure has to be put inside larger structure, and
container_of used to access the larger structure. The magic is there to
cope with the fact that different file descriptors users will have
different structures, so the actual type has to be found before using
container_of.

refs is incrementer on get, decremented on put, when it reaches 0, the
"destroy" callback is called, this in order to avoid destroying a file
descriptor under another file descriptor user's feet.

xnfd_close negates the magic in order to render the file descriptor invalid.

the select_bind callbacks is needed to implement select uniformly.

If nobody disagrees with this API, I will start implementing ASAP, and
rebase the message queues code upon this.

-- 
                                                                Gilles.

