MIME-Version: 1.0
Date: Thu, 17 Jul 2008 09:49:19 +0200
From: Matthieu <matthieu.connaulte_xenomai@domain.hid>
Message-ID: <783552d428d22a5abdf49c868190b52d@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] xenomai scheduler's ticks period
Reply-To: matthieu.connaulte_xenomai@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I have a problem with xntbase_update(wind_tbase,1000000); because it
doesn't give me a 1ms period. The period is given as a count of nanosecon=
ds
as it is said in the API documentation. I search solution around
tick/nanoseconds conversion or periodic/aperiodic timebase but I didn't
solve my problem. Moreover, when I call this instruction,
/proc/xenomai/timebases gives me a vxworks resolution of 1000000, what is
correct, but the period seem's to be 0.452ms . Could you tell me what I'v=
e
done wrong ?

Thank you.

Matthieu.



