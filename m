From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Subject: maximum number of xenomai processes allowed
Message-ID: <89c2b570-ba8b-59b7-49e4-b8913fa5552f@numalliance.com>
Date: Thu, 7 Feb 2019 12:02:46 +0100
MIME-Version: 1.0
Content-Language: fr
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

After running a given amount of xenomai processes, I can no more launch=20
more processes.

They are failing with next message.

 =C2=A0 0"000.000| WARNING: [main] pthread_setschedparam failed (prio=3D-=
1)
 =C2=A0=C2=A0 0"000.000| WARNING: [main] setup call cobalt failed
 =C2=A0=C2=A0 0"000.000| BUG in xenomai_init(): [main] initialization fai=
led, ENOMEM

It looks like there is a limitation on the number of xenomai processes.

Where can I hack it ?

Regards

Steph

