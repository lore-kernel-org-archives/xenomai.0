From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Date: Mon, 30 Jan 2006 16:11:52 -0200
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200601301611.53089.lbocseg@domain.hid>
Subject: [Xenomai-help] RTDM timing problems
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

I just can't understand what is happening.

The above code on my driver initialization gives the following results.

        start_time =3D rtdm_clock_read();
	rtdm_task_busy_sleep(43000);
	temp_time =3D rtdm_clock_read();
	   rtdm_printk(KERN_INFO "%u - %u =3D %u\n",(unsigned int) temp_time, (uns=
igned=20
int) start_time, (unsigned int) (temp_time-start_time));

	   rtdm_printk(KERN_INFO "%u - %u =3D %u\n",(unsigned int)=20
(temp_time&0xffffffff), (unsigned int) start_time&0xffffffff, (unsigned int=
)=20
((temp_time-start_time)&0xffffffff));


As I expected, both printk gave the same (wrong?) result:
3175950208 - 2800623168 =3D 375327040

I was waiting something near to 43000, shouldn't I?

Please, can someone explain me what is going on...

Thanks,

Rodrigo.

=09

=09
	=09
_______________________________________________________=20
Yahoo! doce lar. Fa=E7a do Yahoo! sua homepage.=20
http://br.yahoo.com/homepageset.html=20



