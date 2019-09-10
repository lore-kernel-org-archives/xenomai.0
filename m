Subject: Re: uart high latency on beaglebone
References: <CALOJ9n=-AdauHwrSRiDC9Y54E64xnESKevoQ32VkNLnDaPWd4A@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <32dadf6f-a1c2-fa41-5fec-e1ffc032bc75@siemens.com>
Date: Tue, 10 Sep 2019 12:11:03 +0200
MIME-Version: 1.0
In-Reply-To: <CALOJ9n=-AdauHwrSRiDC9Y54E64xnESKevoQ32VkNLnDaPWd4A@mail.gmail.com>
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
To: Amin Habibi <seyedaminhabibi@gmail.com>, xenomai@xenomai.org

On 04.09.19 11:31, Amin Habibi via Xenomai wrote:
> Hi, after some minor changes to 16550A driver(adding support for word level
> register accessing) i could use it on beaglebone and successfully testing
> it in user space. based on a example application on this mailing list i
> wrote a simple loop back application(with posix skin) which loop back any
> received data. using a logic analyzer i see a high latency.there is around
> 5ms delay between receiving data and resending it. when i use original
> beaglebone UART driver there is approximately same latency(around 5ms).
> it's like the task is stuck at secondary mode! although i used
> PTHREAD_EXPLICIT_SCHED, SCHED_FIFO at task creation.i have attached the
> userspace code.
> always there is only two mode switches at the beginning of task creation
> and there is no mode switches while sending/receiving data.
> any idea of what caused this latency or how i can debug and trace the task
> or driver?
> thanks.
> contents of "/proc/xenomai/sched/stat" while task is running:
>    MSW  CSW     XSC      PF    STAT       %CPU  NAME
>     0       13471      0          0    00018000  100.0   [ROOT/0]
>     1          2          5          0    00060044    0.0     uart_app
>     2          4          6          0    00040042    0.0    DemoPosix
>     0       506071    0          0    00000000    0.0    [IRQ16: [timer]]
>     0          2          0          0    00000000    0.0    [IRQ19: rtser0]

I'm not familiar with the details of the I-pipe patch on the BBB, but maybe 
there is some interrupt dispatching for the rtser line involved that is not 
RT-hardened. The test code looks sane, and you also have no noteworthy mode 
switches.

A typical approach to debug that is using ftrace, starting with event tracing, 
possibly adding function-level tracing via ftrace or the I-pipe tracer later on.

BTW, could you share your driver modification as well?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

