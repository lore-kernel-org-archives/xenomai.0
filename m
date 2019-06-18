Message-ID: <0881c8f094cabf8753b31f4899ce879658d204ae.camel@sprinte.eu>
Subject: Re: serial driver for imx28
From: Julien Blanc <julien.blanc@sprinte.eu>
Date: Tue, 18 Jun 2019 10:40:49 +0200
In-Reply-To: <VI1PR05MB591784C28B09BCDB55042863F6EE0@VI1PR05MB5917.eurprd05.prod.outlook.com>
References: <a4aa24290a89f22416023b74362d88d25c7a005b.camel@sprinte.eu>
 <VI1PR05MB59179825BCF273386EB32AADF6EE0@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <c22f08c9283534d80450c26ec41a8500d279f75d.camel@sprinte.eu>
 <VI1PR05MB591784C28B09BCDB55042863F6EE0@VI1PR05MB5917.eurprd05.prod.outlook.com>
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
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai	(xenomai@xenomai.org)" <xenomai@xenomai.org>

Le vendredi 14 juin 2019 à 13:19 +0000, Lange Norbert a écrit :

> If the issue is on the receive side you probably need HW flow-control 
> via RTS/CTS pins to make sure you don’t lose anything.

This proved to be a very good advice, as it seems to solve our issues.
Why we did not think about enabling it in the first place remains a
mystery to me.

Thank you very much,

Julien


