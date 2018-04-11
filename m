Message-ID: <1523457598.2312.18.camel@smigroup.net>
From: Mauro Salvini <mauro.salvini@smigroup.net>
Date: Wed, 11 Apr 2018 16:39:58 +0200
In-Reply-To: <e0a935b3-8f75-484f-5324-9c5694476bfc@xenomai.org>
References: <1523454871.2312.15.camel@smigroup.net>
 <e0a935b3-8f75-484f-5324-9c5694476bfc@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_task_wait_period() does not return -EWOULDBLOCK
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai <xenomai@xenomai.org>

On Wed, 2018-04-11 at 16:20 +0200, Philippe Gerum wrote:
> On 04/11/2018 03:54 PM, Mauro Salvini wrote:
> > Hi,
> > 
> > I'm facing an unexpected behavior of rt_task_wait_period().
> > 
> > 

...

> Please try this and let me know if the situation gets any better:

Yes, now it works as expected.

Output with SET_PERIOD not defined is:
NON PERIODIC TASK!
Main 0
NON PERIODIC TASK!
NON PERIODIC TASK!
Main 2
NON PERIODIC TASK!
NON PERIODIC TASK!
Main 4
...

Thank you Philippe.

Best regards.

Mauro


