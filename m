Subject: Re: missing RTser0 device
References: <13576ee7-bda6-795b-1260-22f534c364d4@compador.de>
From: Johannes Holtz <johannes.holtz@compador.de>
Message-ID: <ef7c2d41-6945-737d-8aac-68afa20d8bae@compador.de>
Date: Fri, 16 Oct 2020 16:45:12 +0200
MIME-Version: 1.0
In-Reply-To: <13576ee7-bda6-795b-1260-22f534c364d4@compador.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I withdraw the question.

Calling rt_dev_open() with "rtser0" is sufficient.

Cheers.


Am 16.10.20 um 16:09 schrieb Johannes Holtz via Xenomai:
> Hi,
>
> I work with an old i686 2.6 Xenomai.
>
> As per documentation I note my interface details:
>
> setserial /dev/ttyS0
> /dev/ttyS0, UART: 16550A, Port: 0x03f8, IRQ: 4
>
> Then remove the default driver:
>
> setserial /dev/ttyS0 uart none
>
> and insert the xenomai driver
>
> modprobe xeno_16550A io=0x3f8 irq=4
>
>
> All calls succeed and I get the folder /proc/xenomai/rtdm/rtser0/ . 
> However the /dev/rtser0 device is not created. I have no errors to 
> show you.
>
> Am I missing anything?
>
>
>


