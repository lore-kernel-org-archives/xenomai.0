Message-ID: <3D112024.E4B7C59D@opersys.com>
Date: Thu, 20 Jun 2002 00:21:56 +0000
From: Karim Yaghmour <karim@domain.hid>
Reply-To: karim@domain.hid
MIME-Version: 1.0
Subject: Re: [Adeos-main] Address spaces in adeos
References: <3D0F0BA2.969434A3@domain.hid> <20020619051755.75505.qmail@domain.hid> <15632.30733.393799.700979@domain.hid> <20020619130256.GA1529@domain.hid>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: <adeos-main.mail.freesoftware.fsf.org>
List-Unsubscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.freesoftware.fsf.org/pipermail/adeos-main/>
To: Jacob Gorm Hansen <jg@domain.hid>
Cc: adeos-main@gna.org

Hello Jacob,

Jacob Gorm Hansen wrote:
> do you guys have any plans to implement protected address spaces, and means of
> communicating between them (like ipc)? There are some scenarios in which
> operating systems cannot be trusted not to sabotage eachother.

This is one of the scenarios which was discussed in the original
announcement. It is foreseeable, for instance, to have 2 OSes running
in the same RAM, each within its own physical boundaries:
Kernel A: 0-64MB
Kerbel B: 64-128MB

As with other nanokernels, the main mechanism to communicate between
such kernels would be soft interrupts. We could even foresee another
scenario where there's one part of the RAM that is reserved for
setting up shared memory regions between OSes.

There are 2 main "problems" in all these such scenarios:
1- There is no protection for physical accesses since all OSes have
can directly play with the hardware.
2- Page faults must be sent to the faulty domain only.

#2 is not really that hard to solve. We need to implement a page fault
demux which sends the page fault to the current domain only.

There is, unfortunately, no real way to get around #1 without adding
extra virtualization layers. Since we are assuming stable kernels
with "intelligent" code, however, then it should not be a problem.

Karim

===================================================
                 Karim Yaghmour
               karim@domain.hid
      Embedded and Real-Time Linux Expert
===================================================

