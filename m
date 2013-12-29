Message-ID: <52C06262.1030404@xenomai.org>
Date: Sun, 29 Dec 2013 18:56:50 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1388336425-1139-1-git-send-email-romain.naour@openwide.fr>
In-Reply-To: <1388336425-1139-1-git-send-email-romain.naour@openwide.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 1/1] posix: fix build failure when HAVE_OPEN64
 is undefined.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Romain Naour <romain.naour@openwide.fr>
Cc: xenomai@xenomai.org

On 12/29/2013 06:00 PM, Romain Naour wrote:
> fixes: http://autobuild.buildroot.org/results/d59/d590be34637a4043c929ce615f9db504484be435/build-end.log
> 
> Signed-off-by: Romain Naour <romain.naour@openwide.fr>
> ---
>  src/skins/posix/rtdm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/src/skins/posix/rtdm.c b/src/skins/posix/rtdm.c
> index 5840c64..d6c87dc 100644
> --- a/src/skins/posix/rtdm.c
> +++ b/src/skins/posix/rtdm.c
> @@ -107,8 +107,9 @@ int __wrap_open64(const char *path, int oflag, ...)
>  			errno = EMFILE;
>  			ret = -1;
>  		}
> +	}
>  #endif
> -	} else {
> +	else {
>  		errno = -ret;
>  		ret = -1;
>  	}
> 
xenomai-2.6$ git apply ~/foo.eml
/home/gilles/foo.eml:79: trailing whitespace.
        }
/home/gilles/foo.eml:82: trailing whitespace.
        else {
error: patch failed: src/skins/posix/rtdm.c:107
error: src/skins/posix/rtdm.c: patch does not apply

Are you working from xenomai-2.6 git?

-- 
                                                                Gilles.

