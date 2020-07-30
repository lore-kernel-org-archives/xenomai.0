MIME-Version: 1.0
References: <DB3PR0402MB36919E3001EDB630F10F9ACD9A710@DB3PR0402MB3691.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB36919E3001EDB630F10F9ACD9A710@DB3PR0402MB3691.eurprd04.prod.outlook.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 30 Jul 2020 09:33:59 -0400
Message-ID: <CALLqZ8Sh7ktDzhc_onGTi6MKBr0yO3o6Sh-4_6TT7qt4EbRnHw@mail.gmail.com>
Subject: Re: Enable Xenomai on i.MX Platform
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
To: Xiaodong Zhang <xiaodong.zhang@nxp.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

HI,

On Thu, Jul 30, 2020 at 6:30 AM Xiaodong Zhang via Xenomai
<xenomai@xenomai.org> wrote:
>
> Hi Xenomai,
>
>  I ported ipipe patch and enable Xenomai 3.1 on i.MX Platform (i.MX6 seri=
es
> and i.MX8M based on Yocto L4.19.35 1.1.0 GA release), the below link will
> give more information.
Looks great.
>
> https://community.nxp.com/docs/DOC-347373
>
> https://community.nxp.com/docs/DOC-345893
>
> Later I and my colleague will focus on fix bugs, optimize real-time
> performance, add more RTDM i.MX drivers and improve system stability for
> i.MX6/8 platform.
>
Are your changes also coming up stream?

> BTW, I don=E2=80=99t see ipipe 5.4 patch, and can you tell me the plan wh=
en enable
> ipipe on Linux 5.4 kernel?
>
Currently the plan is to switch from using the ipipe to dovetail for
5.4.  With dovetail we shouldn't have to maintain separate repos per
architecture.

-Greg

>
>
>
>
> Thanks & Best Regards,
>
> Zhang Xiao Dong (=E5=BC=A0=E6=99=93=E4=B8=9C)
>
>
>
> NXP Semiconductor
>
> No. 192 Liangjing Rd., Pudong New Area, Shanghai 201203, P.R. China
>
> Tel: +86-21-2893-7154
>
> Fax: +86-21-2893-7444
>
>
>
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: image001.png
> Type: image/png
> Size: 22041 bytes
> Desc: not available
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20200730/b2464c31/=
attachment.png>
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: smime.p7s
> Type: application/pkcs7-signature
> Size: 9593 bytes
> Desc: not available
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20200730/b2464c31/=
attachment.bin>

