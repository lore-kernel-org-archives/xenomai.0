Message-ID: <48A06FBE.50209@domain.hid>
Date: Mon, 11 Aug 2008 18:58:39 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <489FF3A1.2030702@domain.hid>
In-Reply-To: <489FF3A1.2030702@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RT pipe communication between two real-time tasks
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Wolfgang Grandegger wrote:
> Hello,
> 
> I wonder if it's possible to use the RT pipe to exchange messages 
> between two real-time task (in primary mode). The existence of the 
> undocumented function rt_pipe_bind() makes me think so.
>

Nope, this won't work with the current implementation. A message pipe always
connects a real-time endpoint with a regular chardev endpoint.

We could enable this feature in 2.5, but now, we have buffer objects available
as well in the trunk/, which would make this redundant.

> http://www.rts.uni-hannover.de/xenomai/lxr/source/include/native/pipe.h?v=SVN-2.4.x#163
> 
> Wolfgang.
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.

