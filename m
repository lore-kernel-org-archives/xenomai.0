MIME-Version: 1.0
In-Reply-To: <20150216092513.GA1914@hermes.click-hack.org>
References: <CALe7ZU0Y4hb0d7ANK9gitLLaQnGFiH8LpH3ZaTQ5MHLCYjAf=w@mail.gmail.com>
 <20150216092513.GA1914@hermes.click-hack.org>
Date: Mon, 16 Feb 2015 15:22:07 +0530
Message-ID: <CALe7ZU0i4UUABx=xQH1jXy9ak+hXkKPz+0d0qYQoQ=zqA780OA@mail.gmail.com>
From: JAY KOTHARI <jaikothari10@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] rtdm_irq_request not registering irq
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

I am using beaglebone black with Linux 3.8.13 and Xenomai 2.6.3. In
the original Linux driver (without RTDM driver) they are implementing
same irq_number for request_irq API. So I believe the same irq number
must work for rtdm_irq_request in my RTDM driver.

I looked into /proc/xenomai/irq my irq is shown registered but its not working.

How I use to  request_irq and rtrm_irq_request together to solve this
approach?? Do you mean I request irq with both api??
Then how do I implement irq handler and get argument like
dev_id(request_irq) or void * arg(rtdm_irq_request)????

Jay Kothari

On 2/16/15, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> On Mon, Feb 16, 2015 at 10:28:51AM +0530, JAY KOTHARI wrote:
>> Hello,
>>          I am requesting interrupt with rtdm_irq_request. API works
>> without error but not irq is not working. When I look into dmesg I get
>> back-trace of this API but no error. I even looked in /proc/interrupts
>> but no sign of registration. What might be wrong with this API for
>> me??
>
> You will not see an interrupt registered with rtdm_irq_request in
> /proc/interrupts, /proc/interrupts lists interrupts registered with
> request_irq. An interrupt registered with rtdm_irq_request appears
> in /proc/xenomai/irq.
>
> Does exactly the same irq number work when requesting it with
> request_irq ?
>
> If no, then you may have made an error in the irq number: Linux irqs
> are now remapped and the irq number passed to request_irq may not be
> the same as the hardware irq number you would expect.
>
> If yes, then are you running xenomai on an arm platform? If yes, we
> have a very old bug which has been fixed only recently, normally,
> requesting the irq both with request_irq and rtrm_irq_request should
> avoid this bug.
>
> --
> 					    Gilles.
>

