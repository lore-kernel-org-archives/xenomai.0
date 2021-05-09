Subject: Re: Timer_Create for periodic tasks
References: <CAK6DXL0_dMXz7Xdi4vZSBZ9J5E9dVwiWiKOLnoX686ecWe5e3w@mail.gmail.com>
 <4b529835-b035-9e29-acc7-2fdc355222e5@siemens.com>
 <CAK6DXL2Dm5ANiw4fN6NVNeonjPi7mJrfMvLrdCDMOkgcJAKARA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5c4116b1-ba9a-1e3f-c359-f88ca66805a3@siemens.com>
Date: Sun, 9 May 2021 13:23:56 +0200
MIME-Version: 1.0
In-Reply-To: <CAK6DXL2Dm5ANiw4fN6NVNeonjPi7mJrfMvLrdCDMOkgcJAKARA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marco Barletta <barlettamarco8@gmail.com>, Xenomai <xenomai@xenomai.org>

[re-adding the list]

On 09.05.21 13:06, Marco Barletta wrote:
> Yes, of course.
> I attached "test3.c" that is a basic posix period task ripoff i found on
> the web by Marc Le Douarain. I couldn't test with smokey since at the
> best of my knowledge I realized it doesn't handles periodic tasks with
> timers.
> Then I launched Docker with "docker run -itd --name containerName
> --volume=/usr/xenomai:/usr/xenomai --volume=/[folder with
> proggrams]:/home/test --user 1000:1000 --device=/dev/rtdm:/dev/rtdm
> ubuntu /bin/bash" and then I run the periodic task in the container. It
> just blocks on waitsiginfo. Moreover I want to precise that adding
> --pid=host everything is fine, but it can be just a workaround due to
> security issues. I don't think you're also interesed in the server to
> translate pid in different namespaces, the syscall just fail, is a wrong
> way.
> It would be great to add namespace support, and I could contribute to
> it, although my experience limits.

You could already help with adding the information and test case to
https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/19 that i just
created.

One note, though, to avoid the illusion of security: You cannot confine
Xenomai by putting it into a namespace. It remains a set of privileged
service that can easily be used to lock up the system. Also, its APIs
are not consistently checked /wrt security loopholes that could be used
for privilege escalation. That's also why you need CAP_SYS_NICE as
caller or have to be in the 'allowed_group'.

However, I would still consider namespace support a valid feature in
order to use containers as deployment tool for Xenomai applications.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

