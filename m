References: <4215540.eSPgLzVGbT@soho>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <fa625591-d30d-6e14-83fc-c5a98de570b0@xenomai.org>
Date: Fri, 30 Sep 2016 16:06:15 +0200
MIME-Version: 1.0
In-Reply-To: <4215540.eSPgLzVGbT@soho>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Regarding Xenomai and RTNET
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>, xenomai <xenomai@xenomai.org>

On 09/30/2016 02:15 PM, Leopold Palomo-Avellaneda wrote:
> Hi,
> 
> 
> I'm fighting with some code to run with Xenomai 3. One of the projects is soem 
> [1]. 
> 
> The original library uses POSIX to open a raw socket to send Ethercat 
> messages. Our fork, uses rtnet and some Xenomai functionalities to accomplish 
> it. It has been working with 2.6.x without any problems. 
> 
> OTOH, also we have done another fork fril  [2] that, using the POSIX 
> compatibility and rtnet use a rt_ethX device to communicate with a robot. We 
> have used it without any problem too with 2.6.x
> 
> Now, we try to migrate all of this code to Xenomai-3 but we are having crashes 
> all the time.
> 
> With fril, a pure POSIX code, using the compatibility mode, we have a crash, 
> showing:
> 
>  BUG: unable to handle kernel paging request at 00007f47ea0ef878
>  IP: [<ffffffffa0231580>] rt_udp_ioctl+0x50/0x74 [rtudp]
>  PGD 458887067 PUD 4590a1067 PMD 45921f067 PTE 8000000438863867
>

[snip]

> If both the program crashes "unable to handle kernel paging request". 
>

The compat mode is not related to this issue, it is merely a source code
wrapping trick at user level, nothing more. If a driver breaks the
kernel, then it's the driver's fault no matter what, regardless of the
input data userland might have sent.

You should check the RTnet stack for this. Btw, assuming your 2.6 setup
relies on the original out-of-tree RTnet, and that your 3.0
configuration relies on the RTnet code integrated in the Xenomai tree,
then you end up comparing two different RTnet implementations.

> Also, I have found that using the --compat parameter in xeno-config, the values 
> obtained (--posix --compat --cflags) makes that the applications doesn't 
> compile:
> 
>  /home/leopold.palomo/fril/fril.git/src/FastResearchInterfaceLibrary/Console.cpp:50:
> /usr/xenomai/include/trank/posix/pthread.h: In function ‘int 
> pthread_set_mode_np(int, int, int*)’:
> /usr/xenomai/include/trank/posix/pthread.h:55:52: error: ‘pthread_setmode_np’ 
> was not declared in this scope
>   return pthread_setmode_np(clrmask, setmask, mask_r);
> 
> I guess that there's a missing includes hidden here.
> 

No, it's rather an issue in the include directory chain when --compat is
enabled. Fixed in xeno-config, in the stable maintenance tree.

> So, any idea to find a solution?
> Do you have some example that works with xenomai-3 and rtnet?
> 

No, but I'm no RTnet expert.

-- 
Philippe.

