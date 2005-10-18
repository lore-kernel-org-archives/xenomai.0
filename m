From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17237.17732.539752.179481@domain.hid>
Date: Tue, 18 Oct 2005 20:56:04 +0200
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

Did you delete your source tree too ? I renamed Kbuild files into
Makefiles this morning, I can not figure how this could break
compilation though.

-- 


					    Gilles Chanteperdrix.

