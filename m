From: Ralf Moder <ralf.moder@mail.de>
Message-ID: <56377A74.6020803@mail.de>
Date: Mon, 2 Nov 2015 16:00:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] kernel oops in giveup_fpu (file fpu.S)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

i have a powerpc cpu (mpc5200) running linux 3.14.17 with xenomai patch
2.6.4 on it. I use floating point in kernel, so the (assembly-)function
"giveup_fpu" (in file arch/powerpc/kernel/fpu.S) is called and throws a
kernel-oops. fpu.S is patched with ipipe-core-3.14.17-powerpc-6.patch.
In original linux (kernel 3.14.17) "giveup_fpu" looks like this:

_GLOBAL(giveup_fpu)
    mfmsr    r5
    ori    r5,r5,MSR_FP
#ifdef CONFIG_VSX
BEGIN_FTR_SECTION
    oris    r5,r5,MSR_VSX@h
END_FTR_SECTION_IFSET(CPU_FTR_VSX)
#endif
    SYNC_601
    ISYNC_601
    MTMSRD(r5)            /* enable use of fpu now */
    SYNC_601
    isync
    PPC_LCMPI    0,r3,0
    beqlr-                /* if no previous owner, done */
    addi    r3,r3,THREAD            /* want THREAD of task */
    PPC_LL    r6,THREAD_FPSAVEAREA(r3)
    PPC_LL    r5,PT_REGS(r3)
    PPC_LCMPI    0,r6,0
    bne    2f
    addi    r6,r3,THREAD_FPSTATE
2:    PPC_LCMPI    0,r5,0
    SAVE_32FPVSRS(0, R4, R6)
    mffs    fr0
    stfd    fr0,FPSTATE_FPSCR(r6)
    beq    1f
    PPC_LL    r4,_MSR-STACK_FRAME_OVERHEAD(r5)
    li    r3,MSR_FP|MSR_FE0|MSR_FE1
#ifdef CONFIG_VSX
BEGIN_FTR_SECTION
    oris    r3,r3,MSR_VSX@h
END_FTR_SECTION_IFSET(CPU_FTR_VSX)
#endif
    andc    r4,r4,r3        /* disable FP for previous task */
    PPC_STL    r4,_MSR-STACK_FRAME_OVERHEAD(r5)
1:
#ifndef CONFIG_SMP
    li    r5,0
    LOAD_REG_ADDRBASE(r4,last_task_used_math)
    PPC_STL    r5,ADDROFF(last_task_used_math)(r4)
#endif /* CONFIG_SMP */
    blr



After ipipe patch it looks like this:

_GLOBAL(giveup_fpu)
#ifdef CONFIG_IPIPE
    mfmsr    r6
#ifdef CONFIG_PPC64   
    rldicl    r5,r6,48,1        /* clear MSR_EE */
    rotldi    r5,r5,16
#else
    rlwinm    r5,r6,0,17,15        /* clear MSR_EE */
#endif   
#else   
    mfmsr    r5
#endif   
    ori    r5,r5,MSR_FP
#ifdef CONFIG_VSX
BEGIN_FTR_SECTION
    oris    r5,r5,MSR_VSX@h
END_FTR_SECTION_IFSET(CPU_FTR_VSX)
#endif
    SYNC_601
    ISYNC_601
    MTMSRD(r5)            /* enable use of fpu now */
    SYNC_601
    isync
    PPC_LCMPI    0,r3,0
    beq-    2f            /* if no previous owner, done */
    addi    r3,r3,THREAD            /* want THREAD of task */
    PPC_LL    r6,THREAD_FPSAVEAREA(r3)
    PPC_LL    r5,PT_REGS(r3)
    PPC_LCMPI    0,r6,0
    bne    2f
    addi    r6,r3,THREAD_FPSTATE
2:    PPC_LCMPI    0,r5,0
    SAVE_32FPVSRS(0, R4, R6)
    mffs    fr0
    stfd    fr0,FPSTATE_FPSCR(r6)
    beq    1f
    PPC_LL    r4,_MSR-STACK_FRAME_OVERHEAD(r5)
    li    r3,MSR_FP|MSR_FE0|MSR_FE1
#ifdef CONFIG_VSX
BEGIN_FTR_SECTION
    oris    r3,r3,MSR_VSX@h
END_FTR_SECTION_IFSET(CPU_FTR_VSX)
#endif
    andc    r4,r4,r3        /* disable FP for previous task */
    PPC_STL    r4,_MSR-STACK_FRAME_OVERHEAD(r5)
1:
#ifndef CONFIG_SMP
    li    r5,0
    LOAD_REG_ADDRBASE(r4,last_task_used_math)
    PPC_STL    r5,ADDROFF(last_task_used_math)(r4)
#endif /* CONFIG_SMP */
2:
#ifdef CONFIG_IPIPE        /* restore interrupt state */
    andi.    r6,r6,MSR_EE
    beqlr
    mfmsr    r5
    ori    r5,r5,MSR_EE
    SYNC_601
    ISYNC_601
    MTMSRD(r5)
    SYNC_601
    isync
#endif
    blr


Tests have shown, that the reuse of the label "2" is the problem. If i
change "giveup_fpu" in the following way, no problems occurs:

GLOBAL(giveup_fpu)
#ifdef CONFIG_IPIPE
    mfmsr    r6
#ifdef CONFIG_PPC64   
    rldicl    r5,r6,48,1        /* clear MSR_EE */
    rotldi    r5,r5,16
#else
    rlwinm    r5,r6,0,17,15        /* clear MSR_EE */
#endif   
#else   
    mfmsr    r5
#endif   
    ori    r5,r5,MSR_FP
#ifdef CONFIG_VSX
BEGIN_FTR_SECTION
    oris    r5,r5,MSR_VSX@h
END_FTR_SECTION_IFSET(CPU_FTR_VSX)
#endif
    SYNC_601
    ISYNC_601
    MTMSRD(r5)            /* enable use of fpu now */
    SYNC_601
    isync
    PPC_LCMPI    0,r3,0
    beq-    3f            /* if no previous owner, done */
    addi    r3,r3,THREAD            /* want THREAD of task */
    PPC_LL    r6,THREAD_FPSAVEAREA(r3)
    PPC_LL    r5,PT_REGS(r3)
    PPC_LCMPI    0,r6,0
    bne    2f
    addi    r6,r3,THREAD_FPSTATE
2:    PPC_LCMPI    0,r5,0
    SAVE_32FPVSRS(0, R4, R6)
    mffs    fr0
    stfd    fr0,FPSTATE_FPSCR(r6)
    beq    1f
    PPC_LL    r4,_MSR-STACK_FRAME_OVERHEAD(r5)
    li    r3,MSR_FP|MSR_FE0|MSR_FE1
#ifdef CONFIG_VSX
BEGIN_FTR_SECTION
    oris    r3,r3,MSR_VSX@h
END_FTR_SECTION_IFSET(CPU_FTR_VSX)
#endif
    andc    r4,r4,r3        /* disable FP for previous task */
    PPC_STL    r4,_MSR-STACK_FRAME_OVERHEAD(r5)
1:
#ifndef CONFIG_SMP
    li    r5,0
    LOAD_REG_ADDRBASE(r4,last_task_used_math)
    PPC_STL    r5,ADDROFF(last_task_used_math)(r4)
#endif /* CONFIG_SMP */
3:
#ifdef CONFIG_IPIPE        /* restore interrupt state */
    andi.    r6,r6,MSR_EE
    beqlr
    mfmsr    r5
    ori    r5,r5,MSR_EE
    SYNC_601
    ISYNC_601W
    MTMSRD(r5)
    SYNC_601
    isync
#endif
    blr



Is this the right way to solve this problem? If yes, what should i do so
that it comes in the next ipipe patch?

Best regards

Ralf Moder

