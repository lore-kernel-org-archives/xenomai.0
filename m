Subject: Re: [Xenomai-core] [PATCH] fix native ppd cleanup
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46177761.2000806@domain.hid>
References: <46177761.2000806@domain.hid>
Content-Type: text/plain
Date: Sat, 07 Apr 2007 17:44:26 +0200
Message-Id: <1175960666.21062.4.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Sat, 2007-04-07 at 12:50 +0200, Jan Kiszka wrote:
> Not beautiful, but required.
> 

Thanks. r2363 uses a slightly different approach in order to reduce the
#ifdef noise in the same move.

> For a bean-counting approach, we could also make xeno_resource_holder elements conditional.
> 

-- 
Philippe.



