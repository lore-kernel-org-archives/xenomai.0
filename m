From: "Leopold Palomo-Avellaneda" <leo@alaxarxa.net>
Date: Sat, 24 Jan 2015 17:56:27 +0000
References: <129277905.Ag2XebZWbK@soho> <1882941.jW5kVZFuDr@indiana>
 <20150123172739.GA12812@hermes.click-hack.org>
In-Reply-To: <20150123172739.GA12812@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201501241756.28192.leo@alaxarxa.net>
Subject: Re: [Xenomai] Packaging Xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

A Divendres, 23 de gener de 2015, Gilles Chanteperdrix va escriure:
> On Fri, Jan 23, 2015 at 05:50:07PM +0100, Leopold Palomo-Avellaneda wrote:
> > El Divendres, 23 de gener de 2015, a les 16:52:31, Gilles Chanteperdrix
> > va
> > 
> > escriure:
> > > On Fri, Jan 23, 2015 at 01:09:41PM +0100, Leopold Palomo-Avellaneda 
wrote:
> > > > Hi,
> > > > 
> > > > now that I have some kernel to boot, I would like to ask some aspects
> > > > of Xenomai-3 in order to package it.
> > > > 
> > > > Reading the documentation, now the new libxenomai could use two kind
> > > > of kernels: the patched one (Cobalt) or the preempt_rt (Mercury).
> > > 
> > > a preempt_rt kernel is a patched kernel too.
> > 
> > Writing the email I thought, both are patches, but I thought preempt_rt
> > was integrated in mainline.
> 
> No it is not.
> 
> > > > 1) Is it possible to have _only_ one library (binary) that uses one
> > > > or another kernel in function which is running?
> > > 
> > > No, you could want to run a kernel with both patches. So basing the
> > > decision on which patch you are running does not make sense.
> > 
> > I don't want to run a kernel with both patches. It has no sense. But I
> > could have binary packages that could work with both kernels. That was
> > my idea.
> 
> To the contrary, it has a lot of sense. You get one grade of
> real-time for cobalt task, and another grade of real-time for tasks
> scheduled by Linux.

Maybe ... it could be interesting as an experiment.

Just for curiosity, have you had the test comparing in mercury and cobalt in 
the same harware with the same problem?

Best regards,

Leopold

