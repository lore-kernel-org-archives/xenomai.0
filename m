Message-ID: <49E0F6FC.9080900@domain.hid>
Date: Sat, 11 Apr 2009 22:01:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <d6c8ef150904111235wd68b6abmbb5c37c7d9045aff@domain.hid>
In-Reply-To: <d6c8ef150904111235wd68b6abmbb5c37c7d9045aff@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Latest Adeos patch for x86 problem
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

Bosko Radivojevic wrote:
> Hi all,
> 
> I noticed it is not possible to compile 2.6.29.1 kernel with latest
> adeos patch for x86
> (http://download.gna.org/adeos/patches/v2.6/x86/adeos-ipipe-2.6.29.1-x86-2.3-00.patch).
> It fails when compiling kernel/xenomai/nucleus/shadow.c. Problem is
> that 'cap_effective' doesn't exist anymore in task_struct. There is
> whole new thing with cred_struct that replaced cap_* members.
> Unfortunately I don't have the output to paste here, but the problem
> is quite easy to reproduce :)

This issue is solved in xenomai current development branches. Of course,
you can not find it in the v2.4.7 release, since 2.6.29 did not exist at
that time.

-- 
					    Gilles.

