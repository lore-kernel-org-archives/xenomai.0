Message-ID: <53134A2E.1000406@xenomai.org>
Date: Sun, 02 Mar 2014 16:11:42 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAEbDrgkifqMcqqEqh5hKA90YzFzcyDxLHFC79F8CWvZi5heyWQ@mail.gmail.com>
 <530CFC27.5050700@xenomai.org>
 <CAEbDrgnmM_dD3WX42PYawhkW8zTaYczzfozEe1EX7Z5HnERz3g@mail.gmail.com>
 <530D0205.9050406@xenomai.org>
 <CAEbDrgmwch94crHAcrbJDj9MxaiBNaYeLH2U9NtS0tuJKmdDDw@mail.gmail.com>
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
In-Reply-To: <CAEbDrgmQNRjaTEm5TvM93Yy3k+fa+QRETFzXdM3bz8=-N15DPQ@mail.gmail.com>
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

On 03/01/2014 01:27 PM, Gregory Dymarek wrote:
> Hi Gilles,
> 
> Uploaded a new trace in here with them being reduced to 10 and 9
> respectively:
>  https://github.com/gregd72002/rpicopter/blob/master/tmp/frozen

Hi Gregory,

we see what happens before the irq storm, but unfortunately, this looks
like the USB driver is at fault. A transfer is programmed, a little bit
later the irq is received while the root domain is stalled, so is
logged, a little bit later the root domain is unstalled and the log
played, at the end it is unmasked and it triggers again. From the error
that occur we know that the irq handler returned IRQ_NONE, so did not
acknowledged the irq at device level, so it makes perfect sense that the
irq triggers again.

In order to go further, we would have to understand how the driver
works, but it is something that is hard to do by proxy.

The question is: are you sure that the same issue does not happen with
the exact same configuration, except without Xenomai (and without
CONFIG_IPIPE)?

Regards.

-- 
                                                                Gilles.

