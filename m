Message-ID: <2ff1a98a0709140144v3cac6d4fh43958cd5c7845494@domain.hid>
Date: Fri, 14 Sep 2007 10:44:20 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <7289437c0709140109w904c602w324d4fa19c822564@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <7289437c0709140109w904c602w324d4fa19c822564@domain.hid>
Subject: Re: [Xenomai-help] RTDM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On 9/14/07, Perrine Martignoni <perrmart@domain.hid> wrote:
> Hello,
>
> I have to write some drivers in an environment Linux+Xenomai on a
> PowerQuickIIPro board. And I want to know what are the advantages to do the
> drvivers with RTDM.
> Are system calls faster in the Xenomai context?
> Have you some tests who show the difference?

The difference is a difference of design. When using RTDM, driver code
is cleanly separated from application code. This leads to an easier
maintenance, because it allows the two codes to evolve independently.

-- 
                                               Gilles Chanteperdrix

