Message-ID: <54631EB1.1050900@sigmatek.at>
Date: Wed, 12 Nov 2014 09:47:45 +0100
From: Johann Obermayr <johann.obermayr@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] rtdm_nrtsig_pend FAQ
Reply-To: johann.obermayr@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Hello,

we use rtdm_nrtsig_pend follow.

static rtdm_nrtsig_t wait_domain_nrt;
static DECLARE_WAIT_QUEUE_HEAD(wait_domain_wq);

void period_update()
{
         wait_domain_pend_count++;
         rtdm_nrtsig_pend(&wait_domain_nrt);
}

static void wait_domain_nrt_handler(rtdm_nrtsig_t nrt_sig, void *arg)
{
     wait_domain_call_count++;
     //wakeup wait_domain
     wait_domain_wakeup = 1;
     wake_up_interruptible(&wait_domain_wq);
}


period_update is called every millisecond.
this is on imx6 hardware with kernel 3.0.x and xenomai 2.6.2.1.

Why wait_domain_call_count can be smaller that wait_domain_pend_count.
The difference between the counters is growing.

Why ?

Best Regards
   Johann


