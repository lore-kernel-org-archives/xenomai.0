From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-core] RTDM and Timer functions
Date: Tue, 14 Mar 2006 19:32:55 -0300
References: <200603091443.25714.lbocseg@domain.hid>
	<200603141640.18539.lbocseg@domain.hid> <4417279B.4030103@domain.hid>
In-Reply-To: <4417279B.4030103@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200603141932.55374.lbocseg@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

I really tried to not answer this message and finish the "endless thread" y=
=3D
ou=3D20
mentioned, but I couldn't resist. ;) Maybe this will be the last post from =
=3D
my=3D20
own on this thread and will begin writing in the new thread. See below,=3D20
please.
____________________________________________________________
Em Ter=3DE7a 14 Mar=3DE7o 2006 17:29, Jan Kiszka escreveu:

>...
>
>Ok, your framework is effectively aiming for relative times here, that's
>clear now. But your driver will deliver individual frames with absolute
>timestamp, right?

Right.

>Then it's up to the user to NOT mix up these=3D20
>timestamps with dates obtained from the system clock. You will have to
>state this clearly!

Sure, of course. No problem with that.

>Moreover, when considering the TSC as high-resolution timestamp source,
>this is not applicable on SMP / multicore systems. Those tend to have
>unsynchronised and drifting TSCs. So if the first picture was taken on
>one CPU and the second on some other...

Unfortunately I can not arguee on that for now since I know almost nothing=
=3D
=3D20
about SMP systems. I'll take a look on the topic and hopely soon I'll retur=
=3D
n=3D20
you what I think about it.

>> I'm not talking especifically about this application, but giving you a
>> general idea of what is not possible to do currently with RTDM if the
>> application set the timer to periodic.
>
>And as I have this general view in mind, I want to avoid that the TSC
>issue gets exported via RTDM drivers to the user. That's already
>problematic for the other skins, but having to write special notes all
>over the documentation of dozens of driver using mixed clocks would be
>very unhandy.

I don't understand why adding a new function like this would change a lot t=
=3D
he=3D20
documentation. I really can not see your worries... If you could give me a=
=3D
=3D20
practical example, maybe it would be easier for me...

>I see the need for having a high-resolution timestamp aside a
>low-overhead and low-resolution timer now,=3D20

good, got an ally. ;)

>and I think we need to look=3D20
>for a way to avoid its negative sides.

=3D46irst I need to understand better what exactly are the negative sides...

>Not sure yet if it will be=3D20
>feasible, but I will come up with a new thread on this topic soon...

Yes, I've seen. I'll discuss next messages there.

Thank you,

Rodrigo.

=09

=09
	=09
_______________________________________________________=20
Yahoo! doce lar. Fa=E7a do Yahoo! sua homepage.=20
http://br.yahoo.com/homepageset.html=20



