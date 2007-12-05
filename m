Message-ID: <2ff1a98a0712050217k3ab0e81as7a3e8eef84bf550@domain.hid>
Date: Wed, 5 Dec 2007 11:17:23 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <NGBBLNEOGLJIIJKLFLPFIEBPDFAA.linux@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ff1a98a0712040527k6f2c1439i52a5e2d9e756a3c5@domain.hid>
	<NGBBLNEOGLJIIJKLFLPFIEBPDFAA.linux@domain.hid>
Subject: Re: [Xenomai-help] native pipe can not write
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: linux@domain.hid
Cc: xenomai@xenomai.org

On Dec 5, 2007 9:43 AM, Henk Geraads <linux@domain.hid> wrote:
>
> Hi,
>
> Does this mean I have to perform the following patch also in my system?
>
> --- ksrc/skins/native/syscall.c (revision 3195)
> +++ ksrc/skins/native/syscall.c (revision 3196)
> @@ -2468,10 +2468,10 @@
>
>                 if (size > 0)
>                         __xn_copy_to_user(curr, buf, mbuf, size);
> +
> +               rt_queue_free(q, mbuf);
>         }
>
> -       rt_queue_free(q, mbuf);
> -
>         return (int)rsize;
>  }

No, it is a bit more complicated than that. Several changes were made
in the heap implementation. If you want to test the fixed
implementation, which will allow to know if the problem you have is
the one that was fixed, you should try svn trunk.

-- 
                                               Gilles Chanteperdrix

