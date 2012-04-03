Message-ID: <4F7AA402.3040803@domain.hid>
Date: Tue, 03 Apr 2012 09:17:22 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAM1yFZ9GKhzvHNDufRQ2aJOH-gJkwv2-FmyhUx3RyS=06DSo4w@domain.hid>
In-Reply-To: <CAM1yFZ9GKhzvHNDufRQ2aJOH-gJkwv2-FmyhUx3RyS=06DSo4w@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Is it compulsory to apply the PREEMPT_RT patch
 (to Linux) when running Xenomai on the top of it?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

On 04/03/2012 08:56 AM, Anisha Kaul wrote:
> Greetings,
>
>> From "Life with Adeos":
> http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Life-with-Adeos-=
rev-B.pdf
>
>> Both the real=ADtime nucleus and the Linux kernel should handle the case=
 where a high priority thread is kept from running because a low priority o=
ne holds a contended resource>  for a possibly unbounded amount of time. Xe=
nomai provides this support, but only the PREEMPT_RT variant does so for th=
e Linux kernel. For this reason, Xenomai keeps an
>> eye and provides support for the current developments of PREEMPT_RT, alb=
eit the mainline kernel still remains the system of reference for now.
>
>
> I don't understand whether the above quote implies that it necessary
> to apply the PREEMPT_RT patch (to Linux) when working with Xenomai on
> Linux?
> Please guide.
>

No.

> -Anisha
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>


--=20
Philippe.

