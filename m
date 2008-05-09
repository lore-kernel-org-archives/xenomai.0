Message-ID: <48242214.6000400@domain.hid>
Date: Fri, 09 May 2008 12:06:12 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4824197E.90709@domain.hid> <48241CF1.8020708@domain.hid>
	<2ff1a98a0805090253y4e9b2ee3od2d5a7430ba7472c@domain.hid>
In-Reply-To: <2ff1a98a0805090253y4e9b2ee3od2d5a7430ba7472c@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] Unfreeze timers when debugged target
	exits
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Xenomai-core@domain.hid

Gilles Chanteperdrix wrote:
> On Fri, May 9, 2008 at 11:44 AM, Philippe Gerum <rpm@xenomai.org> wrote:
>> Jan Kiszka wrote:
>>> I expressed my skepticism about this global timer freeze before :->, and
>> Just try debugging periodic code without it...
>>
>> We should have an opt-out mechanism to hide timers from the auto-freeze feature,
>>  that is the real issue yet to be fixed.
> 
> Here is a patch I use at work.
> 

Please merge this one (v2.4 and trunk). At some point (i.e. asap), we will need
an interface to set the NOLOCK bit on the thread's ptimer. The *_set_mode()
calls are good candidates to support that feature.

-- 
Philippe.

