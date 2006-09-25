From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Problem with periodic timer on PPC40x solved
Date: Mon, 25 Sep 2006 23:15:38 +0200
References: <200609232013.27649.niklaus.giger@domain.hid>
	<200609252229.56854.niklaus.giger@domain.hid>
	<1159217987.4981.10.camel@domain.hid>
In-Reply-To: <1159217987.4981.10.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609252315.38689.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Am Montag, 25. September 2006 22:59 schrieb Philippe Gerum:
> On Mon, 2006-09-25 at 22:29 +0200, Niklaus Giger wrote:
> > Am Montag, 25. September 2006 17:57 schrieb Philippe Gerum:
> > > On Sun, 2006-09-24 at 23:07 +0200, Wolfgang Grandegger wrote:
> > > > Niklaus Giger wrote:
<..>
> > Is the output of lines like "Xenomai: Switching display-3238 to secondary
> > mode after exception #1025 from user-space at 0x100033c4 (pid 3240)"
> > harmless or the result of a activated CONFIG_XENO_OPT_DEBUG<..> option?
>
> Oops. It's bad news. A memory access error occured while running the
> test. Which Xenomai/Adeos combo are you currently running on the 4xx?

adeos-ipipe-2.6.14-ppc-1.4-00.patch

Shall I use my BDI (tomorrow evening) to get a stack trace of it? Or something 
else you would like to see?
 
Best regards

-- 
Niklaus Giger

