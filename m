References: <08AAAB36BFF54B11B600000E17F0C13F@itd206>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <caefde48-495b-d2d6-c3d4-f036cda25e1e@xenomai.org>
Date: Sun, 11 Sep 2016 13:20:52 +0200
MIME-Version: 1.0
In-Reply-To: <08AAAB36BFF54B11B600000E17F0C13F@itd206>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Reg:Linux 3.10.32 xenomai UART problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sureshvs <sureshvs@datapatterns.co.in>, xenomai@xenomai.org
Cc: sureshvsmca@gmail.com

On 09/09/2016 03:01 PM, Sureshvs wrote:
> Hi
> 
> ARCH=powerPC
> Processor: MPC8641
> Linux Kernel : 3.10.32
> Xenomai patch version: xenomai-2.6.3
> ipipe : ipipe-core-3.10.32-powerpc-2.patch
> 
> We have ns16550 compatible two UART in our mpc8641 processor and 6 external UART interface.
> 
> We have tested all 8 UARTS in linux without xenomai patch and it is working fine.But with xenomai patched kernel when we test external UARTS system hangs after 10 to 15 minutes of testing.
> 
> kindly help us to sove the problem.

Please consider checking whether this issue also happens with recent
pipeline, kernel and Xenomai releases, at least for the purpose of testing.

> 
> 
> Regards
> Suresh V.S
> 
> **************** CAUTION - Disclaimer *****************This email may contain confidential and privileged material for the
> sole use of the intended recipient(s). Any review, use, retention, distribution or disclosure by others is strictly prohibited. If you are not the intended recipient (or authorized to receive for the recipient), please contact the sender by reply email and delete all copies of this message. Also, email is susceptible to data corruption, interception, tampering, unauthorized amendment and viruses. We only send and receive emails on the basis that we are not liable for any such corruption, interception, tampering, amendment or viruses or any consequence thereof. 
> *********** End of Disclaimer ***********DataPatterns ITS Group**********
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
> 


-- 
Philippe.

