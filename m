References: <4C58E39DE6620348B85D78E601C268AF437ABD@srv-exchang2-mi.jerviswebb.com>,
 <201402142329.10853.paul_c@tuxcnc.org>
 <4C58E39DE6620348B85D78E601C268AF438358@srv-exchang2-mi.jerviswebb.com>
 <1392655777.26562.YahooMailNeo@web163503.mail.gq1.yahoo.com>
 <53026F63.5080403@grandegger.com>
 <1392760838.41780.YahooMailNeo@web163505.mail.gq1.yahoo.com>
 <d3241e64b0ad1946aaa3952553fe354f@grandegger.com>
 <1392847535.52577.YahooMailNeo@web163501.mail.gq1.yahoo.com>
 <3a692b55821a5a04d7b55253388edeaf@grandegger.com>
 <5305BAA6.1040007@xenomai.org>
Message-ID: <1393345381.78835.YahooMailNeo@web163505.mail.gq1.yahoo.com>
Date: Tue, 25 Feb 2014 08:23:01 -0800 (PST)
From: Wayne Ross <mr_trekkie@yahoo.com>
In-Reply-To: <5305BAA6.1040007@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] CAN ISA support
Reply-To: Wayne Ross <mr_trekkie@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Wolfgang Grandegger <wg@grandegger.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thursday, February 20, 2014 3:19 AM Gilles Chanteperdrix wrote:=0A=0A> O=
n 02/20/2014 08:47 AM, Wolfgang Grandegger wrote:=0A>> Am Mi, 19.02.2014, 2=
3:05 schrieb Wayne Ross:=0A>>> On Wednesday, February 19, 2014 3:16 AM Wolf=
gang Grandegger wrote:=0A>>>> - What does "/proc/xenomai/irq" list after yo=
u have sent a message?=0A>>>>=0A>>> # cat /proc/xenomai/irq=0A>>> IRQ=A0 =
=A0 =A0 =A0  CPU0=A0 =A0 =A0 =A0 CPU1=A0 =A0 =A0 =A0 CPU2=A0 =A0 =A0 =A0 CP=
U3=0A>>>=A0 12:=A0 =A0 =A0 =A0 =A0  0=A0 =A0 =A0 =A0 =A0  0=A0 =A0 =A0 =A0 =
=A0  0=A0 =A0 =A0 =A0 =A0  0=A0 =A0 =A0 =A0  SJA1000=0A>>>=A0 15:=A0 =A0 =
=A0 =A0 =A0  0=A0 =A0 =A0 =A0 =A0  0=A0 =A0 =A0 =A0 =A0  0=A0 =A0 =A0 =A0 =
=A0  0=A0 =A0 =A0 =A0  SJA1000=0A>> =0A>> ... the problem is here. No inter=
rupts are triggered. Are your sure=0A>> that the IRQ numbers are correct (c=
heck jumpers on the card/board)?>=0A>You can also check cat /proc/interrupt=
s when using the Linux driver.=0A>=0A>-- =0A>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 Gilles.=0A=0A=0AThanks for all the in-sight.=A0 Tr=
acing down this lack of interrupts led me to the following solution:=0A- th=
e Advantech driver *transmits* without the aid of IRQs, so I "thought" it w=
as working, when indeed no IRQs were seen.=0A- I had never tried to receive=
 CAN with the Advantech driver: when I did so, it would not (no IRQs)=0A- I=
 found the setting in my v2.61 American Megatrends BIOS that allows "Legacy=
 IRQs" to be "Reserved" (not allowed to be used by PCIPnP).=0A- I also had =
to select different IRQs that all components (BIOS, CAN card, 4 16550A UART=
s & some ata/acpi Linux drivers) agree were unused and I could tag as "Rese=
rved"=0A- In hindsight, all of this should have been done first, but such i=
s the lesson learned when venturing down a new road.=A0 I'm not used to dea=
ling with a BIOS that gets between the chips on my board and the software I=
 write.=0A=0AI intend to look more at the btr1 register "issue".=A0 As Wolf=
gang mentions, it *should* be 0x1c, so only sometimes do I get the correct =
value.=A0 I think the 0x9c means "3 samples" (instead of 1) -- at least whe=
n I put these register settings into my Windows driver, that is how that so=
ftware decodes the meaning.=A0 But it does indeed transmit and receive thou=
sands of messages without a problem.=0A=0AThanks again=0A=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 Wayne=0A

