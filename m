Message-ID: <44103D71.5040300@domain.hid>
Date: Thu, 09 Mar 2006 11:36:33 -0300
From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] RTDM mmap and vm_operations
References: <200603081558.02034.lbocseg@domain.hid> <440F3354.3010106@domain.hid>
In-Reply-To: <440F3354.3010106@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>


Jan Kiszka escreveu:
> Rodrigo Rosenfeld Rosas wrote:
>  =20
>> Hi Jan,
>>
>> Is there a way of knowing what was the src_addr or pptr data passed to=20
>> rtdm_mmap_to_user without using the vm_private_data struct? I mean, can =
I=20
>> obtain those information directly in the vma struct passed to the close =

>> handler? If so, I could pass a more generic struct to vm_private and use=
=20
>> those information,making my life a bit easier... :)
>>    =20
>
> I do not see a clean, official way right now. It would definitely be
> something you have to obtain via vma_area_struct or something that's
> contained in it. The information is likely there - somewhere. But I
> doubt that obtaining it would make your code very portable across
> different kernel versions.
>  =20
Ok, don't worry Jan. I was wondering if there was a portable easy way of=20
obtaining those data, like a member of vma struct, but if not, there is=20
no problem. I'll include these values in the private data struct.

Rodrigo.


	=09
_______________________________________________________
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!
http://br.acesso.yahoo.com


