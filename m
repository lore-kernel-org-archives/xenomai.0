From: Russell Johnson <russell.johnson@kratosdefense.com>
Subject: Realtime interrupt handling in driver
Date: Wed, 23 Feb 2022 00:10:15 +0000
Message-ID: <PH1P110MB1050BF72127DFC0CE3440B64E23C9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

In my driver that I have been converting to support OOB functionality with =
the EVL core, I have an interrupt handler that handles all interrupts from =
a device sitting on the PCIe bus. I was reading through the information on =
your wiki about interrupt pipelining in Dovetail. I was confused a bit on i=
f there is work that I need to do in order to get interrupts & interrupt ha=
ndlers to run out-of-band (and not be preempted by in-band linux processing=
), or if the EVL core takes care of that for me? If there is work I need to=
 do with interrupt config & interrupt handlers in order to make them able t=
o run out-of-band, where do I need to start?

Thanks!

Russell
