Message-ID: <4AC45853.2040107@domain.hid>
Date: Thu, 01 Oct 2009 09:20:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4AC1BCF9.8050908@domain.hid> <4AC4561B.5070004@domain.hid>
In-Reply-To: <4AC4561B.5070004@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [bug] accept() in non-blocking mode fails with
 EPERM instead of EAGAIN
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Matthieu Nottale wrote:
>> Hi,
>>
>> I believe I found a bug in the Xenomai Posix skin while trying to use
>> boost::asio: The accept() call in asychronous mode
>> fails with ENOPEM instead of EAGAIN. Other than that, the call 'works'
>> in the sense that calling it again after a connection is established
>> returns a new file descriptor.
> 
> On what kind of file descriptor descriping what kind of socket are you
> calling accept()? So far I'm not aware of any RTDM driver providing the
> corresponding service - well, at least not a public one (our RT-TCP
> stack is yet to be released). Or is it intended to pass the call to
> plain Linux, switching the caller into secondary more?

There's a sample attached. Yes, it is a TCP stream. Howeve accept is
wrapped, so it may happen that EPERM is the result of the wrapping.

-- 
					    Gilles.

