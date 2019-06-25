Message-ID: <aa21fde46dfe7df806b978a417d0a915c5ff9cb8.camel@sprinte.eu>
Subject: Re: serial driver for imx28
From: Julien Blanc <julien.blanc@sprinte.eu>
Date: Tue, 25 Jun 2019 14:12:36 +0200
In-Reply-To: <20190621121440.AFE8C240049@gemini.denx.de>
References: <a4aa24290a89f22416023b74362d88d25c7a005b.camel@sprinte.eu>
 <VI1PR05MB59179825BCF273386EB32AADF6EE0@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <c22f08c9283534d80450c26ec41a8500d279f75d.camel@sprinte.eu>
 <VI1PR05MB591784C28B09BCDB55042863F6EE0@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <0881c8f094cabf8753b31f4899ce879658d204ae.camel@sprinte.eu>
 <20190621121440.AFE8C240049@gemini.denx.de>
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
To: Wolfgang Denk <wd@denx.de>, Julien Blanc via Xenomai <xenomai@xenomai.org>

Le vendredi 21 juin 2019 à 14:14 +0200, Wolfgang Denk a écrit :
> Dear Julien,
> 
> The i.MX28 is a special beast.
> 
> Your issue is most likely caused by a somewhat stup^H^H^H^Hsimple
> implementation of the UART driver. When it receives the interrupt
> after receiving a block of data, it stops DMA until the data has
> been read from the RX buffer and pushed to the TTY layer.  Given the
> tiny size of the UART RX FIFO, this will cause frequent overruns if
> you don't enable or cannot use flow control.

Indeed.

The driver seems to be really buggy outside the simple use cases
(anything involving reconfiguring the transmission settings on the fly
is not recommended), but RTS/CTS definitely solved our data loss
issues. As a bonus we were even able to increase the baudrate up to
460800 bauds.

Best regards and thanks all for your answers,

Julien


