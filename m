Subject: Re: [Xenomai-core] sizeof problem in pSOS skin
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200609181328.45621.thomas.necker@domain.hid>
References: <200609181328.45621.thomas.necker@domain.hid>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 14:54:01 +0200
Message-Id: <1158584042.5009.0.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Thomas Necker <thomas.necker@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2006-09-18 at 13:28 +0200, Thomas Necker wrote:
> I encountered a problem with the use of "sizeof" in the pSOS skin.
> E.g., in q_send the last parameter is "u_long msgbuf[4]" and its size is 
> passed to q_send_internal as "sizeof(msgbuf)". However, since arrays are 
> always passed by reference this sizeof call yields 4 instead of the expected 
> 16. This results in only 4 bytes being sent instead of the whole message. The 
> call must be changed, e.g., to "sizeof(u_long[4])".
> The same problem exists for the following calls: q_receive, q_broadcast, 
> q_urgent.
> 

Fixed, thanks.

> Thomas
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



