Message-ID: <49083C20.6060306@domain.hid>
Date: Wed, 29 Oct 2008 11:34:08 +0100
From: "Matteo Facchinetti @ Sirius Electronic Systems S.R.L."
	<matteo.facchinetti@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] rtdm_mmap_to_user() remapping problem on powerpc
	arch.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi all,

I'm using framework RTDM to develop my driver on embedded system mpc5200 
based.
(kernel 2.6.24.4 (powerpc arch) - xenomai 2.4.3).

I've need to use rtdm_mmap_to_user() to share a kmalloc() kernel memory 
in userspace.
For this, I'm using the example in  
http://www.captain.at/xenomai-real-time-driver-example.php.

Running a similar example I've discovered a problem in kmalloc remapping.
The only way that I've found, to make remapping correctly, is to 
allocate an entire kernel mem page with __get_freepage() instead of 
kmalloc().

I think that could be a bug in powerpc arch.
what do you think about?




