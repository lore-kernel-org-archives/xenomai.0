From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <alpine.DEB.2.00.0907242259430.4343@domain.hid>
References: <Pine.LNX.4.62.0907241731170.11473@domain.hid>
	<1248453047.3998.168.camel@domain.hid>
	<alpine.DEB.2.00.0907241917480.4343@domain.hid>
	<1248461458.3998.183.camel@domain.hid>
	<alpine.DEB.2.00.0907242259430.4343@domain.hid>
Content-Type: text/plain
Date: Sat, 25 Jul 2009 12:33:06 +0200
Message-Id: <1248517986.4438.1.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] POSIX skin/Blackfin: SIGSEGV when stracing or
 gdb'ing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenoka09@domain.hid
Cc: xenomai@xenomai.org

On Fri, 2009-07-24 at 23:09 +0200, Waschk,Kolja wrote:
> Hi,
> 
> > git://git.kernel.org/pub/scm/linux/kernel/git/vapier/blackfin.git
> > git://sources.blackfin.uclinux.org/git/readonly-mirrors/uclinux-dist.git
> 
> Okay, that's where I looked but both returned 403 Unknown (on the web
> interface) when I tried the numbers you quoted, i.e.
> 
> http://git.kernel.org/?p=linux/kernel/git/vapier/blackfin.git;a=commit;h=015153eee3851d2c485a85814888f031f3794cf4
> 
> or
> 
> http://blackfin.uclinux.org/git/?p=readonly-mirrors/uclinux-dist.git;a=commit;h=2137ff7920b51643c5c84536fe99fe7c5904498a
> 

Mmf, try this one instead, I mistakenly sent you the top commit # from
my local dev branch, the following tags a commit in trunk/ as expected
(June 20) :
2e17eba8a5b0b2ce3cbd57b68bbb04e028f4260a

> but for the tools the number seems valid
> 
> https://blackfin.uclinux.org/git/?p=readonly-mirrors/toolchain.git;a=commit;h=ce79f3d5449c78877e66965584c55a132d73d4e1
> 
> I'll try again with git locally.
> 
> Thanks for all the information
> 
> Kolja
> 
-- 
Philippe.



