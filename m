MIME-Version: 1.0
In-Reply-To: <20160525152057.GC22660@hermes.click-hack.org>
References: <CAJ2oMh+KSW=wGadQ079T+e7M1E3=UG5GY=J8ih61Ez6UHENzWQ@mail.gmail.com>
 <20160525152057.GC22660@hermes.click-hack.org>
Date: Wed, 25 May 2016 18:37:40 +0300
Message-ID: <CAJ2oMh+53g4ru8AXQHTWPKWGfgEHxvG==fqfcUMaK3wGmsg50A@mail.gmail.com>
From: Ran Shalit <ranshalit@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Oops "undefined instruction: 0 [#1] PREEMPT SMP ARM"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, May 25, 2016 at 6:20 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Wed, May 25, 2016 at 11:55:25AM +0300, Ran Shalit wrote:
>> rtdm.c driver is attached here:
>> https://drive.google.com/file/d/0B22GsWueReZTMjZYWlltZFRXU2M/view?usp=sharing
>
> Starting from the "rtdmtest" driver is a bad idea: the rtdmtest
> driver is a unit test for the RTDM driver and contains a lot of code
> which makes no sense out of that context. Better start from the
> "skeleton" drivers in the examples/rtdm/driver-api directory.
>
> As for the cause of the bug, the problem is that you declare
> rtdm_irq_t on stack, which causes its address to point to random
> bytes as soon as it goes out of scope. rtdm_irq_t needs to remain
> valid from the call to rtdm_irq_request to the call to
> rtdm_irq_free.
>

Right ! That was the issue...

Thank you

