Date: Fri, 10 Apr 2015 16:50:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150410145035.GN20752@hermes.click-hack.org>
References: <CAJZRki9RpfcQQ+c8oz1bJ7RsFQE4MrsQdULxvHAuh-STi0fhkQ@mail.gmail.com>
 <oqegntropy.fsf@merlin.sez.to>
 <20150409220956.GE29558@csclub.uwaterloo.ca>
 <20150409221718.GI20752@hermes.click-hack.org>
 <20150410144410.GF29558@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150410144410.GF29558@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] Why does mqueue.h define mqd_t as unsigned
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Xenomai Mailing List <xenomai@xenomai.org>

On Fri, Apr 10, 2015 at 10:44:10AM -0400, Lennart Sorensen wrote:
> On Fri, Apr 10, 2015 at 12:17:18AM +0200, Gilles Chanteperdrix wrote:
> > This design is specified by POSIX. This looks like a "fighting the
> > windmill" case.
> 
> Yeah "Posix says so" always wins any argument it seems. :)

Adding #define MQ_FAILED ((mqd_t)-1) in your application and using
it makes your application portable. Adding it to Xenomai headers and
using it in your application makes your application non portable. If
the POSIX standard added this definition, then if you wanted your
application to be portable, you would want it to support previous
POSIX standards, so you would still add this definition to your
application (with an added ifdef on the posix standard level).

So, all and all, adding #define MQ_FAILED ((mqd_t)-1) to your
application and move on wins the argument.

-- 
					    Gilles.

