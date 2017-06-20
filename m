From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Tue, 20 Jun 2017 01:57:30 +0000
Message-ID: <DB6PR0701MB2456EF514E9F35DE586D1EFDB5C50@DB6PR0701MB2456.eurprd07.prod.outlook.com>
References: <DB6PR0701MB24567D7382C2C3C1C6BBB0A3B5C60@DB6PR0701MB2456.eurprd07.prod.outlook.com>,
 <3f72aa86-8922-540f-36ca-cad41840dcc4@xenomai.org>
In-Reply-To: <3f72aa86-8922-540f-36ca-cad41840dcc4@xenomai.org>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Gpio: IRQ handler is called ~4ms after state change
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

> This is unlikely a Xenomai issue strictly speaking. You may want to
> check the I-pipe code instead, there is certainly a problem with the
> interrupt delivery code in the low level handler.

I have no idea where to start from in checking the i-pipe code.

What I can say is that I went back to 4.4.43, which is the version original=
ly targeted by the i-pipe patch which is released on the xenomai website, a=
nd the issue is still there.

Any pointers appreciated.

Thanks,
Giulio=

