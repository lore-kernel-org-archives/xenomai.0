MIME-Version: 1.0
Message-ID: <trinity-7cd9b0a1-c550-475e-9def-f17fa2b87af0-1539610501748@msvc-mesg-gmx123>
From: "Sebastian Smolorz" <Sebastian.Smolorz@gmx.de>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Oct 2018 15:35:01 +0200
In-Reply-To: <2c327fc7-5d86-dcb8-9521-c20722f481da@siemens.com>
References: <2060132.jtzqTOXOF1@lenni>
 <72ed3f20-e3c6-abc9-244f-6bc3c2f32f75@siemens.com>
 <trinity-bc2081b0-04b8-43e1-b7da-c86f08ec0d13-1539609474671@msvc-mesg-gmx123>
 <786072ef-a494-33cb-df55-7c0568896d59@xenomai.org>
 <2c327fc7-5d86-dcb8-9521-c20722f481da@siemens.com>
Subject: Re: [Xenomai] Retrieval of user fd from struct rtdm_fd
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Jan Kiszka wrote:

> On 15.10.18 15:28, Philippe Gerum wrote:
> > On 10/15/2018 03:17 PM, Sebastian Smolorz wrote:
> >> Jan Kiszka wrote:
> >>
> >>> On 14.10.18 21:27, Sebastian Smolorz wrote:
> >>>> Hello Philippe or Jan,
> >>>>
> >>>> I need to retrieve the socket file descriptor from an RTDM device driver
> >>>> routine. From what I have seen there is no simple way to obtain this int
> >>>> value from struct rtdm_fd. I have identified three possible ways to do
> >>>> this, all of them necessitate modification of Xenomai code outside the
> >>>> driver:
> >>>>
> >>>> 1. Iterate over the rb_tree rtdm_fd->owner->fds by means of the macro
> >>>> xntree_for_each_entry(pos, root, member). For this macro to work the
> >>>> definition of struct rtdm_fd_index must be known to the driver which
> >>>> means that it would have to be moved from kernel/cobalt/rtdm/fd.c to
> >>>> e.g. include/cobalt/kernel/rtdm/fd.h.
> >>>>
> >>>> 2. Similar to 1. but offer a new function rtdm_fd_get_ufd(struct rtdm_fd
> >>>> *fd) in which the rb_tree is searched.
> >>>>
> >>>> 3. Introduce a new value "int ufd" in struct rtdm_fd for setting and
> >>>> getting the ufd directly (which would be overkill I suppose because the
> >>>> vast majority of drivers don't need it).
> >>>
> >>> OTOH, that structure is not really optimized for size. So I do not see why it
> >>> shouldn't take yet another int, which would also be a faster API than the other
> >>> options.
> >>
> >> Correct. Nevertheless, we could mitigate the effect of this change by
> >> surrounding the new ufd field with
> >> #ifdef CONFIG_XENO_DRIVERS_NET_RTIPV4_TCP
> >>
> > 
> > The core layer implementing RTDM fd is not supposed to depend on high
> > level remote features such as tcp protocol over rtnet.
> > 
> > Let's just add the missing info to rtdm_fd unconditionally, we are
> > talking about a few tenths of additional bytes in a typical Xenomai
> > system fitted with several MB of memory (likely less than what would be
> > needed to scan the fd tree to retrieve the same information btw).
> > 
> 
> Ack.
> 

OK, will prepare a patch.

-- 
Sebastian



