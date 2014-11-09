Date: Sun, 9 Nov 2014 16:53:51 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141109155351.GH17476@sisyphus.hd.free.fr>
References: <04e5e7e2fab241a5916e4e48f9d9b325@EX132MBOX1B.de2.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04e5e7e2fab241a5916e4e48f9d9b325@EX132MBOX1B.de2.local>
Subject: Re: [Xenomai] "inconsistent lock state" on boot-up
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Stoidner, Christoph" <c.stoidner@arvero.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Sun, Nov 09, 2014 at 10:07:54AM +0000, Stoidner, Christoph wrote:
> Hi at all,
> 
> I am using linux 3.10.32 and ipipe-core-3.10.32-arm-4.patch on a
> Freescale i.MX28.
> 
> When booting the kernel the message "inconsistent lock state" is
> given (see below). Does anyone have an idea why this happens? With
> kernel 3.10.18 and according ipipe it is the same. With linux
> 3.4.6 and ipipe 3.4.6-arm-4 the message does not appear.

Do you have the same message with exactly the same kernel
configuration, only with CONFIG_XENOMAI and CONFIG_IPIPE disabled? 

> 
> I am very interested to understand if these message could lead to
> any problems, since I have I unpredictable crashes of my
> xenomai-based application program (e.g. with "segmentation fault"
> or "scheduling while atomic" messages).

Do you have FCSE enabled? If yes, did you try disabling it? same
with unlocked context switch.

-- 
					    Gilles.

