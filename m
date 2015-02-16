MIME-Version: 1.0
In-Reply-To: <20150216100128.GC1914@hermes.click-hack.org>
References: <CALe7ZU0Y4hb0d7ANK9gitLLaQnGFiH8LpH3ZaTQ5MHLCYjAf=w@mail.gmail.com>
 <20150216092513.GA1914@hermes.click-hack.org>
 <CALe7ZU0i4UUABx=xQH1jXy9ak+hXkKPz+0d0qYQoQ=zqA780OA@mail.gmail.com>
 <20150216100128.GC1914@hermes.click-hack.org>
Date: Mon, 16 Feb 2015 16:10:56 +0530
Message-ID: <CALe7ZU1MyQpVzY_+7zMWydeSUvQXAU2AD2Xx2jxf_3TKRBX9-A@mail.gmail.com>
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

On 2/16/15, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> On Mon, Feb 16, 2015 at 03:22:07PM +0530, JAY KOTHARI wrote:
>> I am using beaglebone black with Linux 3.8.13 and Xenomai 2.6.3.
>
> There is no reason to use Xenomai 2.6.3, you should be using xenomai
> 2.6.4. Both releases are ABI compatible.
>
>> In
>> the original Linux driver (without RTDM driver) they are implementing
>> same irq_number for request_irq API. So I believe the same irq number
>> must work for rtdm_irq_request in my RTDM driver.
>>
>> I looked into /proc/xenomai/irq my irq is shown registered but its not
>> working.
>>
>> How I use to  request_irq and rtrm_irq_request together to solve this
>> approach?? Do you mean I request irq with both api??
>> Then how do I implement irq handler and get argument like
>> dev_id(request_irq) or void * arg(rtdm_irq_request)????
>
> Please, no top posting. No need for bazillions of question marks
> either.
>
Sorry for it.

> Yes, I mean request the irq with both API, pass a dummy handler to
> request_irq, it will never be called anyway if the handler
> registered with rtdm_irq_request do not return XN_ISR_PROPAGATE.
>

Again I have query about rtdm_irq_request. As my RTDM driver is not
getting interrupted then how will it go into handler of
rtdm_irq_request and return XN_ISR_PROPAGATE? Interrupt is registered
in /proc/xenomai/isr but not responding.

Thank you

Jay Kothari

