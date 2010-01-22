Message-ID: <4B59DC16.7010908@domain.hid>
Date: Fri, 22 Jan 2010 18:10:46 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B59D952.30202@domain.hid>
In-Reply-To: <4B59D952.30202@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Domain switch during page fault handling
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>, xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi guys,
> 
> we are currently trying to catch an ugly Linux pipeline state corruption
> on x86-64.
> 
> Conceptual question: If a Xenomai task causes a fault, we enter
> ipipe_trap_notify over the primary domain and leave it over the root
> domain, right? Now, if the root domain happened to be stalled when the
> exception happened, where should it normally be unstalled again,
> *for_that_task*? Our problem is that we generate a code path where this
> does not happen.

In other words, and now it's starting to become a pure ipipe topic:

If we migrated during ipipe_trap_notify, shouldn't we restore the root
domain state afterwards from the state of the previously active domain
on entry of __ipipe_handle_exception? I bet that would fix our case, but
I'm yet unsure about side effects and the intended semantic behind this.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

