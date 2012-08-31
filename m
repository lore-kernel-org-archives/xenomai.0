MIME-Version: 1.0
Date: Fri, 31 Aug 2012 11:28:38 +0200
Message-ID: <CAGq8jPis8oxRvBfKY5uVkMtcLvfyXzTK4NMJnNQ2TDE6K49ysA@mail.gmail.com>
From: Minh GIANG <giang.hminh@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] script analog for DAQ card
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I would like to ask you a question, i am working in analogy interface and I
have used the script* insn_read* which are located in */usr/xenomai/bin*,
to test I/O operations with my DAQ card *NI PCI-6221**. *My NI card is not
connected to any equipment

My problem is when i run the script in terminal linux, for example

*/usr/xenomai/bin/insn_read  -v  -d  analogy0   -s 0   S 10  -c 2 *

to get the values in the sub-device number 0 and chanel number 2. So I get
the values following:


*root@debianrt:/home/giang# '/usr/xenomai/bin/insn_read' -v -d analogy0 -s
0 -S 5 -c 2*

*insn_read: device analogy0 opened (fd=3D0)*

*insn_read: basic descriptor retrieved*

*                 subdevices count =3D 14*

*                 read subdevice index =3D 0*

*                 write subdevice index =3D 0*

*insn_read: complex descriptor retrieved*

*insn_read: selected subdevice index =3D 0*

*insn_read: channel width is 16 bits*

*insn_read: global scan size is 10*

*0x0fc4*

*0x0fd2*

*0x0fd8*

*0x0fda*

*0x0fdd*

*insn_read: 10 bytes successfully received*

* *

*root@debianrt:/home/giang# '/usr/xenomai/bin/insn_read' -v -d analogy0 -s
0 -S 5 -c 2*

*insn_read: device analogy0 opened (fd=3D0)*

*insn_read: basic descriptor retrieved*

*                 subdevices count =3D 14*

*                 read subdevice index =3D 0*

*                 write subdevice index =3D 0*

*insn_read: complex descriptor retrieved*

*insn_read: selected subdevice index =3D 0*

*insn_read: channel width is 16 bits*

*insn_read: global scan size is 10*

*0x0000*

*0x0000*

*0x0000*

*0x0000*

*0x0000*

*insn_read: 10 bytes successfully received*

* *

*root@debianrt:/home/giang# '/usr/xenomai/bin/insn_read' -v -d analogy0 -s
0 -S 5 -c 2*

*insn_read: device analogy0 opened (fd=3D0)*

*insn_read: basic descriptor retrieved*

*                 subdevices count =3D 14*

*                 read subdevice index =3D 0*

*                 write subdevice index =3D 0*

*insn_read: complex descriptor retrieved*

*insn_read: selected subdevice index =3D 0*

*insn_read: channel width is 16 bits*

*insn_read: global scan size is 10*

*0x0000*

*0x0000*

*0x0000*

*0x0000*

*0x0000*

*insn_read: 10 bytes successfully received*

* *

* *

The values of the first acquisition are normal, because it was the noise of
analog signal. But for the next acquisition, I don=92t know why the whole
values become zero.


Thanks


my configuration: Debian Squeez 6.0, Xenomai 2.6.0, kernel linux 2.6.38
