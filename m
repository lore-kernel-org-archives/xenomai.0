Date: Fri, 13 Nov 2015 14:28:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151113132827.GD1820@hermes.click-hack.org>
References: <2396B4D2166B62479FBBE370D4A7C1F30A70A448@mb2010-1.intra.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2396B4D2166B62479FBBE370D4A7C1F30A70A448@mb2010-1.intra.tut.fi>
Subject: Re: [Xenomai] Application creation & compilation tutorial for
 Xenomai 3.0.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Umair Ali <ali.umair@tut.fi>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Nov 13, 2015 at 11:45:51AM +0000, Umair Ali wrote:
> Hello there,
> 
> I am looking for the tutorial that how to make and compile an
> application in user work space and also in kernel work space for
> xenomai 3.0.1. I have read many pages regarding this application
> creation (even on xenomai.org)

You did not read carefully then: running applications in
kernel-space has been deprecated for years, and is no longer
possible with xenomai 3.0.1.

Other than that, the following document:
http://xenomai.org/2014/08/porting-a-linux-application-to-xenomai-dual-kernel/

Explains how to port a Linux application to Xenomai user-space. Of
course it assumes you know how to compile a Linux application. If
you do not know this, I suggest you look for that particular
information on more appropriate sites/forums than on the Xenomai
mailing list.

Regards.

-- 
					    Gilles.
https://click-hack.org

