Message-ID: <42C55303.6090203@domain.hid>
Date: Fri, 01 Jul 2005 16:28:19 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <42C42FD4.9050307@domain.hid>
In-Reply-To: <42C42FD4.9050307@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Re: ANNOUNCE: Adeos and Fusion PPC64 port updated
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Heikki Lindholm <holindho@domain.hid>
Cc: rtai-dev@domain.hid, rtai@domain.hid, adeos-main@gna.org

Heikki Lindholm wrote:
> Hello list,
> 
> We've updated the adeos+fusion ppc64 ports. Updated versions available at
> 
> http://www.cs.helsinki.fi/group/nonsto/rtaippc64.html
> 

Just reviewed it, and looks really good. It's on the merge list for 0.9.
Thanks a lot.

> It's starting to get usable. Changes as follows,
> Adeos (r2c1):
> * timer support added
> * fixed syscall bug
> * integrated changes from 2.6.10-ppc-r7 patch
> * disabled threaded domains for now
> Fusion (r2):
> * bumped to 0.8.1 fusion
> * fixed kernel thread switching
> 
> p.s. regardless of the (unfortunate) r6c1 versioning of the former 
> version, it's older
> 
> -- Heikki Lindholm
> 
> 
> 
> _______________________________________________
> Rtai-dev mailing list
> Rtai-dev@domain.hid
> https://mail.gna.org/listinfo/rtai-dev


-- 

Philippe.

