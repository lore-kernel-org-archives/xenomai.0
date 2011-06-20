Message-ID: <4DFF5FEE.8060901@domain.hid>
Date: Mon, 20 Jun 2011 16:57:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <f801f3950e5f79192ebc8824bfd54545@domain.hid>
In-Reply-To: <f801f3950e5f79192ebc8824bfd54545@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] mprotect in Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michael Thalmeier <michael@domain.hid>
Cc: xenomai@xenomai.org

On 06/20/2011 04:14 PM, Michael Thalmeier wrote:
>  Hello !
> 
>  We have a xenomai application that uses mprotect to change write 
>  protection in order to set and clear breakpoint codes.
>  This works quite well (the code invoking mprotect switches to linux, 
>  but thats ok).
>  The problem is that from time to time the realtime task executing code 
>  in the area changed with mprotect also switches domains to handle a page 
>  fault.
>  Is there some functionality in xenomai to change memory protection not 
>  using mprotect ?
>  Attached you find a short sample that can reproduce this problem.

I am afraid this is platform dependent, on what architecture do you get
this behaviour?

-- 
					    Gilles.

