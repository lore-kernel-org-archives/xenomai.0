Message-ID: <OF4655BF29.90082254-ONC12572D5.004B9CB3@domain.hid>
From: "Markus Osterried" <Markus.Osterried@domain.hid>
Date: Tue, 8 May 2007 16:07:29 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Subject: [Xenomai-core] Arguments in psos t_start()
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hello Phillipe,

in __t_start() in /ksrc/skins/psos+/syscall.c the pointer to the
(user-space) tasks argument is directly used for the (kernel-space)
t_start() call.

u_long *argp;
argp = (u_long *)__xn_reg_arg4(regs);
return t_start((u_long)task, mode, startaddr, argp);


I think the arguments must be copied to kernel-space, so isn't it better to
do it this way?

u_long arg[4];
if (!__xn_access_ok
    (curr, VERIFY_READ, __xn_reg_arg4(regs), sizeof(u_long[4])))
      return -EFAULT;
__xn_copy_from_user(curr, arg, (void __user *)__xn_reg_arg4(regs),
                   sizeof(u_long[4]));
return t_start((u_long)task, mode, startaddr, arg);


Thank you.
Markus




