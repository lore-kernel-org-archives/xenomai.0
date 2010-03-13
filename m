From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B9BC504.8070704@domain.hid>
References: <1268327902.27899.106.camel@domain.hid>
	<4B9BC504.8070704@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 13 Mar 2010 19:22:16 +0100
Message-ID: <1268504536.27899.168.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PULL REQUEST] Blackfin upgrade and minor fixes
	for 2.5.x
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Sat, 2010-03-13 at 18:01 +0100, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > The following changes since commit 55b0aa9de28891fcfd4b4ab097583bd7619223ab:
> >   Philippe Gerum (1):
> >         native: introduce rt_task_same()
> > 
> > are available in the git repository at:
> > 
> >   git://xenomai.org/xenomai-rpm.git for-upstream
> > 
> > Philippe Gerum (5):
> >       testsuite/latency: fix false positive in mode switch detection
> >       powerpc: remove dandling reference
> >       blackfin: upgrade I-pipe support to 2.6.33-blackfin-1.13-00
> 
> Could you upgrade the blackfin README file to include the tag to use,
> for applying this patch?
> 

No more tag, it's now based on mainline like powerpc. That is stated
into the revised README committed with that patch.


-- 
Philippe.



