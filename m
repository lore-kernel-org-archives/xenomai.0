Subject: Re: [PATCH 00/12] Assorted updates: RTnet, GPIO, smokey tests
References: <20190124153428.21006-1-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0d503429-a5ac-9a81-fe6c-c1df064fd7dd@siemens.com>
Date: Thu, 24 Jan 2019 19:10:23 +0100
MIME-Version: 1.0
In-Reply-To: <20190124153428.21006-1-rpm@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 24.01.19 16:34, Philippe Gerum wrote:
> Patch 1 addresses the issue in the posix_clock fix as discussed in

And I'm still seeing a 100% identical patch and commit log...

> [1]. Patch 6 works around a recent regression in RTnet as mentioned in
> [2] (tested with the IGB driver which implements a map_rtskb
> handler). Both commits are also -stable candidates.
> 
> A couple of other changes extend the GPIO support with a timestamping
> feature, so that we may ask for the date of the latest state change of
> an input pin when reported by an interrupt event.
> 
> The rest is RTnet-related. In addition to patch 6, I would recommend
> picking 7 and 8 for -stable.
> 

Thanks, looking through them now.

Jan

> [1] https://www.xenomai.org/pipermail/xenomai/2019-January/040225.html
> [2] https://www.xenomai.org/pipermail/xenomai/2019-January/040230.html
> 
> Philippe Gerum (12):
>    testsuite/smokey: posix_clock: prevent false positive in
>      time-dependent test
>    drivers/gpio: provide optional timestamped readouts
>    testsuite/gpiotest: enable timestamping on 'timestamp' argument
>    net/stack: allow initializing pre-allocated device structs
>    net/stack: fresh rtskb should have ip_summed set to CHECKSUM_NONE
>    net/rtdev: ensure per-device skbs get mapped at registration
>    net/udp: getfrag: fix frag preparation status
>    net/udp: getfrag: remove direct reference to user memory
>    testsuite/smokey: net: do not unload pre-loaded modules
>    testsuite/smokey: net: do not down a previously running test interface
>    net/stack: rtskb: do not run nop locking calls
>    testsuite/smokey: net_client: improve stats readability
> 
>   include/cobalt/kernel/rtdm/gpio.h          |   1 +
>   include/rtdm/uapi/gpio.h                   |  18 ++-
>   kernel/drivers/gpio/gpio-core.c            |  54 +++++--
>   kernel/drivers/net/stack/include/rtdev.h   |   9 ++
>   kernel/drivers/net/stack/ipv4/udp/udp.c    |  21 +--
>   kernel/drivers/net/stack/rtdev.c           | 167 ++++++++++++++-------
>   kernel/drivers/net/stack/rtskb.c           |  26 +---
>   testsuite/gpiotest/gpiotest.c              |  37 ++++-
>   testsuite/smokey/net_common/client.c       |  26 ++--
>   testsuite/smokey/net_common/setup.c        | 108 ++++++++++---
>   testsuite/smokey/posix-clock/posix-clock.c |   2 +-
>   11 files changed, 325 insertions(+), 144 deletions(-)
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

