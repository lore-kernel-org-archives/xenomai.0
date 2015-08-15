MIME-Version: 1.0
From: Thawann Malfatti <malfatti@neuro.ufrn.br>
Date: Sat, 15 Aug 2015 11:45:59 -0300
Message-ID: <CAMU1Hman00iX8_5fK5Y=kfuwVNzsxE_8LycBh-_8bx38jLTghA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Xenomai 2.6.4: using list of values as input for
	insn_write
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello all,

Is there a way to use a list or an array of values as input for
insn_write? I tried:

$ insn_write -v -d analogy0 -s 1 -c 1 -R 0.0000001,0.0000005V -V {0..5}
insn_write: device analogy0 opened (fd=0)
insn_write: basic descriptor retrieved
subdevices count = 14
read subdevice index = 0
write subdevice index = 0
insn_write: complex descriptor retrieved
insn_write: selected subdevice index = 1
insn_write: range descriptor retrieved
min = -10000000
max = 10000000
insn_write: channel width is 16 bits
insn_write: global scan size is 2
insn_write: writing value 0.000000 (raw=0x7fff)
insn_write: 2 bytes successfully sent

but, only the 1st value is written. I tried:

$ insn_write -v -d analogy0 -s 1 -c 1 -R 0.0000001,0.0000005V -V 0,5,0,5
insn_write: device analogy0 opened (fd=0)
insn_write: basic descriptor retrieved
subdevices count = 14
read subdevice index = 0
write subdevice index = 0
insn_write: complex descriptor retrieved
insn_write: selected subdevice index = 1
insn_write: range descriptor retrieved
min = -10000000
max = 10000000
insn_write: channel width is 16 bits
insn_write: global scan size is 2
insn_write: writing value 0.000000 (raw=0x7fff)
insn_write: 2 bytes successfully sent

but again, only the 1st value is written. I tried:

$ insn_write -v -d analogy0 -s 1 -c 1 -R 0.0000001,0.0000005V -V [5,0,5,0,5]
insn_write: device analogy0 opened (fd=0)
insn_write: basic descriptor retrieved
subdevices count = 14
read subdevice index = 0
write subdevice index = 0
insn_write: complex descriptor retrieved
insn_write: selected subdevice index = 1
insn_write: range descriptor retrieved
min = -10000000
max = 10000000
insn_write: channel width is 16 bits
insn_write: global scan size is 2
insn_write: writing value 0.000000 (raw=0x7fff)
insn_write: 2 bytes successfully sent

but the value sent is always zero. Finally, I tried:

$ insn_write -v -d analogy0 -s 1 -c 1 -R 0.0000001,0.0000005V -V { 5, 0, 5, 0 }
insn_write: device analogy0 opened (fd=0)
insn_write: basic descriptor retrieved
subdevices count = 14
read subdevice index = 0
write subdevice index = 0
insn_write: complex descriptor retrieved
insn_write: selected subdevice index = 1
insn_write: range descriptor retrieved
min = -10000000
max = 10000000
insn_write: channel width is 16 bits
insn_write: global scan size is 2
insn_write: writing value 0.000000 (raw=0x7fff)
insn_write: 2 bytes successfully sent

but the value sent is always zero.
insn_write works fine with a single value ("-V 5", for example).

Has anyone tried/used this?

==== System info ====
Board: NI PCI-6036E

$ cat /proc/cpuinfo | grep 'model name'
model name : Intel(R) Xeon(R) CPU E3-1280 V2 @ 3.60GHz
[...]

$ cat /proc/cpuinfo | grep 'cpu cores'
cpu cores : 4
[...]

$ uname -a
Linux LeaoLabInVivo 3.14.17-xenomai-2.6.4 #1 SMP Tue Aug 4 14:13:46
BRT 2015 x86_64 GNU/Linux

$ cat /proc/analogy/drivers
--  Analogy drivers --
| idx | driver name
|  00 | analogy_ni_pcimio
|  01 | analogy_8255

$ cat /proc/analogy/devices
--  Analogy devices --
| idx | status | driver
|  00 | Linked | analogy_ni_pcimio
|  01 | Unused | No driver
|  02 | Unused | No driver
|  03 | Unused | No driver
|  04 | Unused | No driver
|  05 | Unused | No driver
|  06 | Unused | No driver
|  07 | Unused | No driver
|  08 | Unused | No driver
|  09 | Unused | No driver

$ cat /proc/analogy/00-analogy_ni_pcimio
--  Subdevices --
| idx | type
|  00 | Analog input subdevice
|  01 | Analog output subdevice
|  02 | Digital input/output subdevice
|  03 | Unused subdevice
|  04 | Unused subdevice
|  05 | Calibration subdevice
|  06 | Memory subdevice
|  07 | Digital input/output subdevice
|  08 | Unused subdevice
|  09 | Serial subdevice
|  10 | Unused subdevice
|  11 | Counter subdevice
|  12 | Counter subdevice
|  13 | Counter subdevice

========

Cheers,
T Malfatti

