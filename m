From: "Charlton, John" <john.charlton@domain.hid>
Date: Fri, 19 Dec 2008 10:16:09 -0500
Message-ID: <CF7FB0793253794F9F45991443E5FE2003C951B97F@us194mx002.tycoelectronics.net>
References: <8b216e9e0812180831n6ebf4ff1gcb990864ba112eab@domain.hid>
	<494A7ED0.8090008@domain.hid>
	<8b216e9e0812180943v1ecc3fcasb45732cd9a58cde2@domain.hid>
	<494A8F3E.9090906@domain.hid>
In-Reply-To: <494A8F3E.9090906@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai-help] Xenomai OpenEmbedded cross compile test applications
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>
Cc: "openembedded-devel@domain.hid" <openembedded-devel@domain.hid>

Using the cross compile environment for OpenEmbedded i686 angstrom of xenom=
ai-2.4.4 described below I built the xenomai test application trivial-perio=
dic in xenomai-2.4.4/examples/native.  I copied the executable to the targe=
t system.  Since there is no /etc/ld.so.conf.d directory in the OE root fil=
e system, I made one and put the xenomai library path in the xenomai.conf f=
ile.  The xenomai.conf file just has the one directory: /usr/local/lib whic=
h does not even exist in the target file system.  I modified xenomai.conf t=
o: /usr/xenomai/lib where the xenomai library files are actually located.  =
I also copied xenomai.conf to /etc and set LD_LIBRARY_PATH=3D/usr/xenomai/l=
ib.

When I execute the trivail-periodic application on the target (NANO-7240) t=
he console hangs and nothing happens.  I also ran trivial-periodic on a non=
 cross compiled laptop build of xenomai and it runs as expected displaying =
the times on the console output. I login to the target using ssh and it is =
alive.  The trivial-periodic process shows up in the ps list as:
 3077 root            Z   [trivial-periodi]
So it is a zombie.  I can kill it with kill -9 3077 and that releases the c=
onsole.
Any help on this issue is welcome.

Also, how do I run the xenomai/src/testsuite applications in a target (non =
build) environment?

Background:
I have applied the xenomai 2.4.4 patch to kernel 2.6.25.11.  I built the ke=
rnel and installed it on a ext2 flash partition and it boots on the target =
system. The /proc/xenomai directory shows up so xenomai seems to be running=
.  I built the xenomai user mode with the following commands:

Set the following:
export XENOMAI_ROOT=3D/home/us075929/projects/oe/xenomai-2.4.4
export XENOMAI_BUILD=3D/home/us075929/projects/oe/build-xenomai-2.4.4

cd $XENOMAI_BUILD
$XENOMAI_ROOT/configure --disable-x86-tsc --host=3Di686-angstrom-linux

I am not sure what tsc refers to.  The only two parameters in my kernal con=
figuration that come up are 'time stamp counter' and 'touch screen device s=
upport' both of which are disabled.  Since TSC is enabled by default and st=
rong binding I disabled it in the xenomai configuration.

The xenomai configure goes smoothly.  I then install xenomai user support t=
o a staging directory as follows:

export DESTDIR=3D/home/us075929/projects/oe/staging-linux-2.6.25.11

cd $XENOMAI_BUILD
make install

The $DESTDIR/dev and $DESDIR/usr/xenomai are installed as expected.  I copy=
 those directories to the target root file system, boot the target and run =
the trivial-periodic application as described above.

--John

