References: <2060132.jtzqTOXOF1@lenni>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <72ed3f20-e3c6-abc9-244f-6bc3c2f32f75@siemens.com>
Date: Mon, 15 Oct 2018 13:18:36 +0200
MIME-Version: 1.0
In-Reply-To: <2060132.jtzqTOXOF1@lenni>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Retrieval of user fd from struct rtdm_fd
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sebastian Smolorz <Sebastian.Smolorz@gmx.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 14.10.18 21:27, Sebastian Smolorz wrote:
> Hello Philippe or Jan,
> 
> I need to retrieve the socket file descriptor from an RTDM device driver
> routine. From what I have seen there is no simple way to obtain this int
> value from struct rtdm_fd. I have identified three possible ways to do
> this, all of them necessitate modification of Xenomai code outside the
> driver:
> 
> 1. Iterate over the rb_tree rtdm_fd->owner->fds by means of the macro
> xntree_for_each_entry(pos, root, member). For this macro to work the
> definition of struct rtdm_fd_index must be known to the driver which
> means that it would have to be moved from kernel/cobalt/rtdm/fd.c to
> e.g. include/cobalt/kernel/rtdm/fd.h.
> 
> 2. Similar to 1. but offer a new function rtdm_fd_get_ufd(struct rtdm_fd
> *fd) in which the rb_tree is searched.
> 
> 3. Introduce a new value "int ufd" in struct rtdm_fd for setting and
> getting the ufd directly (which would be overkill I suppose because the
> vast majority of drivers don't need it).

OTOH, that structure is not really optimized for size. So I do not see why it 
shouldn't take yet another int, which would also be a faster API than the other 
options.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

