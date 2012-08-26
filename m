MIME-Version: 1.0
Date: Sun, 26 Aug 2012 11:22:17 +0430
Message-ID: <CAKKWdtf-pNcoE5oc_OzTN=9DwDve=WtfECZnvUnBUNc23=-kCw@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] x86 disables the interrupts!
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I want to log the interrupts for x86 architecture, is there any
function to enable and unmask all the interrupts? Do i have to call
this function inside any interrupt handler? (or Xenomai unmask the
interrupts (except the one that its handler is being executed) before
executing the handler?)
Because x86 disables all the interrupts before calling the interrupt handler.

