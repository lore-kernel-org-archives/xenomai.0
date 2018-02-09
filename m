Date: Fri, 9 Feb 2018 18:23:47 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20180209182347.7bb4a455@mmd1pvb1c.ad001.siemens.net>
In-Reply-To: <8eaf133f-a235-b0c3-0260-c527800d715a@siemens.com>
References: <20180209161313.32524-1-henning.schild@siemens.com>
 <8eaf133f-a235-b0c3-0260-c527800d715a@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] boilerplate: introduce big lock to serialze
 dso init calls
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

Am Fri, 9 Feb 2018 17:48:22 +0100
schrieb Jan Kiszka <jan.kiszka@siemens.com>:

> On 2018-02-09 17:13, Henning Schild wrote:
> > When using dlopen() to include xenomai libraries into an
> > application, __xenomai_init could be running in multiple threads at
> > a time. That happens if the application dlopens multiple libs in
> > multiple threads.  
> 
> So, dlopen itself is thread-safe, but it does not guarantee atomicity
> for the init functions it executes? Or would we run xenomai_init_dso
> manually in that case?

According to its man-page dlopen is MT-Safe, but i do not think that
necessarily means it will serialize the init functions for us. I think
i will have to read the code to answer this one.

Henning

> > 
> > Introduce a big lock to serialize all calls to __xenomai_init.
> > 
> > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > ---
> >  lib/boilerplate/setup.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/lib/boilerplate/setup.c b/lib/boilerplate/setup.c
> > index f749828b91..653bbae104 100644
> > --- a/lib/boilerplate/setup.c
> > +++ b/lib/boilerplate/setup.c
> > @@ -55,6 +55,9 @@ static int main_init_done;
> >  
> >  static DEFINE_PRIVATE_LIST(setup_list);
> >  
> > +// serialize dlopen() init calls, which come potentially
> > multi-threaded  
> 
> Style: we use /* */ comments.
> 
> > +static pthread_mutex_t dso_init_lock = PTHREAD_MUTEX_INITIALIZER;
> > +
> >  static const struct option base_options[] = {
> >  	{
> >  #define help_opt	0
> > @@ -657,7 +660,9 @@ void xenomai_init(int *argcp, char *const
> > **argvp) 
> >  void xenomai_init_dso(int *argcp, char *const **argvp)
> >  {
> > +	write_lock_nocancel(&dso_init_lock);
> >  	__xenomai_init(argcp, argvp, "DSO");
> > +	write_unlock(&dso_init_lock);
> >  	trace_me("DSO bootstrap done");
> >  }
> >  
> >   
> 
> Jan


