Date: Thu, 20 Jun 2002 14:17:03 +0200
From: Jacob Gorm Hansen <jg@domain.hid>
Subject: Re: [Adeos-main] Address spaces in adeos
Message-ID: <20020620121703.GA2544@domain.hid>
References: <3D0F0BA2.969434A3@domain.hid> <20020619051755.75505.qmail@domain.hid> <15632.30733.393799.700979@domain.hid> <20020619130256.GA1529@domain.hid> <3D112024.E4B7C59D@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <3D112024.E4B7C59D@opersys.com>
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
To: Karim Yaghmour <karim@domain.hid>
Cc: Jacob Gorm Hansen <jg@domain.hid>, adeos-main@gna.org

On Thu, Jun 20, 2002 at 12:21:56AM +0000, Karim Yaghmour wrote:
> 
> There are 2 main "problems" in all these such scenarios:
> 1- There is no protection for physical accesses since all OSes have
> can directly play with the hardware.
> 2- Page faults must be sent to the faulty domain only.
> 
> #2 is not really that hard to solve. We need to implement a page fault
> demux which sends the page fault to the current domain only.
> 
> There is, unfortunately, no real way to get around #1 without adding
> extra virtualization layers. Since we are assuming stable kernels
> with "intelligent" code, however, then it should not be a problem.

We are currently trying to make L4Linux (linux2.2 running on the L4
micro kernel) boot several in L4Linux instances.

The good thing about L4 is that it gives us address space protection and
IPC, but sometimes the 'every linux tasks is an l4 task' way of doing 
things seems a bit much.

We want to be able to migrate entire OSes between machines, and thus we
cannot trust the OSes to be friendly or correct.

If we had the time, it seems that implementing protection in adeos would
be interesting and easier to work with than L4 (which is a very nice 
u-kernel btw).

/Jacob

