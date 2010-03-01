Message-ID: <4B8BEA64.7090108@domain.hid>
Date: Mon, 01 Mar 2010 17:25:08 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1Nl4tX-0001N9-Hb@domain.hid>
	<4B881E9D.1050101@domain.hid>	<4B88203F.2020907@domain.hid>
	<4B8903E1.3020805@domain.hid> <4B8B7540.609@domain.hid>
	<4B8B84BC.90300@domain.hid> <4B8B971D.5080807@domain.hid>
	<4B8B98F5.10602@domain.hid> <4B8BA361.1040807@domain.hid>
	<4B8BC277.4010108@domain.hid> <4B8BC62F.6090403@domain.hid>
	<4B8BCC09.8030100@domain.hid> <4B8BCDB5.2010103@domain.hid>
	<4B8BCF48.70603@domain.hid> <4B8BD4D4.2060109@domain.hid>
	<4B8BDE7F.8060908@domain.hid>
In-Reply-To: <4B8BDE7F.8060908@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : RTDM+POSIX: Avoid
 leaking binding objects on errors
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> To be more precise, it looks to me like each call to bind_one is
>>> supposed to set the bit of the corresponding fd, so, if bind_one fails
>>> because the fd is in the transitory state (the one which I do not like),
>>> bind_all should simply set this bit to 1. And there does not seem to be
>>> any need for additional parameters, additional space on stack, or
>>> anything else.
>> Right, the trick is likely to properly maintain the output fds of
>> bind_all in that not only pending fds are set, but others are cleared -
>> avoids the third bitmap. Still playing with such an approach.
> 
> Another precision, xnselect_bind accesses directly the "pending" set of
> the xnselector structure, so, you have the right to do that for the fds
> which failed binding but which you want to mark as pending.

Right, /me was blind, the issue can trivially be fixed inside RTDM by
binding as pending even if the object is marked deleted. I'm now just
cleaning up some other RTDM bits at this chance, pull request will follow.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

