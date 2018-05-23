Date: Wed, 23 May 2018 10:56:57 -0400
Message-ID: <20180523145657.3o5xvu4d5wobobua@csclub.uwaterloo.ca>
References: <CA+K1mPGz2V-pWH=DLL15onqtL-CRFkezJjy2xrnRQP7rFX1W5Q@mail.gmail.com>
 <77f03786-e75e-cf4b-32b9-e6459fb9dcaa@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77f03786-e75e-cf4b-32b9-e6459fb9dcaa@siemens.com>
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: [Xenomai] Only 2 serial ports at a time with xeno_16550A driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On Wed, May 23, 2018 at 11:18:04AM +0200, Jan Kiszka wrote:
> As noted in the other thread, IRQ 5 is most probably wrong. Check what
> Linux uses when you attach the device to a normal Linux driver.

Agreed.  PCs use IRQ 4 and 3 for serial ports at addresses 3f8, 2f8,
3e8 and 2e8.

ttyS0: 0x3f8 irq 4
ttyS1: 0x2f8 irq 3
ttyS2: 0x3e8 irq 4
ttyS3: 0x2f8 irq 3

It can often be changed, but those are the defaults.

-- 
Len Sorensen

