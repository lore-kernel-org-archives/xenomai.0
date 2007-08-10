Message-ID: <46BCA91A.1050209@domain.hid>
Date: Fri, 10 Aug 2007 20:06:18 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46BC4DCE.80003@domain.hid> <46BC5033.5040602@domain.hid>
	<1186761724.6006.6.camel@domain.hid>
In-Reply-To: <1186761724.6006.6.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig085F0448506D67B780A993D6"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [2.6.22-BUG] inconsistent Linux IRQ mask
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig085F0448506D67B780A993D6
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Fri, 2007-08-10 at 13:46 +0200, Jan Kiszka wrote:
>> Jan Kiszka wrote:
>>> Hi Philippe,
>>>
>>> this appears to be related to 2.6.22+ only:
>>>
>>>  ------------[ cut here ]------------
>>>  kernel BUG at fs/buffer.c:1230!
>>>  invalid opcode: 0000 [#1]
>>>  PREEMPT
>>>  Modules linked in: xeno_rtdm xeno_nucleus ip6t_LOG xt_TCPMSS nvram u=
input snd_pcm_oss cifs snd_mixer_oss snd_seq snd_seq_device radeon drm wl=
an_tkip af_packet thinkpad_acpi button battery ac ip6t_REJECT xt_state ip=
table_nat nf_nat ip6table_mangle nf_conntrack_ipv4 nf_conntrack nfnetlink=
 ip6table_filter ip6_tables ipv6 nls_iso8859_1 nls_cp437 vfat fat nls_utf=
8 ntfs dm_mod fuse wlan_scan_sta ath_rate_sample pcmcia snd_intel8x0 firm=
ware_class snd_ac97_codec ac97_bus snd_pcm ath_pci nsc_ircc wlan ide_cd i=
rda snd_timer e100 cdrom ath_hal(P) snd i2c_i801 uhci_hcd ehci_hcd mii ye=
nta_socket rsrc_nonstatic soundcore usbcore snd_page_alloc i2c_core intel=
_agp crc_ccitt pcmcia_core agpgart parport_pc lp parport reiserfs edd fan=
 piix ide_disk ide_core
>>>  CPU:    0
>>>  EIP:    0060:[<c0187fc3>]    Tainted: P       VLI
>>>  EFLAGS: 00210246   (2.6.22.2-adeos #7)
>>>  EIP is at __find_get_block+0x2c/0x1e8
>>>  eax: 00000000   ebx: e3635dac   ecx: 00000000   edx: 00002e4e
>>>  esi: 00001000   edi: eeeb3080   ebp: e3635b30   esp: e3635af8
>>>  ds: 007b   es: 007b   fs: 0000  gs: 0033  ss: 0068
>>>  Process kio_file (pid: 7433, ti=3De3634000 task=3De6d780b0 task.ti=3D=
e3634000)<0>
>>>  I-pipe domain Linux
>>>  Stack: 00002e4e 00000000 c16e0718 eff36a90 e3634000 e3635b1c c0308f1=
e c05dd700
>>>         00000000 e3635b2c c030bbfd e3635dac 00001000 e3635db4 e3635b9=
8 c01881a4
>>>         00001000 c05dd700 511c5a51 00000022 c014aade 00002e4e 0000000=
0 eeeb3080
>>>  Call Trace:
>>>   [<c0104fd0>] show_trace_log_lvl+0x1f/0x34
>>>   [<c0105085>] show_stack_log_lvl+0xa0/0xa8
>>>   [<c0105294>] show_registers+0x207/0x35c
>>>   [<c01054fd>] die+0x114/0x22a
>>>   [<c01056a1>] do_trap+0x8e/0xa7
>>>   [<c0105a2f>] do_invalid_op+0x8d/0x97
>>>   [<c0113b1a>] __ipipe_handle_exception+0xb1/0x11f
>>>   [<c030be53>] error_code+0x6f/0x7c
>>>   [<c01881a4>] __getblk+0x25/0x29a
>>>   [<f0bdc058>] search_by_key+0x97/0xe38 [reiserfs]
>>>   [<f0bc6c10>] search_by_entry_key+0x20/0x231 [reiserfs]
>>>   [<f0bc6e96>] reiserfs_find_entry+0x75/0x2d0 [reiserfs]
>>>   [<f0bc7643>] reiserfs_lookup+0x6d/0x122 [reiserfs]
>>> ...
>>>
>>> I get this over 2.6.22.2 with latest trunk + ipipe-1.9-03, only
>>> modprobe'ing xeno_rtdm (so that the nucleus becomes active) and then
>>> logging into KDE. Same box, same Xenomai, but 2.6.20.15: no problem a=
t
>>> all (also xeno-text runs fine here, BTW). When Xenomai is inactive,
>>> 2.6.22 makes no problems as well. Note that the tracer is compiled in=
,
>>> but is deactivated. Activating it (with the hope to get a panic
>>> backtrace) makes the issue disappear as well.
>> Ah, and then there was this warning once (same kernel that reliably BU=
Gs):
>>
>> WARNING: at kernel/softirq.c:138 local_bh_enable()
>>  [<c0104fd0>] show_trace_log_lvl+0x1f/0x34
>>  [<c0105c62>] show_trace+0x17/0x19
>>  [<c0105cfc>] dump_stack+0x1a/0x1c
>>  [<c011f38a>] local_bh_enable+0x53/0xb3
>>  [<c028b6d5>] lock_sock_nested+0xbe/0xc6
>>  [<c0288feb>] sock_fasync+0x68/0x125
>>  [<c028a0f3>] sock_close+0x2a/0x38
>>  [<c016bc1a>] __fput+0xb9/0x195
>>  [<c016bd11>] fput+0x1b/0x1d
>>  [<c0169572>] filp_close+0x59/0x61
>>  [<c016a5cd>] sys_close+0x73/0xab
>>  [<c0103f05>] sysenter_past_esp+0x6e/0x72
>>
>> Probably a different symptom of the same bug.
>>
>=20
> Does this disappear with PREEMPT off?
>=20

Nope.

Jan


--------------enig085F0448506D67B780A993D6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGvKkbniDOoMHTA+kRAguoAJ44fwOZnphLLM7ehk0Cex4b4Lw6EwCeMsVF
ZXtlOqaUABRLBdMRfJ4DPYg=
=Kt5k
-----END PGP SIGNATURE-----

--------------enig085F0448506D67B780A993D6--

