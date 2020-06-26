MIME-Version: 1.0
References: <761356215.240180691.1593183018087.JavaMail.root@zimbra14-e2.priv.proxad.net>
 <2036239901.240189362.1593183259994.JavaMail.root@zimbra14-e2.priv.proxad.net>
In-Reply-To: <2036239901.240189362.1593183259994.JavaMail.root@zimbra14-e2.priv.proxad.net>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Fri, 26 Jun 2020 11:10:48 -0400
Message-ID: <CALLqZ8Ry_==1+UyheEbcv-7s-vUngmG4S-cXNAAJMaYFC7nXYg@mail.gmail.com>
Subject: Re: rt_task_create error EINVAL after a while
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jeanmicheltaprest@free.fr
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

On Fri, Jun 26, 2020 at 10:54 AM jeanmicheltaprest--- via Xenomai
<xenomai@xenomai.org> wrote:
>
>
> Hi All,
>
> Hardware and firmware configuration :
> ARM Cortex A7 32 bit processor in an i.MX 6ULL NXP module
> with Linux 4.19.82 and Xenomai 3.0.9 ( Cobalt ).
>
> Problems with rt_task_create ( & object clusters )
> and access to the registry root path :
> ==================================================
>
> The embedded Linux/Xenomai software application starts OK,
> except when, after a while,
> rt_task_create is used to create RT Xenomai daughter tasks.
>
> Suddenly a call to rt_task_create fails with error EINVAL,
> after many successfull calls to the same function.
> Warning debugging messages in the the Xenomai Alchemy and Copperplate
> libraries give EINVAL error
> when calling syncobj_lock from syncluster_addobj ( object clusters )
> ( called from create_tcb, which is called from rt_task_create ).
>
> I also noticed a problem to access to the root registry,
> i don't know if it is related.
> The access to /var/run/xenomai/root/anon@724 blocks.
> The command 'ls /var/run/xenomai/root/anon@724' never returns.
>
> The xenomai libraries build was setup with the following command :
> ./configure --target=arm-linux-gnueabihf --host=arm-linux-gnueabihf
> --build=x86_64-pc-linux-gnu --prefix=/usr --exec-prefix=/usr
> --sysconfdir=/etc --localstatedir=/var --program-prefix=
> --disable-dependency-tracking --disable-static
> --enable-shared --includedir=/usr/include/xenomai/
> --with-core=cobalt --enable-smp --enable-registry --enable-assert
> --enable-async-cancel --enable-pshared

I haven't tested much with --enable-registry, do you have
CONFIG_FUSE_FS enabled in your kernel?  If no one else has any leads I
can do some testing this weekend.

-Greg

>
> Best regards
>
> Jean-Michel
>

