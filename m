Message-ID: <531380BA.70006@xenomai.org>
Date: Sun, 02 Mar 2014 20:04:26 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAEbDrgkifqMcqqEqh5hKA90YzFzcyDxLHFC79F8CWvZi5heyWQ@mail.gmail.com>
 <530D0BBD.6070704@xenomai.org>
 <CAK4EZFR_L+=-LtSVHkvZ36rPOA8ViVboB9M9rf4Yqk=crfBotw@mail.gmail.com>
 <CAEbDrgk=yrGq8KdpdN8e7RtO7qUpWTtwRXhrg0A0=KbDjqoDng@mail.gmail.com>
 <530D2C92.9010607@xenomai.org>
 <CAEbDrgkWZqSxjCUfjR3YCp=YOzh1r-=YC6Wyr-Jvk9d7JYEcmQ@mail.gmail.com>
 <530E6159.4050204@xenomai.org>
 <CAEbDrgmo==15Zar2X=yz=wBL3pJ4DOiqKy2xx43UPxuu6_5LhA@mail.gmail.com>
 <530F17EC.6020204@xenomai.org>
 <CAEbDrgnq46OJ6bi1FCQmC8JBWhSA6o=M9K=fg4x4hq3JpwcBjw@mail.gmail.com>
 <530F9CA2.2040601@xenomai.org>
 <CAEbDrgmLq08Xq5Cgt7oXX3koQDr+HVx_JS-7Nn_pC53rmTTV-g@mail.gmail.com>
 <531075E7.7060107@xenomai.org>
 <CAEbDrgmQNRjaTEm5TvM93Yy3k+fa+QRETFzXdM3bz8=-N15DPQ@mail.gmail.com>
 <53134A2E.1000406@xenomai.org>
 <CAEbDrgmB4vZ0TPrD2-_-vR8bDwYXLKL2fMdNzFZWGsoiK9ZBDQ@mail.gmail.com>
 <53137581.5060600@xenomai.org>
 <CAEbDrg=2nX1kKOGt6i7b-w5AsLXkEyoJCGUMw1dkMXvka4MeKw@mail.gmail.com>
 <53137F18.3020409@xenomai.org>
In-Reply-To: <53137F18.3020409@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RaspberryPi kernel 3.8 issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gregory Dymarek <gregd72002@gmail.com>, Xenomai <xenomai@xenomai.org>

On 03/02/2014 07:57 PM, Gilles Chanteperdrix wrote:
> On 03/02/2014 07:54 PM, Gregory Dymarek wrote:
>> This works!!
>>
>> I thought xenomai does not deal with fiq. Why is it required to enable them
>> in the driver when having xenomai on?
> 
> Because without CONFIG_IPIPE local_irq_restore deals with FIQs
> With CONFIG_IPIPE local_irq_restore does not deal with FIQs
> 
> We can of course rework local_irq_restore to take into account FIQs with
> CONFIG_IPIPE, but that would make local_irq_restore heavier in a lot of
> places, whereas there are in fact only three spots to fix, for only one SOC.
> 
> 
BTW, using FIQs for USB means that USB activity will be able to
influence xenomai latencies. So, it is really not recommended, if there
is a configuration option for disabling the use of FIQ with this driver,
this should be recommended for use with xenomai.

-- 
                                                                Gilles.

