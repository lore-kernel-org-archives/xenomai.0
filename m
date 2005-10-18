Message-ID: <43555033.4010806@domain.hid>
Date: Tue, 18 Oct 2005 13:42:43 -0600
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] latency_rt: disagrees about version of symbol
	rt_task_wait_period
References: <435543AD.4010807@domain.hid>
	<17237.18512.708882.8589@domain.hid>
In-Reply-To: <17237.18512.708882.8589@domain.hid>
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
> > 
> > this has been replicated after deleting old tree,
> > and doing a fresh checkout to -r41
> > 
> > modinfo reports same vermagic for above module,
> > and those in modules/xeno*.ko, and Im at a loss wrt how to track this down.
>
>the rt_task* symbols are defined (or supposed to be) into the
>xeno_native.ko module, which does not seem to appear in your list.
>
>  
>
its there (along with most skins), just excessive trimming..

soekris:/usr/realtime/2.6.13-ski7-v1/modules# ls
xeno_16550A.ko  xeno_nucleus.ko  xeno_rtai.ko    xeno_uvm.ko
xeno_hal.ko     xeno_posix.ko    xeno_rtdm.ko    xeno_vrtx.ko
xeno_native.ko  xeno_psos.ko     xeno_uitron.ko  xeno_vxworks.ko
soekris:/usr/realtime/2.6.13-ski7-v1/modules# modinfo xeno_native.ko
filename:       xeno_native.ko
description:    Native skin
author:         rpm@xenomai.org
license:        GPL
vermagic:       2.6.13-ski7-v1 preempt GEODEGX1 gcc-3.4
depends:        xeno_nucleus,xeno_hal

`nm modules/xeno_native.ko` shows me the symbols exist, (but not their 
'version')

00000270 T rt_task_create
00000900 T rt_task_delete
00001120 T rt_task_inquire

00001020 T rt_task_unblock
00000c30 T rt_task_wait_period
00000a80 T rt_task_yield


