Date: Wed, 2 May 2018 16:56:35 +0300 (EEST)
From: =?windows-1251?B?2OXi9+Xt6u4g0uDw4PEgw/Do4+7w/OXi6Pc=?=
 <shevchenko.taras@triolcorp.com.ua>
Message-ID: <1409831554.4445446.1525269395683.JavaMail.zimbra@triolcorp.com.ua>
In-Reply-To: <CALLqZ8QQPNTKPv=MMLFXhrtxHEJrLdUvnkDXwMLeoheagwCOcQ@mail.gmail.com>
References: <o8krfbogm8lie1nfuolb6du4.1524796511535@embeddedgreg.com>
 <1430984661.4004024.1524839797276.JavaMail.zimbra@triolcorp.com.ua>
 <CALLqZ8RkP3D3z4eCfpevvAtujL5PfcLqK2NTfBakWaKprhTmoA@mail.gmail.com>
 <865117766.4054244.1524858734306.JavaMail.zimbra@triolcorp.com.ua>
 <CALLqZ8SkbLmcv4vLUV-gudwi5L_-GbnBAKXNMCYo0J-jsvdBoQ@mail.gmail.com>
 <1882680512.4260090.1525250520796.JavaMail.zimbra@triolcorp.com.ua>
 <CALLqZ8QQPNTKPv=MMLFXhrtxHEJrLdUvnkDXwMLeoheagwCOcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] how to bring gpio to user space
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: Olej <o.tsiliuric@yandex.ru>, xenomai <xenomai@xenomai.org>

yes, sorry for this and thanks for help

=D1 =F3=E2=E0=E6=E5=ED=E8=E5=EC =E8 =ED=E0=E4=E5=E6=E4=EE=E9 =ED=E0 =F1=EE=
=F2=F0=F3=E4=ED=E8=F7=E5=F1=F2=E2=EE,
=D8=E5=E2=F7=E5=ED=EA=EE =D2.=C3.

----- =C8=F1=F5=EE=E4=ED=EE=E5 =F1=EE=EE=E1=F9=E5=ED=E8=E5 -----
=CE=F2: "Greg Gallagher" <greg@embeddedgreg.com>
=CA=EE=EC=F3: "=D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=E3=EE=F0=
=FC=E5=E2=E8=F7" <shevchenko.taras@triolcorp.com.ua>
=CA=EE=EF=E8=FF: "xenomai" <xenomai@xenomai.org>, "Olej" <o.tsiliuric@yande=
x.ru>
=CE=F2=EF=F0=E0=E2=EB=E5=ED=ED=FB=E5: =D1=F0=E5=E4=E0, 2 =CC=E0=E9 2018 =E3=
 16:47:57
=D2=E5=EC=E0: Re: how to bring gpio to user space

It looks like you are calling rtdm_dev_register twice, so the second
one complains that it already exists.  Take out the second call and
see what happens.


// rtdm_sem_init(&sem, 0);    // init the global semaphore
   rtdm_printk("gpio TRY register Driver \n");
   err=3Drtdm_dev_register(&device);
if ((err=3Drtdm_dev_register(&device))!=3D0){
// gpio_free(GPIO_PIN);
rtdm_printk("err number =3D %d\n",err);
if(err =3D=3D -EINVAL)
    rtdm_printk("err EINVAL =3D %d\n",err);
if(err =3D=3D -EEXIST)
    rtdm_printk("err EEXIST =3D %d\n",err);
     if(err =3D=3D -ENOMEM)
    rtdm_printk("err ENOMEM =3D %d\n",err);
     if(err =3D=3D -EAGAIN)
    rtdm_printk("err EAGAIN =3D %d\n",err);
     if(err =3D=3D -ENOSYS)
    rtdm_printk("err ENOSYS =3D %d\n",err);
     if(err =3D=3D -ENXIO)
    rtdm_printk("err ENXIO =3D %d\n",err);

kfree(&device);
return err;
}

-Greg

On Wed, May 2, 2018 at 4:42 AM, =D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =
=C3=F0=E8=E3=EE=F0=FC=E5=E2=E8=F7
<shevchenko.taras@triolcorp.com.ua> wrote:
> HI Community
> I try to register simple rtdm gpio driver
>
> but get the error EEXIST  ? could you explain what is wrong or missing ?
> and what daes it mean  "invalid opcode: 0000 [#1] SMP" ?
>
> [ 1415.642644] gpio Driver Init
> [ 1415.642646] gpio TRY register Driver
> [ 1415.642881] err number =3D -17
> [ 1415.642885] err EEXIST =3D -17
> [ 1415.642922] ------------[ cut here ]------------
> [ 1415.643010] kernel BUG at mm/slub.c:3873!
> [ 1415.643066] invalid opcode: 0000 [#1] SMP
>

