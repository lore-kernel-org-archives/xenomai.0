References: <1512357744-120225-1-git-send-email-greg@embeddedgreg.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <455a9eb6-9200-1cc3-2254-5d247228d096@xenomai.org>
Date: Tue, 5 Dec 2017 14:28:55 +0100
MIME-Version: 1.0
In-Reply-To: <1512357744-120225-1-git-send-email-greg@embeddedgreg.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] Split rtdm_fd_enter up,
 move the functionality where we store the fd until after the open()
 call succeeds. Calls where open() fail a fd is left in the tree even after
 the cleanup code is executed. If this fd number is used again we will fail
 the call to open until a different fd is used. This patch addresses this
 situation by not adding the fd into the tree until open has succeeded and
 the fd is valid.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>, xenomai@xenomai.org

On 12/04/2017 04:22 AM, Greg Gallagher wrote:
> ---
>  include/cobalt/kernel/rtdm/fd.h |  2 ++
>  kernel/cobalt/posix/mqueue.c    |  7 ++++++-
>  kernel/cobalt/posix/timerfd.c   |  4 ++++
>  kernel/cobalt/rtdm/core.c       | 12 +++++++++---
>  kernel/cobalt/rtdm/fd.c         | 24 ++++++++++++++++--------
>  5 files changed, 37 insertions(+), 12 deletions(-)
> 

Looks good. Merged, thanks.

-- 
Philippe.

