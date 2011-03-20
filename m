Message-ID: <4D860512.4040404@domain.hid>
Date: Sun, 20 Mar 2011 14:45:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTim6tgodUUDYw-zpyadLCj_f=PKKd_CShKTkMuUc@domain.hid>
In-Reply-To: <AANLkTim6tgodUUDYw-zpyadLCj_f=PKKd_CShKTkMuUc@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai System Call
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Warner <xenomai.start@domain.hid>
Cc: xenomai@xenomai.org

Peter Warner wrote:
> Hi All,
> 
> My System Detail:
> Operating System: Ubuntu 10.04
> Xenomai: 2.5.5.2
> 
> I Just want to implement some system calls for xenomai. Can you Please
> Suggest me How It can be done.

What you want may be creating a new skin, or adding a syscall to an
existing skin. Either way, it is relatively simple, you just have to
look at the way an existing skin is done.

For instance, for the native skin service rt_task_create, the service is
implemented in src/skins/native/task.c,  emits a syscall using the
syscall number __native_task_create defined in include/native/task.h,
and the syscall is caught in kernel-space in
ksrc/skins/native/syscall.c, where its implementation uses the
kernel-space service rt_task_create defined in ksrc/skins/native/task.c.
This last step is not mandatory if you do not intend your new service to
be also available to kernel modules.

-- 
                                                                Gilles.

