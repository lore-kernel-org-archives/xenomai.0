Message-ID: <49B14276.20100@domain.hid>
Date: Fri, 06 Mar 2009 16:34:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <27822339.1236353250536.JavaMail.ngmail@domain.hid>
In-Reply-To: <27822339.1236353250536.JavaMail.ngmail@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai and OpenMP
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

M. Koehrer wrote:
> Hi everybody,
> 
> is it possible to use OpenMP with Xenomai Realtime threads? I have a
> Intel QuadCore CPU running. Currently I use the native skin to create
> multiple threads to run on multiple CPU cores. That works perfectly. 
> However for some computations, a more local parallel computation
> could be great. And OpenMP provides exactly the right thing here. My
> question is now: Is it possible to use OpenMP with Xenomai real time
> tasks? How can I define the worker threads of OpenMP to be real time
> threads? What about the priority of these threads?

I do not know what OpenMP is, but if it uses the posix API, the first
step to make it work with Xenomai is to try and compile it with xenomai
posix skin. Then, all threads created by this openmp compiled for
xenomai posix skin will be real-time threads, and the priority of these
threads will be the one chosen by the pthread_att_setschedparam or
pthread_setschedparam services.

-- 
                                                 Gilles.

