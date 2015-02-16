Date: Mon, 16 Feb 2015 10:25:13 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150216092513.GA1914@hermes.click-hack.org>
References: <CALe7ZU0Y4hb0d7ANK9gitLLaQnGFiH8LpH3ZaTQ5MHLCYjAf=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALe7ZU0Y4hb0d7ANK9gitLLaQnGFiH8LpH3ZaTQ5MHLCYjAf=w@mail.gmail.com>
Subject: Re: [Xenomai] rtdm_irq_request not registering irq
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: JAY KOTHARI <jaikothari10@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On Mon, Feb 16, 2015 at 10:28:51AM +0530, JAY KOTHARI wrote:
> Hello,
>          I am requesting interrupt with rtdm_irq_request. API works
> without error but not irq is not working. When I look into dmesg I get
> back-trace of this API but no error. I even looked in /proc/interrupts
> but no sign of registration. What might be wrong with this API for
> me??

You will not see an interrupt registered with rtdm_irq_request in
/proc/interrupts, /proc/interrupts lists interrupts registered with
request_irq. An interrupt registered with rtdm_irq_request appears
in /proc/xenomai/irq.

Does exactly the same irq number work when requesting it with
request_irq ?

If no, then you may have made an error in the irq number: Linux irqs
are now remapped and the irq number passed to request_irq may not be
the same as the hardware irq number you would expect.

If yes, then are you running xenomai on an arm platform? If yes, we
have a very old bug which has been fixed only recently, normally,
requesting the irq both with request_irq and rtrm_irq_request should
avoid this bug.

-- 
					    Gilles.

