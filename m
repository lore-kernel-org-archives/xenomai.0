From: James Leonard <james.leonard@imag.fr>
Date: Mon, 17 Dec 2012 14:07:51 +0100
Message-Id: <CB3E339B-7A10-4A25-A49D-63971ED35FA7@imag.fr>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain;
	charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Beginner's Problem: Installing Xenomai Kernel for i7
	multi-core processor
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello everyone,

I'm an absolute beginner when it comes to Linux based RTOS systems, so I =
apologise in advance for any beginner=92s mistakes I may have made.

I have been trying to install and configure a Xenomai patched Kernel on =
a PC with a Intel i7 quad core processor and an ASUS P7P55D motherboard, =
but so far I have had no success.

I tried patching and installing a 2.6.38.8 Kernel on a Fedora 16 OS =
(with 3.4.2 default kernel), but upon boot I was told that the 'ext4' =
root file system was not recognized, so I decided to try installing on =
other OS, formatted with ext3.

I tried Debian (installing via the debian packages) and Fedora 14 =
(manual patching and install). The results I have with these are the =
following:
=B7     When booting, I get a "MP BIOS bug: 8254 timer not connected to =
IO-APIC" error. Then the system starts OK

=B7      The latency test gives about 10000 overruns per cycle, with =
enormous max latency times.

I've tried many different configurations, initially following this =
tutorial (in French) =
http://doc.fedora-fr.org/wiki/Mise_en_=9Cuvre_de_Xenomai_pour_cr=E9er_un_n=
oyau_Temps_R=E9el_dur :

	- simply disabling power options such as APM and CPU Freq =
Scaling (as in tutorial)
	- Enabling the SMI workaround and globally disabling the SMIs
	- Other things listed in the x86 kernel config guide of the =
Xenomai website

I'm sorry, the description of my problem is probably very vague, but I =
get the feeling I must be forgetting something basic in the =
hardware/kernel configuration, as I cannot get things to work at all and =
have seen many people use i7 processors and Xenomai successfully.


 Regards,

James Leonard


