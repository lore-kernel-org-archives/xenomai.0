Message-ID: <47504706.5050700@domain.hid>
Date: Fri, 30 Nov 2007 18:23:18 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <18252.31008.17258.994903@domain.hid>	
	<BF58A8AFB316514587D61EADBFBF4C410165FD36@domain.hid>	
	<18252.34775.863059.743025@domain.hid>	
	<47503D54.3030005@domain.hid>
	<2ff1a98a0711300903u4908ed6t81009f0684824e90@domain.hid>
In-Reply-To: <2ff1a98a0711300903u4908ed6t81009f0684824e90@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Interrupts lost during sleep / unblock cycles
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> On Nov 30, 2007 5:41 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>> Gilles Chanteperdrix wrote:
>>> Usually, a Xenomai version is compatible with past I-pipe releases. But
>>> you should expect problems using a new I-pipe release with an older
>>> version of Xenomai.
>>>
>> To be more specific about this: we try really, really, really, awfully
>> and painfully hard to keep recent I-pipe patches compatible with
>> (reasonably) older Xenomai releases. No kidding. You may have noticed
>> that the I-pipe API has been quite stable over time for that particular
>> reason, and when we have to break it, there is most often some built-in
>> compat code.
> 
> Then, I really have a problem with the newer ARM I-pipe patches, the
> ones that no longer shut irqs over the mm switch, because they will
> probably compile with a Xenomai 2.2.x, but will not work properly.
>

Well, this is the purpose of "reasonably older" in the sentence. 2.2.x
is already a bit far. 2.3.x is a more reasonable target, particularly
because a shiny new I-pipe patch without all core fixes that went over
time into an entire major Xenomai milestone + maintenance time would not
bring that much. The mm change you mentioned require core surgery in
Xenomai to be compatible, but this was not an API issue.

I'm not sure such kind of changes could ever be detected sanely in older
code, since they don't affect the external interfaces, but require both
the I-pipe and Xenomai cores to agree on interrupt management. This is a
grey area, but not due to API changes.

> The only way I see to work around this is to make the ARM patch depend
> on a CONFIG_ symbol which would be set by the newer Xenomai.
> 

No, we can't do that. We have to admit that sometimes backward compat is
just not possible, unless we start doing really braindamage things. I'm
doing enough silly mistakes unwillingly without wanting to add more of
them deliberately...

-- 
Philippe.

