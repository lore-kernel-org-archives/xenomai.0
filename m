Date: Mon, 4 Nov 2002 18:27:11 +0100
From: Jacob Gorm Hansen <jg@domain.hid>
Subject: Re: [Adeos-main] Re: RTOS over Adeos document
Message-ID: <20021104172711.GA2989@domain.hid>
References: <20021104100720.78382.qmail@domain.hid> <3DC69037.5A9A1577@domain.hid> <20021104154142.GA2608@domain.hid> <3DC6A8E8.AFE2D5DC@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <3DC6A8E8.AFE2D5DC@opersys.com>
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: <adeos-main.nongnu.org>
List-Unsubscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.nongnu.org/pipermail/adeos-main/>
To: Karim Yaghmour <karim@domain.hid>
Cc: adeos-main@gna.org

On Mon, Nov 04, 2002 at 12:05:44PM -0500, Karim Yaghmour wrote:
> 
> Jacob Gorm Hansen wrote:
> > just wanted to point you all to our project about running multiple
> > linuxes on the same machine, as well as migrating them quickly between
> > machines: http://www.nomadbios.dk
> 
> Quite interesting. It would be even more interesting to see the source.

Yes, we are working on a public CVS repo, should be up in a few minutes.
Check back soon for access details.

> The only thing that dampens my enthusiasm for this is the dependency on
> L4. I don't mean to debate its merits, but you're really dragging some
> else's limitations. Would you be interested to interface with the Adeos
> project for future work?

We had a number of reasons for choosing L4:

- It has recursive address spaces, which we need.
- It has fast IPC.
- It has a working Linux implementation.
- It has OSKit driver and TCP/IP support.

Having to deal with multiple tasks for each Linux was extremely complex
though, and might be a good reason for choosing a nano-kernel next time.

If Adeos gets spaces like Space, then it would be interesting.
Otherwise I don't think it is possible, because we need to protect guest
OSes against eachother. 

> Also, I suppose the migration capability requires that both systems have
> the exact same hardware and the exact same data on disk (or maybe this
> is why you discuss NFS boot on the project's site)?

Exactly ;-)
Currently only networking is abstracted, but this means that it may run
on any hardware, as long as it is supported by oskit.

> Karim

best,
jacob


