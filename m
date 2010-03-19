Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <4BA2BFCF.8010000@domain.hid>
Date: Fri, 19 Mar 2010 01:05:35 +0100
From: Alexis Berlemont <berlemont.hauw@domain.hid>
MIME-Version: 1.0
References: <4BA259D1.4020704@domain.hid>
In-Reply-To: <4BA259D1.4020704@domain.hid>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Analogy: cancel ongoing commands when a device
 is closed
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai@xenomai.org

Daniele Nicolodi wrote:
> After fixing analogy to permit continuous acquisition, I discovered that
> ongoing commands are not canceled when a device is closed (I obtain a
> DMA buffer owerwrite warning in the kernel log when I abruptly terminate
>  my acquisition program).
> 
> I think this is quite a surprising behavior. I would expect that the
> commands are canceled when there isn't a data consumer any more. Would
> it be possible to cancel any ongoing command on device close? If there
> is agreement on this, I can look into providing a patch.
> 
The close should indeed stop any occurring acquisition. I implemented
this behaviour. It is in my git repository.

> Thanks. Cheers,

Alexis.

