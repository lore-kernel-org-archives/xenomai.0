References: <33045a16-021a-7899-68da-ec9b3daaf2a8@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f59dfb4f-d330-eefc-82c2-a8fbae909456@siemens.com>
Date: Thu, 6 Sep 2018 14:35:59 +0200
MIME-Version: 1.0
In-Reply-To: <33045a16-021a-7899-68da-ec9b3daaf2a8@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PULL] cobalt kernel fixes, janitorial work
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 2018-09-06 12:17, Philippe Gerum wrote:
> 
> The following changes since commit e9de2fe2c3e6203c1705ba2bdf16bf1a4bcda2bf:
> 
>    cobalt/rtdm: Remove rtdm_ratelimit() (2018-09-03 19:11:06 +0200)
> 
> are available in the Git repository at:
> 
>    git://lab.xenomai.org/xenomai-rpm.git for-upstream/next
> 
> for you to fetch changes up to bbab27460dd8aa88d7319e8c179d39cb8702da18:
> 
>    cobalt/sched: improve watchdog accuracy (2018-09-06 11:57:32 +0200)
> 
> ----------------------------------------------------------------
> Philippe Gerum (3):
>        cobalt/intr: drop last #if XENO_DEBUG() conditional
>        cobalt/sched: group high-level init/cleanup code
>        cobalt/sched: improve watchdog accuracy
> 
>   include/cobalt/kernel/sched.h | 17 ++---------------
>   kernel/cobalt/init.c          | 41 +++--------------------------------------
>   kernel/cobalt/intr.c          |  2 +-
>   kernel/cobalt/sched.c         | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
>   kernel/cobalt/timer.c         |  7 -------
>   5 files changed, 80 insertions(+), 78 deletions(-)
> 

Thanks, applied to next (reordered as I had patch 2 already in).

Please send all new patches in the future to the list as well.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

