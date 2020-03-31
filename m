Subject: Re: Regarding Xenomai patch to the kernel 4.15.38
References: <CAF_6Mayw_popagGGG14B+na6wtH2CFGeBnvYreRSUizQe14w6g@mail.gmail.com>
 <a4469868-3c21-8efd-7469-a9cd6e025742@web.de>
 <CAF_6Maycted8=dyTk42+DEJbrwzWKy4S_4vpnffyvB8yv6HQ2w@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <fa9bbef6-7e9b-a249-f716-2f3afbc0d810@web.de>
Date: Tue, 31 Mar 2020 10:03:18 +0200
MIME-Version: 1.0
In-Reply-To: <CAF_6Maycted8=dyTk42+DEJbrwzWKy4S_4vpnffyvB8yv6HQ2w@mail.gmail.com>
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
To: gopi ratnakaram <gopi.ratnakaram@svayarobotics.com>
Cc: Xenomai <xenomai@xenomai.org>

[re-adding the mailing list]

On 31.03.20 08:42, gopi ratnakaram wrote:
> Dear Jan Kiszka,
>
> Thankyou for the response,
> *It is possible but not wise unless you are deep into the I-pipe details=
.*
> Please provide me some help related to do this and what kind of details
> I-pipe details are needed to do this activity?
>

If you apply the I-pipe patch queue on kernel version different from the
one it has been developed for, you will likely run into merge conflicts.
Then you need to understand what was changed in the original kernel by
the commits, what changed in the target kernel and what needs to be done
to resolve the conflict correctly. That can be trivial or highly complex.

Even worse, there can be logical conflicts that do not cause merge
issues but will make the result fail during runtime. Then you need to be
able to debug the incorrect behavior and identify the incorrect or
missing changes on your target kernel.

IOW: You need to build a good understanding of both the kernel
subsystems changed by I-pipe as well as of I-pipe itself in order to
safely port it to a downstream or legacy kernel yourself.

> *But once you are, you also realize that using a distro kernel will only
> *
> *complicate things for this.*
>
> My question here is why there is no I-pipe patch available=C2=A0for 4.15=
 from
> the following xenomai site?
> https://xenomai.org/downloads/ipipe/v4.x/x86/

Because we only target long-term supported kernel versions. 4.15 is EOL
since 2 years now, so nothing you want to use anymore. The Ubuntu kernel
(I strongly suspect that this is what you are actually targeting) is
still maintained by Canonical. But it is also a downstream kernel with
additional changes that may cause their own conflicts. However, there is
generally no reason to use that particular kernel when changing it
anyway for the sake of Xenomai.

>
> *Just use the latest support long-term stable kernel with Xenomai (by no=
w
> 4.19-cip based) for you Ubuntu installation, just like we do for the
> Debian-based demo images [1]. *
> *
> *
> Can I patch higher version I-pipe patch for the kernel version I use?
> (Example: for linux kernel=C2=A0version 4.15.38 can I use the I-pipe 4.1=
9.y
> or should I use the same version of I-pipe patch).

Yes - but see my first comment on what can happen.

Best regards,
Jan

>
> --best regards
> R Gopi Krishna,
>
>
> On Mon, Mar 30, 2020 at 10:12 PM Jan Kiszka <jan.kiszka@web.de
> <mailto:jan.kiszka@web.de>> wrote:
>
>     On 30.03.20 10:53, gopi ratnakaram via Xenomai wrote:
>      > Team,
>      >
>      > I have a specific requirement that where i need to patch xenomai
>     3 to my
>      > linux kernel 4.15.38 which is running on Ubuntu16.04/Ubuntu18.04.
>     When I
>      > try checking with the following help from
>      >
>      > https://www.xenomai.org/pipermail/xenomai/2018-June/039004.html
>      >
>      > But, I was unable to apply/create arch specific packages.
>      >
>      > Is it possible to create ipipe patch to the corresponding kernel
>     4.15.38,
>      > if yes please let me know required steps to do the same.
>
>     It is possible but not wise unless you are deep into the I-pipe deta=
ils.
>     But once you are, you also realize that using a distro kernel will o=
nly
>     complicate things for this.
>
>     Just use the latest support long-term stable kernel with Xenomai (by=
 now
>     4.19-cip based) for you Ubuntu installation, just like we do for the
>     Debian-based demo images [1].
>
>     Jan
>
>     [1] https://gitlab.denx.de/Xenomai/xenomai-images
>


