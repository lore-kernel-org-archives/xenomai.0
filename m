Message-ID: <53E0DCB3.4040301@xenomai.org>
Date: Tue, 05 Aug 2014 15:31:31 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAMi4Dw02AiGx9ZQFcc3aesJCKkaKdkJ+3V+jPiOuReeC=o5L0A@mail.gmail.com>	<53DFB5A3.2000107@xenomai.org>
 <CAMi4Dw2OfwNnYiKhJr9XYibD5=kBHZBYnjW2T9XY_8zSbw8kHA@mail.gmail.com>
In-Reply-To: <CAMi4Dw2OfwNnYiKhJr9XYibD5=kBHZBYnjW2T9XY_8zSbw8kHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Shared interrupts
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Hidde Verstoep (E2M)" <hverstoep@e2mtechnologies.eu>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 08/05/2014 11:10 AM, Hidde Verstoep (E2M) wrote:

> rtdm_irq_request/free are called during device_open/close from RTnet,
> I don't know in what context that is.

Should be ok, linux aka secondary mode is expected here.

 I'll just have to try or ask on
> the RTnet list. rtdm_irq_enable/disable are never called.
> 
> I believe the calls rtdm_lock_get_irqsave/rtdm_lock_put_irqrestore
> also do something with interrupts. Can these calls cause issues when
> called from inside a realtime MSI handler?

No, they are fine in any context, provided a current task does not block
on the linux side while holding such lock.

Those calls get/put a spinlock and disable/restore interrupts the hard
way, i.e. actually flipping the interrupt disable bit in the current
CPU, bypassing the virtual interrupt mask introduced by the I-pipe patch
(the one which can block interrupts for the regular linux kernel while
still allowing Xenomai to receive them).

-- 
Philippe.

