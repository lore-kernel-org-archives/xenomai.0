Date: Tue, 16 Feb 2016 15:22:59 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160216142259.GC17780@hermes.click-hack.org>
References: <CANWkrRMcQw0deq3xrPrsua1-kRuopyxOU_80_OBizZDs=U3whQ@mail.gmail.com>
 <56C303A0.8090009@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56C303A0.8090009@xenomai.org>
Subject: Re: [Xenomai] Missing rtdm_lock_get_irqsave() in API docs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Michael Smith <2michael.smith@gmail.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Feb 16, 2016 at 12:10:24PM +0100, Philippe Gerum wrote:
> On 02/11/2016 04:17 PM, Michael Smith wrote:
> > Hi guys.
> > I have found that the function call rtdm_lock_get_irqsave() is missing
> > from the API documentation.
> > The complimentary call  rtdm_lock_put_irqrestore() is listed under:
> > RTDM -> Driver programming interface -> Synchronisation Services ->
> > Spinlock with preemption deactivation.
> > I found the rtdm_lock_get_irqsave() / rtdm_lock_put_irqrestore() calls
> > while I was looking at the serial driver example code, but could not
> > find the rtdm_lock_get_irqsave() listing in the API documentation.
> > 
> > Was this done with a purpose or is it a mistake?
> 
> Speaking of Xenomai 3.0.1, for some reason, Doxygen did not pick the
> documentation block for this macro, which is present and looks like
> properly formatted though. Anyway, the doc was fixed up to make this
> block even more obvious, and I can see it in a locally generated
> html/pdf now. The online doc will reflect that change at the next daily
> update.

It should be up to date on the server now.

-- 
					    Gilles.
https://click-hack.org

