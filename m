MIME-Version: 1.0
In-Reply-To: <4C136558.4070002@domain.hid>
References: <AANLkTim0tClnDQPN3u5ozJSEU6BcX--Xf9Ekw00ADvgy@domain.hid>
	<4C1353D8.2060507@domain.hid>
	<AANLkTik39wezPyRC-myOQi_etA5EPAg-LgzSqyO40IX7@domain.hid>
	<4C136558.4070002@domain.hid>
Date: Sun, 13 Jun 2010 01:14:17 +0800
Message-ID: <AANLkTim0yd_MTu3ItT9aecUmH0yt1nj3TWbFVMcfcFMB@mail.gmail.com>
From: Everett Wang <everteq@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] error on rt_dev_read, code Success,
	what does it mean?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Sat, Jun 12, 2010 at 6:45 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Everett Wang wrote:
>> Thanks. I looked my code again, which is modified from example
>> cross-link.c. The section looks like:
>>
>> ...
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irq_time =3D rx_event.rxpend_timestam=
p;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 read =3D rt_dev_read(read_fd, &write_tim=
e, sz);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (read =3D=3D sz) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 read_time =3D rt_timer_r=
ead();
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("%3d |%16llu |%16=
llu |%16llu\n", nr,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irq_time =
=A0- write_time,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0read_time=
 - irq_time,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0read_time=
 - write_time);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nr++;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (read < 0 ) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf(RTASK_PREFIX "err=
or on rt_dev_read, code %s\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strerror(=
-err)); <<<<<<<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf(RTASK_PREFIX "onl=
y %d / %d byte received \n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0read, sz)=
;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> ...
>> I guess I should change the strerror(-err) to strerror(-read).
>
> Indeed, the example suffers from some copy&paste mistakes. Same for the
> write path. And closing in a loop is no longer required. A cleanup is
> needed.
>
>> If I do
>> that, I some
>> times get a " code input/output error". That is better. What can cause
>> input/output error?
>
> Try RTSER_RTIOC_GET_STATUS to learn more.

Thanks for answer my questions, I added

err =3D rt_dev_ioctl(gps_fd,
                        RTSER_RTIOC_GET_STATUS, &serstatus);
printf(STASK_PREFIX "Error code line_status=3D%d
modem_status=3D%d\n",serstatus.line_status, serstatus.modem_status);

This prints a message:

gps_task: Error code line_status=3D98 modem_status=3D187

Line_status bits are  RTSER_LSR_TRANSM_EMPTY , RTSER_LSR_THR_EMTPY,
RTSER_LSR_OVERRUN_ER

and modem status bits:
 RTSER_MSR_DCD, 	RTSER_MSR_DSR ,RTSER_MSR_CTS, 	RTSER_MSR_DDCD,
RTSER_MSR_DDS, RTSER_MSR_DCTS

Does it caused by "RTSER_LSR_OVERRUN_ER"?
The GPS device outputs upto 450 characters every 0.1 second.

>
>> I get my serial port in that state consistently
>> when I
>> finish running my GPS program. I can reset it to a usable serial port
>> again by remove and re-load xeno-16550A module.
>
> Re-opening the rtser port, ie. restarting your program doesn't help?
> Does re-plugging the GPS mouse change the picture? If yes, you may have
> to reset its hardware somehow. If no, there might be a sticky state in
> our serial driver, ie. a bug.

I can only run my program once without the input/output error.
Subsequenct runs immediately yield an input/output error. The
situation will not go away with remove and reattach power to the GPS
device. But removal of the xeno-16550A.ko module and re-load it
sets the serial port back to usable state.

Without removal and reload module procedure  above, if the GPS power
is off and I run the my program again, it will yield a read timeout
error, which make sense since  gps is not output anything. So it seems
the problem is caused by too many characters being sent to the serial
port from GPS?

Thanks,

Everett
>> But setserial -G can't
>> see anything unusual. Could it be some unclosed serial port?
>>
>> My simple code is attached.
>>
>> Thanks,
>>
>> Everett
>>
>
> Jan
>
>

