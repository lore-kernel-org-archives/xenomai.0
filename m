Sender: Michael Welling <mwelling79@gmail.com>
Date: Mon, 22 Feb 2016 17:51:33 -0600
From: Michael Welling <mwelling@ieee.org>
Message-ID: <20160222235133.GB30318@deathstar>
References: <1456184548-30058-1-git-send-email-mwelling@ieee.org>
 <20160222234918.GJ7398@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160222234918.GJ7398@hermes.click-hack.org>
Subject: Re: [Xenomai] [PATCH] demo/alchemy/cross-link: Properly handle
 syscall errors
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On Tue, Feb 23, 2016 at 12:49:18AM +0100, Gilles Chanteperdrix wrote:
> On Mon, Feb 22, 2016 at 05:42:28PM -0600, Michael Welling wrote:
> > Update cross link demo to properly handle errors returned from syscalls.
> > 
> > Signed-off-by: Michael Welling <mwelling@ieee.org>
> > ---
> >  demo/alchemy/cobalt/cross-link.c | 25 +++++++++++++------------
> >  1 file changed, 13 insertions(+), 12 deletions(-)
> > 
> > diff --git a/demo/alchemy/cobalt/cross-link.c b/demo/alchemy/cobalt/cross-link.c
> > index 8c0f53f..dceb928 100644
> > --- a/demo/alchemy/cobalt/cross-link.c
> > +++ b/demo/alchemy/cobalt/cross-link.c
> > @@ -23,6 +23,7 @@
> >  #include <stdio.h>
> >  #include <signal.h>
> >  #include <unistd.h>
> > +#include <errno.h>
> >  #include <sys/mman.h>
> >  #include <alchemy/task.h>
> >  #include <alchemy/timer.h>
> > @@ -78,8 +79,8 @@ static int close_file( int fd, char *name)
> >  	do {
> >  		i++;
> >  		err = close(fd);
> > -		switch (err) {
> > -		case -EAGAIN:
> > +		switch (errno) {
> > +		case EAGAIN:
> 
> This looks incorrect. errno has a meaningful value only if err is
> -1. You could get away with setting errno to 0 before calling close,
> this would probably work, but for a more complex service which calls
> several syscalls under the hoold, this would not even work.
> 
> So, you should probably just add:
> err = err < 0 ? -errno : 0;

Okay I will fix that up in v2 along with the other things that I missed.

> 
> -- 
> 					    Gilles.
> https://click-hack.org

