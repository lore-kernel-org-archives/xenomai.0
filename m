From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4DAD392D.7030501@domain.hid>
References: <4D9F0679.7080109@domain.hid>	<1302268379.2101.35.camel@domain.hid>
	<4DA30C80.3010107@domain.hid>	<1302531493.2054.355.camel@domain.hid>
	<4DA30E14.6070401@domain.hid>	<1302532049.2054.357.camel@domain.hid>
	<4DA31108.9080000@domain.hid>
	<1302532753.2054	<4DA314F1.3070504@domain.hid>
	<4DA31EB6.4040909@domain.hid> <4DA4544F.7020300@domain.hid>
	<4DA45660.4000003@domain.hid> <4DA45D0F.4090501@domain.hid>
	<4DA45E42.5030500@domain.hid> <4DA45FD7.9000802@domain.hid>
	<4DAD392D.7030501@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 19 Apr 2011 09:39:05 +0200
Message-ID: <1303198745.2096.8.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] kernel threads crash
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jesper Christensen <jbc@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2011-04-19 at 09:26 +0200, Jesper Christensen wrote:
> If i run switchtest i get the following output:
> 


If still talking about the cpci6200, this patch should apply:
http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=3d6fa118ef282c60dfeb0e690a579e8357bb7d13

> [root@domain.hid /bin]# switchtest
> == Testing FPU check routines...
> r0: 1 != 2
> r1: 1 != 2
> r2: 1 != 2
> r3: 1 != 2
> r4: 1 != 2
> r5: 1 != 2
> r6: 1 != 2
> r7: 1 != 2
> r8: 1 != 2
> r9: 1 != 2
> r10: 1 != 2
> r11: 1 != 2
> r12: 1 != 2
> r13: 1 != 2
> r14: 1 != 2
> r15: 1 != 2
> r16: 1 != 2
> r17: 1 != 2
> r18: 1 != 2
> r19: 1 != 2
> r20: 1 != 2
> r21: 1 != 2
> r22: 1 != 2
> r23: 1 != 2
> r24: 1 != 2
> r25: 1 != 2
> r26: 1 != 2
> r27: 1 != 2
> r28: 1 != 2
> r29: 1 != 2
> r30: 1 != 2
> r31: 1 != 2
> == FPU check routines: OK.
> == Threads: sleeper_ufps0-0 rtk0-1 rtk0-2 rtk_fp0-3 rtk_fp0-4
> rtk_fp_ufpp0-5 rtk_fp_ufpp0-6 rtup0-7 rtup0-8 rtup_ufpp0-9 rtup_ufpp0-10
> rtus0-11 rtus0-12 rtus_ufps0-13 rtus_ufps0-14 rtuo0-15 rtuo0-16
> rtuo_ufpp0-17 rtuo_ufpp0-18 rtuo_ufps0-19 rtuo_ufps0-20
> rtuo_ufpp_ufps0-21 rtuo_ufpp_ufps0-22
> 
> 
> 
> And then it halts. dmesg shows:
> 
> Xenomai: suspending kernel thread ae819678 ('rtk5/0') at nip=0x80319aa0,
> lr=0x80319a70, r1=0xafa90510 after exception #1792
> 
> 
> switchtest -n runs normally, should i use some sort of soft float flag
> in my compilations?
> 
> /Jesper
> 
> 
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core

-- 
Philippe.



