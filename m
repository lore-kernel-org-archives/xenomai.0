Date: Wed, 25 Aug 2010 14:00:31 -0400
From: Edward Hoffman <quantalgo@domain.hid>
In-reply-to: <1282748372.2845.2.camel@domain.hid>
Message-id: <1282759231.5566.3.camel@domain.hid>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <4C73EC62.80703@domain.hid> <1282703799.2170.4.camel@domain.hid>
	<4C74C059.4090704@domain.hid> <1282748002.1995.2.camel@domain.hid>
	<1282748372.2845.2.camel@domain.hid>
Subject: Re: [Xenomai-help] [RFT] ipipe patch for 2.6.35.3-x86
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, adeos-main <adeos-main@gna.org>

Jan,

I reconfigured the linux-2.6.35.3 kernel (32-bit) after applying the
adeos kernel patch.  All I get when I reboot is a black screen with a
blinking cursor.

Any suggestions.

Ed




On Wed, 2010-08-25 at 10:59 -0400, Edward Hoffman wrote:
> Jan,
> 
> Please ignore my e-mal below.
> 
> I must have missed that second cup of coffee this morning. I forget to
> decompress the patch.  I have applied it to the kernel and I am building
> it now.
> 
> Ed
> 
> 
> 
> On Wed, 2010-08-25 at 10:53 -0400, Edward Hoffman wrote:
> > Jan,
> > 
> > I tried applying the patch.  It appears to be corrupted:
> > 
> > root@domain.hid# scripts/prepare-kernel.sh
> > Linux tree
> > [default /lib/modules/2.6.35.1/source]: /usr/src/linux-2.6.35.3
> > Target architecture [default i686]: 
> > Adeos patch
> > [default /usr/src/xenomai-2.5.4/ksrc/arch/x86/patches/adeos-ipipe-2.6.35.3-x86-test1.patch.bz2]: 
> > patch unexpectedly ends in middle of line
> > patch: **** Only garbage was found in the patch input.
> > prepare-kernel.sh: Unable to patch kernel 2.6.35.3 with
> > adeos-ipipe-2.6.35.3-x86-test1.patch.bz2.
> > 
> > 
> > Please forward a new patch.
> > 
> > Thanks.
> > 
> > RSVP.
> > 
> > 
> > Ed
> > 
> > 
> > 
> > On Wed, 2010-08-25 at 09:03 +0200, Jan Kiszka wrote:
> > > Edward Hoffman wrote:
> > > > I do not have a git repository setup.  Where can I download a version of
> > > > the patch that to put in the xenomai-2.5.4 patches directory?
> > > 
> > > Find it attached.
> > > 
> > > > 
> > > > I will then rebuild the 2.6.35.3 32-bit kernel and provide you with
> > > > feedback.
> > > 
> > > TIA,
> > > Jan
> > > 
> > > > 
> > > > RSVP.
> > > > 
> > > > Ed
> > > > 
> > > > On Tue, 2010-08-24 at 17:59 +0200, Jan Kiszka wrote:
> > > >> Hi,
> > > >>
> > > >> just uploaded a forward port of the 2.6.34 ipipe patch for x86 to latest
> > > >> stable 2.6.35.3. It boots and runs fine here in 64-bit mode with Xenomai
> > > >> head, but I only ran light tests so far. Anyone interested in upgrading
> > > >> the host kernel (I think I read some request recently) is welcome to
> > > >> give it a try and report results back (specifically on 32 bit as that is
> > > >> a bit out of focus for me ATM). You can download the full git tree from
> > > >>
> > > >> 	git://git.kiszka.org/ipipe-2.6.git queues/2.6.35-x86
> > > >> 	(alternatively also via http://)
> > > >>
> > > >> Looking forward to feedback,
> > > >> Jan
> > > >>
> > > > 
> > > > 
> > > 
> > 
> 



