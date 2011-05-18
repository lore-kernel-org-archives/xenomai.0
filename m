From: "Benner Bernd (MH/EES)" <B.Benner@domain.hid>
Date: Wed, 18 May 2011 17:40:12 +0200
Message-ID: <294B28951EBE8146839AF99A61CB5FCE6B3FF1946E@SI-MBX17.de.bosch.com>
References: <294B28951EBE8146839AF99A61CB5FCE6B3F1A7999@domain.hid>
	<4DCD0DFC.7050506@domain.hid>
	<294B28951EBE8146839AF99A61CB5FCE6B3F1A7DDD@SI-MBX17.de.bosch.com>
	<4DD25DF5.1070609@domain.hid>
In-Reply-To: <4DD25DF5.1070609@domain.hid>
Content-Language: de-DE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Same problems with ipipe-2.6.37-x86-branch and
 xenoami-head.git on Core 2 Duo E8400 - fixed with CONFIG_HPET_TIMER
 disabled
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

  I have rebuild my Kernel 2.6.37.6-x86 and uses xenomai-head.git. ( is thi=
s xenomai-2.6 git ? )
This version has the same problems on the Core 2 Duo E8400 machines.

  But there are some strange kernel messages on startup:

May 18 16:07:33 (none) user.warn kernel: CE: hpet3 increased min_delta_ns t=
o 7500 nsec
May 18 16:07:33 (none) user.warn kernel: CE: hpet3 increased min_delta_ns t=
o 11250 nsec
May 18 16:07:33 (none) user.warn kernel: hrtimer: interrupt took 5978 ns
...
May 18 16:07:33 (none) user.warn kernel: CE: hpet2 increased min_delta_ns t=
o 11250 nsec
...
  after a start of latency ( via ssh ) the linux domain will slow down and =
the sata driver will come in trouble.


  If I rebuild my Kernel with CONFIG_HPET_TIMER disabled, latency will run =
normally on the Core 2 Duo E8400 machines.

  CONFIG_HPET_TIMER has to be disabled on faster Core 2 Duo machines! There=
 must be a consistency problem! ( probably in
io_apic- handling with CONFIG_HPET_TIMER enabled )

  I will rebuild and test my kernel with stable 2.5.X xenomai versions and =
ADEOS patches with CONFIG_HPET_TIMER disabled!

Thanks in advance!

Mit freundlichen Gr=FC=DFen / Best Regards
Bernd Benner
MH/SGT3
moehwald
Bosch Group
Moehwald GmbH
Michelinstra=DFe 21
66424 Homburg
GERMANY
www.moehwald.de
b.benner@domain.hid
Moehwald GmbH, Sitz/Registered Office: Homburg/Saar, Zentrales Handelsregis=
ter/Registered Court: Saarbr=FCcken HRB 2812
Gesch=E4ftsf=FChrung/Managing Directors: Jens Last, Wolfgang Geenen


-----Urspr=FCngliche Nachricht-----
Von: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Gesendet: Dienstag, 17. Mai 2011 13:37
An: Benner Bernd (MH/EES)
Cc: Jan Kiszka; xenomai@xenomai.org
Betreff: Re: [Xenomai-help] Same problems with ipipe-2.6.37-x86-branch on C=
ore 2 Duo E8400

On 05/16/2011 12:18 PM, Benner Bernd (MH/EES) wrote:
> Hi,
>
> thank your for the support!
>
> I have upgraded to the ipipe-2.6.37-x86 branch. (
> kernel-2.6.37.6,xenomai-2.5.6 ) The system will start on all computers
> I test it. The latency application is running well on a
> Pentium-M- system and a Mobile Core 2 Duo 2,26 GHz -system. On a HP
> and a Lenovo Desktop Core 2 Duo 3 Ghz system ( Core 2 Duo E8400 ), a
> start of latency will freeze the system after output of the warmup
> console message.
>
> A start of cyclictest over ssh will not fully freeze the 3 GHz
> systems. cyclictest will not update the ssh console output. On the
> local console the system will slow down and there are Kernel error
> messages from the SATA driver after input of a command. With "slow
> keyboard inputs", I am able to kill cyclictest. There are some error
> messages from background file requests, but I am able to enter and
> execute commands.
>
> I have attached my kernel config.
>
> Is there a smp consistency problem on task creation ?
>
> Is there any way to find the reason of the problems on fast Core 2 Duo
> machines?
>
> Our older system with Kernel 2.6.29 and xenomai-2.4.10 has no problem
> on all this machines.
>
> Thanks in advance!
>
Both Jan and I asked it, but we did not see it. So, I am going to try
again: could you try and get the console output on serial console or netcon=
sole? If you can not, could you try booting in text mode, and see if you ha=
ve some traces when the system has issues?

Could you try disabling CONFIG_PCI_MSI in your kernel configuration?


--
                                                                Gilles.

