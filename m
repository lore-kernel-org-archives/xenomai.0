Message-ID: <47205400.9070804@domain.hid>
Date: Thu, 25 Oct 2007 10:29:52 +0200
From: Philippe Gerum <philippe.gerum@domain.hid>
MIME-Version: 1.0
References: <e4ef24880710241635p102f5f44i3f5e5e88bc0e4b02@domain.hid>		<472043C1.1040506@domain.hid>	<e4ef24880710250033x31c7ba0y8f28ddc6f30d2635@domain.hid>
	<47204948.7050109@domain.hid>
In-Reply-To: <47204948.7050109@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problems building Xenomai 2.4-rc4 and
	linux	2.6.23
Reply-To: philippe.gerum@domain.hid
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
> Robert Gubler wrote:
>> Well, sadly I don't have it with me.  I can post it tomorrow, But,
>> essentially the config is whatever the default is.  I didn't change any
>> options when I ran `make menuconfig`.
> 
> OK, will retry your steps later, maybe it also triggers for me.
> 
>> The other configurations I tried were:
>>
>> linux-2.6.23.1.tar.bz2
>> xenomai-2.4-rc4.tar.bz2
>> adeos-ipipe-2.6.23-i386-1.10-10.patch
>>
>>
>> And,
>>
>> linux-2.6.23.1.tar.bz2
>> xenomai-2.3.4.tar.bz2
>> adeos-ipipe-2.6.23-i386-1.10-10.patch
> 
> This combination will not work "by design" (2.3.x only supports kernels
> up to 2.6.20).
> 

Only Xenomai/x86 currently has this limitation, due to the introduction
of the generic clock events layer. Other supported archs may still use
more recent kernels along with v2.3.x, until this layer makes it into
mainline for them too, that is.

-- 
Philippe.

