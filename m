Subject: Re: [Adeos-main] Re: RTOS over Adeos document
From: Jacob Gorm Hansen <jg@domain.hid>
In-Reply-To: <3DC6BEE3.3AD48CCE@opersys.com>
References: <20021104100720.78382.qmail@domain.hid>
	<3DC69037.5A9A1577@domain.hid> <20021104154142.GA2608@domain.hid>
	<3DC6A8E8.AFE2D5DC@opersys.com> <20021104172711.GA2989@domain.hid> 
	<3DC6BEE3.3AD48CCE@opersys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 06 Nov 2002 11:45:22 +0100
Message-Id: <1036579522.718.2.camel@domain.hid>
Mime-Version: 1.0
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
To: karim@domain.hid
Cc: adeos list <adeos-main@gna.org>

On Mon, 2002-11-04 at 19:39, Karim Yaghmour wrote:
> 
> Jacob Gorm Hansen wrote:
> > If Adeos gets spaces like Space, then it would be interesting.
> > Otherwise I don't think it is possible, because we need to protect guest
> > OSes against eachother.
> 
> You don't need to do that if each OS is stable and doesn't behave
> randomly, which we assume is a fine description of Linux. As long
> as the PCI probe is modified to only reveal the devices the OS
> instance is supposed to see, then all other hardware should be
> out of reach.

I agree for the purposes of running a disco-like setup on a large MP
machine.

Our purpose with nomadbios is to make operating systems a kind of mobile
agents, so they cannot be trusted and we need MMU protection. If Grids
are to over happen then I think something like this is needed.

Best,
Jacob



