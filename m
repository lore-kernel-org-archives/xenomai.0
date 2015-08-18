Message-ID: <55D33336.4020004@sigmatek.at>
Date: Tue, 18 Aug 2015 15:29:26 +0200
From: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
MIME-Version: 1.0
References: <55D321A2.6090201@sigmatek.at>
 <20150818124805.GB4740@hermes.click-hack.org>
In-Reply-To: <20150818124805.GB4740@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Function to get state of lock variable
Reply-To: wolfgang.netbal@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: gilles.chanteperdrix@xenomai.org
Cc: Xenomai Mailing List <xenomai@xenomai.org>



Am 2015-08-18 um 14:48 schrieb Gilles Chanteperdrix:
> On Tue, Aug 18, 2015 at 02:14:26PM +0200, Wolfgang Netbal wrote:
>> Hi All,
>>
>> is there a function te returns true or false if a rtdm_lock_t variable is
>> set ?
>> What I have to do is  to check in an interrupt routine if the list is
>> locked,
>> if this is the case I leave the interrupt handler befor accessing the list.
>>
>> I use the following code to lock the add and replace of list elements.
>>
>> static rtdm_lock_t opendev_list_lock;
>> static int open(struct rtdm_dev_context *context, rtdm_user_info_t *
>> user_info, int oflags)
>> {
>>      lrtdrv_context_t *ctx = (lrtdrv_context_t *) context->dev_private;
>>      rtdm_lockctx_t s;
>>
>> ....
>>
>>      rtdm_lock_get_irqsave(&opendev_list_lock, s);
>>      list_add_tail(&ctx->opendev_entry, &lrtdrv_opendev_list);
>>      rtdm_lock_put_irqrestore(&opendev_list_lock, s);
> Well, if you are not running on a multiprocessor system, you can not
> take interrupt during that section.
>
> And on a multiprocessor system, the time this code will hold the
> lock is very short, so, it should not be a problem for an interrupt
> one core to spin while another core is holding the lock.
>
> But we can probably add rtdm_lock_is_locked, yes.
>
I'm working on a multiprocessor system and when I boot the system 
between 200 and 1000 times I get one error, because the add and remove 
from the list will be done on boot.
I tried to add a function rtdm_lock_is_locked but the thing is that the 
variables in struct arch_spinlock_t are different for different 
architectures, for example on ARM it is "u32 slock" and on x86 it is 
"__ticketpair_t head_tail".

If you have a hint for me which element of struct rtdm_lock_t I have to 
use to check if the list is locked I can add this on my own.
If you think this the function rtdm_lock_is_locked should be added it 
would be great if you can add it for Xenomai 2.6.4 as well.

Right now I use the following code to check this.

static rtdm_lock_t* gListLocked = NULL;

static int open(struct rtdm_dev_context *context, rtdm_user_info_t * 
user_info, int oflags)
{
     lrtdrv_context_t *ctx = (lrtdrv_context_t *) context->dev_private;

     gListLocked = &opendev_list_lock;
     rtdm_lock_get_irqsave(gListLocked, s);
     list_add_tail(&ctx->opendev_entry, &lrtdrv_opendev_list);
     rtdm_lock_put_irqrestore(gListLocked, s);
     gListLocked = NULL;
}

int lrtdrv_is_opendev_list_locked(void)
{
     int ret = 0;
     if(gListLocked != NULL)
         ret = 1;

     return ret;
}

Kind regards
Wolfgang


