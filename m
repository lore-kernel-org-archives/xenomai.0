Message-ID: <46EBC5FC.5020807@domain.hid>
Date: Sat, 15 Sep 2007 13:46:04 +0200
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <1ce16a2c0709130245m6c73abd3tc8023237e03f70f2@domain.hid>		<cbe23c50709130434x127c8e86nfb061ac71555cd68@domain.hid>		<46EA3253.3010901@domain.hid>	<cbe23c50709140112q160c809alc398ed1b9a502c40@domain.hid>
	<46EAC591.4050602@domain.hid>
In-Reply-To: <46EAC591.4050602@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] too fast write to serialport?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
>> Do you mean that the serial driver (you wrote) has currently no
>> way to know if written bytes have been sent on the wire by the UART ?
> 
> That is true. The asynchronous transmitting of data was intentionally
> installed, but I didn't consider to establish some interface to request
> and/or synchronise on the output completion. Will think about this when
> time permits.
One way would be to implement ioctl for setting TxBufffer size, then 
with proper coding, TxBufSize = 0 would (analogous to 0 size FIFO) imply 
rendezvous semantics.

Just my 5 cents

Regards

Anders Blomdell

