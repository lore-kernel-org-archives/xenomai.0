MIME-Version: 1.0
References: <mailman.113.1577718625.956.xenomai@xenomai.org>
In-Reply-To: <mailman.113.1577718625.956.xenomai@xenomai.org>
From: Nitin Kulkarni <nitin@elk.audio>
Date: Thu, 9 Jan 2020 17:47:46 +0100
Message-ID: <CAPgPmP0n8Z+czZjEFe6C5dapwBGRdjX6p7MSK1BNdJB30RX6iA@mail.gmail.com>
Subject: Re: [patch 2/5] SPI_RTIOC_TRANSFER_N ioctl with len parameter
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: laurentiu.duca@gmail.com
Cc: xenomai@xenomai.org

>
> Date: Mon, 30 Dec 2019 17:07:21 +0200
> From: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
> To: xenomai <xenomai@xenomai.org>
> Subject: [patch 2/5] SPI_RTIOC_TRANSFER_N ioctl with len parameter
> Message-ID:
>         <CAPm8-H589E2WZB=
> UxrVjbmsxD-7UcLMke56XHKK6Zy_iSS9oDg@mail.gmail.com>
> Content-Type: text/plain; charset="UTF-8"
>
> >From d47ede0283b68ac972d7f6a4b87ba1caa4fa9d5f Mon Sep 17 00:00:00 2001
> From: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
> Date: Mon, 23 Dec 2019 16:49:05 +0200
> Subject: [PATCH] SPI_RTIOC_TRANSFER_N ioctl with len parameter to transfer
>  only len bytes to SPI slave
>
> Note that set_iobufs() used in xenomai-spi-drivers
> (spi-bcm2835.c and other drivers using its model)
> allocates for the user ioctl(SPI_RTIOC_SET_IOBUFS)
> len = L1_CACHE_ALIGN(len) * 2;
> (half for tx and half for rx)
> which in case of am335x for example the resulted len will be greater than
> 2 multiplied with user requested len. So, ioctl(SPI_RTIOC_TRANSFER)
> will transfer more bytes than requested in case of am335x.
> Hence, a new ioctl(SPI_RTIOC_TRANSFER_N, int requested_len) was added
> to transfer only requested_len bytes to SPI slave.
>

For the above patch that you submitted a few days ago,
I just wanted to know if you tested on RPI 3B or 3B+ board ?
I had some issues with the Xenomai SPI RTDM drivers with RPI 3B+.
It was long back but what I can remember is that the GPIO interrupts were
working fine with rtdm interrupts but none of the peripheral devices'
interrupts were working.

Since the SPI RTDM driver works in interrupt mode, I couldn't use it and
had to go for a polling based driver. Just want to confirm if you didn't
have to do anything special to use the xenomai drivers for SPI on RPI
3B/3B+.

Thanks,
Nitin
