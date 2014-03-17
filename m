From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 17 Mar 2014 12:34:17 -0400
Message-ID: <20140317163417.GE17765@csclub.uwaterloo.ca>
References: <20140317155912.GC17765@csclub.uwaterloo.ca>
 <53271E68.6020502@xenomai.org>
 <20140317162736.GD17765@csclub.uwaterloo.ca>
 <5327231B.8010809@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5327231B.8010809@xenomai.org>
Subject: Re: [Xenomai] xenomai 2.6.3 build failure on armhf
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

On Mon, Mar 17, 2014 at 05:30:19PM +0100, Gilles Chanteperdrix wrote:
> On 03/17/2014 05:27 PM, Lennart Sorensen wrote:
> >Hmm, so Debian's version of debian/rules has this:
> >
> ># necessary from GCC 4.6 on
> >CFLAGS += -fno-omit-frame-pointer
> >
> >I wonder if they are wrong.
> 
> Here we maintain our version of debian/rules, not Debian's, which
> unfortunately contains a lot of cruft like this.

Well commenting out the line did not appear to break compiling on powerpc
or i386, but it did fix compiling for armhf.

Excellent suggestion.

-- 
Len Sorensen

