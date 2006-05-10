Date: Wed, 10 May 2006 10:35:23 +0200 (CEST)
From: Klaas Gadeyne <klaas.gadeyne@domain.hid>
Message-ID: <Pine.LNX.4.63.0605101025370.11844@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Xenomai-help] Unknown symbol xnshadow_send_sig
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

Hi,

When using the xenomai-v2.1.x branch (tested with r1058, and a
snapshot from a couple of days ago, using the "Champagne" version of
the nucleus IIRC), I get the above error while trying to load the
xeno_native kernel module.  Relevant data is below:

[kgad@domain.hid /lib/modules/2.6.16adeos-ipipe-1.2-05]$
  lsmod | grep xeno_nucleus
xeno_nucleus          222112  0
[kgad@domain.hid /lib/modules/2.6.16adeos-ipipe-1.2-05]$
  sudo modprobe xeno_native
FATAL: Error inserting xeno_native
  (/lib/modules/2.6.16adeos-ipipe-1.2-05/kernel/kernel/xenomai/skins/native/xeno_native.ko):
  Unknown symbol in module, or unknown parameter (see dmesg)
[kgad@domain.hid /lib/modules/2.6.16adeos-ipipe-1.2-05]$
  dmesg | tail -n 5
Xenomai: hal/x86 started.
I-pipe: Domain IShield registered.
Xenomai: real-time nucleus v2.1.1 (Trundrumbalind) loaded.
xeno_native: Unknown symbol xnshadow_send_sig
xeno_native: Unknown symbol xnshadow_send_sig

[kgad@domain.hid /lib/modules/2.6.16adeos-ipipe-1.2-05]$
  nm --defined-only
  /lib/modules/2.6.16adeos-ipipe-1.2-05/kernel/kernel/xenomai/nucleus/xeno_nucleus.ko
  | grep xnshadow_send_sig
0000e050 T xnshadow_send_sig
[kgad@domain.hid /lib/modules/2.6.16adeos-ipipe-1.2-05]$
  nm
  /lib/modules/2.6.16adeos-ipipe-1.2-05/kernel/kernel/xenomai/skins/native/xeno_native.ko
  | grep xnshadow_send_sig
          U xnshadow_send_sig


The signatures of the function seem to match to and I don't get the
error when using xenomai-trunk with 2.6.16adeos-ipipe-1.3-01.

Any clues?  Am I missing something obvious?

regards,

Klaas

