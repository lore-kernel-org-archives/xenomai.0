MIME-Version: 1.0
Date: Sat, 11 Apr 2009 21:35:07 +0200
Message-ID: <d6c8ef150904111235wd68b6abmbb5c37c7d9045aff@domain.hid>
From: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Latest Adeos patch for x86 problem
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>

Hi all,

I noticed it is not possible to compile 2.6.29.1 kernel with latest
adeos patch for x86
(http://download.gna.org/adeos/patches/v2.6/x86/adeos-ipipe-2.6.29.1-x86-2.3-00.patch).
It fails when compiling kernel/xenomai/nucleus/shadow.c. Problem is
that 'cap_effective' doesn't exist anymore in task_struct. There is
whole new thing with cred_struct that replaced cap_* members.
Unfortunately I don't have the output to paste here, but the problem
is quite easy to reproduce :)

Sincerely,
Bosko

