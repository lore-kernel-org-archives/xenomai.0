MIME-Version: 1.0
References: <4821ee5b-a118-ca86-7706-5ed77fed78d1@163.com>
In-Reply-To: <4821ee5b-a118-ca86-7706-5ed77fed78d1@163.com>
From: gbcwbz <cwbddzxx@gmail.com>
Date: Tue, 7 Jul 2020 14:59:17 +0800
Message-ID: <CABk+T1uqZjg7fqSxN0gD_2_0jeu93cw0ioWfQrW1R+cEg0GLgw@mail.gmail.com>
Subject: Re: About binding failed: Operation not permitted help
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Caffreyfans <Caffreyfans@163.com>
Cc: xenomai <xenomai@xenomai.org>

Hi,

  read this https://gitlab.denx.de/Xenomai/xenomai/-/wikis/Running_As_Regul=
ar_User

  1. Create a user group named "xenomai", and get the group id, add
kernel parameter xenomai.allowed_group=3D<gid>,
replace <gid> with group id you just got.
  2. Add your user name to "xenomai" group
  3. Copy files in xenomai_install_directory/etc/udev/rules.d to
/etc/udev/rules.d
  4. Restart.

Regards
Bryan Cheng

Caffreyfans via Xenomai <xenomai@xenomai.org> =E4=BA=8E2020=E5=B9=B47=E6=9C=
=887=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=882:34=E5=86=99=E9=81=93=EF=
=BC=9A
>
> Hello, sir:
>
>            When I run Xenomai applications in an X64 environment, I find
> that I must use root permissions to execute the application. If you do
> not use privileged users, you will get the error "binding failed:
> Operation not permitted". This error indicates that I also saw binding
> failed: Operation not permitted
> <https://gitlab.denx.de/Xenomai/xenomai/-/wikis/Troubleshooting#user-cont=
ent-binding-failed-operation-not-permitted>
> in the official documentation. But click on the link to find that there
> is no document, so I would like to ask, could you help me know how to
> allow ordinary users to execute Xenomai applications?
>
>
>                                                          Best wish
>
>                                          Author: Caffreyfans
>

