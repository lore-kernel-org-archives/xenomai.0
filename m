Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Oct 2006 11:13:53 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A5FF8EC@ARVMAIL1.mra.roland-man.biz>
From: <Roderik_Wildenburg@domain.hid>
Subject: [Xenomai-help] mmap and secondary mode
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

Just to be sure :
Does the access of a mmaped address (real_mmamp of a device file e.g.
/dev/dualportmemory) force Xenomai to switch to secondary mode ?
I would say yes, as the access of the address probably results into a
read/write of the device file.
Am I right ?

Thanks for your help
Roderik

