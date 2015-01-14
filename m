Message-ID: <BLU177-W51CD73CBF35D42593C1886A0410@phx.gbl>
From: Rosali Pyun <whimt@hotmail.com>
Date: Wed, 14 Jan 2015 15:44:12 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Analogy - Digital input change detection on falling or
 rising edge (NI PCI6229)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello to all=2C
I am using NI m-series DAQ card (PCI 6229)=2C and I would like to use digit=
al input channel to detect a change on falling or rising edge.I need to det=
ect the edge and trigger it to log the exact time.I tried to configure the =
digital channel using instruction as the following=2C but I received -22 er=
ror code.
insn.type      =3D A4L_INSN_CONFIG=3Binsn.idx_subd  =3D SUBD_DIO=3Binsn.cha=
n_desc =3D 0=3Binsn.data_size =3D sizeof(data[0])*3=3Bdata[0] =3D A4L_INSN_=
CONFIG_CHANGE_NOTIFY=3Bdata[1]=3D0x01=3Bdata[2]=3D0x01=3Binsn.data      =3D=
 data=3B
The DAQ card datasheet states that such functionality is supported=2C but I=
 read couple of posts on Comedi forum that it is not supported for ni_pcimi=
o in Comedi.Is it really impossible to use the digital input channel as an =
interrupt on Analogy driver?
If anyone has tried it=2C could you give me some tips on configuring it?I a=
ppreciate any help that I receive.
Best=2CRosali  		 	   		  =
