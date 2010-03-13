Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <4B9ADC6C.8060307@domain.hid>
Date: Sat, 13 Mar 2010 01:29:32 +0100
From: Alexis Berlemont <berlemont.hauw@domain.hid>
MIME-Version: 1.0
References: <4B968538.7030204@domain.hid>	<4B968BAC.5090205@domain.hid>		<4B977F1F.8030304@domain.hid>	<1268220794.27899.50.camel@domain.hid>	<4B97A662.3040004@domain.hid>
	<4B97F0AC.2060003@domain.hid>
In-Reply-To: <4B97F0AC.2060003@domain.hid>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] COMEDI vs Analogy
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai@xenomai.org

Hi,

Daniele Nicolodi wrote:
> Daniele Nicolodi wrote:
>> Philippe Gerum wrote:
>>> If you do want to help, you may want investing your time in developing
>>> and testing a better code base like Analogy with other people, instead
>>> of re-opening a dead development effort all alone.
>> Let's try to have a more constructive approach. What is required  to
>> support the TRIG_WAKE_EOS command functionality in the ni pcimio driver
>> in Analogy?
> 
> Well. After playing a bit with Analogy, it looks like TRIG_WAKE_EOS is
> not unsupported (as is stated in the documentation). It works!
> 
> I'm using a NI 6251 PCI ADC. I have verified that TRIG_WAKE_EOS works as
> expected up to a sampling frequency of 800-1000 Hz, sampling 8 channels
> at time. If I use an higher sampling rate, my acquisition loops
> receives, at each iteration, more data than the data corresponding at
> one scan, but always in multiples of one scan.
> 
> I guess this is due to the fact that the reading process is not able to
> keep peace with the ADC board. It is however strange that I'm unable to
> go to higher sampling rates. I'm able to have, easily, periodic tasks
> running up to more than 10 kHz. There is a way to improve the performance?
> 
> I tried to directly mmap the acqusition buffer, instead of doing copies
> through reads, but it turned out that there are no Analogy drivers that
> support mmap acces to the data buffer (not in xenomai 2.5.1 sources at
> least). Can I somehow help in implementing this missing feature?
> 
The mmap features is only enabled in the test drivers (fake and loop).
The reason is that I did not have enough time to test it on the driver
NI PCIMIO.

If you want to test it you just have to add a flag in the AI subdevice
descriptor (on the driver side, you just add the mmap

subd->flags |= A4L_SUBD_MMAP;

The NI PCIMIO driver contains so many functionalities that it takes me a
lot of time to test only a part of them. By the way, let's start a topic
I will develop in other mails. That may clarify a little bit the situation.

I went on holidays with two requests in mind:
- Stefan Schaal would like to use cmd_write on the NI digital subdevice;
- Cristian Axenie would like to get an API to configure the NI counting
subdevice.

I spent all my free time on them (when my wife and my daughter were
asleep) and I am still unable to provide them any suitable solution. And
do you know why ? I had a look at all the comedi drivers which
implements asynchronous digital transfers and counting features: each
one uses a different way.

The most striking examples were in the configuration of the counting
stuff. At least four comedi drivers manage gpct: the NI ones, s526,
me4000 and vmk80xx. Each one has defined its one configuration
instruction, in other words, its one interface. That means for me that a
user application must be specific to a driver to work properly (in some
cases, you must even give the registers values).

Such a situation is, for me, not acceptable. Any acquisition user
application should work with any acquisition driver and especially
because of the acquisition framework.

Starting from here, it is really difficult for me to find out what
interface I should implement so as to satisfy all of them.

One more thing: my job is related in no way with acquisition stuff. I
spent quite a lot of time in documentation reading (DAQ-STC, etc.) to be
sure I miss nothing. So, if you have experience to share, I am really
interested.

So to sum-up, that was just a few lines to explain why analogy is still
work in progress in many cases and why comedi still provides far more
features. I take great care in the API enrichment because I cannot
afford any API breakage in the near future.

With these practical anecdotes, I intend to make understand the main
reasons of the divergences between comedi and analogy. The divergence in
terms of implementation and API is real and I think it will continue.
However, I hope Analogy will soon match comedi in terms of features and
drivers, maybe with your help.

> Thanks. Cheers,

Alexis.

