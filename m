From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <17882.10558.579029.893183@domain.hid>
References: <45D45AEA.50404@domain.hid> <1171547803.24117.8.camel@domain.hid>
	<45D46704.9050109@domain.hid> <1171560346.24117.77.camel@domain.hid>
	<17882.10558.579029.893183@domain.hid>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 00:26:15 +0100
Message-Id: <1171927576.18310.40.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Re: I-pipe 1.7 breaks mlockall safety check
Reply-To: rpm@xenomai.org
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

On Mon, 2007-02-19 at 23:48 +0100, Gilles Chanteperdrix wrote:

> Here comes yet another amendment of the nocow patch, which avoid a race
> between pgd_alloc creating a new pgd, and __ipipe_pin_range_globally not
> seeing the new pgd because its task is not yet in the task
> list. Unfortunately, __ipipe_pin_range_globally becomes an architecture
> dependent function, but at least we should have no race. The patch also
> fixes the issue with munlockall not clearing the VM_LOCKED flag.

Ok, I'm queuing this one for 1.7-04, in order to play safe with 1.7-03
for the upcoming 2.3.1 release. Since the race has always been there
anyway, we have some time ahead to shake this fix over 2.4-devel.

-- 
Philippe.



