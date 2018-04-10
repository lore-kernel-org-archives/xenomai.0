Date: Tue, 10 Apr 2018 10:20:01 -0400
Message-ID: <20180410142001.wsd4mcomp3ur2n7a@csclub.uwaterloo.ca>
References: <CAOuPNLgfpzTWgeBZcsntHDP07cOPyvhPEZM6WsQ453s=6id3tA@mail.gmail.com>
 <20180410135030.qh2gep2yxj5tnyga@csclub.uwaterloo.ca>
 <CAOuPNLjPbzwhVfaY=Kmk6cv2q5L1U+qXcmG7tcN=qsZbkRn7vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOuPNLjPbzwhVfaY=Kmk6cv2q5L1U+qXcmG7tcN=qsZbkRn7vA@mail.gmail.com>
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: [Xenomai] [RTNET]: Which rtnet driver to use with beagle bone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pintu Kumar <pintu.ping@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Apr 10, 2018 at 07:41:38PM +0530, Pintu Kumar wrote:
> So, this means there is no rtnet driver available for beagle bone ?
> Then it looks like we have to drop Xenomai for beagle bone... :-(

I don't know if one exists, but certainly it wasn't in the list you had.

> However, I found that somebody have ported TI ethernet driver here:
> https://github.com/hiddeate2m/rtnet/tree/master/drivers
> 
> https://sourceforge.net/p/rtnet/mailman/message/32523245/
> 
> Is it worth to try ?

Well I think you could look at that as inspiration, but you would
probably have to redo the work on the current driver to have it work
with the current kernel.

-- 
Len Sorensen

