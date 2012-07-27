Message-ID: <50128EE5.3090904@xenomai.org>
Date: Fri, 27 Jul 2012 14:51:49 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <208C6975C932E94F86239FEA59CCA632068318D3@AUSMXMBX02.mrws.biz>
In-Reply-To: <208C6975C932E94F86239FEA59CCA632068318D3@AUSMXMBX02.mrws.biz>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] [PATCH, Xenomai 2.5.6]
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: dietmar.schindler@manroland-web.com
Cc: xenomai@xenomai.org

On 07/27/2012 02:45 PM, dietmar.schindler@manroland-web.com wrote:
> These are patches for two files in ksrc/nucleus of Xenomai 2.5.6 to cure an incompatibility with Linux 2.4; if they are bad in form, please let me know.
>

You should backport this patch from the 2.6 tree instead:
e3c13f0685c2edf2a2ce30cd239b3f

> Index: heap.c
> ===================================================================
> --- heap.c      (revision 3587)
> +++ heap.c      (revision 4276)
> @@ -1127,7 +1127,12 @@
>          return NULL;
>   }
>
> +#if HAVE_UNLOCKED_IOCTL
>   static long xnheap_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +#else
> +static int xnheap_ioctl(struct inode *inode,
> +                       struct file *file, unsigned int cmd, unsigned long arg)
> +#endif
>   {
>          file->private_data = (void *)arg;
>          return 0;
>
> Index: pipe.c
> ===================================================================
> --- pipe.c      (revision 3587)
> +++ pipe.c      (revision 4276)
> @@ -923,7 +923,12 @@
>          return (ssize_t)count;
>   }
>
> +#if HAVE_UNLOCKED_IOCTL
>   static long xnpipe_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +#else
> +static int xnpipe_ioctl(struct inode *inode,
> +                       struct file *file, unsigned int cmd, unsigned long arg)
> +#endif
>   {
>          struct xnpipe_state *state = file->private_data;
>          int ret = 0;
>
> --
> Best regards,
> Dietmar Schindler
> ________________________________________
> manroland web systems GmbH -- Managing Director: Uwe Lüders
> Registered Office: Augsburg -- Trade Register: AG Augsburg -- HRB-No. 26816 -- VAT: DE281389840
>
> Confidentiality note:
> This eMail and any files transmitted with it are confidential and intended solely for the use of the individual or entity to whom they are addressed. If you are not the intended recipient, you are hereby notified that any use or dissemination of this communication is strictly prohibited. If you have received this eMail in error, then please delete this eMail.
>
> - Please consider your environmental responsibility before printing this eMail
> ________________________________________
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


-- 
Philippe.



