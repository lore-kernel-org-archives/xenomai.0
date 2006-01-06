Message-ID: <43BE9919.5010305@domain.hid>
Date: Fri, 06 Jan 2006 17:21:45 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Problem with #define uint  "i"
References: <43BE3F92.1000107@domain.hid>
In-Reply-To: <43BE3F92.1000107@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org, RTnet-users <rtnet-users@domain.hid>

Wolfgang Grandegger wrote:
> Hallo,
> 
> when trying to build RTnet with Xenomai and Linux 2.4.25 for PowerPC, I 
> stumbeld over the following problem:
> 
> In "linuxppc_2_4_devel/include/asm-generic/xenomai/wrappers.h" there is 
> defined:
> 
>   #define ulong "i"
>   #define uint  "i"
> 
> This makes trouble when a driver uses the types uint or ulong, which is 
> the case for the MPC RTnet drivers. Can we use different names for the 
> above definitions?
> 

Yes, will fix in Xenomai. Actually, since module_param() has been 
backported in its simplest forms to 2.4, the above hack should be useless.

> Thanks.
> 
> Wolfgang.
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 


-- 

Philippe.

