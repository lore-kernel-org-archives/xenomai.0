From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Message-ID: <e3076881-32d1-7a35-7769-632fc54a2ff7@numalliance.com>
Date: Mon, 18 Dec 2017 09:13:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] posix thread api vs linux pthread api
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

I have got a program that uses some xeno heap api functions for shared=20
memory access, but I would like to be able to run my program on the=20
secondary space for pthreads. This is not a hard realtime task.

Is there a flag in xenomai that permits specifying which pthread_=C2=A0 f=
unc=20
we use (xenomai or linux system pthread version) ?

or everything is managed by precise compilation flags ?

Regards,

S.Ancelot


