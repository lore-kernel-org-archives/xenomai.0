References: <1539775907-5124-1-git-send-email-sebastian.smolorz@gmx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <efacce14-b2b0-4961-1694-06d5f4041d22@siemens.com>
Date: Wed, 17 Oct 2018 13:44:30 +0200
MIME-Version: 1.0
In-Reply-To: <1539775907-5124-1-git-send-email-sebastian.smolorz@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 0/4] net/tcp: Fix several bugs and allow rttcp
 to be built
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sebastian Smolorz <sebastian.smolorz@gmx.de>, xenomai@xenomai.org

On 17.10.18 13:31, Sebastian Smolorz wrote:
> This patch series makes RTnet's tcp module usable again. It was not
> selectable in Kconfig for a long time. Now it is supposed to work in
> the way it worked when RTnet was a separate project for Xenomai 2.

Despite the "supposed", can I assume you tested it already successfully with 
some real workload?

> 
> Sebastian Smolorz (4):
>    net/tcp: return ufd in rt_tcp_accept()
>    net/tcp: fix listen() and shutdown() IOCTL calls
>    net/tcp: Fix bug when obtaining RST socket's private structure from
>      its rtdm_fd pointer
>    net/tcp: Allow choice of rttcp protocol in Kconfig
> 
>   kernel/drivers/net/stack/ipv4/Kconfig   |  2 +-
>   kernel/drivers/net/stack/ipv4/tcp/tcp.c | 16 ++++------------
>   2 files changed, 5 insertions(+), 13 deletions(-)
> 

Thanks for reanimating this!

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

