From: Thierry Bultel <thierry.bultel@basystemes.fr>
Message-ID: <571F77FE.2040100@basystemes.fr>
Date: Tue, 26 Apr 2016 16:15:26 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] crash in __pthread_mutex_check_init
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, Jean-Baptiste Tredez <jean-baptiste.tredez@basystemes.fr>

Hi,

I am currently still porting ipipe to kernel 4.5, and after having 
solved some issues
(for instance, I found out that the DTB are no longer compatible, 
between 3.18.12 and 4.5
and without recompiling the device tree, the hardware address of the 
timer is wrong, preventing the tsc to work,
and making the kernel lockup on whatever sleep call )

... I wanted to pass the regression tests and I am now facing this one:
The posix "leaks" test leads to a kernel crash

Apparently, the shadow mutex address returned by _xn_safe_copy_from_user 
is wrong, and the crash occurs when
accessing umx->shadow_mutex.magic

I can consider that the problem I have is obviously in my ipipe work, 
because the same xenomai version works fine
with 3.18.12 ...
But I do not see any relation for now.

I have some questions, please:
1) What is the meaning of CONFIG_XENO_FASTSYNCH ? I see that the 
_pthread_mutex_check_init syscall only exists
when CONFIG_XENO_FASTSYNC is defined (which is the case, here)

2) I have a number of regression tests that pass, proving that the 
syscall interface is not so completely broken,
where should I pay more attention in the ipipe side, in my case ?

Thanks
Thierry
