Date: Tue, 28 Apr 2015 18:02:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150428160255.GD1993@hermes.click-hack.org>
References: <CADvZd9azLVdxYd8gy4BwT8Fh1LixV_=vbZoAAZegJ+rAut8mng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvZd9azLVdxYd8gy4BwT8Fh1LixV_=vbZoAAZegJ+rAut8mng@mail.gmail.com>
Subject: Re: [Xenomai] RT-CAN driver for C_CAN,D_CAN cores ready
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <haberlerm@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On Tue, Apr 28, 2015 at 05:47:40PM +0200, Michael Haberler wrote:
> as requested:

This is a mess, really, you add files to remove them later.

A patch should be against Xenomai sources, and for adding a driver
it should only add file or modify existing files.

Second point, the indentation, Xenomai follows the linux kernel
rules where the indentation "unit" is a tab characters which should
be displayed as 8 spaces by diff. Here your indentation seems to be
one space (maybe your mailer did that ?).

A smaller patch means an easier review.

-- 
					    Gilles.

