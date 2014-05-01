References: <1398502711.53016.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <535B8B43.1000109@xenomai.org> <535BDB20.7070100@xenomai.org>
Message-ID: <1398944980.54240.YahooMailNeo@web171603.mail.ir2.yahoo.com>
Date: Thu, 1 May 2014 12:49:40 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <535BDB20.7070100@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Issue in notifier_callback while threadobj_lock is
	being held (forge/mercury)
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

----- Original Message -----

> From: Philippe Gerum <rpm@xenomai.org>
> To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xenomai.org" <xeno=
mai@xenomai.org>
> Cc: =

> Sent: Saturday, April 26, 2014 6:13 PM
> Subject: Re: [Xenomai] Issue in notifier_callback while threadobj_lock is=
 being held (forge/mercury)
> =

> On 04/26/2014 12:32 PM, Philippe Gerum wrote:
> =

>>  There is a single sane option: no code running on top of the SIGNOTIFY
>>  handler should attempt to grab any lock. notifier_callback() is simply
>>  wrong in acquiring a lock, only to set the suspend bit in the status.
>>  There is a better option for reflecting the current state locklessly.
>> =

>>  I'll issue a fix.
>> =

> =

> Ok, this time I grabbed the chainsaw to fix this code, dropping all =

> non-sense and left overs from the early days. Feedback welcome.
> =

> http://git.xenomai.org/xenomai-forge.git/commit/?h=3Dnext&id=3D4f3396bf96=
b9fcb750d68e843c60ec9f5d22f9cd
> =

> TIA,
> =

> =

> -- =

> Philippe.
> =


On a first glance the commit seems to work find - I am still verifying.
Simplifying the suspend handling, would sending a SIGNOTIFY signal straight
to the=A0signal handler instead of using pipe read/write operations be an
equivalent, even simpler alternative as demonstrated=A0in the attached patc=
h?

Regards,
Matthias
-------------- next part --------------
A non-text attachment was scrubbed...
Name: simple_signal_suspend.patch
Type: text/x-patch
Size: 4992 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140501/49e56fd=
d/attachment.bin>
