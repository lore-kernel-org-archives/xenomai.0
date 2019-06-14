Message-ID: <c22f08c9283534d80450c26ec41a8500d279f75d.camel@sprinte.eu>
Subject: Re: serial driver for imx28
From: Julien Blanc <julien.blanc@sprinte.eu>
Date: Fri, 14 Jun 2019 14:45:54 +0200
In-Reply-To: <VI1PR05MB59179825BCF273386EB32AADF6EE0@VI1PR05MB5917.eurprd05.prod.outlook.com>
References: <a4aa24290a89f22416023b74362d88d25c7a005b.camel@sprinte.eu>
 <VI1PR05MB59179825BCF273386EB32AADF6EE0@VI1PR05MB5917.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

Le vendredi 14 juin 2019 à 12:26 +0000, Lange Norbert via Xenomai a
écrit :
> > -----Original Message-----
> > From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Julien
> > Blanc
> > via Xenomai
> > Sent: Freitag, 14. Juni 2019 13:54
> > To: Xenomai@xenomai.org
> > Subject: serial driver for imx28
> > 
> > 
> > We’re currently trying to make the serial port working on a custom
> > board
> > based on an imx28 som.
> 
> Are you using the Debug uart or the Application UART?
> The debug uart has incredibly slow register accesses, and can't do
> DMA, you would not be happy about that in an RT application.

I’m talking about the application uart. Also, note that the UART does
not need to be realtime (the reason we are using it from plain linux in
the first place), but the issues we encounter make us reconsider this
decision.

> Further what interfaces are you planning to use? Ethernet is rather
> horrible to use aswell, as you need to byteswap *all* data (hardware
> bug, I am not talking about the Ethernet heads using BigEndian).

We’re not planning to do any rtnet, and the linux driver seems fine
(frow a user pov). RT is required for CAN and gpios (both handled by
xenomai drivers) which work fine. Our only issues are with uart, called
from linux domain (issues which were unfortunately not seen during the
qualification phase).

> Sorry, don’t know the state of Xenomai in regards to this SOC, (but I
> know the Chip and its warts pretty well).

Switching to another chip is not an option (we need to solve this issue
for existing boards).

Thanks for your reply,

Regards,

Julien


