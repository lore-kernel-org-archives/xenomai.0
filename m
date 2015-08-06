Message-ID: <55C3C7F4.1030107@xenomai.org>
Date: Thu, 06 Aug 2015 16:47:48 -0400
From: Jorge Ramirez Ortiz <jro@xenomai.org>
MIME-Version: 1.0
References: <55C17C8E.5000909@gatech.edu> <55C3AEBE.9080603@xenomai.org>
 <55C3C3F8.1090808@gatech.edu>
In-Reply-To: <55C3C3F8.1090808@gatech.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] analogy calibration issue(s)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Yogi A. Patel" <yapatel@gatech.edu>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/06/2015 04:30 PM, Yogi A. Patel wrote:
> When I run
> 
> sudo ./analogy_calibrate --device=analogy0 --output=file
> 
> I see
> 
> [ 1124.191097] analogy_calibra[2822]: segfault at 7 ip 00007f10b88c6a03 sp
> 00007fffaee2bb40 error 4 in libc-2.19.so[7f10b887b000+1bb000]
> 
> on two computers running Xenomai RC5 with Linux 3.18.12 both with NI DAQs
> installed (M-Series).

please send the procs /proc/analogy/*
can you run analogy_calibrate under gdb?

