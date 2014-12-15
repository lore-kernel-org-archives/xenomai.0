Date: Mon, 15 Dec 2014 21:49:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141215204954.GQ11058@hermes.click-hack.org>
References: <548ed95828a095.41388325@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <548ed95828a095.41388325@wp.pl>
Subject: Re: [Xenomai] RTnet compilation issues with kernel above 3.10
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mariusz Janiak <mariuszjaniak@wp.pl>
Cc: Xenomai <xenomai@xenomai.org>

On Mon, Dec 15, 2014 at 01:51:36PM +0100, Mariusz Janiak wrote:
> Hi,
> 
> I have prepared a patch that should fix the RTnet compilation
> issues on a kernel 3.10 and higher, especially the latest
> supported 3.14.17 by the Xenomai 2.6.4. It is based on the Anders
> Blomdell patch
> 
> http://sourceforge.net/p/rtnet/mailman/message/32034653/
> 
> supplemented with missing parts. Patch should be applied to
> original RTnet git repository.

That is nice, but if it is true that we said we were going to
maintain RTnet in Xenomai 3.x, we did not say such thing for RTnet
for Xenomai 2.6.4. So the patch should be sent to the rtnet mailing
list.

-- 
					    Gilles.

