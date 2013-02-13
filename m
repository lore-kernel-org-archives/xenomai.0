Message-ID: <511B94E4.2070708@mediso.hu>
Date: Wed, 13 Feb 2013 14:28:04 +0100
From: Norbert Bukuli <norbert.bukuli@mediso.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Floating point operations in kernel on powerpc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dear List Members,

First of all, this will be a newbie question, sorry for it.
Shortly, I have to port an old RTAI based kernelspace application to
Xenomai userpace. This application uses FPU so we compile it hard
float support. First step of the porting is switching the real-time
extension. I am done with this, however I have some compilation warnings:
WARNING: "_restfpr_22_x" [app.ko] undefined!
WARNING: "_restfpr_29_x" [app.ko] undefined!
WARNING: "_savefpr_22" [app.ko] undefined!
WARNING: "_savefpr_29" [app.ko] undefined!

I reproduced these warnings with the following example kernel module:
http://pastebin.com/AAehcivx

The corresponding Kbuild is:

obj-m := fpu_test.o
ccflags-y += -Iinclude/xenomai -Iinclude/xenomai/posix -mhard-float

As I see, the missing functions should be in the C runtime library,
however the kernel library (arch/powerpc/lib/crtsavres.S) contains
only save/restore macros for general purpose registers. On the other
hand, the Xenomai extensions provides kernelspace FPU facility and the
T_FPU flag was turned on rt_task_create().
So, my question is, how can I eliminate this problem?

The environment is the following:
Toolchain: ELDK-5.2.1, powerpc, hard float.
Kernel: linux-v3.2.21
Xenomai: v2.6.1

Any suggestion is highly appreciated. Thank you in advance!

- -- 
Best regards,
Norbert Bukuli
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJRG5TkAAoJEJEs22zQJ00S86IIAIh0vYdLf5++r+0EZSkSGGD+
Mui9k9h4huRmUo31H9rWMJvU/DkJHAKrvoR/QBpQ1L6ty6xyeOoYhwzpEbW9e9TO
uy9nxBeB3ORg6RFV6NLKaP6iifgifYJKkT89mEjts8hbXNoRyxZHJUNJuQtDNh45
JB3EuGKbjB5ItISXJupeKE4CXGMRHKxcHBiM3l1Nxq+zwrO+/CyGWtO+ZjWzEN4/
fiWIBMm3g/p82+KxTqTQLmmOA0/0aAZcO02mw/v8/dPm8Ty+K9jB0cIsakPifehm
gDUVlg1r/uNEaj4KVc0exE6zdiWwhIq3brYAxfzbCeEpc4b+MeFDNyggYE8vi2M=
=FKk7
-----END PGP SIGNATURE-----

