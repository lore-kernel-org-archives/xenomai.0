From: =?utf-8?Q?Deniz_U=C4=9Fur?= <deniz343@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: RTnet on Raspberry Pi 3B+
Message-Id: <DDED34AC-1834-4932-B053-AD8EEF810205@gmail.com>
Date: Thu, 8 Oct 2020 12:04:35 +0300
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello all,

I=E2=80=99m currently researching for a real-time sensor data =
acquisition system and I was thinking about using Raspberry Pi 3B+. =
Along with my move to making everything real-time, I also want to =
experiment with RTnet. Although from what I can understand, RPi=E2=80=99s =
ethernet module is not supported in RTnet.

Is RPi not supported in RTnet? If not, is there anything I can do to =
bring this feature?
Do I have any alternative for making TCP socket connection real-time =
using Xenomai on RPi?
Lastly, If RPi is an impossible target for RTnet, do we have any =
alternative embedded system that works with RTnet?

Thanks in advance.
Deniz.

Some important details:
ARCH: ARM
SoC: BCM2835
Linux: 4.14.36
Xenomai: 3.0.7
I-Pipe: 4.14.36-arm-1=

