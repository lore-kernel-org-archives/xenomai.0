From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Date: Wed, 8 Mar 2006 15:58:01 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200603081558.02034.lbocseg@domain.hid>
Subject: [Xenomai-core] RTDM mmap and vm_operations
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi Jan,

Is there a way of knowing what was the src_addr or pptr data passed to=20
rtdm_mmap_to_user without using the vm_private_data struct? I mean, can I=20
obtain those information directly in the vma struct passed to the close=20
handler? If so, I could pass a more generic struct to vm_private and use=20
those information,making my life a bit easier... :)

Thanks in advance,

Rodrigo.

	=09
_______________________________________________________
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!
http://br.acesso.yahoo.com


