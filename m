From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 1 Oct 2014 21:49:02 -0400
Message-ID: <20141002014902.GL4435@csclub.uwaterloo.ca>
References: <CANgF67Q+ZneJM-osJT07NS45AWaZEPetHjUL5EBc5SvW0Dc7rQ@mail.gmail.com>
 <20141001213611.GI4435@csclub.uwaterloo.ca>
 <542C789F.4090309@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <542C789F.4090309@xenomai.org>
Subject: Re: [Xenomai] nucleus/sched.h: No such file or directory
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

On Wed, Oct 01, 2014 at 11:56:47PM +0200, Gilles Chanteperdrix wrote:
> Why is is unfortunate, if I may ask? It also depends on how you run the
> configure script, you get includes in /usr/include/xenomai if you passed
> --includedir=/usr/include/xenomai

Well only unfortunate in that you can't compile without adding to the
include path with the path the xenomai headers use internally.

Quite common of course for many libraries.

-- 
Len Sorensen

