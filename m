Subject: Re: [PATCH 0/5] serial, net, testsuite fixes
References: <20190320154425.30639-1-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <a1fe56bb-ef87-e8d2-7c77-3b5cf97b6cbd@web.de>
Date: Mon, 1 Apr 2019 20:01:20 +0200
MIME-Version: 1.0
In-Reply-To: <20190320154425.30639-1-rpm@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 20.03.19 16:44, Philippe Gerum via Xenomai wrote:
> No critical changes here; although patch #0002 fixes a locking
> imbalance in some error path, the latter is in theory impossible to
> trigger.
>
> Philippe Gerum (5):
>    testsuite/gpiotest: define missing 'timestamp' argument
>    drivers/serial: imx: fix locking imbalance upon -EBADF
>    drivers/serial: imx: drop useless EWOULDBLOCK->EAGAIN remapping
>    net/drivers: macb: do not check for initial checksum value
>    net/drivers: stack: remove unused assertion
>
>   doc/asciidoc/MIGRATION.adoc              |  4 +---
>   kernel/drivers/net/drivers/macb.c        |  2 --
>   kernel/drivers/net/stack/include/rtskb.h |  2 --
>   kernel/drivers/serial/rt_imx_uart.c      |  6 +-----
>   testsuite/gpiotest/gpiotest.c            | 11 ++++++-----
>   5 files changed, 8 insertions(+), 17 deletions(-)
>

Thanks, applied.

Jan

