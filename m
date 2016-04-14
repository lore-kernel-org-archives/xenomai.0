References: <1460497870-26014-1-git-send-email-jmelville@mitre.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <570F4BC1.4050602@xenomai.org>
Date: Thu, 14 Apr 2016 09:50:25 +0200
MIME-Version: 1.0
In-Reply-To: <1460497870-26014-1-git-send-email-jmelville@mitre.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] posix: fix pthread_mutex_timedlock for
 recursive mutexes.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeffrey Melville <jmelville@mitre.org>, xenomai@xenomai.org

On 04/12/2016 11:51 PM, Jeffrey Melville wrote:
> Fix erroneous returns of -EBUSY when calling pthread_mutex_timedlock on
> a recursive mutex already locked by the calling thread.
> 
> Signed-off-by: Jeffrey Melville <jmelville@mitre.org>
> ---
>  src/skins/posix/mutex.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/skins/posix/mutex.c b/src/skins/posix/mutex.c
> index 0cf2d8b..0323fe0 100644
> --- a/src/skins/posix/mutex.c
> +++ b/src/skins/posix/mutex.c
> @@ -265,6 +265,7 @@ int __wrap_pthread_mutex_timedlock(pthread_mutex_t *mutex,
>  			}
>  
>  			++shadow->lockcnt;
> +			err = 0;
>  			goto out;
>  		}
>  
> 

Merged, thanks.

-- 
Philippe.

