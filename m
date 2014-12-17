Date: Wed, 17 Dec 2014 11:31:18 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141217103118.GB7151@hermes.click-hack.org>
References: <5490A954.8040207@nta-inc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5490A954.8040207@nta-inc.net>
Subject: Re: [Xenomai] Add "rtroute solicit" support to the rtnet script and
 rtnet.conf
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Webb <jeff.webb@nta-inc.net>
Cc: rtnet-users@lists.sourceforge.net, Xenomai <xenomai@xenomai.org>

On Tue, Dec 16, 2014 at 03:51:16PM -0600, Jeff Webb wrote:
> I am using rtnet without rtmac/tdma. I previously sent a patch
> that allows one to use the "rtnet" script and rtnet.conf in this
> configuration. I would also like to be able to specify a list of
> IP addresses in rtnet.conf that are passed along to "rtroute
> solicit". I have attached patches for the rtnet and
> xenomai-3.git/next repositories. I think others will find them
> useful.

Well, you should probably be using "nomac" if you are not interested
in tdma.

-- 
					    Gilles.

