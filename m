MIME-Version: 1.0
References: <CAPm8-H4LK2cdVkiK=AmVE1UT8kCOehDxsHafkh7EupOoQRebnA@mail.gmail.com>
In-Reply-To: <CAPm8-H4LK2cdVkiK=AmVE1UT8kCOehDxsHafkh7EupOoQRebnA@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Fri, 31 Jan 2020 15:34:47 -0500
Message-ID: <CALLqZ8SqKMgFuvQNjX0SNL183O8d6trDRqxPg-e7A3SJGZ-L7Q@mail.gmail.com>
Subject: Re: Beaglebone black raw_printk
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

Hi

On Fri, Jan 31, 2020 at 7:04 AM Laurentiu-Cristian Duca
<laurentiu.duca@gmail.com> wrote:
>
> Hello xenomai family
>
>   In this way I was able to use raw_printk on evl.
> Maybe works on xenomai too.
>
> CONFIG_DEBUG_RAW_PRINTK=y
> CONFIG_DEBUG_LL=y
> # under LL menu entry
> CONFIG_DEBUG_UART_8250=y
> CONFIG_DEBUG_UART_PHYS=0x44e09000
> CONFIG_DEBUG_UART_VIRT=0xf9e09000

Thanks!! That worked great, I now have printascii working and can
debug with more success.  I was missing the UART_8250 part.

-Greg

