Subject: Re: [Xenomai-help] License question: xenomai is LGPL but GPL in
	headers
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <21504966.1163669346422.JavaMail.ngmail@domain.hid>
References: <21504966.1163669346422.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 12:53:47 +0100
Message-Id: <1163678028.4962.51.camel@domain.hid>
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

On Thu, 2006-11-16 at 10:29 +0100, M. Koehrer wrote:
> Hi everybody,
> 
> I have a copyright question concerning Xenomai:
> As far as I understand it, Xenomai in user space is licensed under the LGPL
> which means that I may link any commercial application against it.
> My question is now: 
> Even in a user space application I have to include some xenomai headers
> like <native/task.h>
> When I look into native/task.h I see there the GPL copyright statement and not
> the LGLP.
> My question is now:
> When I include the Xenomai headers in a user space application, does my
> user space application fall automatically under the GPL or is it still possible
> to build a commercial application?

In general, the issue of whether including headers makes a code a
derived work or not of the said headers is even a question on its own,
regardless of the Xenomai context.
It could be considered as normal interface use, in which case this is no
derived work, or not, depending on the contents of such headers. Because
the situation is unclear and will very likely always remain so, I made
my best to express the intent clearly regarding this aspect for some
interface files shipped by the Xenomai project, and this can be read
from include/COPYING.

It basically says that, including the unmodified GPLed interface headers
used in building the Xenomai system which normally runs in kernel space,
for the purpose of calling the user-space services it exports, is
considered as normal use, and not as a derived work, by the author. You
will notice that when included from user-space, those headers do not
read any Linux kernel headers, so we are not making decision for others.
This is about _our_ code, and only ours.

The other option would have been to duplicate the definitions in
separate header files for kernel and user-space uses, which would have
led to a maintenance nightmare.

IOW, what's important is the intent: Xenomai strictly abides by the
Linux kernel license when it comes to using the code we provide from
kernel space. If any question arises about how to interpret the Linux
kernel licensing clauses for applications embodied in kernel modules,
just ask the LKML for explanations, not us.
When used from user-space, the services Xenomai libraries provide are
licensed under the LGPL terms, and the notice given in include/COPYING
is there to define under which condition the author(s) consider(s) using
the interface headers to call them as being normal use.

> 
> I am not a lawyer, however sometime I think each software developer should be a lawyer..
> 

Uh, no. Unfortunately enough, each software developer should _ask_ a
lawyer when it comes to licensing terms. Probably because the latter are
the only ones to really understand the gibberish they wrote with such
license in the first place, and accurately evaluate the risk the
unspoken "details" within the license bring to the picture...

> 
> Thanks for any answers on that!
> 
> Regards
> 
> Mathias
> 
> 
-- 
Philippe.



