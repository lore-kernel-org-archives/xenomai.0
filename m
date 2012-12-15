Message-ID: <50CC890D.20304@xenomai.org>
Date: Sat, 15 Dec 2012 15:28:29 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAM6X2GKDLrs=Aua1bp83V_H-2TA32ervyUxXGdtkz0VcxA7R2w@mail.gmail.com>
In-Reply-To: <CAM6X2GKDLrs=Aua1bp83V_H-2TA32ervyUxXGdtkz0VcxA7R2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Unable to start Xenomai-2.6.1 on Ubuntu kernel 3.2.21
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: karan shah <itskaranshah@gmail.com>
Cc: xenomai@xenomai.org

On 12/04/2012 05:14 PM, karan shah wrote:

> Respected Sir,
> 
> I am trying to install Xenomai-2.6.1 on Ubuntu with a kernel version
> 3.2.21,but when a reboot  my system after compiling and building the
> kernel, system give the error as follows
> 
> Nov 30 07:04:47 karan-Pc kernel: [    3.753371] I-pipe: could not find
> timer for cpu #1
> Nov 30 07:04:47 karan-Pc kernel: [    3.753375] Xenomai: system init
> failed, code -19.
> Nov 30 07:04:47 karan-Pc kernel: [    3.753383] Xenomai: native skin init
> failed, code -19.
> Nov 30 07:04:47 karan-Pc kernel: [    3.753387] Xenomai: starting POSIX
> services.
> Nov 30 07:04:47 karan-Pc kernel: [    3.753390] Xenomai: POSIX skin init
> failed, code -19.
> Nov 30 07:04:47 karan-Pc kernel: [    3.753394] Xenomai: RTDM skin init
> failed, code -19.
> 
> I want through the Troubleshooting document but that doesn't work.


You probably missed that part of the troubleshooting guide:
http://www.xenomai.org/documentation/xenomai-2.6/html/TROUBLESHOOTING/#kconf


-- 
                                                                Gilles.

