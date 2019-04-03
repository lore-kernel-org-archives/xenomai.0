From: Giulio Moro <g.moro@qmul.ac.uk>
Subject: Re: Xenomai kernel for BBB
Date: Wed, 3 Apr 2019 09:33:48 +0000
Message-ID: <AM0PR07MB5572224F2932E2B851C25557B5570@AM0PR07MB5572.eurprd07.prod.outlook.com>
References: <CAFc1U0uSt1WVzeDWfzPp+07SqCD=t=ET8X+2NXieYE0WE66Xfw@mail.gmail.com>
In-Reply-To: <CAFc1U0uSt1WVzeDWfzPp+07SqCD=t=ET8X+2NXieYE0WE66Xfw@mail.gmail.com>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

we use this one for 4.14 https://github.com/RobertCNelson/ti-linux-kernel-d=
ev/tree/ti-linux-xenomai-4.14.y (and the 4.4 branch there for 4.4). These a=
re scripts to "rebuild a kernel": it checks out the appropriate vendor (TI)=
 branch, and merges the corresponding ipipe patches in.

Known issues I encountered so far with 4.14 are here https://forum.bela.io/=
d/841-4-14-kernel-work-in-progress.

Latency is good, comparable to previous versions we used. I get something l=
ike this when running for a few minutes with dohell on the side:

RTS|      2.905|     37.935|     62.660|       0|     0|    00:02:52/00:02:=
52


________________________________________
From: Xenomai <xenomai-bounces@xenomai.org> on behalf of Pierre FICHEUX via=
 Xenomai <xenomai@xenomai.org>
Sent: 03 April 2019 08:55
To: xenomai@xenomai.org
Subject: Xenomai kernel for BBB

Hi,

Xenomai kernel (-xenomai branches) is available for BBB (AM335x) from
https://github.com/beagleboard/linux for some kernel releases (4.4, 4.9,
4.14). I've tried 4.9 and 4.14 but jitter is very bad with latency tool (>
200 =B5s).

According to Xenomai wiki, AM335x SoC is supported for "vendor branch",
hope this is the same thing (?)

Dos anybody use AM335x with success? I did it a long time ago with Xenomai
2 and 3.8.13 kernel.

thx


--

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code

