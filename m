MIME-Version: 1.0
In-Reply-To: <1882680512.4260090.1525250520796.JavaMail.zimbra@triolcorp.com.ua>
References: <o8krfbogm8lie1nfuolb6du4.1524796511535@embeddedgreg.com>
 <1430984661.4004024.1524839797276.JavaMail.zimbra@triolcorp.com.ua>
 <CALLqZ8RkP3D3z4eCfpevvAtujL5PfcLqK2NTfBakWaKprhTmoA@mail.gmail.com>
 <865117766.4054244.1524858734306.JavaMail.zimbra@triolcorp.com.ua>
 <CALLqZ8SkbLmcv4vLUV-gudwi5L_-GbnBAKXNMCYo0J-jsvdBoQ@mail.gmail.com>
 <1882680512.4260090.1525250520796.JavaMail.zimbra@triolcorp.com.ua>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 2 May 2018 09:47:57 -0400
Message-ID: <CALLqZ8QQPNTKPv=MMLFXhrtxHEJrLdUvnkDXwMLeoheagwCOcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?B?0KjQtdCy0YfQtdC90LrQviDQotCw0YDQsNGBINCT0YDQuNCz0L7RgNGM0LXQstC40Yc=?= <shevchenko.taras@triolcorp.com.ua>
Cc: Olej <o.tsiliuric@yandex.ru>, xenomai <xenomai@xenomai.org>

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

On Wed, May 2, 2018 at 4:42 AM, =D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=D0=BA=
=D0=BE =D0=A2=D0=B0=D1=80=D0=B0=D1=81 =D0=93=D1=80=D0=B8=D0=B3=D0=BE=D1=80=
=D1=8C=D0=B5=D0=B2=D0=B8=D1=87
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

