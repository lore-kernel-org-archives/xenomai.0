Message-ID: <5073F9F4.5090103@gmail.com>
Date: Tue, 09 Oct 2012 12:18:28 +0200
From: Stefan Roese <stefan.roese@gmail.com>
MIME-Version: 1.0
References: <50729DAB.2080909@gmail.com> <50730FB7.3060604@xenomai.org>
	<5073C8C8.7000606@gmail.com> <5073F2BA.3060009@xenomai.org>
In-Reply-To: <5073F2BA.3060009@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Oops while running "cat /proc/xenomai/stat"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 10/09/2012 11:47 AM, Gilles Chanteperdrix wrote:
> On 10/09/2012 08:48 AM, Stefan Roese wrote:
>> root@generic-powerpc:~# cat /proc/xenomai/stat 
>> [   65.215600] Oops: Kernel access of bad area, sig: 11 [#1]
>> [   65.221118] mpc5200-simple-platform
>> [   65.224671] Modules linked in: rt_fpga(O) rt_mpc52xx_lpbfifo(O)
>> [   65.230718] NIP: c0066914 LR: c009adf0 CTR: c009ada0
>> [   65.235784] REGS: c716bac0 TRAP: 0300   Tainted: G           O  (3.5.3-00253-g4699145-dirty)
>> [   65.244386] MSR: 00001032 <ME,IR,DR,RI>  CR: 24000488  XER: 20000000
>> [   65.250888] DAR: 00000000, DSISR: 22000000
>> [   65.255064] TASK = c705cba0[1400] 'cat' THREAD: c716a000
>> GPR00: 00000000 c716bb70 c705cba0 c7b3060c 00000002 02000006 00000000 00000030 
>> GPR08: c70f0000 c7b30800 00000000 00000000 c009ada0 100a5a74 10017830 10006834 
>> GPR16: 10006770 10006774 100170f4 00010000 c00733d8 c75e4a60 00000000 c03ee068 
>> GPR24: 00000002 00000001 00000002 c03ec460 00000000 00000000 c7a6ccc4 c7a6ccb4 
>> [   65.289337] NIP [c0066914] xnsynch_flush+0x64/0x100
> 
> Could you show us the diassembly of xnsynch_flush in the corresponding
> kernel?

Sure. Here you go: Kernel 3.5.3 with ipipe (core-3.5 branch) from
git.denx.de:

c00668b0 <xnsynch_flush>:
 *
 * Rescheduling: never.
 */

int xnsynch_flush(struct xnsynch *synch, xnflags_t reason)
{
c00668b0:       94 21 ff d0     stwu    r1,-48(r1)
c00668b4:       7c 08 02 a6     mflr    r0
c00668b8:       bf 21 00 14     stmw    r25,20(r1)
c00668bc:       7c 7f 1b 78     mr      r31,r3
c00668c0:       7c 9c 23 78     mr      r28,r4
c00668c4:       90 01 00 34     stw     r0,52(r1)
static inline void hard_local_irq_disable_notrace(void)
{
#ifdef CONFIG_BOOKE
        __asm__ __volatile__("wrteei 0": : :"memory");
#else
        unsigned long msr = mfmsr();
c00668c8:       7c 00 00 a6     mfmsr   r0
        mtmsr(msr & ~MSR_EE);
c00668cc:       54 00 04 5e     rlwinm  r0,r0,0,17,15
c00668d0:       7c 00 01 24     mtmsr   r0
 */
static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
{
        unsigned long mask = BIT_MASK(nr);
        unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
        unsigned long old = *p;
c00668d4:       3f 60 c0 3f     lis     r27,-16321
        return qslot->elems;
}

static inline int emptyq_p(xnqueue_t *qslot)
{
        return qslot->head.next == &qslot->head;
c00668d8:       7c 7e 1b 78     mr      r30,r3
c00668dc:       3b 7b c4 60     addi    r27,r27,-15264
        xnlock_get_irqsave(&nklock, s);

        trace_mark(xn_nucleus, synch_flush, "synch %p reason %lu",
                   synch, reason);

        status = emptypq_p(&synch->pendq) ? XNSYNCH_DONE : XNSYNCH_RESCHED;
c00668e0:       3b 40 00 02     li      r26,2
c00668e4:       83 3b 09 18     lwz     r25,2328(r27)

        *p = old | mask;
c00668e8:       63 20 00 01     ori     r0,r25,1
        return (old & mask) != 0;
c00668ec:       57 39 07 fe     clrlwi  r25,r25,31
{
        unsigned long mask = BIT_MASK(nr);
        unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
        unsigned long old = *p;

        *p = old | mask;
c00668f0:       90 1b 09 18     stw     r0,2328(r27)
c00668f4:       85 3e 00 10     lwzu    r9,16(r30)
c00668f8:       7f 89 f0 00     cmpw    cr7,r9,r30
c00668fc:       41 9e 00 ac     beq-    cr7,c00669a8 <xnsynch_flush+0xf8>

        while ((holder = getpq(&synch->pendq)) != NULL) {
                struct xnthread *sleeper = link2thread(holder, plink);
                xnthread_set_info(sleeper, reason);
                sleeper->wchan = NULL;
c0066900:       3b a0 00 00     li      r29,0
c0066904:       48 00 00 44     b       c0066948 <xnsynch_flush+0x98>
}

static inline xnholder_t *getq(xnqueue_t *qslot)
{
        xnholder_t *holder = getheadq(qslot);
        if (holder)
c0066908:       41 9a 00 54     beq-    cr6,c006695c <xnsynch_flush+0xac>
        head->next = holder;
}

static inline void dth(xnholder_t *holder)
{
        holder->last->next = holder->next;
c006690c:       81 69 00 04     lwz     r11,4(r9)
c0066910:       80 09 00 00     lwz     r0,0(r9)
c0066914:       90 0b 00 00     stw     r0,0(r11)
        holder->next->last = holder->last;
c0066918:       81 69 00 00     lwz     r11,0(r9)
c006691c:       80 09 00 04     lwz     r0,4(r9)
c0066920:       90 0b 00 04     stw     r0,4(r11)
}

static inline void removeq(xnqueue_t *qslot, xnholder_t *holder)
{
        dth(holder);
        --qslot->elems;
c0066924:       81 7f 00 18     lwz     r11,24(r31)
c0066928:       38 0b ff ff     addi    r0,r11,-1
c006692c:       90 1f 00 18     stw     r0,24(r31)
c0066930:       93 a9 00 20     stw     r29,32(r9)

        status = emptypq_p(&synch->pendq) ? XNSYNCH_DONE : XNSYNCH_RESCHED;

        while ((holder = getpq(&synch->pendq)) != NULL) {
                struct xnthread *sleeper = link2thread(holder, plink);
                xnthread_set_info(sleeper, reason);
c0066934:       80 09 ff d0     lwz     r0,-48(r9)
c0066938:       7c 00 e3 78     or      r0,r0,r28
c006693c:       90 09 ff d0     stw     r0,-48(r9)
                sleeper->wchan = NULL;
                xnpod_resume_thread(sleeper, XNPEND);
c0066940:       4b ff b2 39     bl      c0061b78 <xnpod_resume_thread>
c0066944:       81 3f 00 10     lwz     r9,16(r31)
#endif /* XENO_DEBUG(QUEUES) */

static inline xnholder_t *getheadq(xnqueue_t *qslot)
{
        xnholder_t *holder = qslot->head.next;
        return holder == &qslot->head ? NULL : holder;
c0066948:       7f 9e 48 00     cmpw    cr7,r30,r9
}

static inline xnholder_t *getq(xnqueue_t *qslot)
{
        xnholder_t *holder = getheadq(qslot);
        if (holder)
c006694c:       2f 09 00 00     cmpwi   cr6,r9,0
c0066950:       38 69 fe 0c     addi    r3,r9,-500
c0066954:       38 80 00 02     li      r4,2
#endif /* XENO_DEBUG(QUEUES) */

static inline xnholder_t *getheadq(xnqueue_t *qslot)
{
        xnholder_t *holder = qslot->head.next;
        return holder == &qslot->head ? NULL : holder;
c0066958:       40 9e ff b0     bne+    cr7,c0066908 <xnsynch_flush+0x58>
        }

        if (testbits(synch->status, XNSYNCH_CLAIMED)) {
c006695c:       80 1f 00 0c     lwz     r0,12(r31)
c0066960:       70 09 00 10     andi.   r9,r0,16
c0066964:       41 82 00 14     beq-    c0066978 <xnsynch_flush+0xc8>
                xnsynch_clear_boost(synch, synch->owner);
c0066968:       80 9f 00 1c     lwz     r4,28(r31)
c006696c:       7f e3 fb 78     mr      r3,r31
                status = XNSYNCH_RESCHED;
c0066970:       3b 40 00 02     li      r26,2
                sleeper->wchan = NULL;
                xnpod_resume_thread(sleeper, XNPEND);
        }

        if (testbits(synch->status, XNSYNCH_CLAIMED)) {
                xnsynch_clear_boost(synch, synch->owner);
c0066974:       4b ff f7 05     bl      c0066078 <xnsynch_clear_boost>
 * @nr: bit number to test
 * @addr: Address to start counting from
 */
static inline int test_bit(int nr, const volatile unsigned long *addr)
{
        return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
c0066978:       80 1b 09 18     lwz     r0,2328(r27)
c006697c:       54 00 07 fe     clrlwi  r0,r0,31
void __ipipe_restore_head(unsigned long x);

static inline void ipipe_restore_head(unsigned long x)
{
        ipipe_check_irqoff();
        if ((x ^ test_bit(IPIPE_STALL_FLAG, &__ipipe_head_status)) & 1)
c0066980:       7f 80 c8 00     cmpw    cr7,r0,r25
c0066984:       41 be 00 0c     beq+    cr7,c0066990 <xnsynch_flush+0xe0>
                __ipipe_restore_head(x);
c0066988:       7f 23 cb 78     mr      r3,r25
c006698c:       4b ff 64 ad     bl      c005ce38 <__ipipe_restore_head>
        xnlock_put_irqrestore(&nklock, s);

        xnarch_post_graph_if(synch, 0, emptypq_p(&synch->pendq));

        return status;
}
c0066990:       80 01 00 34     lwz     r0,52(r1)
c0066994:       7f 43 d3 78     mr      r3,r26
c0066998:       bb 21 00 14     lmw     r25,20(r1)
c006699c:       38 21 00 30     addi    r1,r1,48
c00669a0:       7c 08 03 a6     mtlr    r0
c00669a4:       4e 80 00 20     blr
        xnlock_get_irqsave(&nklock, s);

        trace_mark(xn_nucleus, synch_flush, "synch %p reason %lu",
                   synch, reason);

        status = emptypq_p(&synch->pendq) ? XNSYNCH_DONE : XNSYNCH_RESCHED;
c00669a8:       3b 40 00 00     li      r26,0
c00669ac:       4b ff ff 54     b       c0066900 <xnsynch_flush+0x50>

c00669b0 <xnsynch_sleep_on>:
 * xnpod_init_thread), or nanoseconds otherwise.
 */

xnflags_t xnsynch_sleep_on(struct xnsynch *synch, xnticks_t timeout,
                           xntmode_t timeout_mode)



