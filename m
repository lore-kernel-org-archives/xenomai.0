Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7F062.47AAAE0E"
Date: Thu, 6 Sep 2007 10:45:30 +0200
Message-ID: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E08F1F9@domain.hid>
From: "Markus Osterried (BA/EDD)" <markus.osterried@domain.hid>
Subject: [Xenomai-core] rtdm_iomap_to_user() with PowerPC
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7F062.47AAAE0E
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

I want to use rtdm_iomap_to_user() to map our device registers to user
space.
But this doesn't work, our application just crashes when I read from the
mapped registers.

When I insert the line

	vma->vm_page_prot =3D phys_mem_access_prot(filp,
paddr>>PAGE_SHIFT, size, vma->vm_page_prot);

in rtdm_mmap_buffer() just before calling xnarch_remap_io_page_range()
it works fine.
This is just like it is done in /drivers/char/mem.c and in
/drivers/video/fbmem.c.

But I think this is architecture and kernel version dependent and I
don't know whether rtdm_mmap_buffer() is the right place.
I use Xenomai 2.3.1 and Linux 2.6.18 with PowerPC CPU.
What is the best solution? Everyone else seen this problem?

Thanks
Markus


------_=_NextPart_001_01C7F062.47AAAE0E
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>rtdm_iomap_to_user() with PowerPC</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hello,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I want to use rtdm_iomap_to_user() to =
map our device registers to user space.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">But this doesn't work, our application =
just crashes when I read from the mapped registers.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">When I insert the line</FONT>
</P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">vma-&gt;vm_page_prot =3D phys_mem_access_prot(filp, =
paddr&gt;&gt;PAGE_SHIFT, size, vma-&gt;vm_page_prot);</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">in rtdm_mmap_buffer() just before =
calling xnarch_remap_io_page_range() it works fine.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">This is just like it is done in =
/drivers/char/mem.c and in /drivers/video/fbmem.c.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">But I think this is architecture and =
kernel version dependent and I don't know whether rtdm_mmap_buffer() is =
the right place.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I use Xenomai 2.3.1 and Linux 2.6.18 =
with PowerPC CPU.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">What is the best solution? Everyone =
else seen this problem?</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Markus</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C7F062.47AAAE0E--

