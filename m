Date: Fri, 4 Dec 2015 14:24:38 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151204132438.GC29398@hermes.click-hack.org>
References: <B7E9A6C055724C8F931591A5C2DD07C8@itd206>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B7E9A6C055724C8F931591A5C2DD07C8@itd206>
Subject: Re: [Xenomai] Reg: Linux assertion
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sureshvs <sureshvs@datapatterns.co.in>
Cc: aditya <aditya.kumar@industeqsite.com>, sureshvsmca@gmail.com, xenomai@xenomai.org

On Fri, Nov 20, 2015 at 12:22:15PM +0530, Sureshvs wrote:
> 
> Hi
> 
> ARCH=powerPC
> Processor: MPC8641
> Linux Kernel : 2.6.30
> Xenomai patch version: xenomai-2.5.2
> 
> 
> We are getting the below assertion randomly.
> 
> kindly help us to isolate the problem, stack trace during assertion is given below.
> 
> 
> ------------[ cut here ]------------
> Badness at a00384e8 [verbose debug info unavailable]

What about enabling more debug infos? Function addresses only make
sense for a particular kernel configuration, so, we can not help you
if we do not know the line of code corresponding to the address.

Also note that xenomai 2.5.2 and Linux 2.6.30 are really old (2010),
so a lot of things have been fixed since then, and it is very
unlikely that we can remember the particular bug you encounter.

-- 
					    Gilles.
https://click-hack.org

