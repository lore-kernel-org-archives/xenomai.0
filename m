Date: Thu, 8 Jan 2015 16:35:19 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150108153519.GC21505@hermes.click-hack.org>
References: <87BB06E7C07D514A96969FF11282F7954DEB98@MXSTU2012.hpi.uni-potsdam.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87BB06E7C07D514A96969FF11282F7954DEB98@MXSTU2012.hpi.uni-potsdam.de>
Subject: Re: [Xenomai] Is there a specification?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Eichenberg, Marius" <Marius.Eichenberg@student.hpi.uni-potsdam.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Jan 08, 2015 at 03:13:10PM +0000, Eichenberg, Marius wrote:
> Hey folks, 
> we're a team of two students at a university in Germany.
> 
> Currently we're trying to evaluate how easy it is to map tasks
> from Autosar (OSEK) to Xenomai. Therefore we're looking for a
> specification of Xenomai. Right now we're dealing with the API,
> but this is acutally a little bulky.

The API documentation is big because it documents several
interfaces, the underlying common interface as well as several skins
implemented on top of this common interface. But implementing a new
interface such as OSEK means implementing a new skin, on top of the
common interface only.

For Xenomai 2.x, this common interface resides in kernel-space and
is documented here:
https://xenomai.org/documentation/xenomai-2.6/html/api/group__nucleus.html

For Xenomai 3.x (which is recommended for starting a new
development), this common interface moved to user-space, is based on
the POSIX interface and is documented here:
https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__alchemy.html

-- 
					    Gilles.

