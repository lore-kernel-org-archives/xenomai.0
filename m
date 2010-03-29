Message-ID: <4BB0F428.5050905@domain.hid>
Date: Mon, 29 Mar 2010 20:40:40 +0200
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <4BA259D1.4020704@domain.hid> <4BA2BFCF.8010000@domain.hid>
In-Reply-To: <4BA2BFCF.8010000@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: xenomai@xenomai.org

Alexis Berlemont wrote:
> Daniele Nicolodi wrote:
>> After fixing analogy to permit continuous acquisition, I discovered that
>> ongoing commands are not canceled when a device is closed (I obtain a
>> DMA buffer owerwrite warning in the kernel log when I abruptly terminate
>>  my acquisition program).
>>
>> I think this is quite a surprising behavior. I would expect that the
>> commands are canceled when there isn't a data consumer any more. Would
>> it be possible to cancel any ongoing command on device close? If there
>> is agreement on this, I can look into providing a patch.
>>
> The close should indeed stop any occurring acquisition. I implemented
> this behaviour. It is in my git repository.

Hi Alexis. I have been working with analogy from your git three and I
should say that the new behavior, in my use case, is worst than the
previous.

Now, when a device is closed, all accurring acquisition are terminated,
also the ones that haven't been started by the current process. While it
is possible to use at the same time two different subdevices, from two
different processes, now it is not possible to terminate one process and
leave the other one running. I think that the correct behavior would be
to terminate just the acquisitions started by the current process.
However, I have no idea on how difficult this would be.

This bring me also to the fact that there isn't currently a way to
prevent two concurrent processes to access the same subdevice,
interfering each other. Would it possible to have a lock() method, as
comedi has?

Thanks. Cheers,
-- 
Daniele

