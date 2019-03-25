MIME-Version: 1.0
From: Virendra Kate <virendrakate@gmail.com>
Date: Mon, 25 Mar 2019 13:09:52 -0700
Message-ID: <CAA3JOdZuwus7K4kNBWkQiEWGRMQ6YGwYVEsDwX+W0xoV0SWinA@mail.gmail.com>
Subject: [Xenomai] ipipe-4.14: planned release date
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>, jan.kiszka@siemens.com, MSchrenkhammer@data-modul.com, henning.schild@siemens.com

Hi Martin, Jan and Henning,

Did you all get an update on this issue ? Was it resolved after all? I have
the exact same hardware with the exact same issue. The board keeps
resetting after "Loading initial ramdisk..."

My Setup is as follows:
ipipe version: ipipe-core-4.14.89-x86-2
Linux-kernel version: linux-4.14.89
xenomai version: xenomai-3.0.8
Hardware: AMD=C2=AE Ryzen embedded v1756b

The board works fine with Linux kernel 3.9.146 patched with the appropriate
xenomai-ipipe files. I would like to move to linux-kernel_4.14 as the GPU
driver is officially supported by AMD for linux-kernel_4.14.

Thanks,
Virendra


>> Hi Jan,
>>
>> now I run into another problem. My Board does a reset right after
>> "Loading initial ramdisk..." It is an AMD Ryzon Embedded V1000. There
>> are no logs to kern.log I already tried disabling CONFIG_MAXSMP.
>> Original 4.14.71 boots without problems.
>>
>> Any ideas?
>
>Any updates on that? We are about to release 4.14 amd64 so any known
>open issues should be fixed before.
>
>Please check 361b1bac5d903d2199903a5cb3d6e0fbc3c604ae together with
>xenomai/master.
>
>Henning
