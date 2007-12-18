Message-ID: <476792F5.6030108@domain.hid>
Date: Tue, 18 Dec 2007 10:29:25 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <7289437c0712140324s41dd3255u9534c606bc510ec7@domain.hid>
In-Reply-To: <7289437c0712140324s41dd3255u9534c606bc510ec7@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RTDM mmap and DMA
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

Perrine Martignoni wrote:
> Hi,
> 
> Currently, I write an RTDM module and I would like to do DMA and mmap to
> perform transfers who have hard constraints.
> I would like to know if there is an example in a driver who would help me to
> do this.

There is code using the related rtdm_mmap_to_user service, but it is
unpublished. So let me sketch to basic patter:

1. Define some IOCTL that allocate the DMA area statically and maps it
   to the requesting user's address space with rtdm_mmap_to_user.

2. Register pieces of the DMA buffer with the hardware and let it
   perform the transfer

3. Signal the transfer completion to the user (who may be waiting on it
   in some other IOCTL)

4. The user signals via an IOCTL (may be the same as in 3.) that he's
   done with some piece of the buffer so that it can be reused with the
   hardware.

5. Goto 2.

HTH,
Jan


