Message-ID: <55D321A2.6090201@sigmatek.at>
Date: Tue, 18 Aug 2015 14:14:26 +0200
From: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] Function to get state of lock variable
Reply-To: wolfgang.netbal@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai Mailing List <xenomai@xenomai.org>

Hi All,

is there a function te returns true or false if a rtdm_lock_t variable 
is set ?
What I have to do is  to check in an interrupt routine if the list is 
locked,
if this is the case I leave the interrupt handler befor accessing the list.

I use the following code to lock the add and replace of list elements.

static rtdm_lock_t opendev_list_lock;
static int open(struct rtdm_dev_context *context, rtdm_user_info_t * 
user_info, int oflags)
{
     lrtdrv_context_t *ctx = (lrtdrv_context_t *) context->dev_private;
     rtdm_lockctx_t s;

....

     rtdm_lock_get_irqsave(&opendev_list_lock, s);
     list_add_tail(&ctx->opendev_entry, &lrtdrv_opendev_list);
     rtdm_lock_put_irqrestore(&opendev_list_lock, s);


     return 0;
}

Kind regards
-- 
Wolfgang Netbal
Softwareentwicklung
________________________________

SIGMATEK GmbH & Co KG
Sigmatekstraße 1
5112 Lamprechtshausen
Österreich / Austria

Tel.: +43/6274/4321-0
Fax: +43/6274/4321-300
E-Mail: wolfgang.netbal@sigmatek.at
http://www.sigmatek-automation.at

****************************Please note: ****************************
This email and all attachments are confidential and intended solely
for the person or entity to whom it is addressed. If you are not the
named addressee you must not make this email and all attachments
accessible to any other person. If you have received this email in
error please delete it together with all attachments.
*********************************************************************
