Message-ID: <51C45C6F.9080109@siemens.com>
Date: Fri, 21 Jun 2013 16:00:15 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <mailman.1.1371808801.4609.xenomai@xenomai.org>
	<1371820048.30624.YahooMailNeo@web172205.mail.ir2.yahoo.com>
In-Reply-To: <1371820048.30624.YahooMailNeo@web172205.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] High latency and smi with intel vendor chip
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Franz Engel <franz_lambert_engel@yahoo.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2013-06-21 15:07, Franz Engel wrote:
> Hi,
>=20
> In my dmesg I get the following message:
> dmesg | grep -i xeno
> [    4.478964] I-pipe: head domain Xenomai registered.
> [    4.494089] Xenomai: hal/x86_64 started.
> [    4.505969] Xenomai: scheduling class idle registered.
> [    4.521300] Xenomai: scheduling class rt registered.
> [    4.538525] Xenomai: real-time nucleus v2.6.2.1 (Day At The Beach) l=
oaded.
> [    4.559065] Xenomai: debug mode enabled.
> [    4.579351] Xenomai: SMI-enabled chipset found
> [    4.592628] Xenomai: SMI workaround failed!
> [    4.605677] Xenomai: starting native API services.
> [    4.619979] Xenomai: starting POSIX services.
> [    4.633088] Xenomai: starting RTDM services.
>=20
>=20
> And I have very high latencies. I read that I should try to insert my t=
he ID of my LCP into the /usr/src/xenomai/ksrc/arch/x86/smi.c file.

That is no longer true since 2.6.2.1. Xenomai already detects your LPC
(see above), but the BIOS has apparently locked SMI disabling down.

In this case, you may want to play with smi_mask (see documentation of
"SMI_EN =97 SMI Control and Enable Register" in the Intel chipset manuals=
)
to see if disabling of individual SMI features work. If not, the board
is useless for low-latency real-time purposes.

Jan

--=20
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

