Message-ID: <443C11CF.7030905@domain.hid>
Date: Tue, 11 Apr 2006 22:30:07 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] deleting a left over heap (shared memory segment)
References: <067C9A1F6AFEB643895EA4513E116884178FF2@domain.hid>
In-Reply-To: <067C9A1F6AFEB643895EA4513E116884178FF2@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: "Moser, Dan" <DMoser@domain.hid>
Cc: xenomai@xenomai.org

Moser, Dan wrote:
> Hi,
> 
> I was wondering if there was a command line method for deleting left
> over heaps (i.e., those that were not properly deleted with a call to
> rt_heap_delete()) from /proc/xenomai/registry/native/heaps.
> 
> Just a simple rm command (as root) yields the following:
> 
> # rm -f myshmem
> cannot remove `myshmem': Operation not permitted
> 

For the moment, there is way to remove lingering native API objects from 
the /proc interface. On the other hand, the RTDM API allows this for 
some of its objects by writing a magic value to the proper /proc entry, 
and we might use the same technique to provide this feature to the 
native one.

> Thanks in advance for any help/insight,
> Dan
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

