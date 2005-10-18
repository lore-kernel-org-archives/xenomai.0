Message-ID: <4355626D.6070907@domain.hid>
Date: Tue, 18 Oct 2005 15:00:29 -0600
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] latency_rt: disagrees about version of symbol
	rt_task_wait_period
References: <435543AD.4010807@domain.hid>
	<17237.22199.793983.902217@domain.hid>
In-Reply-To: <17237.22199.793983.902217@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:

>Jim Cromie wrote:
> > 
> > Im having trouble with built/installed xenomai,
> > 
> > soekris:/usr/realtime/2.6.13-ski7-v1# insmod 
> > testsuite/klatency/latency_rt.ko
> > latency_rt: disagrees about version of symbol rt_task_delete
> > latency_rt: Unknown symbol rt_task_delete
> > latency_rt: disagrees about version of symbol rt_task_wait_period
> > latency_rt: Unknown symbol rt_task_wait_period
> > insmod: error inserting 'testsuite/klatency/latency_rt.ko': -1 Unknown 
> > symbol in module
>
>I already saw that, and can not remember where it came from...
>Do you have CONFIG_MODVERSION enabled ?
>
>
>  
>
It is enabled.  Ive not had trouble with this in the past,
though its possible that Ive gotten lucky til now.

heres all the MOD occurrences:
soekris:/usr/realtime/2.6.13-ski7-v1/bin# zgrep MOD /proc/config.gz
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_FB_MACMODES is not set
CONFIG_FB_MODE_HELPERS=y


so I disabled modversion, recompiled kernel, recompiled xenomai.
Problem Gone.  Heisenbugs :-/ ?

Ill try re-enabling it at some point, to see if it just resolves itself.



