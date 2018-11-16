Subject: Re: [PATCH v2 0/8] net/tcp: Fix several bugs and allow rttcp to be
 built
References: <1541498426-2916-1-git-send-email-sebastian.smolorz@gmx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1cd6ad7e-d42e-88ff-94a6-74e61aca6d80@siemens.com>
Date: Fri, 16 Nov 2018 07:28:12 +0100
MIME-Version: 1.0
In-Reply-To: <1541498426-2916-1-git-send-email-sebastian.smolorz@gmx.de>
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
To: Sebastian Smolorz <sebastian.smolorz@gmx.de>, xenomai@xenomai.org

On 06.11.18 11:00, Sebastian Smolorz via Xenomai wrote:
> This patch series makes RTnet's tcp module usable again. It was not
> working due to several bugs which showed up in combination with reworked
> RTDM of Xenomai 3.
> 
> Tests on real hardware (little endian) were successful. A test on big
> endian is still pending.
> 
> Sebastian Smolorz (8):
>    net/tcp: return ufd in rt_tcp_accept()
>    net/tcp: fix listen() and shutdown() IOCTL calls
>    net/tcp: Fix bug when obtaining RST socket's private structure from
>      its rtdm_fd pointer
>    net/tcp: Copy data back to user buffer in rt_tcp_recvmsg
>    net/tcp: fix TCP connection termination
>    net/tcp: Set valid flags in struct tcphdr on little and big endian
>      machines
>    net/tcp: return already copied number of bytes to recv() callers when
>      peer socket terminates
>    net/tcp: Allow choice of rttcp protocol in Kconfig
> 
>   kernel/drivers/net/stack/ipv4/Kconfig   |  2 +-
>   kernel/drivers/net/stack/ipv4/tcp/tcp.c | 54 ++++++++++++---------------------
>   2 files changed, 21 insertions(+), 35 deletions(-)
> 

Thanks, applied to next.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

