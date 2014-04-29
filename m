Message-ID: <535FD440.7000104@zultron.com>
Date: Tue, 29 Apr 2014 11:33:04 -0500
From: John Morris <john@zultron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] CONFIG_XENO_OPT_NATIVE_INTR=y
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

My Debian kernel packages [1] use Gilles's kernel config snippet [2] for 
Xenomai configuration, where CONFIG_XENO_OPT_NATIVE_INTR is turned off.

Michael Haberler requested [3] that option be turned on to support RT 
parport ISRs [4], presumably since many LinuxCNC and Machinekit users 
attach stepper motor drivers through the parport.

Given the 'one size fits all' approach to these kernel packages, which 
are intended to run on a variety of x86 hardware for a variety of 
applications (not necessarily just Machinekit), is this an appropriate 
option to enable for general use?  Is there a specific reason this is 
turned off in Gilles's configuration?

Thanks-

	John

[1] https://github.com/zultron/kernel-rt-deb
[2] http://www.xenomai.org/pipermail/xenomai/2013-January/027345.html
[3] https://github.com/zultron/kernel-rt-deb/issues/1
[4] http://acadis.org/pages/captain.at/parallel-port-intr-isr

