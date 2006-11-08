Message-ID: <4551F26A.8050209@domain.hid>
Date: Wed, 08 Nov 2006 16:06:18 +0100
From: Jean-Luc Pamart <jlpamart@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] LATENCIES > 100 us or CRASH WITH X
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

Hello

I am a newbie with Xeno. My goal for the beginning of 2007 is to launch=20
a project for 4 french studiants : a box with Linux embedded and a usb=20
camera. The embedded application will analyse the movies in Real time=20
and lead a mobile machine with CAN-BUS.
Now i play with Xeno for my knowledge (without specific hardware) :  a=20
little linux installed in a usb key with a little embedded distrib =20

- vanilla kernel 2.6.16 with patch for usb [.config is joint]
- Xenomai 2.1.2
- essentially BusyBox
- for xenomai : only "latency" directory and libs in usr/libs
I have checked "SMI woraround" for the kernel.
In BIOS I have UNchecked  "legacy usb".

=20
my Desktop PC (a AMD ATHLON) can boot with this little vanilla kernel and
1/ a little embedded distrib of my own

OR

2/ a complete mandrake 9.1 on a partition of a classic hard disk

I have 2 differents problems when I lauch this :

1/ with the linux embedded directories on the usb key
high latency > 100 us are ok ? perhaps usb work is not compatible with RT ?


2/ with the complete mandrake 9.1 :
it crashes X after 1 or few minutes.
What is the relation between X and Xenomai ?
Is Xenomai compatible with X ?


Best Regards
   =20
joint : the complete list of the directories

=09

=09
	=09
___________________________________________________________________________=
=20
D=E9couvrez une nouvelle fa=E7on d'obtenir des r=E9ponses =E0 toutes vos qu=
estions !=20
Profitez des connaissances, des opinions et des exp=E9riences des internaut=
es sur Yahoo! Questions/R=E9ponses=20
http://fr.answers.yahoo.com


