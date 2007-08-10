Message-ID: <46BC4DCE.80003@domain.hid>
Date: Fri, 10 Aug 2007 13:36:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig917438D1C942A73CA1B88EEB"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [2.6.22-BUG] inconsistent Linux IRQ mask
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig917438D1C942A73CA1B88EEB
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

this appears to be related to 2.6.22+ only:

 ------------[ cut here ]------------
 kernel BUG at fs/buffer.c:1230!
 invalid opcode: 0000 [#1]
 PREEMPT
 Modules linked in: xeno_rtdm xeno_nucleus ip6t_LOG xt_TCPMSS nvram uinpu=
t snd_pcm_oss cifs snd_mixer_oss snd_seq snd_seq_device radeon drm wlan_t=
kip af_packet thinkpad_acpi button battery ac ip6t_REJECT xt_state iptabl=
e_nat nf_nat ip6table_mangle nf_conntrack_ipv4 nf_conntrack nfnetlink ip6=
table_filter ip6_tables ipv6 nls_iso8859_1 nls_cp437 vfat fat nls_utf8 nt=
fs dm_mod fuse wlan_scan_sta ath_rate_sample pcmcia snd_intel8x0 firmware=
_class snd_ac97_codec ac97_bus snd_pcm ath_pci nsc_ircc wlan ide_cd irda =
snd_timer e100 cdrom ath_hal(P) snd i2c_i801 uhci_hcd ehci_hcd mii yenta_=
socket rsrc_nonstatic soundcore usbcore snd_page_alloc i2c_core intel_agp=
 crc_ccitt pcmcia_core agpgart parport_pc lp parport reiserfs edd fan pii=
x ide_disk ide_core
 CPU:    0
 EIP:    0060:[<c0187fc3>]    Tainted: P       VLI
 EFLAGS: 00210246   (2.6.22.2-adeos #7)
 EIP is at __find_get_block+0x2c/0x1e8
 eax: 00000000   ebx: e3635dac   ecx: 00000000   edx: 00002e4e
 esi: 00001000   edi: eeeb3080   ebp: e3635b30   esp: e3635af8
 ds: 007b   es: 007b   fs: 0000  gs: 0033  ss: 0068
 Process kio_file (pid: 7433, ti=3De3634000 task=3De6d780b0 task.ti=3De36=
34000)<0>
 I-pipe domain Linux
 Stack: 00002e4e 00000000 c16e0718 eff36a90 e3634000 e3635b1c c0308f1e c0=
5dd700
        00000000 e3635b2c c030bbfd e3635dac 00001000 e3635db4 e3635b98 c0=
1881a4
        00001000 c05dd700 511c5a51 00000022 c014aade 00002e4e 00000000 ee=
eb3080
 Call Trace:
  [<c0104fd0>] show_trace_log_lvl+0x1f/0x34
  [<c0105085>] show_stack_log_lvl+0xa0/0xa8
  [<c0105294>] show_registers+0x207/0x35c
  [<c01054fd>] die+0x114/0x22a
  [<c01056a1>] do_trap+0x8e/0xa7
  [<c0105a2f>] do_invalid_op+0x8d/0x97
  [<c0113b1a>] __ipipe_handle_exception+0xb1/0x11f
  [<c030be53>] error_code+0x6f/0x7c
  [<c01881a4>] __getblk+0x25/0x29a
  [<f0bdc058>] search_by_key+0x97/0xe38 [reiserfs]
  [<f0bc6c10>] search_by_entry_key+0x20/0x231 [reiserfs]
  [<f0bc6e96>] reiserfs_find_entry+0x75/0x2d0 [reiserfs]
  [<f0bc7643>] reiserfs_lookup+0x6d/0x122 [reiserfs]
=2E..

I get this over 2.6.22.2 with latest trunk + ipipe-1.9-03, only
modprobe'ing xeno_rtdm (so that the nucleus becomes active) and then
logging into KDE. Same box, same Xenomai, but 2.6.20.15: no problem at
all (also xeno-text runs fine here, BTW). When Xenomai is inactive,
2.6.22 makes no problems as well. Note that the tracer is compiled in,
but is deactivated. Activating it (with the hope to get a panic
backtrace) makes the issue disappear as well.

Jan


--------------enig917438D1C942A73CA1B88EEB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGvE3SniDOoMHTA+kRAnG+AJ9miiUdhKeT5CO928Khqo/oL/ghfgCeKEiu
HQrIqBpEgqzjRTGEO55fMLo=
=V4I0
-----END PGP SIGNATURE-----

--------------enig917438D1C942A73CA1B88EEB--

