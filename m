Message-ID: <3DC6BEE3.3AD48CCE@opersys.com>
Date: Mon, 04 Nov 2002 13:39:31 -0500
From: Karim Yaghmour <karim@domain.hid>
Reply-To: karim@domain.hid
MIME-Version: 1.0
Subject: Re: [Adeos-main] Re: RTOS over Adeos document
References: <20021104100720.78382.qmail@domain.hid> <3DC69037.5A9A1577@domain.hid> <20021104154142.GA2608@domain.hid> <3DC6A8E8.AFE2D5DC@opersys.com> <20021104172711.GA2989@domain.hid>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
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
To: Jacob Gorm Hansen <jg@domain.hid>
Cc: adeos-main@gna.org

Jacob Gorm Hansen wrote:
> If Adeos gets spaces like Space, then it would be interesting.
> Otherwise I don't think it is possible, because we need to protect guest
> OSes against eachother.

You don't need to do that if each OS is stable and doesn't behave
randomly, which we assume is a fine description of Linux. As long
as the PCI probe is modified to only reveal the devices the OS
instance is supposed to see, then all other hardware should be
out of reach.

BTW, I've went through the L4Linux source code briefly and it was
interesting to see how they take care of cli/sti. They too redefine
those functions :) However, they use L4's IPC mechanisms to
implement cli/sti, which is kind of interesting.

Karim

===================================================
                 Karim Yaghmour
               karim@domain.hid
      Embedded and Real-Time Linux Expert
===================================================


