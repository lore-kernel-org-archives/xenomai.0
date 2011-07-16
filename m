Message-ID: <4E21483B.7050503@domain.hid>
Date: Sat, 16 Jul 2011 10:13:47 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1QfDvt-0003TN-G7@domain.hid> <4E1B4AC0.80506@domain.hid>
	<4E1B4C19.2070205@domain.hid> <4E1B542B.2010906@domain.hid>
	<4E1B5638.1050005@domain.hid> <4E1B56E0.20109@domain.hid>
	<4E1B57D1.1070401@domain.hid> <4E1B5860.1000309@domain.hid>
	<4E1B5944.5030408@domain.hid> <4E1BEC9F.1020404@domain.hid>
	<4E1BF619.6010609@domain.hid> <4E1C2912.9050605@domain.hid>
	<4E1C2959.8080004@domain.hid> <4E1C2A2D.9090602@domain.hid>
	<4E1C2AA5.6060208@domain.hid> <4E1C2B44.5060907@domain.hid>
	<4E1C2B8F.5080700@domain.hid> <4E1C2F56.8020103@domain.hid>
	<4E1C302A.8050309@domain.hid> <4E1C3301.2030203@domain.hid>
	<4E1C3672.1030104@domain.hid> <4E1C36EE.70803@domain.hid>
	<4E1C38CE.7090202@domain.hid> <4E1C3A5D.3020700@domain.hid>
	<4E1C44B4.50106@domain.hid> <4E1C8508.5010400@domain.hid>
	<4E1C858A.7070403@domain.hid> <4E1C86A1.6030707@domain.hid>
	<4E1C87BB.7000307@domain.hid> <4E1DE646.1090900@domain.hid>
	<4E1DEC58.4000901@domain.hid> <4E1DEE27.7030900@domain.hid>
	<4E1F581C.4050809@domain.hid> <4E2032EF.5030700@domain.hid>
	<4E203C55.3080605@domain.hid .de>
In-Reply-To: <4E203C55.3080605@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : nucleus: Fix race
 between gatekeeper and thread deletion
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 2011-07-15 15:10, Jan Kiszka wrote:
> But... right now it looks like we found our primary regression: 
> "nucleus/shadow: shorten the uninterruptible path to secondary mode".
> It opens a short windows during relax where the migrated task may be
> active under both schedulers. We are currently evaluating a revert
> (looks good so far), and I need to work out my theory in more
> details.

Looks like this commit just made a long-standing flaw in Xenomai's
interrupt handling more visible: We reschedule over the interrupt stack
in the Xenomai interrupt handler tails, at least on x86-64. Not sure if
other archs have interrupt stacks, the point is Xenomai's design wrongly
assumes there are no such things. We were lucky so far that the values
saved on this shared stack were apparently "compatible", means we were
overwriting them with identical or harmless values. But that's no longer
true when interrupts are hitting us in the xnpod_suspend_thread path of
a relaxing shadow.

Likely the only possible fix is establishing a reschedule hook for
Xenomai in the interrupt exit path after the original stack is restored
- - just like Linux works. Requires changes to both ipipe and Xenomai
unfortunately.

Jan

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk4hSDsACgkQitSsb3rl5xSmOACfbZfcNKyO9YDvPE+R5H75d0ky
DX0An32BrZW+lpEnxnLLCHSQ5r8itnE9
=n6u8
-----END PGP SIGNATURE-----

