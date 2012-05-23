Message-ID: <4FBD1245.1040108@xenomai.org>
Date: Wed, 23 May 2012 18:37:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <623784B6C75D274389918D358E89E8BB0B7FD420@OPTELIAN5.optelian.local>
	<4FBD105E.7070204@xenomai.org>
	<623784B6C75D274389918D358E89E8BB0B7FD43D@OPTELIAN5.optelian.local>
In-Reply-To: <623784B6C75D274389918D358E89E8BB0B7FD43D@OPTELIAN5.optelian.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] MDIO on Freescale MX35.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Chris Stone <chris.stone@optelian.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/23/2012 06:34 PM, Chris Stone wrote:
> With CONFIG_XENOMAI disabled, and CONFIG_IPIPE enabled the timeout
> still happens. With both CONFIG_XENOMAI and CONFIG_IPIPE disabled the
> MDIO timeout goes away. Thus the issue appears to be introduced by
> enabling ipipe.

You can try enabling the I-pipe tracer, and triggering a trace freeze
when the MDIO timeout happen. The trace has to have sufficiently many
points to see the last interrupt corresponding to MDIO (if MDIO is
interrupt based).

-- 
					    Gilles.

