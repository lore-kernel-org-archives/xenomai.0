MIME-Version: 1.0
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Wed, 3 Apr 2019 09:55:38 +0200
Message-ID: <CAFc1U0uSt1WVzeDWfzPp+07SqCD=t=ET8X+2NXieYE0WE66Xfw@mail.gmail.com>
Subject: Xenomai kernel for BBB
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
To: xenomai@xenomai.org

Hi,

Xenomai kernel (-xenomai branches) is available for BBB (AM335x) from
https://github.com/beagleboard/linux for some kernel releases (4.4, 4.9,
4.14). I've tried 4.9 and 4.14 but jitter is very bad with latency tool (>
200 =C2=B5s).

According to Xenomai wiki, AM335x SoC is supported for "vendor branch",
hope this is the same thing (?)

Dos anybody use AM335x with success? I did it a long time ago with Xenomai
2 and 3.8.13 kernel.

thx


--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
