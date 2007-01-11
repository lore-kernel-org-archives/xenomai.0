Message-ID: <45A65984.3070402@domain.hid>
Date: Thu, 11 Jan 2007 16:36:36 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Unwanted mode switch.
References: <45A656C6.6060406@domain.hid>
In-Reply-To: <45A656C6.6060406@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Hi,
> 
> in order to test the nocow patch, I wrote the attached test. Despite the
> fact that there is no longer any page fault (I have nucleus debugging
> on, so I would get a message if there was a fault), there is still an
> unwanted mode switch at step 5. Any idea what could be the cause ?

I added a show_stack(NULL, NULL) in xnshadow_relax, and I get the
following stack trace:
xnshadow_relax
hisyscall_event
xnshadow_sys_migrate
losyscall_event

-- 
                                                 Gilles Chanteperdrix

