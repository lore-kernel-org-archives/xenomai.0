Message-ID: <3D12014D.55739F1A@opersys.com>
Date: Thu, 20 Jun 2002 12:22:37 -0400
From: Karim Yaghmour <karim@domain.hid>
Reply-To: karim@domain.hid
MIME-Version: 1.0
Subject: Re: [Adeos-main] Address spaces in adeos
References: <3D0F0BA2.969434A3@domain.hid> <20020619051755.75505.qmail@domain.hid> <15632.30733.393799.700979@domain.hid> <20020619130256.GA1529@domain.hid> <3D112024.E4B7C59D@opersys.com> <20020620121703.GA2544@domain.hid>
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

Jacob Gorm Hansen wrote:
> We are currently trying to make L4Linux (linux2.2 running on the L4
> micro kernel) boot several in L4Linux instances.
> 
> The good thing about L4 is that it gives us address space protection and
> IPC, but sometimes the 'every linux tasks is an l4 task' way of doing
> things seems a bit much.
> 
> We want to be able to migrate entire OSes between machines, and thus we
> cannot trust the OSes to be friendly or correct.
> 
> If we had the time, it seems that implementing protection in adeos would
> be interesting and easier to work with than L4 (which is a very nice
> u-kernel btw).

L4 is very interesting indeed. Last I read about it, though, its
licensing was problematic (i.e. couldn't be released "open source"
because of the funding of the project) and it is very hardware dependent
(in order to achieve better performance). Is this still true?

I understand the need to be able to migrate entire OSes between
machines. Because we do not virtualize the physical RAM, this
may a little harder to do with Adeos. But since we assume that
we can modify the OSes to better interact with Adeos, then it
should not be that much harder to implement code that "rewires"
the kernels' mappings. Of course, this would require some work,
and time ... ;)

Cheers,

Karim

===================================================
                 Karim Yaghmour
               karim@domain.hid
      Embedded and Real-Time Linux Expert
===================================================

