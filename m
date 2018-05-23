References: <CA+K1mPH6SPht4gtnO4iU9NT814H8GUKUi7OVerF=jcaL-imMJA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <18370ab1-dd9e-f62a-524f-e64608f7fec1@siemens.com>
Date: Wed, 23 May 2018 06:55:50 +0200
MIME-Version: 1.0
In-Reply-To: <CA+K1mPH6SPht4gtnO4iU9NT814H8GUKUi7OVerF=jcaL-imMJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Only 2 serial ports at a time with xeno_16550A driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: C Smith <csmithquestions@gmail.com>, xenomai@xenomai.org

On 2018-05-20 09:43, C Smith wrote:
> An update:
> In the modprobe, I tried putting first the two ports which share IRQ 5:
> modprobe xeno_16550A io=0x02f8,0x2e8,0x3f8 irq=5,5,4

BTW, the x86 platform UARTs use IRQ4 (port 1 and 3) and IRQ3 (port 2 and 4).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

