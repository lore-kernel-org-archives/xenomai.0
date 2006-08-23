Subject: Re: [Xenomai-core] [PATCH] semicolon delimiters & quotes
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200608231931.43452.paul_c@domain.hid>
References: <200608231931.43452.paul_c@domain.hid>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 20:53:54 +0200
Message-Id: <1156359235.4401.45.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Paul <paul_c@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2006-08-23 at 19:31 +0100, Paul wrote:
> Hi Folks
> 
> Having found a problem with another project where semicolons in a few make 
> targets were causing the shell to barf, I grepped xenomai trunk for similar 
> problems. In doing so, I also spotted a few echos where the text wasn't 
> quoted - A sure fire problem should anyone run the offending rule.
> 
> Small patch attached.
> 

Builds fine. Applied, thanks.

> 
> Regards, Paul.
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



