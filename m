Message-ID: <526E3407.9050400@xenomai.org>
Date: Mon, 28 Oct 2013 10:53:11 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <C0EBEDB7-2439-4083-AF21-4896462E5B7E@gmail.com>
In-Reply-To: <C0EBEDB7-2439-4083-AF21-4896462E5B7E@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Static linking fails for global mutex variable(c++
 class) on embedded system
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Jaap Kempenaar <janjaapkempenaar@gmail.com>
Cc: xenomai@xenomai.org

On 10/28/2013 10:44 AM, Jan Jaap Kempenaar wrote:
> Hello,
> 
> For our projects we developed a multiplatform library which is used
> to create our applications. We are now porting this to Xenomai. 
> Because we compile for embedded targets, in this case an ARM board,
> we use static linking as it might occur that dynamic libraries are
> not available.
> 
> In one of our test cases we compile a global class containing a
> mutex. This class gets initiated before the main function.

Whether this works depends on initialization order: the Xenomai library
has to be initialized before you call pthread_mutex_init, and this is
probably not true when you link the library statically. The only
solution is to defer the call to pthread_mutex_init somehow.

Also note that in order to static link the Xenomai library, you have to
use the "wrap-link.sh" script.
-- 
                                                                Gilles.

