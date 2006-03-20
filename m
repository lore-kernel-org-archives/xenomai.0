Message-ID: <441EE46E.3080604@domain.hid>
Date: Mon, 20 Mar 2006 18:20:46 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] yet another test tool
References: <441DD89A.4000501@domain.hid>
	<17438.51347.702261.525919@domain.hid>
In-Reply-To: <17438.51347.702261.525919@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > (...)As Xenomai does not support hard-RT signal delivery yet (...)
> 
> This is the next feature missing to the POSIX skin. I would like to
> implement this, but I am not sure which way to go :
> - either, if it is possible, getting Linux signals services to run in
>   every domain at Adeos level, by replacing spinlocks with spinlocks_hw
>   and such kind of tricks;

Would be a nightmare, I think. Way too many paths are involved in the 
vanilla kernel, and this would be overkill wrt what we want to do. 
Actually, what we need is basically exposing the nucleus signal 
interface to user-space, and map Linux RT signals over nucleus signals. 
Other (non-RT) Linux signals would keep on being handled in secondary 
mode the way they are now.

> - or adding a generic service at the adeos layer (a hook called when
>   returning to user-space), building a generic user-space signals
>   service at the nucleus level, and finally building all posix signals
>   services on top of this.

A (maybe easier) third option would be to generalize some kind of 
pseudo-asynchronous call support, with a worker thread operating on a 
dedicated priority level inside applications registering for 
asynchronous notifications. The kernel-side would handle the server 
wakeups, providing a unified interface for pending on hooks, signals, 
watchdogs etc. It would also need to properly multiplex those events 
notified from within the skins, and wake up the right pending server in 
user-space, which would in turn fire the user provided handler, all in 
primary mode. In any case, this would not be more costly latency-wise 
than implementing mere callouts, since most of the switching cost comes 
from the MMU switch, which we would have to do in both cases, anyway.

> 
> The first approach guarantees the best integration with Linux, but
> potentially add sections in Linux that are not preemptible by any
> Xenomai skin. With the second approach, all services related to signals
> have to be reimplemented plus some shortcuts to have standard user-space
> tools such as "kill" working.
> 
> 
>  > 
>  > What do you think, is it worth including as a POSIX counterpart for
>  > testsuite/latency?
> 
> There are a few details that I do not like about this tool, but we may
> take it, and fix the details later.
> 
> 


-- 

Philippe.

