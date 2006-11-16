From: Stephan Zimmermann <s.zimmermann@domain.hid>
Subject: Re: [Xenomai-help] Kernel crash during queue create/destroy
Date: Thu, 16 Nov 2006 13:59:23 +0100
References: <200611151121.51836.s.zimmermann@domain.hid>
	<200611151544.00429.s.zimmermann@domain.hid>
	<1163678246.4962.53.camel@domain.hid>
In-Reply-To: <1163678246.4962.53.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611161359.23875.s.zimmermann@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Am Donnerstag, 16. November 2006 12:57 schrieb Philippe Gerum:
> On Wed, 2006-11-15 at 15:44 +0100, Stephan Zimmermann wrote:
> > Am Mittwoch, 15. November 2006 14:19 schrieb Dmitry Adamushko:
> > > Hello,
> > >
> > > I got some trouble with the native skin and queues, when creating /
> > > deleting
> > >
> > > > queues, my Kernel sometimes (actually very often...) crashes, leading
> > > > to a frozen system, with my Xenomai program continuing until it
> > > > returns. I tried
> > > > to isolate / reproduce the problem, which lead me to the following
> > > > demo-code.
>
> [...]
>
> Cannot test it yet, but could you try out this patch? TIA,

This is the moment I have to confess I'm somehow not familiar enough with 
patch command....

I did download an fresh 1838 revision fron svn using "svn co -r 1838 
svn://svn.gna.org/svn/xenomai/trunk xenomai", saved your patch to a file and 
tried to apply it from within the xenomai directory like this "patch -p0 < 
filename" (worked somehow last time), which leads me to the following output:
<patch putput>
patching file ksrc/nucleus/registry.c
Hunk #1 FAILED at 65.
Hunk #2 FAILED at 104.
Hunk #3 FAILED at 271.
Hunk #4 FAILED at 335.
Hunk #5 FAILED at 394.
patch unexpectedly ends in middle of line
Hunk #6 FAILED at 402.
6 out of 6 hunks FAILED -- saving rejects to file ksrc/nucleus/registry.c.rej
</patch output>

sorry, don't know how to fix that...

> --- ksrc/nucleus/registry.c	(revision 1838)
> +++ ksrc/nucleus/registry.c	(working copy)
> @@ -65,10 +65,8 @@
>
>  static void registry_proc_schedule(void *cookie);
>
> -static xnqueue_t registry_obj_exportq;	/* Objects waiting for /proc
> export. */ +static xnqueue_t registry_obj_procq;	/* Objects waiting for
> /proc handling. */
>
> -static xnqueue_t registry_obj_unexportq;	/* Objects waiting for /proc
> unexport. */ -
>  #ifndef CONFIG_PREEMPT_RT
>  static DECLARE_WORK(registry_proc_work, &registry_proc_callback, NULL);
>  #endif /* !CONFIG_PREEMPT_RT */
> @@ -106,8 +104,7 @@
>  		return -ENOMEM;
>  	}
>
> -	initq(&registry_obj_exportq);
> -	initq(&registry_obj_unexportq);
> +	initq(&registry_obj_procq);
>  #endif /* CONFIG_XENO_EXPORT_REGISTRY */
>
>  	initq(&registry_obj_freeq);
> @@ -274,16 +271,20 @@
>
>  	xnlock_get_irqsave(&nklock, s);
>
> -	while ((holder = getq(&registry_obj_exportq)) != NULL) {
> +	while ((holder = getq(&registry_obj_procq)) != NULL) {
>  		object = link2xnobj(holder);
>  		pnode = object->pnode;
>  		type = pnode->type;
> +		dir = pnode->dir;
> +		rdir = pnode->root->dir;
>  		root = pnode->root->name;
> +
> +		if (object->proc != XNOBJECT_PROC_RESERVED1)
> +			goto unexport;
> +
>  		++pnode->entries;
>  		object->proc = XNOBJECT_PROC_RESERVED2;
>  		appendq(&registry_obj_busyq, holder);
> -		dir = pnode->dir;
> -		rdir = pnode->root->dir;
>
>  		xnlock_put_irqrestore(&nklock, s);
>
> @@ -334,19 +335,14 @@
>  			object->pnode = NULL;
>  			--pnode->entries;
>  		}
> -	}
>
> -	while ((holder = getq(&registry_obj_unexportq)) != NULL) {
> -		object = link2xnobj(holder);
> -		pnode = object->pnode;
> -		object->pnode = NULL;
> +		continue;
> +
> +	unexport:
> +		entries = --pnode->entries;
>  		entry = object->proc;
>  		object->proc = NULL;
> -		type = pnode->type;
> -		dir = pnode->dir;
> -		rdir = pnode->root->dir;
> -		root = pnode->root->name;
> -		entries = --pnode->entries;
> +		object->pnode = NULL;
>
>  		if (entries <= 0) {
>  			pnode->dir = NULL;
> @@ -398,7 +394,7 @@
>  	object->proc = XNOBJECT_PROC_RESERVED1;
>  	object->pnode = pnode;
>  	removeq(&registry_obj_busyq, &object->link);
> -	appendq(&registry_obj_exportq, &object->link);
> +	appendq(&registry_obj_procq, &object->link);
>  	rthal_apc_schedule(registry_proc_apc);
>  }
>
> @@ -406,13 +402,13 @@
>  {
>  	if (object->proc != XNOBJECT_PROC_RESERVED1) {
>  		removeq(&registry_obj_busyq, &object->link);
> -		appendq(&registry_obj_unexportq, &object->link);
> +		appendq(&registry_obj_procq, &object->link);
>  		rthal_apc_schedule(registry_proc_apc);
>  	} else {
>  		/* Unexporting before the lower stage has had a chance to
>  		   export. Move back the object to the busyq just like if no
>  		   export had been requested. */
> -		removeq(&registry_obj_exportq, &object->link);
> +		removeq(&registry_obj_procq, &object->link);
>  		appendq(&registry_obj_busyq, &object->link);
>  		object->pnode = NULL;
>  		object->proc = NULL;

