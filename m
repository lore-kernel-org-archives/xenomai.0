References: <1539865220-1372-1-git-send-email-sebastian.smolorz@gmx.de>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <d9e08992-4083-3c1a-06ee-1a36a2fbdd3a@xenomai.org>
Date: Thu, 18 Oct 2018 14:37:11 +0200
MIME-Version: 1.0
In-Reply-To: <1539865220-1372-1-git-send-email-sebastian.smolorz@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] boilerplate/avl: fix missing include
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sebastian Smolorz <sebastian.smolorz@gmx.de>, xenomai@xenomai.org

On 10/18/2018 02:20 PM, Sebastian Smolorz wrote:
> Signed-off-by: Sebastian Smolorz <sebastian.smolorz@gmx.de>
> ---
>  lib/boilerplate/avl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/boilerplate/avl.c b/lib/boilerplate/avl.c
> index 3bf9bf1..2e16e7d 100644
> --- a/lib/boilerplate/avl.c
> +++ b/lib/boilerplate/avl.c
> @@ -22,6 +22,7 @@
>   */
>  #include <errno.h>
>  #include <memory.h>
> +#include <boilerplate/avl.h>
>  
>  #ifdef AVL_PSHARED
>  #define __AVL(__decl)	shavl_ ## __decl
> 

Nack. The proper include file needs to be included via some Makefile
magic, depending on whether that source is build for private or shared
mode (avl.h vs shavl.h). See Makefile.am.

-- 
Philippe.

