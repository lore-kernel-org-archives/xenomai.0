From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 17 Oct 2013 11:00:12 -0400
Message-ID: <20131017150012.GM13097@csclub.uwaterloo.ca>
References: <CAEk6gTAj51aYJiCLVx+4-O_tnxfyyPvtLZO-hFVZvS+WjBpDtg@mail.gmail.com>
	<525EC963.2000005@xenomai.org>
	<CAEk6gTC7=6NJVJJTATHApcf8G13bX=68ZOAR4XdEmhiAgf3ZoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEk6gTC7=6NJVJJTATHApcf8G13bX=68ZOAR4XdEmhiAgf3ZoQ@mail.gmail.com>
Subject: Re: [Xenomai] Hardware I/O from Userspace
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Drasko DRASKOVIC <drasko.draskovic@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Oct 17, 2013 at 04:57:43PM +0200, Drasko DRASKOVIC wrote:
> I will most probably have only one application who access these regs.
> 
> Is not putting this application into the user-space safer - if it
> breaks it will not block system?
> Did i misunderstand something, or RTDM kernel module is like standard
> kernel module - if it has a bug it can break the whole kernel.

What do you think using /dev/mem can do?

-- 
Len Sorensen

