Date: Fri, 28 Dec 2012 11:06:06 +0100
From: "Mariusz Janiak" <mariuszjaniak@wp.pl>
Message-ID: <50dd6f0ee3dc65.48983574@wp.pl>
Content-Disposition: inline
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Subject: [Xenomai] Odp: Re: Xenomai 2.6.2 + Kernel 3.5.3 + AMD Phenom II X6
 1055
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

   Dnia Pi+-tek, 28 Grudnia 2012 01:41 Gilles Chanteperdrix
   <gilles.chanteperdrix@xenomai.org> napisa^3(a)

   > On 12/28/2012 12:47 AM, Mariusz Janiak wrote:

   >

   > > Hi

   > >

   > > As soon as you publish new Xenomai 2.6.2 release, I have tried to
   launch it on my desktop, and unfortunately I went into trouble. My
   testbed:

   > >

   > >  - Xenomai 2.6.2,

   > >

   > >  - Kernel 3.5.3 (I haven't testes earlier versions),

   > >

   > >  - AMD Phenom II X6 1055 + Gigabyte GA-890GPA-UD3H

   > >

   > >  - Ubuntu 12.10.

   > >

   > > The problem is following (from dmesg):

   >

   >

   > The problem real problem is here (from your dmesg):

   >

   > > System has AMD C1E enabled

   > > Switch to broadcast mode on CPU1

   > > Switch to broadcast mode on CPU2

   > > Switch to broadcast mode on CPU3

   > > Switch to broadcast mode on CPU4

   >

   >

   > > I went through installation manual, troubleshooting guide and forum

   >

   > > archives, maybe I have missed something. What is more I have tested
   this

   >

   > > kernel on my laptop HP pavilion dm1 with AMD E-350 and it work

   > > without problems.

   >

   > We have a message saying:

   > I-pipe: cannot use LAPIC as a tick device

   > I-pipe: disable C1E power state in your BIOS

   Thank you Gilles, this was may case, disabling a C1E power state in a
   BIOS definitively solved my problem.


   > For some reason, however, it does not get printed in your case. I
   agree

   > that we should document this in the TROUBLESHOOTING guide.

   >

   > --

   >
   Gilles.

   If you find useful please add bellow text to the TROUBLESHOOTING.adoc
   file.

   On AMD x86_64
   ^^^^^^^^^^^^^
   You will most likely also see the following message:
   --------------------------------------------
   I-pipe: cannot use LAPIC as a tick device
   I-pipe: disable C1E power state in your BIOS
   --------------------------------------------
   Xenomai sends this message if C1E option is enabled in a BIOS. To fix
   this issue please disable C1E support in the BIOS. In some Award BIOS
   this option is located in the +Advanced BIOS Features->+ menu (+AMD
   C1E Support+).
   On some systems, above message may not appear in the system log.
   IMPORTANT: Disabling +AMD K8 Cool&Quiet+ option in a BIOS does not
   solve the problem.

   Mariusz
