Message-ID: <53E7691A.7090605@xenomai.org>
Date: Sun, 10 Aug 2014 14:44:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <oqegwqn4xu.fsf@merlin.sez.to>
In-Reply-To: <oqegwqn4xu.fsf@merlin.sez.to>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] hal/x86: Export symbol rthal_c1e_disable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul Janzen <pcj@xenomai.sez.to>, xenomai@xenomai.org

On 08/08/2014 08:44 PM, Paul Janzen wrote:
> ---
>  ksrc/arch/x86/c1e.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/ksrc/arch/x86/c1e.c b/ksrc/arch/x86/c1e.c
> index a5bdc34..984c039 100644
> --- a/ksrc/arch/x86/c1e.c
> +++ b/ksrc/arch/x86/c1e.c
> @@ -79,4 +79,5 @@ void rthal_c1e_disable(void)
>  	}
>  }
>  
> +EXPORT_SYMBOL_GPL(rthal_c1e_disable);
>  #endif
> 

Merged, thanks.

-- 
                                                                Gilles.

