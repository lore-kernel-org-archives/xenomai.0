From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17237.18512.708882.8589@domain.hid>
Date: Tue, 18 Oct 2005 21:09:04 +0200
Subject: Re: [Xenomai-help] latency_rt: disagrees about version of symbol
	rt_task_wait_period
In-Reply-To: <435543AD.4010807@domain.hid>
References: <435543AD.4010807@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai@xenomai.org

Jim Cromie wrote:
 > 
 > Im having trouble with built/installed xenomai,
 > 
 > soekris:/usr/realtime/2.6.13-ski7-v1# insmod 
 > testsuite/klatency/latency_rt.ko
 > latency_rt: disagrees about version of symbol rt_task_delete
 > latency_rt: Unknown symbol rt_task_delete
 > latency_rt: disagrees about version of symbol rt_task_wait_period
 > latency_rt: Unknown symbol rt_task_wait_period
 > insmod: error inserting 'testsuite/klatency/latency_rt.ko': -1 Unknown 
 > symbol in module
 > 
 > this has been replicated after deleting old tree,
 > and doing a fresh checkout to -r41
 > 
 > modinfo reports same vermagic for above module,
 > and those in modules/xeno*.ko, and Im at a loss wrt how to track this down.

the rt_task* symbols are defined (or supposed to be) into the
xeno_native.ko module, which does not seem to appear in your list.

-- 


					    Gilles Chanteperdrix.

