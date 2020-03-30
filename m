Subject: Re: Regarding Xenomai patch to the kernel 4.15.38
References: <CAF_6Mayw_popagGGG14B+na6wtH2CFGeBnvYreRSUizQe14w6g@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <a4469868-3c21-8efd-7469-a9cd6e025742@web.de>
Date: Mon, 30 Mar 2020 18:42:26 +0200
MIME-Version: 1.0
In-Reply-To: <CAF_6Mayw_popagGGG14B+na6wtH2CFGeBnvYreRSUizQe14w6g@mail.gmail.com>
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
To: gopi ratnakaram <gopi.ratnakaram@svayarobotics.com>, xenomai@xenomai.org

On 30.03.20 10:53, gopi ratnakaram via Xenomai wrote:
> Team,
>
> I have a specific requirement that where i need to patch xenomai 3 to my
> linux kernel 4.15.38 which is running on Ubuntu16.04/Ubuntu18.04. When I
> try checking with the following help from
>
> https://www.xenomai.org/pipermail/xenomai/2018-June/039004.html
>
> But, I was unable to apply/create arch specific packages.
>
> Is it possible to create ipipe patch to the corresponding kernel 4.15.38=
,
> if yes please let me know required steps to do the same.

It is possible but not wise unless you are deep into the I-pipe details.
But once you are, you also realize that using a distro kernel will only
complicate things for this.

Just use the latest support long-term stable kernel with Xenomai (by now
4.19-cip based) for you Ubuntu installation, just like we do for the
Debian-based demo images [1].

Jan

[1] https://gitlab.denx.de/Xenomai/xenomai-images

