Date: Tue, 18 Aug 2015 14:48:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150818124805.GB4740@hermes.click-hack.org>
References: <55D321A2.6090201@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55D321A2.6090201@sigmatek.at>
Subject: Re: [Xenomai] Function to get state of lock variable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
Cc: Xenomai Mailing List <xenomai@xenomai.org>

On Tue, Aug 18, 2015 at 02:14:26PM +0200, Wolfgang Netbal wrote:
> Hi All,
> 
> is there a function te returns true or false if a rtdm_lock_t variable is
> set ?
> What I have to do is  to check in an interrupt routine if the list is
> locked,
> if this is the case I leave the interrupt handler befor accessing the list.
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

Well, if you are not running on a multiprocessor system, you can not
take interrupt during that section.

And on a multiprocessor system, the time this code will hold the
lock is very short, so, it should not be a problem for an interrupt
one core to spin while another core is holding the lock.

But we can probably add rtdm_lock_is_locked, yes.

-- 
					    Gilles.
https://click-hack.org

