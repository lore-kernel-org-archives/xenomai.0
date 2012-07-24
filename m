From: Michael Lausch <michael.lausch@omicron.at>
Date: Tue, 24 Jul 2012 08:49:40 +0200
Message-ID: <6B3AC2788014DD49B43AF9611365BBAA21B0B95718@mary.at.omicron.at>
References: <6B3AC2788014DD49B43AF9611365BBAA21B0B94DE9@mary.at.omicron.at>
	<5009902B.7070705@xenomai.org>
	<6B3AC2788014DD49B43AF9611365BBAA21B0B954F3@mary.at.omicron.at>
	<500D298C.6080601@xenomai.org>
	<6B3AC2788014DD49B43AF9611365BBAA21B0B9550A@mary.at.omicron.at>
In-Reply-To: <6B3AC2788014DD49B43AF9611365BBAA21B0B9550A@mary.at.omicron.at>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] xenomai 2.6.1 on ixp4xx hangs on boot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Lausch <michael.lausch@omicron.at>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,
I've some patches lying around against linux 3.0.x and xenomai 2.6 which co=
mpile and=20
the "No kuser TSC emulation" (sp?)  message when starting a xenomai applica=
tion is not printed any more.
I will merge them with the ipipe patch mentioned  in your post. (have i men=
tioned, i don't like outlook?).=20

Can you point me to an acid test which i can use to verify if kuser TSC emu=
lation is working correctly?

-----Original Message-----
From: xenomai-bounces@xenomai.org [mailto:xenomai-bounces@xenomai.org] On B=
ehalf Of Michael Lausch
Sent: Monday, July 23, 2012 12:48 PM
To: Gilles Chanteperdrix
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] xenomai 2.6.1 on ixp4xx hangs on boot

I'll be looking into this.=20

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]=20
Sent: Monday, July 23, 2012 12:38 PM
To: Michael Lausch
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] xenomai 2.6.1 on ixp4xx hangs on boot

On 07/23/2012 12:28 PM, Michael Lausch wrote:

> Hi,
> Yep this fixes the boot error.


Good news.=20

We have a pending issue on ixp4xx however: ixp4xx is the only arm SOC=20
port not  using the "kuser" tsc emulation. It still works with xenomai=20
2.6, but xenomai 3.x requires the arm SOC ports to use the kuser tsc.

I had done the necessary modifications at some point in the past:
http://git.denx.de/ipipe.git/?p=3Dipipe.git;a=3Dcommit;h=3Dcbd591ed5797f105=
ff45e04cca3bc939388624ea

But it did not work, so we decided to revert it. Now, it would be nice=20
if you could try it again and see if it still does not work.


--=20
                                                                Gilles.
_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
http://www.xenomai.org/mailman/listinfo/xenomai

