Date: Wed, 27 Oct 2004 14:42:19 -0400 (EDT)
From: Currie Reid <curriereid@domain.hid>
In-Reply-To: <20041027042517.19465.86755.Mailman@domain.hid>
Message-ID: <Pine.LNX.4.44L.0410271428370.21604-100000@domain.hid>
References: <20041027042517.19465.86755.Mailman@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Adeos-main] Re: Adeos-main digest, Vol 1 #39 - 1 msg
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: adeos-main@gna.org

Hello,

It looks like spurious interrupts are ignored during kernel/device
initialization until __adeos_takeover().  Then, any spurious interrupts
that occur are counted in the total.
