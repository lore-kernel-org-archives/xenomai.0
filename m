Subject: Re: [Adeos-main] [PATCH] remove ipipe_root_domain indirection
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4516C957.60605@domain.hid>
References: <4516C957.60605@domain.hid>
Content-Type: text/plain
Date: Sun, 24 Sep 2006 23:16:01 +0200
Message-Id: <1159132561.4971.44.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org

On Sun, 2006-09-24 at 20:07 +0200, Jan Kiszka wrote:
> This simple patch removes an unneeded indirection by mapping
> ipipe_root_domain to &ipipe_root. Saves more than 7k kernel size with my
> setup here when CONFIG_PREEMPT is enabled, and I bet it requires a few
> cycles less as well.
> 

Merged, thanks.

> Jan
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
-- 
Philippe.



