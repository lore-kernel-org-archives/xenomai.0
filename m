Message-ID: <490873B2.2020809@domain.hid>
Date: Wed, 29 Oct 2008 15:31:14 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20081029141527.GA13565@domain.hid>
In-Reply-To: <20081029141527.GA13565@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_sem_p() -> -ESRCH
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
> Hello list,
> 
> What's the meaning of rt_sem_p() returning -ESRCH (No such process) ?
> This return value doesn't seem to be in the list of documented values..
> 
> This appeared after upgrading to current SVN trunk.
>

There is likely a mismatch between your userland support and the kernel bits.
The ABI changed once more in the trunk recently, did you rebuild the userland
Xenomai libs to match the new one?

> Cheers,
> Tom
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.

