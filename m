Message-ID: <53EE6E07.7090104@xenomai.org>
Date: Fri, 15 Aug 2014 16:31:03 -0400
From: Jorge Ramirez Ortiz <jro@xenomai.org>
MIME-Version: 1.0
References: <mailman.653.1404749254.5713.xenomai@xenomai.org>	<53C3E6CE.2040306@xenomai.org>	<53C42ADE.7040204@gmail.com>	<53C44696.2070906@xenomai.org>	<53C44EE9.3040000@xenomai.org>	<53C6CC9B.4040009@xenomai.org>	<53C81CFD.30908@gmail.com>	<53C82A08.50100@xenomai.org>	<CACKc53LL5C2AUTjd6cah1JyoDD5BMGeg5RQjsDjX9_FNvqdAJQ@mail.gmail.com>	<53DAA390.7040406@xenomai.org>	<CACKc53LQ5pCL14tVodDbMjyexPoYcaLi-PFzFOGT=VNGhR6FpQ@mail.gmail.com>	<53DBA8D7.9040505@xenomai.org>	<CACKc53+jJ9tq-5oHN65V5o-tTU5L67ZiwKQ5eyFW0C=4HRyYqA@mail.gmail.com>
 <CACKc53KpB1=-HciLvY-E_u4FDO72LGBSwtSV19G_h5_iT8e-LQ@mail.gmail.com>
 <53E96D0E.7060505@xenomai.org>
In-Reply-To: <53E96D0E.7060505@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] sensoray 626 patch [Re: Xenomai Digest, Vol 27,
	Issue 12]
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wojciech Domski <wojciech.domski@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/11/2014 09:25 PM, Jorge Ramirez Ortiz wrote:
> On 08/05/2014 06:01 AM, Wojciech Domski wrote:
>> Ok, there was a problem with closing the descriptor on the side of API (new
>> file in attachment). I have resolved it but now I have problem with IRQ.
>> Here is what dmesg says:
> 
>> [  103.942431] Analogy: a4l_add_drv: name=S626
>> [  103.942434] Analogy: a4l_lct_drv: name=S626
>> [  103.942450] Analogy: Probing for s626
>> [  103.942469] Analogy: Probing for s626
>> [  115.764941] Analogy: a4l_lct_drv: name=S626
>> [  115.764945] Analogy: S626: Attaching s626
>> [  115.764947] Analogy: S626: Desired Bus: 2, Slot: 4
>> [  115.764949] Analogy: S626: Has Bus: 2, Slot: 4
>> [  115.764951] Analogy: S626: PCI dev = ffff880211c72000
>> [  115.764952] Analogy: S626: PCI set master
>> [  115.764960] Analogy: S626: PCI region request
>> [  115.764964] Analogy: S626: PCI ioremap
>> [  115.764997] Analogy: S626: disable master interrupt
>> [  115.764998] Analogy: S626: DMA
>> [  115.765004] Analogy: S626: RTDM irq
>> [  115.765016] Analogy: S626: RTDM irq request
>> [  115.765027] Analogy: S626: subdevices allocation
>> [  115.765031] Analogy: S626: card initialization
>> [  115.780513] Analogy: S626: Driver ready
>> [  115.780516] Analogy: a4l_setup_transfer: nb_subd=6
>> [  119.620570] Analogy: a4l_lct_drv: name=S626
>> [  119.620575] Analogy: S626: Attaching s626
>> [  119.620579] Analogy: S626: Desired Bus: 2, Slot: 5
>> [  119.620581] Analogy: S626: Has Bus: 2, Slot: 5
>> [  119.620583] Analogy: S626: PCI dev = ffff880211c73000
>> [  119.620584] Analogy: S626: PCI set master
>> [  119.620592] Analogy: S626: PCI region request
>> [  119.620596] Analogy: S626: PCI ioremap
>> [  119.620630] Analogy: S626: disable master interrupt
>> [  119.620632] Analogy: S626: DMA
>> [  119.620635] Analogy: S626: RTDM irq
>> [  119.620644] Analogy: S626: RTDM irq request
>> [  119.620655] Analogy: S626: subdevices allocation
>> [  119.620659] Analogy: S626: card initialization
>> [  119.636135] Analogy: S626: Driver ready
>> [  119.636139] Analogy: a4l_setup_transfer: nb_subd=6
>> [  121.908284] Analogy: a4l_precleanup_transfer: subd[0]->status=0x00000000
>> [  121.908287] Analogy: a4l_precleanup_transfer: subd[1]->status=0x00000000
>> [  121.908289] Analogy: a4l_precleanup_transfer: subd[2]->status=0x00000000
>> [  121.908290] Analogy: a4l_precleanup_transfer: subd[3]->status=0x00000000
>> [  121.908291] Analogy: a4l_precleanup_transfer: subd[4]->status=0x00000000
>> [  121.908293] Analogy: a4l_precleanup_transfer: subd[5]->status=0x00000000
>> [  121.908298] Analogy: S626: Detaching s626
>> [  121.908300] Analogy: S626: Cleaning private
>> [  121.908322] Analogy: S626: Handling irq
>> [  122.111663] Analogy: S626: Releasing PCI regions
>> [  122.111670] Analogy: S626: Removing private
>> [  122.111671] Analogy: S626: Detaching completed
>> [  124.081687] Analogy: a4l_precleanup_transfer: subd[0]->status=0x00000000
>> [  124.081691] Analogy: a4l_precleanup_transfer: subd[1]->status=0x00000000
>> [  124.081692] Analogy: a4l_precleanup_transfer: subd[2]->status=0x00000000
>> [  124.081694] Analogy: a4l_precleanup_transfer: subd[3]->status=0x00000000
>> [  124.081695] Analogy: a4l_precleanup_transfer: subd[4]->status=0x00000000
>> [  124.081696] Analogy: a4l_precleanup_transfer: subd[5]->status=0x00000000
>> [  124.081702] Analogy: S626: Detaching s626
>> [  124.081704] Analogy: S626: Cleaning private
>> [  124.081726] Analogy: S626: Handling irq
>> [  124.283848] Analogy: S626: Releasing PCI regions
>> [  124.283855] Analogy: S626: Removing private
>> [  124.283856] Analogy: S626: Detaching completed
>> [  127.376882] Analogy: a4l_lct_drv: name=S626
>> [  127.376887] Analogy: S626: Attaching s626
>> [  127.376888] Analogy: S626: Desired Bus: 2, Slot: 5
>> [  127.376890] Analogy: S626: Has Bus: 2, Slot: 5
>> [  127.376893] Analogy: S626: PCI dev = ffff880211c73000
>> [  127.376894] Analogy: S626: PCI set master
>> [  127.376901] Analogy: S626: PCI region request
>> [  127.376905] Analogy: S626: PCI ioremap
>> [  127.376961] Analogy: S626: disable master interrupt
>> [  127.376962] Analogy: S626: DMA
>> [  127.376968] Analogy: S626: RTDM irq
>> [  127.376983] Analogy: S626: RTDM irq request
>> [  127.376992] Analogy: a4l_assign_driver: call(drv->attach) failed
> 
> 
> the IRQ line is already in use as per the return code (EBUSY).
> it could be that the previous call to rtdm_irq_free failed.
> 
> could you try again after applying this patch please ?
> 
> http://git.xenomai.org/xenomai-jro.git/commit/?h=for-forge&id=44e4db095fb690705e311aaee378d66e84a381db
> 
> 

this is the fix that you probably need:
http://git.xenomai.org/xenomai-jro.git/commit/?h=for-forge&id=99ec0e1122f27c0a4b6b0a3d1f3d8aff6498a877

please let me know if it addresses your problem.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJT7m4HAAoJECDcy2IJkagRCA0IAIfvRvrfaLFjbExAHZGY+1LO
B7hpOzzlzsUPD21Rz8xyuVAsMLfP6I3+ogOQgAje1ALy04DbVFluL7GTyYHVItRn
wzjccqPHmOeRQJR1L5p+dGXzrJvm3WxTeZwX7klaf//6ygWpj/Dd0RTXl2TiYAXm
S9qkEL0FKXF+PN0L5ScnSPA1oecsHoDx1JXtwcQW6T6RkiF8EwuLIRj2Tdi5A13i
evtfncYoBXn47gNQ9RYPMVfR5GhVd8xyNXPJGIDtSNdnYGXSnu1FChTCd+4zkf+r
9y2MwgCP3BJhWuOpA/NgNlS9reYD5A8JRNsXONvPLMHJvwFCniR4n1HbL2Ex+Dw=
=8NM+
-----END PGP SIGNATURE-----

