From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-core] RTDM and Timer functions
Date: Tue, 14 Mar 2006 16:40:18 -0300
References: <200603091443.25714.lbocseg@domain.hid>
	<200603141545.29301.lbocseg@domain.hid> <441712EB.5040401@domain.hid>
In-Reply-To: <441712EB.5040401@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200603141640.18539.lbocseg@domain.hid>
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

Em Ter=3DE7a 14 Mar=3DE7o 2006 16:00, Jan Kiszka escreveu:

>Rodrigo Rosenfeld Rosas wrote:
>> Em Ter=3DE7a 14 Mar=3DE7o 2006 13:59, Rodrigo Rosenfeld Rosas escreveu:
>>> Em Ter=3DE7a 14 Mar=3DE7o 2006 13:46, Jan Kiszka escreveu:
>>>>>>> ... Another one is for timeouts on short delays. In
>>>>>>> those cases, we want a good resolution, but this should be
>>>>>>> independent of the user's timer choice IMO.
>>>>>>
>>>>>> And this is something rtdm_clock_read_tsc() will obviously not be fo=
=3D
r.
>>>>>
>>>>> Please, take a look in my case. The specification recommends wait at
>>>>> least Xus before testing a bit. But the time to wait is not constant,
>>>>> it can vary a few microseconds. So, I busy wait Xus and then do some
>>>>> code like:
>>>>>
>>>>> rtdm_task_busy_sleep(X*1000);
>>>>> start_time =3D3D rtdm_clock_read[_tsc]();
>>>>> do {
>>>>> condition=3D3Dtestbit();
>>>>> } while (! condition && (time_passed(start_time) < TIMEOUT));
>>>>>
>>>>> But if the user specifies a periodic timer, with tickval=3D3D1ms, the=
n =3D
my
>>>>> driver will be too slow. I could busy wait TIMEOUT before testing, and
>>>>> it would be faster then the above code in this case. But I would like
>>>>> to go away as soon as possible, ie, just after the bit has been set...
>>>>
>>>> This is how the eepr100 driver of RTnet handles it, though RTnet would
>>>> not work very well in periodic mode. Actually, this has been ported ov=
=3D
er
>>>>
>>> >from Linux where you do not have a portable API for reading the TSC, I
>>>>
>>>> think.
>>>>
>>>> static inline int rt_wait_for_cmd_done(long cmd_ioaddr, const char *cm=
=3D
d)
>>>> {
>>>>    int wait =3D3D CONFIG_RTNET_DRV_EEPRO100_CMDTIMEOUT;
>>>>
>>>>    while (inb(cmd_ioaddr) !=3D3D 0) {
>>>>        if (wait-- =3D3D=3D3D 0)
>>>>            return 1;
>>>>        rtdm_task_busy_sleep(1000);
>>>>    }
>>>>    return 0;
>>>> }
>>>> (Hmm, BTW, de-inlining might be worth considering...)
>>>>
>>>> So this works at a polling period of 1 us, but you may also reduce it,
>>>> though this would certainly degrade the accuracy further. For sure, the
>>>> accuracy is slightly worse than with your pattern. Would this matter to
>>>> you?
>>>
>>> No, in my case it doesn't matter. I'll adopt this way of doing it.
>>
>> Thinking better, I would need such a function for registering the
>> timestamp of the captured frame on the irq handler...
>
>What will this timestamp be used for, relative time calculations? I just
>would like to remind that the output of rtdm_clock_read_tsc() will not
>be in sync with the system clock in periodic mode (one of my major
>concern: that driver writers forget this fact).

But that is exactly what I need. Suppose that a robot control system uses t=
=3D
wo=3D20
images to estimate the robot speed. The application may need a control loop=
=3D
=3D20
of, say, 100ms, putting the periodic timer set to 1, 10 or 100ms. But,=3D20
suppose that in each loop it takes two images in a short time interval (les=
=3D
s=3D20
then 100ms or even less then 1ms) and the real time interval is very=3D20
important. So the driver must pass the timestamp of each captured frame to=
=3D
=3D20
application loop. But those times shouldn't be multiple of the timer tick,=
=3D
=3D20
but the real time with all precision it can get.

I'm not talking especifically about this application, but giving you a gene=
=3D
ral=3D20
idea of what is not possible to do currently with RTDM if the application s=
=3D
et=3D20
the timer to periodic.

Regards,

Rodrigo.

	=09
_______________________________________________________
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!
http://br.acesso.yahoo.com


