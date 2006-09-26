Subject: Re: [Xenomai-core] Problem with periodic timer on PPC40x solved
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200609252315.38689.niklaus.giger@domain.hid>
References: <200609232013.27649.niklaus.giger@domain.hid>
	<200609252229.56854.niklaus.giger@domain.hid>
	<1159217987.4981.10.camel@domain.hid>
	<200609252315.38689.niklaus.giger@domain.hid>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 08:59:42 +0200
Message-Id: <1159253982.5084.4.camel@domain.hid>
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
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

On Mon, 2006-09-25 at 23:15 +0200, Niklaus Giger wrote:
> Am Montag, 25. September 2006 22:59 schrieb Philippe Gerum:
> > On Mon, 2006-09-25 at 22:29 +0200, Niklaus Giger wrote:
> > > Am Montag, 25. September 2006 17:57 schrieb Philippe Gerum:
> > > > On Sun, 2006-09-24 at 23:07 +0200, Wolfgang Grandegger wrote:
> > > > > Niklaus Giger wrote:
> <..>
> > > Is the output of lines like "Xenomai: Switching display-3238 to secondary
> > > mode after exception #1025 from user-space at 0x100033c4 (pid 3240)"
> > > harmless or the result of a activated CONFIG_XENO_OPT_DEBUG<..> option?
> >
> > Oops. It's bad news. A memory access error occured while running the
> > test. Which Xenomai/Adeos combo are you currently running on the 4xx?
> 
> adeos-ipipe-2.6.14-ppc-1.4-00.patch
> 
> Shall I use my BDI (tomorrow evening) to get a stack trace of it? Or something 
> else you would like to see?

It would be great if you could first run the very same Xenomai config
over Adeos 1.3-07 instead of 1.4-00, just to see if the issue is still
there on the 4xx. After that, a BDI trace would be nice to have when
time permits.

>  
> Best regards
> 
-- 
Philippe.



