From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 21 Jan 2015 09:37:38 -0500
Message-ID: <20150121143737.GH30245@csclub.uwaterloo.ca>
References: <6773858.JgE1vlCdur@soho> <2621675.LcrfARJh6l@soho>
 <ce8779a9a03f5c7fbe48cf43e334f44c.squirrel@xenomai.org>
 <15627875.xOGqqJnifV@soho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15627875.xOGqqJnifV@soho>
Subject: Re: [Xenomai] Compiling xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Jan 21, 2015 at 02:44:59PM +0100, Leopold Palomo-Avellaneda wrote:
> it fails when I execute the debian command. But it works when I just execute  
> make bzImage modules.
> 
> So, I don't think that it could be prepare-kernel.sh script

Which kernel version and which make-kpkg version?  Could be the make-kpkg
is too old for the kernel version.

I hadn't noticed xenomai support for 3.16 yet either, only 3.14, but I
haven't checked lately.

-- 
Len Sorensen

