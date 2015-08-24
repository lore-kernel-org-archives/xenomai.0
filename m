References: <55D321A2.6090201@sigmatek.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <55DAC981.2080409@siemens.com>
Date: Mon, 24 Aug 2015 09:36:33 +0200
MIME-Version: 1.0
In-Reply-To: <55D321A2.6090201@sigmatek.at>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Function to get state of lock variable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: wolfgang.netbal@sigmatek.at, Xenomai Mailing List <xenomai@xenomai.org>

On 2015-08-18 14:14, Wolfgang Netbal wrote:
> Hi All,
> 
> is there a function te returns true or false if a rtdm_lock_t variable
> is set ?
> What I have to do is  to check in an interrupt routine if the list is
> locked,
> if this is the case I leave the interrupt handler befor accessing the list.

Why? Why can't you simply spin until the lock is released - provided the
section that holds it is as short as in the code below?

Testing for a lock being held is usually only reasonable for debugging
purposes. trylock services make some sense in complex nested locking
scenarios or when creatively having to optimize the fast path. I dare to
say trying to use those mechanisms in a real-time context indicates that
the design has some other problem.

Jan

> 
> I use the following code to lock the add and replace of list elements.
> 
> static rtdm_lock_t opendev_list_lock;
> static int open(struct rtdm_dev_context *context, rtdm_user_info_t *
> user_info, int oflags)
> {
>     lrtdrv_context_t *ctx = (lrtdrv_context_t *) context->dev_private;
>     rtdm_lockctx_t s;
> 
> ....
> 
>     rtdm_lock_get_irqsave(&opendev_list_lock, s);
>     list_add_tail(&ctx->opendev_entry, &lrtdrv_opendev_list);
>     rtdm_lock_put_irqrestore(&opendev_list_lock, s);
> 
> 
>     return 0;
> }
> 
> Kind regards

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

