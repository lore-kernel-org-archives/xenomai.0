From: Shabaz Yousaf <shabaz_yousaf@hotmail.com>
Subject: Xenomai install question (get error running test apps)
Date: Mon, 12 Aug 2019 01:39:39 +0000
Message-ID: <DB6P18901MB021417660CD32E74B1F2201184D30@DB6P18901MB0214.EURP189.PROD.OUTLOOK.COM>
Content-Language: en-GB
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

Apologies in advance, this is probably really basic since I'm a beginner, b=
ut I'm stumped and have searched for an answer.

In a nutshell, I installed a pre-built Xenomai kernel, and then tried to in=
stall the remainder of it and run a sample app, but I get an error:
BUG in __xenomai_init(): [main] running non-SMP libraries on SMP kernel?


Here's the detail:
I've installed the pre-built Xenomi kernel on a BeagleBone Black using some=
 script it already has, and uname -a looks good:
Linux beaglebone 4.14.108-ti-xenomai-r114 #1 SMP PREEMPT Sun Aug 4 08:52:45=
 UTC 2019 armv7l GNU/Linux

Next, to get the remainder Xenomi stuff, I did the following (I presumed it=
 was Xenomi 3.0.9, but I wasn't sure, I did search in the github beagleboar=
d/linux commits here:
https://github.com/beagleboard/linux/tree/4.14-xenomai  but unfortunately c=
ouldn't see where it was specified. There was a version.h file here:
https://github.com/beagleboard/linux/blob/4.14-xenomai/include/xenomai/vers=
ion.h   but it only had text like XENO_VERSION_STRING with no number)


wget https://xenomai.org/downloads/xenomai/stable/latest/xenomai-3.0.9.tar.=
bz2

bunzip2 xenomai-3.0.9.tar.bz2

tar xvf xenomai-3.0.9.tar

cd xenomai-3.0.9

./configure CFLAGS=3D"-march=3Darmv7-a -mfpu=3Dvfp3" LDFLAGS=3D"-march=3Dar=
mv7-a -mfpu=3Dvfp3"

make

make install

When I try to run any of the sample/test applications (such as /usr/xenomai=
/bin/xeno-test), I get an error:
BUG in __xenomai_init(): [main] running non-SMP libraries on SMP kernel?

I think I'm probably doing something silly, and have googled around, but ne=
ed a pointer to where I may have messed up.
Many thanks,

Shabaz.

