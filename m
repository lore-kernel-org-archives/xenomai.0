Message-ID: <5114BE02.6040901@sirius-es.it>
Date: Fri, 08 Feb 2013 09:57:38 +0100
From: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Backport Xenomai-26 to Linux 2.6.29.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

We decided to try to backport the 
adeos-ipipe-2.6.36.4-powerpc-2.12-05.patch against the Linux 2.6.29.1 
kernel but we encountered problems with spinlock handling:

In the 2.6.29 kernel, we found some differences about spinlock 
structures hierarchy. In detail at kernel side we have only 
raw_spinlock_t and spinlock_t but xenomai (ipipe_lock.h) uses 
arch_spinlock_t, raw_spinlock_t and spinlock_t.
Those differences will force us to heavily modify the spinlock handling 
in the xenomai patch, deleting a layer and replacing arch_spinlock_t 
with raw_spinlock_t and raw_spinlock_t with spinlock_t.

Is there an old patch file that contains spinlock handling compliant 
with 2.6.29.1 kernel and xenomai 2.6?

Regards,

Matteo Facchinetti
Sirius Electronic Systems

