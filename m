From: Marcel Van Mierlo <Marcel.VanMierlo@marel.com>
Date: Thu, 19 May 2016 14:04:55 +0000
Message-ID: <AM4PR05MB174700B5C16BC1827BFEC363914A0@AM4PR05MB1747.eurprd05.prod.outlook.com>
References: <2tp93g0j23ghsr5l30as2gwu.1463605197163@email.android.com>,
 <20160518210815.GF13609@hermes.click-hack.org>
In-Reply-To: <20160518210815.GF13609@hermes.click-hack.org>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] xenomai 3 on the BBB (beaglebone black)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Yes, it is possible. You need to align the versions of the kernel, ipipe an=
d xenomai. The following work:

xenomai 3.0
ipipe-core-3.18.20-arm-6.patch (I think)

Kernel 3.18 for the BBB, as per:
https://eewiki.net/pages/viewpage.action?pageId=3D43844370&navigatingVersio=
ns=3Dtrue

Apply the ipipe patch once you have verified a working vanilla Kernel build=
 via Robert Nelsons website.=20


Cheers.

______________________________
From: Xenomai <xenomai-bounces@xenomai.org> on behalf of Gilles Chanteperdr=
ix <gilles.chanteperdrix@xenomai.org>
Sent: 18 May 2016 22:08
To: Antoine Rennuit
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] xenomai 3 on the BBB (beaglebone black)

On Wed, May 18, 2016 at 09:00:01PM +0000, Antoine Rennuit wrote:
>
>
>
> Hi all,
>
>
> I can find no information on getting xenomai 3 on the BBB, anywhere on th=
e internet. Does it mean it is not possible to install xenomai 3 on the BBB=
? This is weird, no?

Hi,

we do not provide board-specific installation instructions: the
installation instructions do not depend on the board you use. See
the generic installation instructions here (see, you do not need to
look for them "anywhere on the internet", just on xenomai website):
https://xenomai.org//installing-xenomai-3-x/

The real question being, is the processor used by your board
supported by Xenomai? If you want to use xenomai over preempt_rt,
then the question is whether preempt_rt runs with this processor, we
do not keep track of this on Xenomai website yet, if you want to use
Xenomai over dual kernel, then the question is whether the I-pipe
patch has support for this processor. The answer is here:
https://xenomai.org/embedded-hardware/#Supported_SoC

Regards.

--
                                            Gilles.
https://click-hack.org

_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
https://xenomai.org/mailman/listinfo/xenomai=

