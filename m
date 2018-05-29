References: <CA+K1mPHAYw41SVh9M1zUwcZUB5g8ygjSbM7Pn0J61gRMzTkKcA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ca10bce1-a06d-6c3d-41ad-af0c3012a999@siemens.com>
Date: Tue, 29 May 2018 08:39:29 +0200
MIME-Version: 1.0
In-Reply-To: <CA+K1mPHAYw41SVh9M1zUwcZUB5g8ygjSbM7Pn0J61gRMzTkKcA@mail.gmail.com>
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

On 2018-05-28 19:21, C Smith wrote:
> Jan wrote:
>> Platform UART IRQs are assumed to be edge-triggered (see irqtype
>> variable) - maybe your special board is different in this regard as
>> well. Try removing RTDM_IRQTYPE_EDGE.
> 
> I couldn't find a kernel option called RTDM_IRQTYPE_EDGE, either with 'make
> menuconfig' or by grepping the Xenomai sources.
> 
> So I assumed you meant do do this in include/rtdm_driver.h ?
> /* #define RTDM_IRQTYPE_EDGE        XN_ISR_EDGE */   // just a test
> #define RTDM_IRQTYPE_EDGE 0
> 
> I  recompiled the xeno_16550A driver this way and it behaved no better. I
> still can't get an interrupt if two serial ports share an IRQ.
> 

How does /proc/interrupts look like when you have Linux driving all UARTs?

Jan

PS: You mail program is constantly breaking the topic threading - or you
are not replying to the previous answers but writing new emails.

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

