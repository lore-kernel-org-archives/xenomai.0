MIME-Version: 1.0
Date: Wed, 22 Aug 2012 08:58:34 +0430
Message-ID: <CAKKWdtei-4S1A_AyhAifj+HxuGcVCuNRsDUeytX=21=bB9UwbQ@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Can we have nested interrupt handling in Xenomai?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Can we have nested interrupt handling in Xenomai? Suppose we are in
the middle of an interrupt handler and a new interrupt comes in, CPU
will start executing the handler of the new interrupt completely? or
that interrupt is logged only for that domain to be serviced later?

As far as I understood, when an interrupt comes, that interrupt is
disabled and the domain pipeline is stalled and then the interrupt
handler is called.
When the interrupt handler returns, the domain pipeline is unstalled.
Is that correct?

