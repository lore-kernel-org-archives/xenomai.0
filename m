Message-ID: <1458922449.20027.23.camel@henry-ThinkCentre-M93p>
From: Henry Bausley <hbausley@deltatau.com>
Date: Fri, 25 Mar 2016 09:14:09 -0700
In-Reply-To: <56F3C088.1030000@xenomai.org>
References: <1457983382.28082.11.camel@henry-ThinkCentre-M93p>
 <56E71CC1.5070600@xenomai.org>
 <1457990656.28082.20.camel@henry-ThinkCentre-M93p>
 <56E90784.7080702@xenomai.org>
 <1458260422.4930.2.camel@henry-ThinkCentre-M93p>
 <1458666633.2713.2.camel@henry-ThinkCentre-M93p>
 <56F3C088.1030000@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Reentrant Interrupts on Freescale LS1021A
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, 2016-03-24 at 11:25 +0100, Philippe Gerum wrote:
>  Content preview:  On 03/22/2016 06:10 PM, Henry Bausley wrote: > What we are
>     seeing is if we are in the intr->isr(intr) and another H/W > interrupt occurs
>     it is replayed after the current intr->isr(intr) is > finished. > > What
>    we are trying to accomplish is when a second H/W interrupt occurs > the current
>     intr->isr(intr) is stopped and a second call to > intr->isr(intr) gets processed
>     then when finished the original > intr->isr(intr) . > > > Is there a way
>    to accomplish what we are trying to do? > [...] 
>  
>  Content analysis details:   (-1.0 points, 5.0 required)
>  
>   pts rule name              description
>  ---- ---------------------- --------------------------------------------------
>  -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
> X-Barracuda-Connect: sd-51317.xenomai.org[62.210.215.82]
> X-Barracuda-Start-Time: 1458815113
> X-Barracuda-URL: https://76.79.246.10:443/cgi-mod/mark.cgi
> X-Virus-Scanned: by bsmtpd at deltatau.com
> X-Barracuda-BRTS-Status: 1
> X-Barracuda-Spam-Score: 0.00
> X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=2.0 QUARANTINE_LEVEL=4.0 KILL_LEVEL=7.0 tests=
> X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.28117
> 	Rule breakdown below
> 	 pts rule name              description
> 	---- ---------------------- --------------------------------------------------
> 
> On 03/22/2016 06:10 PM, Henry Bausley wrote:
> > What we are seeing is if we are in the intr->isr(intr) and another H/W
> > interrupt occurs it is replayed after the current intr->isr(intr) is
> > finished.  
> > 
> > What we are trying to accomplish is when a second H/W interrupt occurs
> > the current intr->isr(intr) is stopped and a second call to
> > intr->isr(intr) gets processed then when finished the original
> > intr->isr(intr) .  
> > 
> > 
> > Is there a way to accomplish what we are trying to do?
> > 
> 
> You need to fixup the virtual interrupt state for the head domain to
> match the hardware IRQ state change. There are pipeline helpers
> combining both operations the proper way. e.g. in your handler:
> 
> ipipe_unstall_head(); /* enable IRQs (hw-wise and virtually) */
> ...
> ipipe_stall_head(); /* disable IRQs for the head domain */
> 

Works perfect!!!

Thank you




Outbound scan for Spam or Virus by Barracuda at Delta Tau


