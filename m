From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Mon, 15 May 2017 10:47:09 +0000
Message-ID: <DB6PR0701MB24562E69AA670D2EF605A322B5E10@DB6PR0701MB2456.eurprd07.prod.outlook.com>
References: <DB6PR0701MB2456788DAE300E14759F9646B5E10@DB6PR0701MB2456.eurprd07.prod.outlook.com>,
 <2eb3cb3c-bbfd-32f1-0864-77749389813c@xenomai.org>,
 <DB6PR0701MB24566C9B89E527ACFA283E03B5E10@DB6PR0701MB2456.eurprd07.prod.outlook.com>
In-Reply-To: <DB6PR0701MB24566C9B89E527ACFA283E03B5E10@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] rt_task_bind returns -EINVAL when not using
 --enable-smp
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks for your response Philippe,

> --enable-smp in user-space entails no interaction with the kernel at
> all, this is only a matter of issuing memory barriers in the code flow
> to deal with lockless atomic sections.

still, is it expected that when not using --enable-smp my code fails?

> xeno-config --info would help.

root@bela:~# /usr/xenomai/bin/xeno-config --info
Xenomai version: Xenomai/cobalt v3.0.4 -- #f68a020 (2017-04-02 16:46:34 +02=
00)
Linux bela 4.4.62-ti-xenomai-r103 #1 Sat May 13 03:08:17 BST 2017 armv7l GN=
U/Linux
Kernel parameters: console=3DttyS0,115200n8 root=3D/dev/mmcblk0p2 rw rootfs=
type=3Dext4 rootwait coherent_pool=3D1M net.ifnames=3D0 quiet
I-pipe release #7 detected
Cobalt core 3.0.4 detected
Compiler: gcc version 5.4.1 20161213 (Linaro GCC 5.4-2017.01)
Build args: --with-core=3Dcobalt --enable-smp --enable-pshared --host=3Darm=
-linux-gnueabihf --build=3Darm CFLAGS=3D-march=3Darmv7-a -mfpu=3Dvfp3 build=
_alias=3Darm host_alias=3Darm-linux-gnueabihf

