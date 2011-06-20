Message-ID: <4DFF675E.6080403@domain.hid>
Date: Mon, 20 Jun 2011 17:29:34 +0200
From: Johann Obermayr <johann.obermayr@domain.hid>
MIME-Version: 1.0
References: <f801f3950e5f79192ebc8824bfd54545@domain.hid>
	<4DFF5FEE.8060901@domain.hid>
In-Reply-To: <4DFF5FEE.8060901@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] mprotect in Xenomai
Reply-To: johann.obermayr@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Am 20.06.2011 16:57, schrieb Gilles Chanteperdrix:
> On 06/20/2011 04:14 PM, Michael Thalmeier wrote:
>>   Hello !
>>
>>   We have a xenomai application that uses mprotect to change write
>>   protection in order to set and clear breakpoint codes.
>>   This works quite well (the code invoking mprotect switches to linux,
>>   but thats ok).
>>   The problem is that from time to time the realtime task executing code
>>   in the area changed with mprotect also switches domains to handle a page
>>   fault.
>>   Is there some functionality in xenomai to change memory protection not
>>   using mprotect ?
>>   Attached you find a short sample that can reproduce this problem.
> I am afraid this is platform dependent, on what architecture do you get
> this behaviour?
>
Hello,

Now we use x86 platform.
later we will use ARM9 or higher.
with  Xenomai 2.5.6 .

Thanks
   Johann


