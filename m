MIME-Version: 1.0
In-Reply-To: <53090AA4.4000903@xenomai.org>
References: <CAKKWdtfmWoZPjDmiqd2wVq2GOZEA0==iwv=KTcBHBn+wB3nZxw@mail.gmail.com>
 <53090AA4.4000903@xenomai.org>
Date: Sun, 23 Feb 2014 19:24:05 +0330
Message-ID: <CAKKWdtf0qqEOTsAbXE_SSYxVFV-3JpRHodzw_PmS1z0byp9N7w@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Virtual terminal does not work
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 2/23/14, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> Le 22/02/2014 09:35, ali hagigat a =E9crit :
>> I have installed:
>>
>> xenomai-2.6.3
>> linux-3.5.7
>> x86, 32 bits Intel-quad-core machine@2.4GHZ
>> Fedora 13
>> GNOME 2
>> Motherboard: ASUS Commando
>>
>> Once I logged in as root graphically and then i used "switch user" icon
>> and
>> then i logged in as a regular user and pressed, <CTRL-ALT-F2> and i
>> pressed
>> some <CTRL_ALT-Fx> suddenly computer froze and i had a black screen, no
>> key-presses or mouse movements were seen and the computer started beepin=
g
>> repeatedly.
>> When i pressed <CTRL-ALT-F2> to see a Linux text-based virtual terminal,
>> there is a black screen and no terminal and no key presses are seen
>>
>> My kernel config file is attached, i thought to share this experience.
>
> Doesn't the same kernel configuration, only without Xenomai patch, and
> without enabling Xenomai, show the same behaviour?
>
>
> --
> Gilles.
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>

Yes, you were right. I just copied the .config file of
linux-with-xenomai to a new linux-3.5.7 and ran 'make', it first asked
some questions about para-virtualization, high memory and huge page
tables and then started to make. Not sure if that wrote over that
.config file but when i logged in with the new kernel, there was the
same problem, i did not have virtual terminal in Fedora 13.
Thank you for your direction

