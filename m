MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17705.18090.626766.823503@domain.hid>
Date: Sun, 8 Oct 2006 20:42:50 +0200
Subject: Re: [Xenomai-help] Native API manual in PDF format?
In-Reply-To: <45293CC0.8040204@domain.hid>
References: <F75B1CC921BD8E43B7D0484C9AB4C490450F83@domain.hid>
	<4512E4A3.9050303@domain.hid>
	<17705.13155.675021.10130@domain.hid>
	<45293CC0.8040204@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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
Cc: xenomai@xenomai.org, David Betz <david.betz@domain.hid>

Jan Kiszka wrote:
 > Gilles Chanteperdrix wrote:
 > > Jan Kiszka wrote:
 > >  > David Betz wrote:
 > >  > > Is there a PDF version of the Native API manual available? I'd like to
 > >  > > be able to print a copy for reference.
 > >  > 
 > >  > You can generate your own version: Set "GENERATE_LATEX = YES" in
 > >  > doc/doxygen/Doxygen.in, build the documentation (don't forget to enable
 > >  > it on configure), go to doc/doxygen/latex in your build directory and
 > >  > run "make". The result is refman.pdf, a >500 pages monster (2.5M) that
 > >  > looks rather unhandy to me. Maybe one can tune things and drop out
 > >  > parts, you may want to play a bit with doxygen.
 > > 
 > > I split the 500 pages monster into four parts; nucleus, native skin,
 > > rtdm skin and posix skin. I temporarily put them at the address:
 > > http://download.gna.org/xenomai/doxygen/
 > > 
 > > If nobody dislikes them, they could be commited in the repository.
 > > 
 > 
 > That would also mean we are going to keep them in sync with new release,
 > i.e. you can generate them automatically? Then I'm all for it! I just
 > want to avoid the RTAI effect: documentation all over the place, but
 > mostly decades old, useless, and -even worse- confusing.

It is automated, but takes a looong time, doxygen is run five
times. My question was rather about the documents themselves,
whether people find them handy or not.

-- 


					    Gilles Chanteperdrix.

