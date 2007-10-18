From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <47178DFA.5040703@domain.hid>
References: <47178DFA.5040703@domain.hid>
Content-Type: text/plain
Date: Thu, 18 Oct 2007 19:01:02 +0200
Message-Id: <1192726862.5884.57.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] Latest x86_64 seems to require a fix
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Pierangelo Masarati <masarati@domain.hid>
Cc: adeos-main@gna.org

On Thu, 2007-10-18 at 18:46 +0200, Pierangelo Masarati wrote:
> Dear ADEOS users,
> 
> it seems that a "local_irq_disable_hw();" is required before "return 1;"
> in __ipipe_syscall_root() in the latest patches (e.g. the 1.2 series),
> otherwise user-space applications could fail badly.
> 

Indeed. Fixed, thanks.

> Sincerely, p.
> 
> 
> 
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
-- 
Philippe.



