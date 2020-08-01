MIME-Version: 1.0
References: <DB3PR0402MB36919E3001EDB630F10F9ACD9A710@DB3PR0402MB3691.eurprd04.prod.outlook.com>
 <CALLqZ8Sh7ktDzhc_onGTi6MKBr0yO3o6Sh-4_6TT7qt4EbRnHw@mail.gmail.com>
 <DB3PR0402MB36910851CD9DC0B2928437F09A4E0@DB3PR0402MB3691.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB36910851CD9DC0B2928437F09A4E0@DB3PR0402MB3691.eurprd04.prod.outlook.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Sat, 1 Aug 2020 00:31:34 -0400
Message-ID: <CALLqZ8RjYTsgvpOtT7uoTdmsDT6QsceyqyG=53WG7QW9=yCFjw@mail.gmail.com>
Subject: Re: [EXT] Re: Enable Xenomai on i.MX Platform
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Jul 30, 2020 at 10:54 PM Xiaodong Zhang <xiaodong.zhang@nxp.com> wrote:
>
> Hi Greg,
>    Thank you for your feedback. I also have plan to upload to i.MX next release (maybe Yocto L5.4.47) which will support i.MX8MP(the first i.MX SOC has NPU, ISP and TSN).
> I find some information about Dovetail in EVL project(https://evlproject.org/dovetail/ ), and do you mean Xenomai will reuse dovetail of EVL project for Linux Kernel 5 or future version ?
>
Yes, the plan at the moment is to reuse dovetail and port Xenomai as
the realtime core.  This will hopefully help with reducing the amount
of maintenance required.


-Greg

