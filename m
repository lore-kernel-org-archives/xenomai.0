Message-ID: <503C634B.8050604@xenomai.org>
Date: Tue, 28 Aug 2012 08:20:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <503A2770.1020405@grandegger.com>
In-Reply-To: <503A2770.1020405@grandegger.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] rt-imx-uart: RTserial driver for the UART's
 on the Freescale IMX SOCs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 08/26/2012 03:41 PM, Wolfgang Grandegger wrote:

> This RTserial driver is for the Freescale IMX internal UART compatible
> controllers. It has been tested with Freescale's 3.0.15 kernel on an
> i.MX53 and i.MX6Q board but it should work with more recent mainline
> kernel versions as well. The modem control and line state is handled
> similar to the 16550A UART, if possible. But this part is still weak
> and not very well tested.


Applied, thanks.


-- 
                                                                Gilles.

