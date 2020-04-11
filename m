Subject: Re: I think lib/copperplate depends on glibc while using dual kernel
 configuration.Am i right?
References: <CAAvDm6YExdCv-Bk9RCin4ah7HTjEuiO2RzN835PsDBt_UoEbbg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <993ec258-fb69-cfa6-14f6-6cfb0967f9e8@web.de>
Date: Sat, 11 Apr 2020 09:22:42 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6YExdCv-Bk9RCin4ah7HTjEuiO2RzN835PsDBt_UoEbbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>, xenomai <xenomai@xenomai.org>

On 10.04.20 05:56, =E5=AD=99=E4=B8=96=E9=BE=99 via Xenomai wrote:
> Hi,
>    I am using xenomai-3.1.
>
>     Two figures are contained in url
> https://gitlab.denx.de/Xenomai/xenomai/-/wikis/Start_Here.
>
>     Since the architecture showed in figure 2 named xenomai 3 single ker=
nel
> configuration, i could draw the conclusion that copperplate interface
> depends on the glibc.
>
>     But i don't think i can draw the same conclusion from the Figure 1.
> Xenomai 3 dual kernel configuration.
>
>    When i enable the --enable-pshared compiler option, I could clearlly =
see
> the create_main_heap function calls shm_open which is provided by glibc.
>    So, i think copperplate interface depends on glibc while using dual
> kernel configuration.Am i right?

Xenomai does not replace a libc when using the cobalt mode. It only
provides alternatives to certain time-sensitive services. So a libc,
like glibc, remains a natural dependency, for Xenomai libs themselves as
well as the target application.

Jan

