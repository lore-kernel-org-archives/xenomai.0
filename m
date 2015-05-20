Date: Wed, 20 May 2015 11:00:31 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20150520110031.473dc739@md1em3qc>
In-Reply-To: <50e02c6cc01a52e26ce177b7238b094fd68968d5.1430318857.git.henning.schild@siemens.com>
References: <50e02c6cc01a52e26ce177b7238b094fd68968d5.1430318857.git.henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] debian: add pkg-config as explicit build dep
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Bump.

On Wed, 29 Apr 2015 16:47:57 +0200
Henning Schild <henning.schild@siemens.com> wrote:

> configure.ac uses the PKG_CHECK_MODULES macro, which is provided by
> pkg-config Not having pkg-config installed will cause a syntax error
> in configure
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  debian/control | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/debian/control b/debian/control
> index 2225648..492f0e2 100644
> --- a/debian/control
> +++ b/debian/control
> @@ -2,7 +2,7 @@ Source: xenomai
>  Section: devel
>  Priority: extra
>  Maintainer: Xenomai <xenomai@xenomai.org>
> -Build-Depends: debhelper (>= 8), findutils (>= 4.2.28),
> autotools-dev, autoconf, automake, libtool +Build-Depends: debhelper
> (>= 8), findutils (>= 4.2.28), autotools-dev, autoconf, automake,
> libtool, pkg-config Standards-Version: 3.9.3 Homepage:
> http://www.xenomai.org/ 


