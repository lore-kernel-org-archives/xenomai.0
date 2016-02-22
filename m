Sender: Michael Welling <mwelling79@gmail.com>
Date: Mon, 22 Feb 2016 15:29:44 -0600
From: Michael Welling <mwelling@ieee.org>
Message-ID: <20160222212944.GA14055@deathstar>
References: <56C57320.8060002@sigmatek.at> <20160218161047.GA10005@deathstar>
 <20160222175341.GA22349@deathstar> <56CB4DF8.2010802@siemens.com>
 <20160222190431.GB22349@deathstar> <56CB5E84.1010803@siemens.com>
 <20160222205139.GA7819@deathstar>
 <20160222210227.GG7398@hermes.click-hack.org>
 <20160222211059.GB7819@deathstar>
 <20160222211439.GH7398@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160222211439.GH7398@hermes.click-hack.org>
Subject: Re: [Xenomai] RT serial cross-link failure
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: mwelling79@gmail.com, Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On Mon, Feb 22, 2016 at 10:14:39PM +0100, Gilles Chanteperdrix wrote:
> > > > Why in the world would -ETIMEDOUT come out as Operation not permitted?
> > > 
> > > Because EPERM is -1. ioctl return -1 upon error and the "real" error
> > > status is found in errno. So, in fact, the test should check errno
> > > if err is not 0.
> > 
> > Ah I see it now. Would you like a patch for the cross-link demo?
> 
> Yes, thanks.

Sent.

Would you like a properly formed patch for the imx uart driver?

> 
> -- 
> 					    Gilles.
> https://click-hack.org

