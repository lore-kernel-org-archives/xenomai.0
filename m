Message-ID: <491B00C6.7000806@domain.hid>
Date: Wed, 12 Nov 2008 17:13:58 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20081112152249.GA7849@domain.hid>
In-Reply-To: <20081112152249.GA7849@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] CSP style channels on Xenomai
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tom Schouten <tom@domain.hid>
Cc: xenomai@xenomai.org

Tom Schouten wrote:
> Hello,
> 
> Somewhat related to the question on RPC (thanks for replies).
> 
> What would be the simplest and/or most efficient way to implement Occam 
> style channels on Xenomai? (Hoare's CSP).  Did anyone try this already?
>

Depends on the skin you want to use, but native API RT_EVENT's would provide the
basic semantics for kind of barrier synchronization.

> Cheers,
> Tom
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.

