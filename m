Subject: Re: [Xenomai-core] [patch, RFC] detect unhandled interrupts
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <b647ffbd0608291228i58bfa3fex5e8f3e18dc0ecc0@domain.hid>
References: <b647ffbd0608291228i58bfa3fex5e8f3e18dc0ecc0@domain.hid>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 10:31:32 +0200
Message-Id: <1157013092.4359.11.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2006-08-29 at 21:28 +0200, Dmitry Adamushko wrote:
> 
> Hello,
> 
> Jan has rised this question initially and I was struggling last week
> to get his request eventually done :)
> 
> The main idea is to prevent system lockups when the cross domain IRQ
> sharing isn't properly used (there were a number of reports recently).
> 
> So here is an initial patch as well as some related critics (yep, I
> critisize my own patch).

[...]

Applied, thanks.

-- 
Philippe.



