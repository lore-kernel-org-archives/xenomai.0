From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17888.34603.816719.451150@domain.hid>
Date: Sat, 24 Feb 2007 19:42:51 +0100
Subject: Re: [Xenomai-help] thread in thread
In-Reply-To: <bc4264770702241027g1657b785x837ea9038c772293@domain.hid>
References: <bc4264770702241027g1657b785x837ea9038c772293@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

roland Tollenaar wrote:
 > Hi,
 > 
 > I have a xenomai task running in a Qt application. Its doing its tricks at 1 ms.
 > 
 > I just need brief confirmation of the following:
 > 
 > I have made my own separate thread (QThread) and then started a real
 > time task within that. I strongly get the feeling that a real-time
 > task is a thread of its own (I am not so knowledgeable of threads in
 > plain C ) and I have now ended up starting a thread in a thread?
 > 
 > Is this suspicion correct?

No, with Xenomai, a thread is real-time when it uses real-time services
and non real-time when it uses non real-time services. This is well
explained in the document "Native API tour". Furthermore, you can turn
a Linux thread into a Xenomai thread by running rt_task_shadow if you
have chosen the native API, or pthread_setschedparm if you have chosen
the POSIX API.



 > 
 > I also still need to discover how to stop a xenomai task from my
 > application. At the moment I have to kill the entire process with $
 > kill -9 PID . Any hints would be welcome.

You can terminate a Xenomai thread either by running ordinary Linux
pthread_cancel, or by running rt_task_delete if you prefer the native
API.

-- 


					    Gilles Chanteperdrix.

