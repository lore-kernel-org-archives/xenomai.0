Date: Sun, 25 Apr 2010 00:20:30 +0200
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20100424222030.GA3143@domain.hid>
References: <4BA259D1.4020704@domain.hid> <4BA2BFCF.8010000@domain.hid>
	<4BB0F428.5050905@domain.hid> <20100405215416.GA2522@domain.hid>
	<0B3F00B1-55F9-4239-A154-E63EAE89072B@usc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0B3F00B1-55F9-4239-A154-E63EAE89072B@usc.edu>
Subject: Re: [Xenomai-core] Analogy: cmd_bits
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stefan Schaal <sschaal@domain.hid>
Cc: Peter Pastor Sampedro <pastorsa@domain.hid>, xenomai@xenomai.org

Hi,

Stefan Schaal wrote:
> I tried the new cmd_bits function today to use commands to write to a DIO device on my NI6259 board (thanks a lot, Alexis, for starting this!). Unfortunately, cmd_bits terminates with an error:
> 
> root@domain.hid> ./cmd_bits -v -s 2 0xffffffff 0xffffffff
> cmd_bits: device analogy0 opened (fd=0)
> cmd_bits: basic descriptor retrieved
> 	 subdevices count = 14
> 	 read subdevice index = 0
> 	 write subdevice index = 1
> cmd_bits: complex descriptor retrieved
> cmd_bits: selected subdevice index = 2
> cmd_bits: command successfully sent
> cmd_bits: a4l_write failed (err=-2) (count=0)       
> (I added a counter in the while loop in cmd_bits.c, and the error occurs immediately after the while loop is entered, i.e., count=0)
> 
> root@domain.hid> dmesg
> [63462.716029] Analogy: a4l_write: idle subdevice

I noticed this bug. I am working on it. This test program disclosed an
annoying bug which needs some time to fix: a4l_async_write() returned
"idle subdevice" because the subdevice index is wrongly retrieved.

> 
> Any thoughts what may cause this error?
> 
> Best wishes,
> 
> -Stefan

-- 
Alexis.

