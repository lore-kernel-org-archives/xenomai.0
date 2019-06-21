From: Wolfgang Denk <wd@denx.de>
Subject: Re: serial driver for imx28
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
In-reply-to: <0881c8f094cabf8753b31f4899ce879658d204ae.camel@sprinte.eu>
References: <a4aa24290a89f22416023b74362d88d25c7a005b.camel@sprinte.eu>
 <VI1PR05MB59179825BCF273386EB32AADF6EE0@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <c22f08c9283534d80450c26ec41a8500d279f75d.camel@sprinte.eu>
 <VI1PR05MB591784C28B09BCDB55042863F6EE0@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <0881c8f094cabf8753b31f4899ce879658d204ae.camel@sprinte.eu>
Date: Fri, 21 Jun 2019 14:14:40 +0200
Message-Id: <20190621121440.AFE8C240049@gemini.denx.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Julien Blanc <julien.blanc@sprinte.eu>, Julien Blanc via Xenomai <xenomai@xenomai.org>

Dear Julien,

In message <0881c8f094cabf8753b31f4899ce879658d204ae.camel@sprinte.eu> you wrote:
>
>
> > If the issue is on the receive side you probably need HW flow-control 
> > via RTS/CTS pins to make sure you don’t lose anything.
>
> This proved to be a very good advice, as it seems to solve our issues.
> Why we did not think about enabling it in the first place remains a
> mystery to me.

The i.MX28 is a special beast.

Your issue is most likely caused by a somewhat stup^H^H^H^Hsimple
implementation of the UART driver. When it receives the interrupt
after receiving a block of data, it stops DMA until the data has
been read from the RX buffer and pushed to the TTY layer.  Given the
tiny size of the UART RX FIFO, this will cause frequent overruns if
you don't enable or cannot use flow control.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I can type faster than I can move a  mouse,  so  I  find  menu-driven
drawing packages time consuming and frustrating.      - W. R. Stevens

