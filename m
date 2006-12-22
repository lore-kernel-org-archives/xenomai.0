Message-ID: <b647ffbd0612220124u459bfd58w7a06e81e8739424b@domain.hid>
Date: Fri, 22 Dec 2006 10:24:00 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <9212697.1166778373331.JavaMail.ngmail@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b647ffbd0612210509r7494454fqc820f83a4b1f8719@domain.hid>
	<25528819.1166701882755.JavaMail.ngmail@domain.hid>
	<13574091.1166708188484.JavaMail.ngmail@domain.hid>
	<1166710393.4960.13.camel@domain.hid>
	<12420573.1166713240349.JavaMail.ngmail@domain.hid>
	<b647ffbd0612210717u4b8f0505m65d01bc2824a144a@domain.hid>
	<8403506.1166715370788.JavaMail.ngmail@domain.hid>
	<b647ffbd0612210743m2b208cb2w6e9054336fd68028@domain.hid>
	<458ACFDA.8070300@domain.hid>
	<9212697.1166778373331.JavaMail.ngmail@domain.hid>
Subject: [Xenomai-help] Re: Re: A fairly small rtnet/Xenomai...
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
Cc: Xenomai help <xenomai@xenomai.org>

> One additional question comes in my mind:
> As I learned from all that things that are related to the issue, it seems to be fairly
> critical to fork out of a real time task or to create new processes out of it.
> My question is now:
> Is it possible to force a real time task back to standard linux task behaviour,
> in this state the critical calls can be made. After it a move back to the origin
> real time state would be nice.

A switch is done automatically when you make a call to any
secondary-domain sys call, and the vice-versa. Nevertheless,
rt_task_set_mode() does it excplicitly. Look for the T_PRIMARY flag.

But, well, it's not something that might help you in this particular
case (I mean a problem with fork() :)

So far, I would suggest to use a separate (preliminary) forked context
(and make some communication channel to it from your application) to
send arp requests in your scenario (or anything else that requires
fork()).


-- 
Best regards,
Dmitry Adamushko

