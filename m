Date: Mon, 4 Jul 2016 19:30:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160704173016.GC9465@hermes.click-hack.org>
References: <3137778ca215b6db6061de83fa64dcae@smile.fr>
 <20160702150226.GC12357@hermes.click-hack.org>
 <304b3c85b2eb4c147b9df3163efcf90a@smile.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <304b3c85b2eb4c147b9df3163efcf90a@smile.fr>
Subject: Re: [Xenomai] RTnet - List corruption when creating packet socket
 two consecutive times
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Geoffrey BONNEVILLE <geoffrey.bonneville@smile.fr>
Cc: xenomai@xenomai.org

On Mon, Jul 04, 2016 at 05:00:38PM +0200, Geoffrey BONNEVILLE wrote:
> Hi,
> 
> I can confirm that your patch fixes the problem. Thank you !

Without loading a drivers which has rtskb_map/unmap, I knew that.
The question is whether it does not cause issue on igb and e1000e,
the two drivers which define these functions.
-- 
					    Gilles.
https://click-hack.org

