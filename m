Message-ID: <441F6EDC.6020502@domain.hid>
Date: Tue, 21 Mar 2006 00:11:24 -0300
From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Synchronising TSC and periodic timer
References: <44172B67.2000609@domain.hid>
	<200603201142.27591.lbocseg@domain.hid>	<441EDD9B.20708@domain.hid>
	<200603201627.54738.lbocseg@domain.hid> <441F4494.5010803@domain.hid>
In-Reply-To: <441F4494.5010803@domain.hid>
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
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

Jan Kiszka escreveu:

>We discussed a lot about how to prevent the user shooting him/herself in
>the knee with inter-tick timestamps, but I still think that
>rtdm_clock_read_tsc() would even be worse in this regard.
> =20
>
What do you think abou this documentation:
"This function is meant to be used in periodic mode for getting a high=20
timestamp, independently from the system timer's tick.
Its return values should not be used mixed with rtdm_clock_read() values=20
because they are not syncronised.
Driver authors[developers?] are advised to state this on driver=20
documentation for the final users where returning these values to them=20
for avoiding confusion.

Note: This function is available for uniprocessor systems only in the=20
meantime."

I think it explains and will not make confusion in driver developers...=20
If sometime someone give a good solution to the syncronisation problem=20
between multiple processors, this can be changed...

 > ...

Rodrigo.

=09

=09
	=09
_______________________________________________________=20
Yahoo! doce lar. Fa=E7a do Yahoo! sua homepage.=20
http://br.yahoo.com/homepageset.html=20



