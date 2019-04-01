Subject: Re: [PATCH 0/4] i.MX serial driver fixes
References: <20190329174103.8158-1-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <f688a594-bd99-3da5-0ab6-2fba6a5b66ba@web.de>
Date: Mon, 1 Apr 2019 20:17:17 +0200
MIME-Version: 1.0
In-Reply-To: <20190329174103.8158-1-rpm@xenomai.org>
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

On 29.03.19 18:40, Philippe Gerum via Xenomai wrote:
> Another set of changes for the i.MX serial driver, addressing some
> issues observed here.
>
> Patch #1 updates the init and configuration code to align with
> mainline; it also fixes random lockups caused by the reset probe loop
> spinning indefinitely. This was specifically observed when re-opening
> the device for multiple runs (first run was generally ok).
>
> Patch #2 is a must-have, the Cobalt interface requires it.
>
> Tested on i.MX6Q. Patch #1 needs further testing by other parties to
> make sure it does not introduce regression(s).
>
> Philippe Gerum (4):
>    drivers/serial: imx: robustify device setup/cleanup
>    drivers/serial: always propagate -EINTR downstream
>    drivers/serial: imx: simplify RX loop
>    drivers/serial: imx: dismiss noisy IRQ events
>
>   kernel/drivers/serial/rt_imx_uart.c | 130 ++++++++++++++++++----------
>   1 file changed, 82 insertions(+), 48 deletions(-)
>

Applied to next, thanks.

Jan

