Date: Sun, 4 Apr 2010 15:18:53 +0200
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20100404131853.GA2582@domain.hid>
References: <4BB10B38.30806@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BB10B38.30806@domain.hid>
Subject: Re: [Xenomai-core] Analogy: improve a4l_find_range()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Hi,

Sorry for the delay.

Daniele Nicolodi wrote:
> Hello Alexis, I wrote a small patch to improve a4l_find_range().
> 
> As many every other functions expect to have the range specified as its
> idx into the struct describing the subdevice it is useful have it
> returned from a4l_find_range(). I also made returning a pointer to the
> range struncture optional.
> 
> I also attache a simple patch to clean up trailing whitespaces in the
> range.c file.
> 

I merged both. Thanks.

> Cheers,
> -- 
> Daniele


-- 
Alexis.

