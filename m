Date: Fri, 6 May 2016 11:22:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160506092248.GE13285@hermes.click-hack.org>
References: <E1aybuF-000446-5i@sd-51317.xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1aybuF-000446-5i@sd-51317.xenomai.org>
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : boilerplate: Allow for
 enabling Xenomai only in shared libs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: xenomai-git@xenomai.org

On Fri, May 06, 2016 at 11:18:43AM +0200, git repository hosting wrote:
> diff --git a/lib/boilerplate/init/Makefile.am b/lib/boilerplate/init/Makefile.am
> index 7a58f54..8c09e28 100644
> --- a/lib/boilerplate/init/Makefile.am
> +++ b/lib/boilerplate/init/Makefile.am
> @@ -4,6 +4,7 @@ libbootstrap_a_SOURCES = bootstrap.c
>  
>  libbootstrap_a_CPPFLAGS =		\
>  	@XENO_USER_CFLAGS@		\
> +	-fPIC				\
>  	-I$(top_srcdir)/include		\
>  	-I$(top_srcdir)/lib

This is not how this should be done.

-- 
					    Gilles.
https://click-hack.org

