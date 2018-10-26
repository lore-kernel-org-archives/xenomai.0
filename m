Subject: Re: [PULL REQUEST] fixes for GCC 8.x, automatic RTnet interface
 dismantling - v2
References: <f5969ceb-572d-ffc5-c516-3810fb33a8fe@xenomai.org>
 <bb9e392a-3cab-224a-40be-864037064578@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <92ee051a-b7ea-8deb-af60-07caf377b355@siemens.com>
Date: Fri, 26 Oct 2018 14:28:58 +0100
MIME-Version: 1.0
In-Reply-To: <bb9e392a-3cab-224a-40be-864037064578@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 25.10.18 16:31, Philippe Gerum wrote:
> 
> Fixed a locking imbalance in the commit dealing with extraneous UP/DOWN interface requests.
> 
> ----
> 
> The following changes since commit 04df93890befa4e5a642ecdef38eebed4660b217:
> 
>    rtdm: expose user-side file descriptors to drivers (2018-10-17 13:20:06 +0200)
> 
> are available in the Git repository at:
> 
>    git://lab.xenomai.org/xenomai-rpm.git for-upstream/next
> 
> for you to fetch changes up to 8af7351efdfb75fff0066a75f4e57d3734f1b220:
> 
>    net/igb: igb_ioctl() requires execution in secondary mode (2018-10-25 17:28:31 +0200)
> 
> ----------------------------------------------------------------
> Philippe Gerum (9):
>        utils/can: prevent unterminated destination buffer with strncpy()
>        demos/posix: prevent unterminated destination buffer with strncpy()
>        boilerplate/ancillaries: prevent false positive with -Wstringop-truncation
>        cobalt/ancillaries: prevent false positive with -Wstringop-truncation
>        boilerplate/compiler: drop __const and __pure shorthands
>        net/stack: export services to switch interface up/down
>        net/stack: ignore extraneous interface UP/DOWN calls
>        net/igb: down interface upon PCI unregister
>        net/igb: igb_ioctl() requires execution in secondary mode
> 
>   demo/posix/cobalt/can-rtt.c               |   4 ++--
>   demo/posix/cobalt/eth_p_all.c             |   3 ++-
>   demo/posix/cyclictest/cyclictest.c        |   4 ++--
>   include/boilerplate/ancillaries.h         |   2 +-
>   include/boilerplate/compiler.h            |   8 --------
>   include/cobalt/kernel/ancillaries.h       |   2 +-
>   kernel/drivers/net/drivers/igb/igb_main.c |   4 ++++
>   kernel/drivers/net/stack/include/rtdev.h  |   4 ++++
>   kernel/drivers/net/stack/rtdev.c          | 103 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   kernel/drivers/net/stack/rtnet_chrdev.c   |  85 ++-----------------------------------------------------------------------------------
>   utils/can/rtcanconfig.c                   |   7 ++++---
>   utils/can/rtcanrecv.c                     |   3 ++-
>   utils/can/rtcansend.c                     |   3 ++-
>   13 files changed, 129 insertions(+), 103 deletions(-)
> 

Could you post the patches to the list as well (or did I missed that?)? Would 
allow in-line review for everyone without having to go to git first.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

