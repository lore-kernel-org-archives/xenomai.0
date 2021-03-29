MIME-Version: 1.0
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Mon, 29 Mar 2021 11:20:13 +0200
Message-ID: <CAFc1U0s93=zDEQA9X+QyGD=miNAHdhKVTwn0YPbsAAysChdMyA@mail.gmail.com>
Subject: Arm64 jitter
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
To: xenomai <xenomai@xenomai.org>

Hi all,

I=E2=80=99ve been using Xenomai-3.1/I-pipe for several months on Pi 3 B/B+ =
with
mainline kernel (4.19.128 and 4.19.144, arm). I had good results (about 30
=C2=B5s jitter) with latency + dohell (or latency + hackbench).

Unfortunately, a new arm64 test on  5.4.72 or 5.4.107
(ipipe-core-5.4.107-arm64-1 tag) leads to a  70 =C2=B5s jitter on the same
board.

I know I-pipe support is recent for arm64 but do you have any idea about
the problem? What are the results on other Arm64 boards such as iMX, or
OMAP ?


Please note, I removed the warnings about APM/ACPI/CPU freq/MIGRATION from
the kernel config.


Thx by advance


Regards

--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
