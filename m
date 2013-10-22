MIME-Version: 1.0
In-Reply-To: <1c0dc43665a4b66fa8c6.1381827038@devws164.be.alcatel-lucent.com>
References: <patchbomb.1381827036@devws164.be.alcatel-lucent.com>
 <1c0dc43665a4b66fa8c6.1381827038@devws164.be.alcatel-lucent.com>
Date: Tue, 22 Oct 2013 18:54:50 +0200
Message-ID: <CAKc2HpZK7FSJYzgs2nxgC0o=pQm6rOt+BpeRtV8ZZ4_6xAe64g@mail.gmail.com>
From: Kim De Mey <kim.demey@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] [PATCH 2 of 3] Initial implementation registry pSOS
	semaphore
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

2013/10/15 Kim De Mey <kim.demey@gmail.com>

> Initial implementation of the registry functionality
> for pSOS semaphores.
>
> I noticed now that it is probably better to not let the
registry_add_file() call return the data to the return var of sm_create as
this might give an unexpected error at the creation of a semaphore. The
same happens in the patch for a queue.
It is also not consistent as in the patch for a task the error will not be
returned as the registry_add_file is done in the trampoline.


> Signed-off-by: Kim De Mey <kim.demey@gmail.com>
>
> ---
>
> diff --git a/lib/psos/sem.c b/lib/psos/sem.c
> --- a/lib/psos/sem.c
> +++ b/lib/psos/sem.c
> @@ -21,6 +21,7 @@
>  #include <errno.h>
>  #include <stdlib.h>
>  #include <string.h>
> +#include <fcntl.h>
>  #include <copperplate/heapobj.h>
>  #include <copperplate/init.h>
>  #include <copperplate/cluster.h>
> @@ -68,10 +69,44 @@ objid_error:
>  static void sem_finalize(struct semobj *smobj)
>  {
>         struct psos_sem *sem = container_of(smobj, struct psos_sem, smobj);
> +       registry_destroy_file(&sem->fsobj);
>         xnfree(sem);
>  }
>  fnref_register(libpsos, sem_finalize);
>
> +#ifdef CONFIG_XENO_REGISTRY
> +
> +static ssize_t sem_registry_read(struct fsobj *fsobj,
> +                                 char *buf, size_t size, off_t offset)
> +{
> +       struct psos_sem *sem;
> +       size_t len;
> +       int value;
> +
> +       sem = container_of(fsobj, struct psos_sem, fsobj);
> +       semobj_getvalue(&sem->smobj , &value);
> +       len =  sprintf(buf,       "%-11s= %11s\n", "name", sem->name);
> +       len += sprintf(buf + len, "%-11s= %#011lx\n","sem_id",
>  mainheap_ref(sem, u_long));
> +       len += sprintf(buf + len, "%-11s= %11d\n", "value", value);
> +
> +       if(len < offset)
> +               return (ssize_t)0;
> +       else
> +               return (ssize_t)len;
> +}
> +
> +
> +static struct registry_operations registry_ops = {
> +       .read   = sem_registry_read
> +};
> +
> +#else
> +
> +static struct registry_operations registry_ops;
> +
> +#endif /* CONFIG_XENO_REGISTRY */
> +
> +
>  u_long sm_create(const char *name,
>                  u_long count, u_long flags, u_long *smid_r)
>  {
> @@ -116,6 +151,14 @@ u_long sm_create(const char *name,
>                 goto out;
>         }
>
> +       registry_init_file(&sem->fsobj, &registry_ops);
> +
> +       ret = __bt(registry_add_file(&sem->fsobj, O_RDONLY,
> +                                     "/psos/semaphores/%s", sem->name));
> +       if (ret)
> +               warning("failed to export semaphore %s to registry",
> +                               sem->name);
> +
>         *smid_r = mainheap_ref(sem, u_long);
>  out:
>         CANCEL_RESTORE(svc);
> diff --git a/lib/psos/sem.h b/lib/psos/sem.h
> --- a/lib/psos/sem.h
> +++ b/lib/psos/sem.h
> @@ -28,6 +28,7 @@ struct psos_sem {
>         char name[32];
>         struct semobj smobj;
>         struct clusterobj cobj;
> +       struct fsobj fsobj;
>  };
>
>  extern struct cluster psos_sem_table;
>
