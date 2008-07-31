Message-ID: <48918ACA.9090006@domain.hid>
Date: Thu, 31 Jul 2008 11:50:02 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <406CC9939904F143B9D42CEEA3E56E563ABBC9@domain.hid>
In-Reply-To: <406CC9939904F143B9D42CEEA3E56E563ABBC9@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] V2.4.4 on blackfin
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Filip Van Rillaer <Filip.VanRillaer@domain.hid>
Cc: xenomai@xenomai.org

Filip Van Rillaer wrote:
>  
> Hello, 
>  
> << 
> 
> rt_event_wait seems not to work properly if one specifies a timeout :
> the functioncall returns after the specified of time, but it returns 0,
> instead of -ETIMEDOUT. 
> 
>>>
> 
> In the mean time I found the bug : ksrc/skins/native/syscall.c:
> 
> the last line of the function __rt_event_wait should be
> 
> return err;
> 
> instead of
> 
> return 0;
> 

Fixed in the development trunk/, thanks.

PS: please, next time send a patch; it is easier to read and apply, and most
importantly, maintainers usually raise the priority of your mail when they see
one attached/inlined.

TIA,

-- 
Philippe.

