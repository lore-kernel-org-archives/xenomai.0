Message-ID: <4ECCBFF1.1040104@domain.hid>
Date: Wed, 23 Nov 2011 10:42:09 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1320995056.19430.YahooMailNeo@domain.hid>	<4EBD0A71.7090409@domain.hid>
	<1322037104.76183.YahooMailNeo@domain.hid>
In-Reply-To: <1322037104.76183.YahooMailNeo@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] IDDP send-receive example emits SIGXCPU signal
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

On 11/23/2011 09:31 AM, Guvenc Gulce wrote:
> Yes.. I have enabled the support for iddp sockets in the kernel configuration. It looks like that
>
> it works with xenomai 2.6.0 when I enable the
>
> pthread_set_mode_np(0, PTHREAD_WARNSW);
> after the socket() and bind() calls. (tested again with the example code from xenomai)
>
> My question is:
>
> Is it designed that way that the calls socket() and bind() for IDDP cause a switch to
>
> secondary mode and the calls recvfrom() and sendto() do not ? In other words
>
> does the real-timeliness guarantee exist only for recvfrom() and sendto() ?

No. socket() or bind() have no reason to switch to secondary mode, 
unless socket() fails for the AF_RTIPC domain, in which case the call is 
routed to the regular kernel to handle the address family. You not only 
need to enable IDDP in the kernel, but you also have to wrap POSIX calls 
to libpthread_rt services.

If socket(AF_RTIPC, ...) failed reaching Xenomai/RTDM, then it will also 
fail with the regular kernel, and this call will return an error.

>
>
> Thanks&  Regards
>
> Guvenc
>
>
>
>
> ----- Original Message -----
> From: Gilles Chanteperdrix<gilles.chanteperdrix@xenomai.org>
> To: Guvenc Gulce<gulceg@domain.hid>
> Cc: "xenomai@xenomai.org"<xenomai@xenomai.org>
> Sent: Friday, November 11, 2011 12:43 PM
> Subject: Re: [Xenomai-help] IDDP send-receive example emits SIGXCPU signal
>
> On 11/11/2011 08:04 AM, Guvenc Gulce wrote:
>> looks like XENOMAI_SKINCALL3 macro is failing for some reason but I can't
>>
>> explain this behavior as I am using the example code linked with the correct
>>
>> xenomai libraries. Any help would be highly appreciated.
>
> Do you have support for iddp sockets enabled in kernel configuration? If
> yes, do you have the same issue with xenomai 2.6.0?
>


-- 
Philippe.

