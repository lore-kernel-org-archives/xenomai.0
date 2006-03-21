MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17440.14775.987528.126782@domain.hid>
Date: Tue, 21 Mar 2006 18:36:55 +0100
Subject: Re: [Xenomai-core] yet another test tool
In-Reply-To: <441F1B05.1090505@domain.hid>
References: <441DD89A.4000501@domain.hid>
	<17438.51347.702261.525919@domain.hid>
	<441EDA08.7050900@domain.hid>
	<17438.65058.166546.339686@domain.hid>
	<441F1B05.1090505@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
 > The current implementation is one thing (we could fix it), the purpose 
 > of the tool is another, and actually, this is the latter which seems 
 > useful to me. By sharing some common tests between native preemption and 
 > real-time sub-systems like Xeno, we would make performance comparisons 
 > more relevant. 

Ok. I added the tool. I also had to add some cruft to configure.in to
get the --wrap flags in src/testsuite/cyclic/Makefile.

Now, running this test seem to have uncovered a bug with the binary heap
based timers that the latency test did not show. I am investigating on
this, but in the mean time, please do not enable the binary heap timers
option.

 > Additionally, I'm convinced that the POSIX skin is an 
 > underutilized goodie albeit it works damn well and obviously favours a 
 > close integration within the Linux environment, simply because there is 
 > a lack of explanation about it. Illustrating how one could leverage it 
 > is always a good thing.

Well, thanks. I believe that if the POSIX skin works well, it is simply
because its testsuite has a good coverage. As for the documentation, you
may have noticed that I am in the process of documenting the POSIX API,
you can follow the progression here :

http://download.gna.org/xenomai/documentation/trunk/html/api/group__posix.html

Please, everybody, feel free to send comments, critics, patches.

I guess you would like something like a POSIX API tour, but in order
to write that, we would need a concrete example, such as, for example,
playing .wav files with a PC speaker.

-- 


					    Gilles Chanteperdrix.

