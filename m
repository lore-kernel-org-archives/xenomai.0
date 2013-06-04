Message-ID: <51ADC1E2.50009@grandegger.com>
Date: Tue, 04 Jun 2013 12:30:58 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <1198817500.51915549.1370338190512.JavaMail.root@zimbra14-e2.priv.proxad.net>
In-Reply-To: <1198817500.51915549.1370338190512.JavaMail.root@zimbra14-e2.priv.proxad.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] IMX27 internal uart xenomai driver ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jeanmicheltaprest@free.fr
Cc: xenomai@xenomai.org

On 06/04/2013 11:29 AM, jeanmicheltaprest@free.fr wrote:
> 
> Is there a xenomai driver for the internal uart of the IMX27 Freescale microcontroller ?

There is a rt-imx-uart [1], which should work for the i.MX27 as well.
There might be some SOC and especially platform specific quirks
necessary to get it working, though.

[1] http://git.xenomai.org/?p=xenomai-2.6.git;a=commitdiff;h=146fae2ecae13b4883f8a8f9466a74725da4cac5

Wolfgang.


