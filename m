Message-ID: <501028DC.8000803@xenomai.org>
Date: Wed, 25 Jul 2012 19:11:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CE2E43470FE5444A811B580382FE5EDF2113D8D95A@KEMPMAIL2.woodward.com>	<5009A292.4060508@grandegger.com>
	<CE2E43470FE5444A811B580382FE5EDF2113EA8DE7@KEMPMAIL2.woodward.com>
In-Reply-To: <CE2E43470FE5444A811B580382FE5EDF2113EA8DE7@KEMPMAIL2.woodward.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai installation on P1020RDB
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lukasz Zemla <Lukasz.Zemla@woodward.com>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 07/25/2012 06:18 PM, Lukasz Zemla wrote:

> I tried to install Xenomai on 3.2.21 - it boots, but waits about 76 seconds after initialization of first eth0 controller: 
> 
> 	[    0.905820] fsl-gianfar ethernet.1: eth0: TX BD ring size for Q[7]: 256
> 	[   77.451135] fsl-gianfar ethernet.2: eth1: mac: 00:04:9f:02:2d:11
> 
> There is no delay between eth1 and eth2. 
> 
> The vanilla 3.2.21 does not have any delays - it initializes eth0, eth1, eth2 immediately.
> 
> [...]


It is very much likely a timer issue. At the time it happens, is xenomai
started ?

-- 
                                                                Gilles.

