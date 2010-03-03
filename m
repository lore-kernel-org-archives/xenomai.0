Message-ID: <4B8E260D.7070809@domain.hid>
Date: Wed, 03 Mar 2010 10:04:13 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B8E24B4.9000806@domain.hid>
In-Reply-To: <4B8E24B4.9000806@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Potential heap corruption on thread cleanup
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>, xenomai-core <xenomai@xenomai.org>, Gernot Hillier <gernot.hillier@domain.hid>

Jan Kiszka wrote:
> Hi Gilles,
> 
> I'm pushing your findings to the list, also as my colleagues showed
> strong interest - this thing may explain rare corruptions for us as well.
> 
> I thought a bit about that likely u_mode-related crash in your test case
> and have the following theory so far: If the xeno_current_mode storage
> is allocated on the application heap (!HAVE_THREAD, that's also what we
> are forced to use), it is automatically freed on thread termination in
> the context of the dying thread. If the thread is already migrated to
> secondary or if that happens while it is cleaned up (i.e. before calling
> for exit into the kernel), there is no problem, Xenomai will not touch
> the mode storage anymore. But if the thread happens to delete the
> storage "silently", without any migration, the final exit will trigger
> one further access. And that takes place against an invalid head area at
> this point.
> 
> Does this make sense?

Yes, it is the issue we observed.

> 
> If that is true, all we need to do is to force a migration before
> releasing the mode storage. Could you check this?

No, that does not fly. Calling, for instance, __wrap_pthread_mutex_lock
in another TSD cleanup function is which could be called after the
current_mode TSD cleanup is allowed and could trigger a switch to
primary mode and a write to the u_mode.

-- 
					    Gilles.

