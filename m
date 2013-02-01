From: "Poole Jr, Donald R." <donald.poole@swri.org>
Date: Fri, 1 Feb 2013 17:13:13 +0000
Message-ID: <E9605457112439448B6B3ED284E065333175CDE2@mbx256-1.adm.swri.edu>
In-Reply-To: <CADyNBOpdu9LMetkk_Ya2Ma93QJ-wmwxS2MPVHccYV57uVHXnWQ@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21243FD491D77B4DADCF7771B5C359FC@sw.pvt>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] rtdm_dev_register
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Amit Bhaira <a.hearthacker.b@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello Amit,

I had just asked a similar question a fews day ago that Jan answered for
me.  I'Ve documented it below.

RTDM devices aren't registered with the Linux VFS layer. They live in
their own space, managed by Xenomai, addressable via Native's
rt_dev_open or the wrapped POSIX open call. The POSIX skin allows you to
address them as "/dev/mydevice" as well, but it acutally cuts "/dev/"
off before doing the open via RTDM.

Check /proc/xenomai/rtdm/named_devices to see if your device was
registered.

Jan

--
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

Hope this helps!


Donald R. Poole, Jr.
Research Engineer
Voice: 210.522.3131 | Fax: 210.522.4931
Tactical Networks & Communications (tacticalnetworks.swri.org)
Southwest Research Institute (SwRI)




On 2/1/13 11:09 AM, "Amit Bhaira" <a.hearthacker.b@gmail.com> wrote:

>where the rtdm_dev_register(&device) will register the device ??
>
>_______________________________________________
>Xenomai mailing list
>Xenomai@xenomai.org
>http://www.xenomai.org/mailman/listinfo/xenomai


