Message-ID: <4439791B.7060003@domain.hid>
Date: Sun, 09 Apr 2006 23:14:03 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] latency -t 1 crashes on SMP.
References: <17465.8101.106079.634470@domain.hid>
In-Reply-To: <17465.8101.106079.634470@domain.hid>
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
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> I tried latency -t 1 on an SMP machines, and observed a very
> reproducible crash. Most of the time, the machine locks up
> completely. The rest of the time, I get :
> 
> Xenomai: suspending kernel thread e7559044 ('timerbench') at 0xb01051f2 after ex
> ception #14
> 
> And the system remains runnable, but 0xb01051f2 is not a valid kernel
> module text address.

Looks like a kernel-based task stack address on x86.

-- 

Philippe.

