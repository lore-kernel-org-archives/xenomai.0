From: Lowell Gilbert <kludge@be-well.ilk.org>
References: <CAOXDmPrOH2C3voU+p4ZuPfurceVhs2B13bVDY157LUA7+o9NmA@mail.gmail.com>
Date: Tue, 21 Feb 2017 14:00:54 -0500
In-Reply-To: <CAOXDmPrOH2C3voU+p4ZuPfurceVhs2B13bVDY157LUA7+o9NmA@mail.gmail.com>
 (Cong Monkey's message of "Sun, 19 Feb 2017 20:39:05 +0800")
Message-ID: <44zihf2wt5.fsf@lowell-desk.lan>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Xenomai] Is that possible to use xenomai in multi user
	environment without root permission?
Reply-To: xenomai@xenomai.org
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Cong Monkey <congzhangzh@gmail.com>
Cc: xenomai@xenomai.org

Cong Monkey <congzhangzh@gmail.com> writes:

> I have a center server shared by multi user which is assigned sudo
> permission for special cmd when needed.
>
> Is that possible to allow the user to run any self develop rt base
> application(the user will not attack server by this way) without root
> permission?

Not really. Xenomai involves, among other things, making changes to the
kernel. Your user will definitely want to run his real-time application
on a system that isn't being used for anything else. The best way for
him to do that will depend entirely on what his project is.

He can *build* his Xenomai kernel and application without any special
privileges, and might save a lot of time doing so if your server is very
fast. 

