MIME-Version: 1.0
Sender: bodgesoc@gmail.com
In-Reply-To: <52D8609C.5050903@xenomai.org>
References: <CAN1+YZVvgPNNHFub5QAkw6SeSUPuf1dv_94kYGqhbjMpNt70Sg@mail.gmail.com>
 <CAN1+YZWOjxf=s+6LH3Xymzx_mwWa6XmO_Xt7SHF589RzJCANBA@mail.gmail.com>
 <52D8609C.5050903@xenomai.org>
From: Andy Pugh <andy@bodgesoc.org>
Date: Thu, 16 Jan 2014 23:17:34 +0000
Message-ID: <CAN1+YZW+nJgMb0hLy2JWZW6JrxA+mZzA+-oN-gjQgeGTcoe0jg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Fwd: Kernel Compilation Problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>

On 16 January 2014 22:43, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

>
> The pre- and post- patches are for the freescale tree. If the Udoo tree
> is not based on the freescale tree, there is no reason to add the pre
> and post patches.


I think it must have been at some point. The main adeos patch "took"
cleanly after forcing the ..pre.patch, and not at all without it.


> You are probably better off following the I-pipe
> porting guide, and add support for the imx6 yourself


Unfortunately that is probably rather outside my skill level, but I might
return to that if my current plan fails (which is making a patch of all the
changes in the Udoo github, and seeing if those will apply to my working
xenomai/arm kernel

>
> > I am pretty sure that there really isn't any function anywhere called
> > "`imx_pcm_preallocate_dma_buffer.constprop.8"
>

Does the
>  unpatched kernel, with exactly the same configuration, compile correctly?
>

Yes it does, which is why it seemed like a promising starting-point.


-- 
atp
