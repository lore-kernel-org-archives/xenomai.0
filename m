Message-ID: <458ACFDA.8070300@domain.hid>
Date: Thu, 21 Dec 2006 19:18:02 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <b647ffbd0612210509r7494454fqc820f83a4b1f8719@domain.hid>	
	<2890274.1166696466862.JavaMail.ngmail@domain.hid>	
	<16382545.1166699974895.JavaMail.ngmail@domain.hid>	
	<1166700491.4936.5.camel@domain.hid>	
	<25528819.1166701882755.JavaMail.ngmail@domain.hid>	
	<13574091.1166708188484.JavaMail.ngmail@domain.hid>	
	<1166710393.4960.13.camel@domain.hid>	
	<12420573.1166713240349.JavaMail.ngmail@domain.hid>	
	<b647ffbd0612210717u4b8f0505m65d01bc2824a144a@domain.hid>	
	<8403506.1166715370788.JavaMail.ngmail@domain.hid>
	<b647ffbd0612210743m2b208cb2w6e9054336fd68028@domain.hid>
In-Reply-To: <b647ffbd0612210743m2b208cb2w6e9054336fd68028@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Re: A fairly small rtnet/Xenomai...
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Dmitry Adamushko wrote:
>>when I use fork() instead of vfork() I have the freeze again.
>>I.e. using vfork() it works fine, using fork() freezes the system.
> 
> 
> Gilles: is this not the end point of the fork vs. vfork epopee ? :)

Right. I am currently using linuxthreads pthread implementation, that is
why I had a look at it.

> 
> Anyway, it looks your remarks about fork() make sense. But if it's
> true indeed, a more nicer solution would be required.

The simple solution is to only use fork in non time-critical part of
code (like initializations and cleanup) and to fault the pages after the
fork. It make sense to limit fork use to non time-critical code, I mean,
I would already not recommend to create threads in time-critical code,
creating a process is even worse.

A more complex solution would be to really duplicate the mlocked pages
at fork time.

-- 
                                                 Gilles Chanteperdrix

