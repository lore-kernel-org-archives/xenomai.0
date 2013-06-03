From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 3 Jun 2013 14:20:02 -0400
Message-ID: <20130603182002.GS11182@csclub.uwaterloo.ca>
References: <1370278240.95211.YahooMailNeo@web172203.mail.ir2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1370278240.95211.YahooMailNeo@web172203.mail.ir2.yahoo.com>
Subject: Re: [Xenomai] gcc error: posix.wrappers
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Franz Engel <franz_lambert_engel@yahoo.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Jun 03, 2013 at 05:50:40PM +0100, Franz Engel wrote:
> I've a little problem. When I try to compile my code with my new system (xenomai 2.6.2.1) I get the following error:
> gcc: error: ;-Wl,@/usr/xenomai/lib/posix.wrappers: No such file or directory

What is that ';' doing there?  That looks weird.  That would end one
command and make it seem the -Wl... is a command to try and execute,
which is unlikely to work.

The rest of your message is probably just symptoms of the above problem.

-- 
Len Sorensen

