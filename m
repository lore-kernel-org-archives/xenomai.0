MIME-Version: 1.0
Message-ID: <trinity-71d48a15-4ece-4d49-b012-73220dfbbc6f-1539873444067@msvc-mesg-gmx123>
From: "Sebastian Smolorz" <Sebastian.Smolorz@gmx.de>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Oct 2018 16:37:24 +0200
In-Reply-To: <d9e08992-4083-3c1a-06ee-1a36a2fbdd3a@xenomai.org>
References: <1539865220-1372-1-git-send-email-sebastian.smolorz@gmx.de>
 <d9e08992-4083-3c1a-06ee-1a36a2fbdd3a@xenomai.org>
Subject: Re: [Xenomai] [PATCH] boilerplate/avl: fix missing include
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 18.10.18 14:37, Philippe Gerum wrote:

> On 10/18/2018 02:20 PM, Sebastian Smolorz wrote:
> > Signed-off-by: Sebastian Smolorz <sebastian.smolorz@gmx.de>
> > ---
> >  lib/boilerplate/avl.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/lib/boilerplate/avl.c b/lib/boilerplate/avl.c
> > index 3bf9bf1..2e16e7d 100644
> > --- a/lib/boilerplate/avl.c
> > +++ b/lib/boilerplate/avl.c
> > @@ -22,6 +22,7 @@
> >   */
> >  #include <errno.h>
> >  #include <memory.h>
> > +#include <boilerplate/avl.h>
> >  
> >  #ifdef AVL_PSHARED
> >  #define __AVL(__decl)	shavl_ ## __decl
> > 
> 
> Nack. The proper include file needs to be included via some Makefile
> magic, depending on whether that source is build for private or shared
> mode (avl.h vs shavl.h). See Makefile.am.

Sorry for the noise, it was my fault. I was hunting another bug which
included switching gcc versions and jumping back and forth in
the git history. At some point I just forgot to execute scripts/bootstrap
and fooled myself with wrong Makefiles.

Nevertheless, I guess there is an issue with the definition of const (line 50) in
include/boilerplate/compiler.h. It does work with gcc 5.4 but not with
gcc 4.3.5.

-- 
Sebastian

