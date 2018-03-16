From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
References: <48e48b6a-c767-1ae0-29cf-e59dd9c9c0d4@numalliance.com>
Message-ID: <0f1ccba1-bfe3-7d7b-bfd3-b17df3708fb0@numalliance.com>
Date: Fri, 16 Mar 2018 12:20:58 +0100
MIME-Version: 1.0
In-Reply-To: <48e48b6a-c767-1ae0-29cf-e59dd9c9c0d4@numalliance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] shared session and latest release
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>



Le 16/03/2018 =C3=A0 12:19, St=C3=A9phane Ancelot a =C3=A9crit=C2=A0:
> Hi,
>
> I upgraded my applications to latest release (next branch) .
>
> I do not manage to run the shared session , using session-label to run=20
> the program as user (fixed in a tunable config)

it fails as follow :
 =C2=A0=C2=A0 0"000.413| WARNING: [main] failed to initialize main shared=
 heap
 =C2=A0=C2=A0 0"000.480| WARNING: [main] setup call copperplate failed
 =C2=A0=C2=A0 0"000.508| BUG in __xenomai_init(): [main] initialization f=
ailed, EACCES

>
> my session name is numalliance/automat (automat corresponds to my=20
> group user id 1000)
>
> however , if I launch the program as root , it works.
>
> I checked /dev/rtdm files, they all have rw access for user/ group /=20
> other
>
> What else to check for ?
>
> Regards,
>
> S.Ancelot
>
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

