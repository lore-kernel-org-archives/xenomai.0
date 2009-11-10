Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2009 12:58:15 -0500
Message-ID: <6FCCA913376DD7488F4139A4D11B8F48FD107D@troe2k1.cs.myharris.net>
In-Reply-To: <4AF99CAD.9070105@domain.hid>
References: <6FCCA913376DD7488F4139A4D11B8F48FD1044@domain.hid>
	<4AF99CAD.9070105@domain.hid>
From: "Herrera-Bendezu, Luis" <lherrera@domain.hid>
Subject: Re: [Xenomai-core] rtdm_iomap_to_user with phys addr > 4GB
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

=20

>-----Original Message-----
>From: Jan Kiszka [mailto:jan.kiszka@domain.hid
>Sent: Tuesday, November 10, 2009 12:03 PM
>To: Herrera-Bendezu, Luis
>Cc: xenomai@xenomai.org
>Subject: Re: rtdm_iomap_to_user with phys addr > 4GB
>
>
>Herrera-Bendezu, Luis wrote:
>> Hello,
>>=20
>> I am writing an RTDM driver to replace one that uses UIO. The device
>> resides in a physical address > 4 GB on a PPC440EPx. The UIO could
>> not handle this address so I made a proposal to address it,=20
>details at:
>> http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-April/070097.html
>>=20
>> Function rtdm_iomap_to_user() has same issue with the physical I/O
>> address
>>    unsigned long src_addr
>>=20
>> I am new to Xenomai and would like to get some ideas on how to solve
>> this
>> issue.
>
>I think UIO as well as RTDM suffers from the same problem here: The
>kernel service used to remap the physical memory (remap_pfn_range)
>accepts unsigned long, not phys_addr_t. How is this supposed to work?
>
>Jan
>
>--=20
>Siemens AG, Corporate Technology, CT SE 2
>Corporate Competence Center Embedded Linux
>

Actually, remap_pfn_range() gets passed the physical address left
shifted by PAGE_SIZE in both UIO and RTDM (xnarch_remap_io_page_range,
wrap_remap_io_page_range).

Luis
	=09
=09

