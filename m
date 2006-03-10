From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-core] RTDM and Timer functions
Date: Fri, 10 Mar 2006 10:54:40 -0300
References: <200603091443.25714.lbocseg@domain.hid> <4410911F.4070507@domain.hid>
In-Reply-To: <4410911F.4070507@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200603101054.41122.lbocseg@domain.hid>
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
Cc: xenomai-core <xenomai@xenomai.org>

Em Quinta 09 Mar=3DE7o 2006 17:33, Jan Kiszka escreveu:

>Rodrigo Rosenfeld Rosas wrote:
>> Hi Jan,
>>
>> I'm still concerned about the future of RTDM and timer functions. I think
>> there should be some function for starting the timer manually, since the
>> automatic feature don't work great for RTDM drivers.
>>
>> It is not nice to have to run the latency (or any other) program for
>> starting the timer before I can load my driver. And it is not suffice to
>> run it once I booted. After I open/close my rtdm device and reload my
>> driver the problem will occur again and I'll have to re-run the latency
>> program.
>
>Sorry I don't see the problem here.
>
># modprobe xeno_nucleus; cat /proc/xenomai/timer
>status=3D3Doff:setup=3D3D1392:tickval=3D3D0:jiffies=3D3D0
>
># modprobe xeno_rtdm; cat /proc/xenomai/timer
>status=3D3Doneshot:setup=3D3D1392:tickval=3D3D1:jiffies=3D3D8113917792696
>
>So the timer is running right since when rtdm is loaded?!

Yes, here too.

>And that simple heartbeat rtdm example on my rt-addon homepage now
>cleanly runs even without any further helper to start some timer.

Yes, here too. You are right, once the timer is in oneshot mode. My driver=
=3D
=3D20
loads correctly without the helper. Then I start a user application that=3D=
20
changes the timer to periodic mode and uses my driver. When I reload my=3D20
driver, now in periodic mode, the problem raises.

It seems, there is no problem when the timer is set to oneshot. But when=3D=
20
turning it to periodic, at least one of rtdm_task_busy_sleep() or=3D20
rtdm_clock_read() doesn't seem to work. See below:

cat /proc/xenomai/timer
  status=3D3Dperiodic:setup=3D3D188:tickval=3D3D100000:jiffies=3D3D19972453

start_time =3D3D rtdm_clock_read();
rtdm_task_busy_sleep(84000);
temp_time =3D3D rtdm_clock_read();
rtdm_printk(KERN_INFO "Should be near 84000: %u\n", (unsigned int)
                   (temp_time-start_time));

Sometimes the result is "Should be near 84000: 100000", that is kind of=3D20
correct, since the tickval is 100000, although I think that those functions=
=3D
=3D20
in the RTDM driver context should be independent of the tick value set by t=
=3D
he=3D20
user program... Maybe using oneshot in the driver calls and periodic in the=
=3D
=3D20
application... I really don't know what would be the best approach here...

But the worst case is that sometimes I get "Should be near 84000: 0" which=
=3D
=3D20
clearly is a incorrect result.

After I run the latency program, the timer turns to be oneshot again and=3D=
20
everything goes right.

What can I do to solve this problem?

Thanks in advance,

Rodrigo.

	=09
_______________________________________________________
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!
http://br.acesso.yahoo.com


