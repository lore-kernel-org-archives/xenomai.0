MIME-Version: 1.0
In-Reply-To: <44mvdeqc08.fsf@be-well.ilk.org>
References: <CAOXDmPrOH2C3voU+p4ZuPfurceVhs2B13bVDY157LUA7+o9NmA@mail.gmail.com>
 <44zihf2wt5.fsf@lowell-desk.lan>
 <CAOXDmPptZFBv5SiF_0X0cjA3us4tJ+Fuv9SR_8e2Mp0zkNmHYA@mail.gmail.com>
 <44mvdeqc08.fsf@be-well.ilk.org>
From: Cong Monkey <congzhangzh@gmail.com>
Date: Fri, 24 Feb 2017 23:24:20 +0800
Message-ID: <CAOXDmPo7Ji-T9mO=YHik4E_z_7sXjSeZj2KDdTDhYmNDg+84bA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Is that possible to use xenomai in multi user
 environment without root permission?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

tks, I got it:)

2017-02-23 3:08 GMT+08:00 Lowell Gilbert <kludge@be-well.ilk.org>:
>> 2017-02-22 3:00 GMT+08:00 Lowell Gilbert <kludge@be-well.ilk.org>:
>>> Cong Monkey <congzhangzh@gmail.com> writes:
>>>
>>>> I have a center server shared by multi user which is assigned sudo
>>>> permission for special cmd when needed.
>>>>
>>>> Is that possible to allow the user to run any self develop rt base
>>>> application(the user will not attack server by this way) without root
>>>> permission?
>>>
>>> Not really. Xenomai involves, among other things, making changes to the
>>> kernel. Your user will definitely want to run his real-time application
>>> on a system that isn't being used for anything else. The best way for
>>> him to do that will depend entirely on what his project is.
>>>
>>> He can *build* his Xenomai kernel and application without any special
>>> privileges, and might save a lot of time doing so if your server is very
>>> fast.
>
> Cong Monkey <congzhangzh@gmail.com> writes:
>
>> Is there some other way different than recompile the kernel, like add
>> user to special group or change some device's permission? it will
>> really be easy if simple way is possible and the user need do nothing!
>
> It might be possible to run the application in a virtual machine.
> Of course, it wouldn't get real-time behaviour.
>
> Linux is not a real-time operating system.

