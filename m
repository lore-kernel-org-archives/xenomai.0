Message-ID: <4C0E7B60.7000403@domain.hid>
Date: Tue, 08 Jun 2010 19:18:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTimIDghE4o5RpesavooS0cB96ekIgYTXv8rkPRZb@domain.hid>	<4C0E05F6.5030200@domain.hid>
	<AANLkTikxCJ0mDTu2RmSndN-McFJNv1PuWV8j-xywS3NK@mail.gmail.com>
In-Reply-To: <AANLkTikxCJ0mDTu2RmSndN-McFJNv1PuWV8j-xywS3NK@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [RTnet-users] Alignment problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Cyril Wallois <walloiscyril@domain.hid>
Cc: xenomai@xenomai.org

Cyril Wallois wrote:
> Hi Gilles,
> 
> Thanks for your help
> 
>     Still on ARM, right? Do you have the same issue if you use an I-pipe
>     patch for a more recent kernel versions (anything more recent than
>     2.6.28).
> 
>  
> Yes on ARM with PXA270 (toradex colibri), I try to use a newer kernel
> but I have a problem of file system and can't use NFS (ethernet driver
> as module for rtnet).
> On an other embedded system, with kernel 2.6.29, I haven't any problem.
> 
>     Other than that, you do not give us enough information to help solving
>     your issue. What about the last issue you had? What was the value of the
>     r3 register at the time of the alignment fault?
> 
>  
> I don't solve the last issue, I focus on try with newer version of
> kernel and xenomai.
> Probably my problem should be solve with a more recent kernel , I think
> I will try 2.6.29 (and try to solve fs problem).

I do not understand why choosing such an old kernel when starting a new
project. Why not 2.6.33? 2.6.29 is more than one year old.

As for the unaligned access, it looks like a problem in rtnet. So, I
doubt it could be solved by a more recent version of Xenomai. For the
record, I have been using Xenomai and rtnet for a long time on ARM, and
had no issues, so, there is definitely no bug fixed recently in Xenomai
to get rtnet working on ARM, they have been working together for a long
time. But Ok, it will avoid bugs that we already know.

-- 
					    Gilles.

