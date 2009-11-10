Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2009 11:42:14 -0500
Message-ID: <6FCCA913376DD7488F4139A4D11B8F48FD1044@domain.hid>
From: "Herrera-Bendezu, Luis" <lherrera@domain.hid>
Subject: [Xenomai-core] rtdm_iomap_to_user with phys addr > 4GB
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hello,

I am writing an RTDM driver to replace one that uses UIO. The device
resides in a physical address > 4 GB on a PPC440EPx. The UIO could
not handle this address so I made a proposal to address it, details at:
http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-April/070097.html

Function rtdm_iomap_to_user() has same issue with the physical I/O
address
   unsigned long src_addr

I am new to Xenomai and would like to get some ideas on how to solve
this
issue.

Thanks,

Luis G. Herrera-Bendezu

