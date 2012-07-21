Message-ID: <500B2F9F.8020602@xenomai.org>
Date: Sun, 22 Jul 2012 00:39:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F534D1A615F544D95E57BFD8460658301CBE3DF@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
In-Reply-To: <4F534D1A615F544D95E57BFD8460658301CBE3DF@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] switching domains at will
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Jorge Ramirez Ortiz, HCL Europe" <Jorge.Ramirez-Ortiz@hcl.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/21/2012 10:59 PM, Jorge Ramirez Ortiz, HCL Europe wrote:
> 
> Is there an API to switch domains  from a user RT task

For what purpose do you need to do that?

> and  a kernel based task?

kernel based task can not switch domain: they are always running in
xenomai domain, and any call to Linux services will cause mysterious
crashes such as the one you got when calling wake_up from an interrupt
handler (also happening in xenomai domain).



> ::DISCLAIMER:: 
> ----------------------------------------------------------------------------------------------------------------------------------------------------
>
> (...) Any form of reproduction, dissemination, copying,
> disclosure, modification, distribution and / or publication of this
> message without the prior written consent of authorized
> representative of HCL is strictly prohibited. (...)

The only easy way to comply to this part of your disclaimer is to
unsubscribe you from the xenomai mailing list, we are not going to
moderate you and ask HCL representatives if we can publish each of your
posts. If this is not what you want, I suggest you manage to send mails
to the mailing list without the disclaimer.

-- 
                                                                Gilles.

