From: Sebastian Smolorz <Sebastian.Smolorz@gmx.de>
Date: Sun, 14 Oct 2018 21:27:07 +0200
Message-ID: <2060132.jtzqTOXOF1@lenni>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: [Xenomai] Retrieval of user fd from struct rtdm_fd
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello Philippe or Jan,

I need to retrieve the socket file descriptor from an RTDM device driver 
routine. From what I have seen there is no simple way to obtain this int 
value from struct rtdm_fd. I have identified three possible ways to do 
this, all of them necessitate modification of Xenomai code outside the 
driver:

1. Iterate over the rb_tree rtdm_fd->owner->fds by means of the macro 
xntree_for_each_entry(pos, root, member). For this macro to work the 
definition of struct rtdm_fd_index must be known to the driver which 
means that it would have to be moved from kernel/cobalt/rtdm/fd.c to 
e.g. include/cobalt/kernel/rtdm/fd.h.

2. Similar to 1. but offer a new function rtdm_fd_get_ufd(struct rtdm_fd 
*fd) in which the rb_tree is searched.

3. Introduce a new value "int ufd" in struct rtdm_fd for setting and 
getting the ufd directly (which would be overkill I suppose because the 
vast majority of drivers don't need it).

What do you think, which of the above would you prefer?

-- 
Sebastian





