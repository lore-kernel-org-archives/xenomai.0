Message-ID: <45E46D67.9030600@domain.hid>
Date: Tue, 27 Feb 2007 18:41:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <45E4646A.10205@domain.hid>
In-Reply-To: <45E4646A.10205@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-help] Re: high latency every 8 seconds
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Theo Veenker <Theo.Veenker@domain.hid>
Cc: xenomai@xenomai.org

Theo Veenker wrote:
> Hi all,
> 
> I'm installing xenomai 2.2.5 (kernel 2.6.17.14) on a number of

When starting new, pick something new, i.e. 2.3 right now. Only if you
have good reasons, staying at older versions is recommended.

> systems (MSI 945P, Intel P4 3Ghz). My kernel runs fine on several
> other/older systems, but on the new systems there is something going
> on every 8 seconds. See output of latency test below. What could
> this be? Is this an SMI effect?

Is CONFIG_XENO_HW_SMI_WORKAROUND selected? What does the kernel output
tell you about if it's working? Do you have an ICH7 chipset on your
board? Would be another reason to update Xenomai (2.3 takes care of it,
2.2.x doesn't)... :)

If this all doesn't help, have a look at this tool:

http://www.xenomai.org/index.php/I-pipe:Tracer

In any case, please give a feedback on the outcome.

Jan

