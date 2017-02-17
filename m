References: <20170217134813.23980-1-henning.schild@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <fd3f8245-6c46-ebad-baf0-deae40388ac6@xenomai.org>
Date: Fri, 17 Feb 2017 15:14:48 +0100
MIME-Version: 1.0
In-Reply-To: <20170217134813.23980-1-henning.schild@siemens.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] debian/control: add pkg-config as build dep
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, xenomai@xenomai.org

On 02/17/2017 02:48 PM, Henning Schild wrote:
> Required for PKG_CHECK_MODULES that is used for fuse in configure
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  debian/control | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/debian/control b/debian/control
> index 2225648..86e8e37 100644
> --- a/debian/control
> +++ b/debian/control
> @@ -2,7 +2,8 @@ Source: xenomai
>  Section: devel
>  Priority: extra
>  Maintainer: Xenomai <xenomai@xenomai.org>
> -Build-Depends: debhelper (>= 8), findutils (>= 4.2.28), autotools-dev, autoconf, automake, libtool
> +Build-Depends: debhelper (>= 8), findutils (>= 4.2.28), autotools-dev, autoconf, automake, libtool,
> + pkg-config
>  Standards-Version: 3.9.3
>  Homepage: http://www.xenomai.org/
>  
> 

Merged, thanks.

-- 
Philippe.

