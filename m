Message-ID: <4A0040D9.60907@domain.hid>
Date: Tue, 05 May 2009 15:36:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OF90B43322.3740E337-ONC12575AD.00480F2D-C12575AD.0048903F@datacon.at>
In-Reply-To: <OF90B43322.3740E337-ONC12575AD.00480F2D-C12575AD.0048903F@datacon.at>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] gatekeeper/0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: henning.richter@domain.hid
Cc: xenomai@xenomai.org

henning.richter@domain.hid wrote:
> Hi,
> 
> running a xenomai task in which I am sending a single Frame (size ~500
> byte) from my EtherCAT Master to some Beckhoff slaves has latencies around
> 200 us.
> While running that task, top shows that gatekeeper/0 (with RT priority) has
> 30% CPU usage.
> What is the task of this gatekeeper and can this cause my high latencies?

The gatekeeper is used when a taks is migrating from secondary mode to
primary mode. The gatekeeper itself can not cause the high latencies,
but the fact that a task runs in secondary mode can.

To check if this is what happens, check the MSW column in
/proc/xenomai/stat for the thread which has latencies issues. If MSW is
increasing then you have a problem.

To find where your thread switches to secondary mode, use the technique
demonstrated in examples/native/sigxcpu.c.

-- 
                                                 Gilles.

