Message-ID: <2ff1a98a0806030549v28404c7fve261b90c313735c5@domain.hid>
Date: Tue, 3 Jun 2008 14:49:10 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <4845166E.3000203@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4845166E.3000203@domain.hid>
Subject: Re: [Xenomai-help] xeno-test on AT91SAM9263 irqloop and switchtest
	problem?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Paradoxxa <paradoxxa2001@domain.hid>
Cc: xenomai@xenomai.org

On Tue, Jun 3, 2008 at 12:01 PM, Paradoxxa <paradoxxa2001@domain.hid> wrote:
> Hi all,
>
> I have here a AT91SAM9263 with a 2.6.24 kernel, Xenomai 2.4.3 and Adeos
> Patch 1.9-01 and run the xeno-test. It seems there are a Problem with the
> irqloop and the switchtest applications.
> In the attachment you can find the log files.

Despite what the doc says, the irqloop test requires a PC parallel
port, so will probably only work on x86.

-- 
 Gilles

