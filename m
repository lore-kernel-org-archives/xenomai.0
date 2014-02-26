Message-ID: <530E60C2.6010509@xenomai.org>
Date: Wed, 26 Feb 2014 22:46:42 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAEbDrgkifqMcqqEqh5hKA90YzFzcyDxLHFC79F8CWvZi5heyWQ@mail.gmail.com>
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
 <530D365F.5010606@xenomai.org>
 <CAEbDrgk+zkgSY4xGu-bD25Dy+6_ncnLbS0+jhkGZ55EY1SYPfA@mail.gmail.com>
In-Reply-To: <CAEbDrgk+zkgSY4xGu-bD25Dy+6_ncnLbS0+jhkGZ55EY1SYPfA@mail.gmail.com>
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

On 02/26/2014 11:00 AM, Gregory Dymarek wrote:
> I will have a look later on. However this makes me question, why to spend
> time fixing old kernel if there are already ipipe patches for 3.10.
> Shouldn't we try to do this for the more recent kernel 3.10 so this can be
> eventually incorporated into Xenomai? or this not that straight forward?

Well, the local_fiq_enable/local_fiq_disable fix will apply to 3.10 as
well, and chances are that the second issue is there on 3.10, since it
has not been fixed.


-- 
                                                                Gilles.

