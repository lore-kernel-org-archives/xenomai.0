Message-ID: <trinity-acdda77f-4051-47ce-9404-d613a031eb17-1448033646319@3capp-webde-bap51>
From: JK.Behnke@web.de
Date: Fri, 20 Nov 2015 16:34:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] rtdm_lock_get_irqsave question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

   Hello,

   my understanding of rtdm_lock_get_irqsave is, that it disables all
   interrupts (maybe except NMI).
   If a rtdm driver uses this function to disable interrupts for too long
   and meanwhile some device
   generates more than one interrupt, at least one interrupt might get
   lost.
   Is that true?

   I'm running xenomai on an x86 based target (Atom E660 1.3 GHz) and
   suspect that
   one of our rtdm drivers disables interrupts for an unneccessary long
   time.
   I measured max lock times of up to 290 us, which is quite a long time.
   I know this is not easy to answer, but is there a rule of thumb on how
   long interrupts
   might be disabled before running into problems?

   Regards
   Jochen
