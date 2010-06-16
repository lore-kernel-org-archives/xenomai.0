Message-ID: <4C190092.2040708@domain.hid>
Date: Wed, 16 Jun 2010 18:49:22 +0200
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <4C177276.7060005@domain.hid> <20100615221116.GB3087@domain.hid>
In-Reply-To: <20100615221116.GB3087@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] How to avoid a tight real time loop
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alexis Berlemont <alexis.berlemont@domain.hid>
Cc: xenomai@xenomai.org

On 16/06/10 00:11, Alexis Berlemont wrote:
>> There is not an analogy API that can be used to require a certain amount
>> of data to the ADC driver. How can I code this loop to let other
>> processes to run?
> 
> As a matter of fact, there is something in the API which could have
> helped you in an unmapped configuration. If you set the flag
> A4L_CMD_BULK in the field "flags" of the command structure, a call to
> a4l_async_read() only returns when the data size specified as argument
> is available.

Unfortunately copying memory data around would decrease too much the
performance of my data acquisition code. By the way, I think that using
the O_NONBLOCK fcntl flag on the device descriptor file descriptor would
be the best way to activate this feature.

> Unfortunately, I have not done the same thing with a4l_poll, I might
> have added the requested size as an additional argument to a4l_poll. 
> 
> Any idea on how to extend the API without breaking it ?

I do not see any way rather than augmenting the function signature with
an additional parameter. If you want to maintain API compatibility the
only thing to do is to add a different function.

Cheers,
-- 
Daniele

