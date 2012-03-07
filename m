From: Bertram Stemer <bertram.stemer@domain.hid>
Date: Wed, 7 Mar 2012 12:46:09 +0100
Message-ID: <59395C11A1D1C44ABE7AD0566C50F68BCC15A49EDD@mary.at.omicron.at>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai-help] Cast a double value fails
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "'xenomai@xenomai.org'" <xenomai@xenomai.org>

Hi,
I'm using Xenomai 2.5.6 with Linux 2.6.36 on a PowerPC and=20
have written a real-time application that runs on an isolated
CPU (Kernel option isolcpus). When I start this application on=20
another core, where a plain Linux application runs I get=20
sporadically unexpected results in the non real-time application,=20
when casting a double to an integer?!

To reproduce this behavior I have a small non real-time test
application that runs in parallel to the RT application:
...
while (1) {
	int z =3D 4.0;
	if (z !=3D 4)
		printf("cast error detected!");
	/* sleep some microseconds */
}
...
=20
Does anyone know how this can happen? Is there a CPU utilization
bound for real-time applications that run on the same CPU with=20
plain Linux tasks?

Thanks in advance,
Bertram

