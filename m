References: <e3076881-32d1-7a35-7769-632fc54a2ff7@numalliance.com>
From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Message-ID: <cfd7e137-b698-ac56-a14b-6ff4e5b905fc@numalliance.com>
Date: Mon, 18 Dec 2017 09:15:20 +0100
MIME-Version: 1.0
In-Reply-To: <e3076881-32d1-7a35-7769-632fc54a2ff7@numalliance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] posix thread api vs linux pthread api
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org



Le 18/12/2017 =C3=A0 09:13, St=C3=A9phane Ancelot a =C3=A9crit=C2=A0:
> Hi,
>
> I have got a program that uses some xeno heap api functions for shared=20
> memory access, but I would like to be able to run my program on the=20
> secondary space for pthreads. This is not a hard realtime task.
>
> Is there a flag in xenomai that permits specifying which pthread_ func=20
> we use (xenomai or linux system pthread version) ?
>
> or everything is managed by precise compilation flags ?
>
I mean cobalt /mercury ?
> Regards,
>
> S.Ancelot
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


