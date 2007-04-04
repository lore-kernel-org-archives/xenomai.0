Message-ID: <4613690A.2010508@domain.hid>
Date: Wed, 04 Apr 2007 10:59:54 +0200
From: Stephan Zimmermann <s.zimmermann@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Which thread holds a Mutex?
References: <4613623A.6090008@domain.hid>
	<1175676629.4666.11.camel@domain.hid>
In-Reply-To: <1175676629.4666.11.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Philippe Gerum schrieb:
> On Wed, 2007-04-04 at 10:30 +0200, Stephan Zimmermann wrote:
>> Hi,
>> I see a deadlock occur every now and than in my app. Is there a way to 
>> tell which thread is actually holding a lock from a normal userspace 
>> app? rt_mutex_inquire() only tells me that it is locked, but not who is 
>> holding it.
>>
> 
> /proc/xenomai/registry/native/mutexes/...

Ouch!

>> Tia, Stephan
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help


