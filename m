Date: Mon, 4 Jul 2016 19:27:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160704172745.GB9465@hermes.click-hack.org>
References: <CALZu-7bww3OBzRcu67gP4yWeJ0GRfGR5Mm6_sDWen2V5Aryp8Q@mail.gmail.com>
 <20160701113422.GF17647@hermes.click-hack.org>
 <CALZu-7amePV01sp_x6ao_06ZFuADycuj8TU4MOLUuxfCviaC1A@mail.gmail.com>
 <CALZu-7YnBgp58AWcxgdcZ7aaH7DVEz8JOJCOEm+_EWdJF5jJfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALZu-7YnBgp58AWcxgdcZ7aaH7DVEz8JOJCOEm+_EWdJF5jJfw@mail.gmail.com>
Subject: Re: [Xenomai] Pb with 4 serial ports Moxa card
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: marc favereau <favereau.marc.m2gl@gmail.com>
Cc: xenomai@xenomai.org

On Fri, Jul 01, 2016 at 02:30:49PM +0200, marc favereau wrote:
> I don't understand why the driver is on /sys/bus/pci/drivers and not on
> /sys/bus/pci_express/drivers  ???

Because that is the way Linux works. This has nothing to do with
Xenomai.

> ?!?!?!?!
> 
> Why 5 rtser instead of 1 ???
> 
> and why no error ???

I guess the answers to all those questions are in the driver code.
Xenomai is free software, you are free to read, and even modify its
code.
-- 
					    Gilles.
https://click-hack.org

