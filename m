Date: Wed, 29 Apr 2015 11:39:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150429093943.GL1993@hermes.click-hack.org>
References: <5c789beff3ff2c2ef88fbe1a53342cb7ebc714b8.1430299655.git.henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c789beff3ff2c2ef88fbe1a53342cb7ebc714b8.1430299655.git.henning.schild@siemens.com>
Subject: Re: [Xenomai] [PATCH 1/2] debian: add autoreconf to build rules
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: xenomai@xenomai.org

On Wed, Apr 29, 2015 at 11:32:42AM +0200, Henning Schild wrote:
> Add autoreconf steps to debian/rules and add required tools to build deps.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  debian/control | 2 +-
>  debian/rules   | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/debian/control b/debian/control
> index 2225648..54fc898 100644
> --- a/debian/control
> +++ b/debian/control
> @@ -2,7 +2,7 @@ Source: xenomai
>  Section: devel
>  Priority: extra
>  Maintainer: Xenomai <xenomai@xenomai.org>
> -Build-Depends: debhelper (>= 8), findutils (>= 4.2.28), autotools-dev, autoconf, automake, libtool
> +Build-Depends: debhelper (>= 8), findutils (>= 4.2.28),
> autotools-dev, autoconf, automake, dh-autoreconf

is dh-autoreconf available on wheezy ?

If people work from a release, autoreconf is useless and has chances
to do more harm than good.

If people do not work from a release, can we not expect them to run
autoreconf by themselves ?

-- 
					    Gilles.

