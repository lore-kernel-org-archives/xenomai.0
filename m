Message-ID: <4C36FD74.9020602@domain.hid>
Date: Fri, 09 Jul 2010 12:44:04 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <AANLkTilLcPtUo564fICdJQtOQAjbvVj2l2Oxq8F3yycp@domain.hid>
In-Reply-To: <AANLkTilLcPtUo564fICdJQtOQAjbvVj2l2Oxq8F3yycp@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] IXXAT SJA_MOD register refuses to set up dual
 channel cards
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Soetens <peter@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Hi Peter,

On 07/09/2010 12:26 PM, Peter Soetens wrote:
> Hi,
> 
> (Xenomai 2.5.2&2.5.3)
> 
> I'm testing the rtcan ixxat driver for a dual channel card (PLX
> Technology, Inc. Device 2540)
> 
> It recognizes the first channel, but refuses to setup the second one
> because the SJA_MOD flag is 0x7f instead of 0x21
> The SJA_IR and SJA_SR flags read as are what the driver expects.

In the Socket-CAN "plx_pci" driver we mask the value with 0xa1:

  0x7f & 0xa1 = 0x21 ==> OK.

See
http://lxr.linux.no/#linux+v2.6.34.1/drivers/net/can/sja1000/plx_pci.c#L223

> Any suggestions on what it means and how to fix this ?

See above. A patch would be nice.

Wolfgang.



