Date: Tue, 29 Jun 2004 13:48:53 +0300 (EEST)
From: "Rus V. Brushkoff" <rus@domain.hid>
Subject: Re: [Adeos-main] Re: Problem with FIFO's (maybe with RTAI/Adeos) at
 2.6.x branch
In-Reply-To: <1088442437.1094.41.camel@domain.hid>
Message-ID: <Pine.LNX.4.53.0406291346290.767@domain.hid>
References: <Pine.LNX.4.53.0406151339110.1831@domain.hid>
 <1088442437.1094.41.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org

On Mon, 28 Jun 2004, Philippe Gerum wrote:

:Found the gremlin. As suspected, this was due to the on-demand VM

 Tested ok - working like a sharm ;) By the way I tested with
CONFIG_MODVERSIONS turned on (rem'ed in configure from vesuvio cvs) - no
problems.

:

		Rus

