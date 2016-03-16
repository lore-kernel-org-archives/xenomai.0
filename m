Message-ID: <1458099705.9868.11.camel@henry-ThinkCentre-M93p>
From: Henry Bausley <hbausley@deltatau.com>
Date: Tue, 15 Mar 2016 20:41:45 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] ARM LS1021A SMP Floating point Interrupt Service Routine
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

How does one properly permit floating point operations in an ISR in a
kernel driver running on an ARM CPU.  Our ISR is on cpu 0 and I thought
that the code below would work.  However sometimes the userspace
application using the floating point unit will get a segmentation fault.
The kernel driver running floating point does not have a problem.  I am
sure I am missing something here since I can use floating point in
xenomai kernel threads without a problem.

int FloatingPointISR()
{
  rthal_vfp_save((union vfp_state*)x, rthal_enable_fpu());

   // A bunch of floating point stuff

  rthal_vfp_load((union vfp_state*)x, 0);
}




Outbound scan for Spam or Virus by Barracuda at Delta Tau


