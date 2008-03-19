MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18400.53752.538963.384358@domain.hid>
Date: Wed, 19 Mar 2008 09:42:32 +0100
In-Reply-To: <16201.81.252.86.91.1205764989.squirrel@domain.hid>
References: <16201.81.252.86.91.1205764989.squirrel@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Application crash
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fabien MAHOT <fabien.mahot@domain.hid>
Cc: xenomai@xenomai.org

Fabien MAHOT wrote:
 > Hello,
 > 
 > I ve got a problem with my application. I use the Xenomai 2.3.4 kernel
 > (disable priority coupling option -> deactivate).
 > I wrote a test program to show you the problem.
 > 
 > There are T1 thread with the highest priority and T2 thread.
 > T1 thread sleeps during 5ms and uses the console function to display its
 > current state.
 > T2 uses the console function to display its current state.
 > To use the console function, the threads need lockConsole mutex.

Except the fact that your program relies on correct priorities ordering
for starting up tasks, which does not always work if priority coupling is
disabled, your program runs just fine on ARM.

On what platform are you testing this program ? What does 
getconf GNU_LIBPTHREAD_VERSION 
returns on your platform ?
Could you send me the .config of the kernel you are using ?

-- 


					    Gilles.

