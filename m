Message-ID: <1384955931.52735.YahooMailNeo@web122604.mail.ne1.yahoo.com>
Date: Wed, 20 Nov 2013 05:58:51 -0800 (PST)
From: Giuseppe Iellamo <peppedx@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] - RTDM and other Linux Kernel Facilities (device tree /
	sysfs)
Reply-To: Giuseppe Iellamo <peppedx@gmail.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi all, =0A=0A=0AI finally managed to run a xenomai userspace task on a Bea=
gleBoardBlack with xenomai 2.6.3 on linux 3.8.13, and it works fairly well,=
 but at the moment the kernel driver I use are linux platform driver with t=
he interaction happening via sysfs.=0ASo I know that sooner or later the wa=
y is to migrate this driver from standard linux to RTDM driver, in order to=
 remove unwanted mode switches.=0A=0AThe thing is that from the examples I'=
ve found it seems the RTDM driver are pretty much char driver. Is it possib=
ile for an RTDM driver to interact with the device tree and to use sysfs? D=
o you have any pointer to some "interesting" driver I could study to unders=
tand RTDM model more?=0A=0AThank you very much,=0AGiuseppe=0A
