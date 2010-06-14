Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
References: <op.vdpsychunuwxn3@domain.hid>
	<20100603143550.GD4438@domain.hid>
Date: Mon, 14 Jun 2010 16:52:27 +0200
MIME-Version: 1.0
From: "stephane ancelot" <sancelot@domain.hid>
Message-ID: <op.veaoxplznuwxn3@domain.hid>
In-Reply-To: <20100603143550.GD4438@domain.hid>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] rt_pipe_open / rt_pipe_delete bug
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Andreas Glatz <andreasglatz@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

H
Le Thu, 03 Jun 2010 16:35:50 +0200, Andreas Glatz =20
<andreasglatz@domain.hid> a =C3=A9crit:

> On Thu, Jun 03, 2010 at 04:09:38AM -0400, stephane ancelot wrote:
>> Hi,
>>
>> tryied in v2.4.10 :
>>
>>
>> I have opened a /dev/rtp7 pipe , and deleted it.
>>
>> if I launch again the same program, rt_pipe_open replies with -EBUSY =20
>> ....
>>
>
> Can you describe the sequence how you are invoking =20
> rt_pipe_open()/open()/rt_pipe_delete()?
>
> If the following description applies to you then you discovered what =20
> we've discovered
> before and there is no easy fix for that as far as I know.
>
> 1) create pipe with rt_pipe_open()
> 2) connect to it by opening /dev/rtp7 with open()
> 3) delete pipe with rt_pipe_delete() (for example by killing the Xenoma=
i =20
> application)
> 4) create same pipe again with rt_pipe_open() (for example by restartin=
g =20
> the
>    Xenomai application with /dev/rtp7 is still open)
>
> --> rt_pipe_open() reports an error
>

Yes, but it has worked in xeno 2.1 .... Is there a work around ? only =20
hacking it ?
Best Regards
S.Ancelot

> Andreas

