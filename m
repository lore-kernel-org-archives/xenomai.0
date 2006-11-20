Subject: Re: [Xenomai-help] removing orphaned xenomai registry entries
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <5517606.1164028545775.JavaMail.ngmail@domain.hid>
References: <5517606.1164028545775.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 14:27:52 +0100
Message-Id: <1164029272.5006.95.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2006-11-20 at 14:15 +0100, M. Koehrer wrote:
> Hi everybody,
> 
> especially in the development phase of a project, I have the situation to create some 
> entries like events that end up in the Xenomai's registry.
> However, while developing I exit my application before processing the clean up phase.
> This means, that I have a couple of orphaned events in the registry
> (e.g. in /proc/xenomai/registry/native/events).
> How can I force Xenomai to remove this entries?
> Is there something like a rmxeno  that works like rm or rmmod and removes specified
> elements? (if not: Isn't this an idea for any of the next versions of Xenomai....)
> The only way I found out is to reboot the PC which is not nice as it takes a while.
> Of course, in a final application I should never have this situation, however in the development
> phase this might occur fairly often.
> 
> Thanks for any feedback on this.

Yould could create a small application finding existing nodes
under /proc/xenomai/registry/native, bind to them depending on their
type (e.g. rt_event_bind(&desc, ...)), then call the proper deletion
routine against the bound descriptor (e.g. rt_event_delete(&desc)).

> 
> Regards
> 
> Mathias
> 
-- 
Philippe.



