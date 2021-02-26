MIME-Version: 1.0
References: <CAFZ-hKhxmHDYOqQT_TWJaCLoFTiXB7d0Py_9XXLZehMshMBR-A@mail.gmail.com>
In-Reply-To: <CAFZ-hKhxmHDYOqQT_TWJaCLoFTiXB7d0Py_9XXLZehMshMBR-A@mail.gmail.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Fri, 26 Feb 2021 06:25:47 +0100
Message-ID: <CAFc1U0sho180RXjnkYTEgE3z9KCVVuMwZX4wc+mQpw+M8QWsAQ@mail.gmail.com>
Subject: Re: rebuild kernel
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
To: Leandro Bucci <guestleandro11@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

Hi,

Do you run Raspbian ?

Le mar. 23 f=C3=A9vr. 2021 =C3=A0 12:36, Leandro Bucci via Xenomai <
xenomai@xenomai.org> a =C3=A9crit :

> Hi, I'm new to Linux and xenomai. I installed xenomai on raspberry and it
> works great. However, some kernel modules are missing. If I want to
> recompile the kernel with the missing modules, what I need to do is:
> $ make clean
> $ make menuconfig (and insert the modules)
> $ make
> $ make modules_install
> $ make install
>
> reboot the system.
> Is this correct?
>


--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
