MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17411.5135.897479.800009@domain.hid>
Date: Mon, 27 Feb 2006 16:00:31 +0100
Subject: Re: [Xenomai-core] [BUG] prepare-kernel is broken
In-Reply-To: <44031010.7010407@domain.hid>
References: <4402FA52.3080606@domain.hid>
	<17411.1445.159527.784570@domain.hid>
	<44031010.7010407@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > Gilles Chanteperdrix wrote:
 > > Jan Kiszka wrote:
 > >  > Hi,
 > >  > 
 > >  > the last check-in seems to have messed something up:
 > >  > 
 > >  > .../xenomai/scripts/prepare-kernel.sh: line 61: syntax error near
 > >  > unexpected token `fi'
 > >  > 
 > >  > I do not understand what's going on here, so I don't want to hack some
 > >  > probably wrong fix for this.
 > > 
 > > In order to have it work, I had to make the following changes to
 > > revision 610 :
 > > 
 > 
 > We seem to use different find versions:

What about revision 614 ?

-- 


					    Gilles Chanteperdrix.

