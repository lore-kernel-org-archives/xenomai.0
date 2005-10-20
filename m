Message-ID: <4357407D.2060204@domain.hid>
Date: Thu, 20 Oct 2005 09:00:13 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] XenoEmbeddedPPC Help
References: <55787.128.93.15.41.1129787966.squirrel@domain.hid>
In-Reply-To: <55787.128.93.15.41.1129787966.squirrel@domain.hid>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: smannori@domain.hid
Cc: roberto.bucher@domain.hid, xenomai@xenomai.org

On 10/20/2005 07:59 AM smannori@domain.hid wrote:
> Hi:
> 
> I see a lot's of activity around PPC embedded hardware. I'm happy to see
> that there is intelligent lifeform beyond x86 :).
> 
> I' relatively new to this environnement, so if someone will post a short
> list of "Xenomai tested" PPC embedded boards I think that will useful for
> newbie like me.

You just need Linux 2.6.13 supported and running on the embedded PowerPC
board (this is not yet the case for some boards). Most sub-architectures
like 4xx, 8xx, 603 cores (52xx, 82xx), e500 cores (85xx) seem already to
work fine with Xenomai and iPIPE 1.0x. The latency figures might be a
criteria as well, apart from your general resource requirements (CPU
power, peripherals, FLASH, etc.). There are plenty of boards available
on the market.

Wolfgang.

