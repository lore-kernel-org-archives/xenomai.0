MIME-Version: 1.0
References: <CAKcohPwzA9Vx7iN6t_jazRSdvZFsvxktKH+OYfzFjtHEsHkZHw@mail.gmail.com>
In-Reply-To: <CAKcohPwzA9Vx7iN6t_jazRSdvZFsvxktKH+OYfzFjtHEsHkZHw@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Sun, 26 Dec 2021 00:08:23 -0500
Message-ID: <CALLqZ8S5JjKuJNOz_OdNDeo90aU00DXi13RLwnUsy27hrz_zyw@mail.gmail.com>
Subject: Re: spi-bcm2835 for rtdm
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
To: Yunjie Gu <yunjie.gu1@gmail.com>
Cc: rpm@xenomai.org, xenomai@xenomai.org

On Sat, Dec 25, 2021 at 5:35 AM Yunjie Gu via Xenomai <xenomai@xenomai.org>
wrote:

> Hi Everyone,
>
> I'm trying to use rtdm spi on raspberry pi, and I find something confusin=
g.
> I could see there are two spi-bcm2835.c files in the kernel source (after
> xenomai patching), one with rtdm, and one native. But these two drivers u=
se
> the same .compatible =3D "brcm,bcm2835-spi", which means the device-tree
> cannot distinguish them. Does this mean I have to manually disable the
> native spi driver in Kconfig to avoid binding conflicts if I want to use
> the rtdm one?
>
> Best Regards,
> Yunjie


Yes, the native driver needs to be disabled. I usually unbind the native
driver manually when doing development.  I=E2=80=99ve never tried the metho=
d you
described above but I can=E2=80=99t see why it wouldn=E2=80=99t work.

Thanks

Greg

>
>
