Message-ID: <4B97F0AC.2060003@domain.hid>
Date: Wed, 10 Mar 2010 20:19:08 +0100
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <4B968538.7030204@domain.hid>
	<4B968BAC.5090205@domain.hid>		<4B977F1F.8030304@domain.hid>	<1268220794.27899.50.camel@domain.hid>
	<4B97A662.3040004@domain.hid>
In-Reply-To: <4B97A662.3040004@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Daniele Nicolodi wrote:
> Philippe Gerum wrote:
>> If you do want to help, you may want investing your time in developing
>> and testing a better code base like Analogy with other people, instead
>> of re-opening a dead development effort all alone.
> 
> Let's try to have a more constructive approach. What is required  to
> support the TRIG_WAKE_EOS command functionality in the ni pcimio driver
> in Analogy?

Well. After playing a bit with Analogy, it looks like TRIG_WAKE_EOS is
not unsupported (as is stated in the documentation). It works!

I'm using a NI 6251 PCI ADC. I have verified that TRIG_WAKE_EOS works as
expected up to a sampling frequency of 800-1000 Hz, sampling 8 channels
at time. If I use an higher sampling rate, my acquisition loops
receives, at each iteration, more data than the data corresponding at
one scan, but always in multiples of one scan.

I guess this is due to the fact that the reading process is not able to
keep peace with the ADC board. It is however strange that I'm unable to
go to higher sampling rates. I'm able to have, easily, periodic tasks
running up to more than 10 kHz. There is a way to improve the performance?

I tried to directly mmap the acqusition buffer, instead of doing copies
through reads, but it turned out that there are no Analogy drivers that
support mmap acces to the data buffer (not in xenomai 2.5.1 sources at
least). Can I somehow help in implementing this missing feature?

Thanks. Cheers,
-- 
Daniele

