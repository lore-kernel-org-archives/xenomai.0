MIME-Version: 1.0
From: Pavel Anistratov <pavel903@gmail.com>
Date: Wed, 11 Mar 2015 20:48:59 +0600
Message-ID: <CAC=FX11g823+4e50Tx4yDkp9ukGp588Qunp5epOFgFDc9EgGew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] irqbench: irqloop device or resource busy
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I=E2=80=99m trying to test interrupt handling from parallel port using irql=
oop
program from irqbench, but when I try to start irqloop I get an error:
$ root@debian:/home/user/xenomai-2.6.4/src/testsuite/irqbench# ./irqloop -i=
 1
$ irqloop: error starting test: Device or resource busy

I loaded kernel module with modprobe xeno_irqbench command, but the
problem seems to occur during the first access command:
ioctl(benchdev, RTTST_RTIOC_IRQBENCH_START, &config)
How to solve this problem?

I=E2=80=99m using the last stable release Xenomai 2.6.4 and Debian 7.8
(wheezy) 32-bit with kernel 3.16.0

--
Pavel

