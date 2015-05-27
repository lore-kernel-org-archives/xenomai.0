Date: Wed, 27 May 2015 11:11:26 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20150527111126.2f03fa66@md1em3qc>
In-Reply-To: <d0dc8c289d0b45fafbb6b39b839b468bd53f256f.1430395105.git.henning.schild@siemens.com>
References: <d0dc8c289d0b45fafbb6b39b839b468bd53f256f.1430395105.git.henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] debian: remove xeno-config from
	libxenomai-dev package
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hey Guys,

we have a continuous integration setup here at Siemens. Next to our own
repos we also compile and test upstream to detect problems before
merging.
I know the changes to the debian directory seem unimportant, but our
current CI infrastructure is built on that. So please consider applying
my suggestions. Using the CI we hope to find and fix issues in the
whole project but for that to work we need a reliable way of deploying
binaries to our test systems.

If there is a debian directory in the tree, it should be consistent.
The other option would be to remove it all together, i personally
prefer the first option.

regards,
Henning

On Thu, 30 Apr 2015 13:59:54 +0200
Henning Schild <henning.schild@siemens.com> wrote:

> Since 8871363fa57266af4c8d8a06965f2898b940fb48 the binary and its
> man-page are in the base package (xenomai-runtime). Remove the files
> from the -dev package to resolve the current package conflict.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  debian/libxenomai-dev.install | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/debian/libxenomai-dev.install
> b/debian/libxenomai-dev.install index 40ae57d..7b107cb 100644
> --- a/debian/libxenomai-dev.install
> +++ b/debian/libxenomai-dev.install
> @@ -1,8 +1,6 @@
> -usr/bin/xeno-config
>  usr/include
>  usr/lib/*.la
>  usr/lib/*.a
>  usr/lib/*.so
>  usr/lib/cobalt.wrappers
>  usr/lib/dynlist.ld
> -usr/share/man/man1/xeno-config.1


