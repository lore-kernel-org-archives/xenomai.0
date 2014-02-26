Message-ID: <530D365F.5010606@xenomai.org>
Date: Wed, 26 Feb 2014 01:33:35 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAEbDrgkifqMcqqEqh5hKA90YzFzcyDxLHFC79F8CWvZi5heyWQ@mail.gmail.com>
 <530A8767.4030004@xenomai.org>
 <CAEbDrgmf+RtS5gS5SKO7eq66ge-LHoJ0hTOC=yeRmUgk0MXqog@mail.gmail.com>
 <530BC103.3010809@xenomai.org>
 <CAEbDrgnFr7YvfoMmFQx=PBKSFEWvwJftx0wZx39ySMqRO2X6gQ@mail.gmail.com>
 <530CFB0D.8040001@xenomai.org>
 <CAEbDrgkJCnbWu_J4svoXOU1x2rz=n95A5+3Ee=R_9CpMgx-JmA@mail.gmail.com>
 <530CFC27.5050700@xenomai.org>
 <CAEbDrgnmM_dD3WX42PYawhkW8zTaYczzfozEe1EX7Z5HnERz3g@mail.gmail.com>
 <530D0205.9050406@xenomai.org>
 <CAEbDrgmwch94crHAcrbJDj9MxaiBNaYeLH2U9NtS0tuJKmdDDw@mail.gmail.com>
 <530D0BBD.6070704@xenomai.org>
 <CAK4EZFR_L+=-LtSVHkvZ36rPOA8ViVboB9M9rf4Yqk=crfBotw@mail.gmail.com>
 <CAEbDrgk=yrGq8KdpdN8e7RtO7qUpWTtwRXhrg0A0=KbDjqoDng@mail.gmail.com>
 <CAK4EZFRm-jd=0VrEjFVjE_h7dWu8nEBVi=HQijkgWXu2MBiPNQ@mail.gmail.com>
 <CAK4EZFRerL7yrqD+nKzp0DyvYFvv+gxpBVqzKWbeyy2vbspiAg@mail.gmail.com>
 <CAEbDrgkAus9KtTHiP6_n6+JoA5geg2yX0ELdU3yBEZyCmH=XrQ@mail.gmail.com>
In-Reply-To: <CAEbDrgkAus9KtTHiP6_n6+JoA5geg2yX0ELdU3yBEZyCmH=XrQ@mail.gmail.com>
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
To: Gregory Dymarek <gregd72002@gmail.com>
Cc: xenomai@xenomai.org

On 02/26/2014 01:12 AM, Gregory Dymarek wrote:
> Adam, when i try to boot with a usb mass storage i got also the same
> warning. I'm running with FIQ disabled and on version A board.
> 
> What kernel version are you using Adam? Are there any other patches that
> you enabled?
> 
> I guess this also might be down to the kernel configuration. I'm now
> running with a full debug, don't know if this can affect the result.

If the same issue does not happen without xenomai, then the issue is
most likely due to the I-pipe patch or xenomai. fiq_print is probably
broken if FIQ_DEBUG is enabled, but if you did not enable it, I see
nothing else that could go wrong. So, I would say the I-pipe tracer will
tell us.

-- 
                                                                Gilles.

