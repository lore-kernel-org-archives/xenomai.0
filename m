From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4E66049D.6000105@domain.hid>
References: <4E63E503.8090206@domain.hid>  <4E66049D.6000105@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 06 Sep 2011 15:27:08 +0200
Message-ID: <1315315628.20820.48.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-help] Xenomai 2.6.0-rc1
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

On Tue, 2011-09-06 at 13:31 +0200, Gilles Chanteperdrix wrote:
> On 09/04/2011 10:52 PM, Gilles Chanteperdrix wrote:
> > 
> > Hi,
> > 
> > The first release candidate for the 2.6.0 version may be downloaded here:
> > 
> > http://download.gna.org/xenomai/testing/xenomai-2.6.0-rc1.tar.bz2
> 
> Hi,
> 
> currently 2.6.0-rc1 fails to build on 2.4 kernel, with errors related to
> vfile support. Do we really want to still support 2.4 kernels?
> 

That would not be a massive loss, but removing linux 2.4 support is more
than a few hunks here and there, so this may not be the right thing to
do ATM. Besides, it would be better not to leave the few linux 2.4 users
out there without upgrade path to xenomai 2.6, since this will be the
last maintained version from the Xenomai 2.x architecture.

That stuff does not compile likely because the Config.in bits are not up
to date, blame it on me. I'll make this build over linux 2.4 and commit
the result today.

-- 
Philippe.



