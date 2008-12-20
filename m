Message-ID: <494D5CFE.8020406@domain.hid>
Date: Sat, 20 Dec 2008 22:00:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20081219084446.8148.89319.stgit@domain.hid>
	<494D1ED5.2090300@domain.hid> <494D5A00.6070809@domain.hid>
In-Reply-To: <494D5A00.6070809@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH  0/3] NMI watchdog fixes / enhancements
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
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> This is basically a repost of the NNI watchdog series I sent out a few
>>> weeks ago. I just rebased things over latest trunk and fixed some
>>> warnings.
>>>
>>> All patches are also available at
>>> git://git.kiszka.org/xenomai.git nmi-wd-queue
>> That is a lot of stuff to review. I am afraid it is impossible to review
>> everything, so the only thing we can rely on is testing, hence the next
>> question: have these patches been tested in every configuration
>> (enabled, disabled, built-in, module, voluntary overrun)?
> 
> In most configurations, but definitely not in all (they are too many).
> 
> This is a debugging tool, so first of all the disabled case must not
> cause harm, and I'm quite sure I haven't changed anything regarding
> this. Moreover, the enabled case was not working for many recent
> platforms anymore as we were lacking P6 support. So there shouldn't be
> much to loose.

I disagree: the current version compiles in all configurations tested
until now, and happened to work when enabled at some point in the past.
I find it annoying, to say the least, when I want to test something on
trunk, that some previous unrelated commit breaks a configuration
because it was not tested. So, please test your patch. The
configurations to test are not so numerous: disabled, enabled built-in
with an overrun check, enabled in module with an overrun check, repeat
for x86_64. That makes 6 configurations, not that much.

-- 
					    Gilles.

